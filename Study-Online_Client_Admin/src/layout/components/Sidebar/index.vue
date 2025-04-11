<template>
  <div :class="{ 'has-logo': showLogo }">
    <logo :collapse="isCollapse" />
    <el-scrollbar wrap-class="scrollbar-wrapper">
      <el-menu :default-active="activeMenu" :collapse="isCollapse" :background-color="variables.menuBg"
        :text-color="variables.menuText" :unique-opened="false" :active-text-color="variables.menuActiveText"
        :collapse-transition="false" mode="vertical">
        <sidebar-item v-for="route in menus" :key="route.path" :item="route" :base-path="route.path" />
      </el-menu>
    </el-scrollbar>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Logo from './Logo'
import { resetRouter } from "@/router";
import { mapRouteToVueRouter } from "@/utils/route-utils";
import SidebarItem from './SidebarItem'
import variables from '@/styles/variables.scss'

export default {
  data() {
    return {
      newMenus: '',
    };
  },
  created() {
    this.newMenus = JSON.parse(sessionStorage.getItem("menus"))
    console.log(this.newMenus,'newMenus');
  },
  watch: {
    newMenus(newVal, oldVal) {
      console.log(newVal,'new');
      console.log(oldVal,'old');
      if (newVal !== oldVal) {
        this.newMenus = newVal
      }
    }
  },
  components: { SidebarItem, Logo },
  computed: {
    ...mapGetters([
      'sidebar',"menus"
    ]),
    routes() {
      console.log(this.$router.options.routes, '222')
      return this.$router.options.routes
    },
    activeMenu() {
      const route = this.$route
      const { meta, path } = route
      // if set path, the sidebar will highlight the path you set
      if (meta.activeMenu) {
        return meta.activeMenu
      }
      return path
    },
    showLogo() {
      return this.$store.state.settings.sidebarLogo
    },
    variables() {
      return variables
    },
    isCollapse() {
      return !this.sidebar.opened
    }
  }
}
</script>

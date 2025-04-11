<template>
  <div id="app">
    <keep-alive>
      <router-view />
    </keep-alive>
  </div>
</template>

<script>
export default {
  name: 'App',
  provide() {
    return {
      reload: this.reload
    }
  },
  data() {
    return {
      property: 'value',
    };
  },
  methods: {
    reload() {
      this.isRouterAlive = false,
        this.$nextTick(function () {
          this.isRouterAlive = true
        })
    },
  }
}
</script>

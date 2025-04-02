<template>
    <div>
        <div class="header">
            <img @click="$router.push('/')" width="auto" height="40px" style="margin-top: 25px;"
                src="https://study-onlne.oss-cn-nanjing.aliyuncs.com/study-online-LOGO.png" alt="">
            <el-menu style="margin-top: 15px;" :default-active="activeIndex" class="el-menu-demo" mode="horizontal"
                @select="handleSelect">
                <el-menu-item index="1" @click="$router.push('/')">首页</el-menu-item>
                <el-menu-item index="2">前言技术</el-menu-item>
                <el-menu-item index="3">专业技术</el-menu-item>
                <el-menu-item index="4">思政课程</el-menu-item>
                <el-menu-item index="5">实践课程</el-menu-item>
                <el-menu-item index="6" @click="goNews">新闻资讯</el-menu-item>
                <el-submenu index="7">
                    <template slot="title">更多</template>
                    <el-menu-item index="7-1">企业服务</el-menu-item>
                    <el-menu-item index="7-2">高职课程</el-menu-item>
                    <el-menu-item index="7-3">SIELE</el-menu-item>
                    <el-menu-item index="7-4">工程硕士</el-menu-item>
                    <el-menu-item index="7-5">健康中国</el-menu-item>
                    <el-menu-item index="7-6">医药学研究生</el-menu-item>
                    <el-menu-item index="7-7" style="border: none;">工商管理专业学位研究生</el-menu-item>
                </el-submenu>
            </el-menu>
            <el-input @keyup.enter.native="search" style="width: 180px;height: 40px" placeholder="请输入内容"
                prefix-icon="el-icon-search" v-model="input">
            </el-input>
            <!-- <i class="el-icon-mobile-phone" style="font-size: 33px;margin-top: 30px;"></i> -->
            <div style="margin-left: -30px;" v-show="!userName">
                <span style="cursor: pointer;" @click="dialogVisible = true">登录</span>
                <el-button style="width: 100px;margin-left: 25px;" @click="dialogVisible2 = true" type="primary"
                    round>注册</el-button>
            </div>
            <div class="block" v-show="userName">
                <el-dropdown>
                    <el-avatar @click.native="goPersion" :size="45" :src="imgFile ? imgFile : circleUrl"
                        style="margin-left: -20px;"></el-avatar>
                    <el-dropdown-menu class="lang-select-dropdown" slot="dropdown">
                        <el-dropdown-item @click.native="$router.push('/personal/1')">个人中心</el-dropdown-item>
                        <el-dropdown-item @click.native="$router.push('/personal/2')">我的课程</el-dropdown-item>
                        <el-dropdown-item @click.native="$router.push('/personal/3')">积分排名</el-dropdown-item>
                        <el-dropdown-item @click.native="logout">退出登录</el-dropdown-item>
                    </el-dropdown-menu>
                </el-dropdown>
                <span style="position: relative;top: -17px;margin-left: 20px;">{{ userName }}</span>
            </div>

        </div>
        <div class="login">
            <el-dialog width="462px" title="账号登陆" :visible.sync="dialogVisible" @close="close">
                <Login :dia.sync="dialogVisible" :dia2.sync="dialogVisible2" />
            </el-dialog>
        </div>
        <div class="register">
            <el-dialog width="462px" title="账号注册" :visible.sync="dialogVisible2">
                <Register :dia.sync="dialogVisible" :dia2.sync="dialogVisible2" />
            </el-dialog>
        </div>
    </div>
</template>

<script>
import Login from '@/views/Login.vue';
import Register from '@/views/Register.vue'
import { mapGetters, mapMutations } from 'vuex';
import { getUserDetail } from '@/api/user.js'
export default {
    name: 'StudyOnlineHeader',
    inject: ['reload'],
    data() {

        return {
            activeIndex: '1',
            input: '',
            dialogVisible: false,
            dialogVisible2: false,
            userName: localStorage.getItem('userName'),
            circleUrl: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png",
            imgFile: ''
        };
    },
    props: ['ai', 'dia', 'index', 'index2', 'index3', 'update'],

    components: {
        Login,
        Register
    },
    created() {
        if (this.index) {
            this.activeIndex = this.index
        } else if (this.index2) {
            this.activeIndex = this.index2
        } else if (this.index3) {
            this.activeIndex = this.index3
        }
    },
    mounted() {
        if (this.ai) {
            this.activeIndex = this.ai
        }
        if (this.userId) {
            getUserDetail(this.userId).then(res => {
                this.imgFile = res.data.img
            })
        }

        // console.log(this.userId,'2323');
    },
    computed: {
        ...mapGetters(['userId'])
    },
    methods: {
        ...mapMutations(['SETUSERID', 'SETSEARCH']),
        customFunc() {
            // 子组件中需要执行的代码
            this.reload()
        },
        handleSelect(key, keyPath) {
            console.log(key, keyPath);
            // console.log(key);
            this.activeIndex = key
        },
        logout() {
            // console.log('22');
            this.$router.push('/')
            this.SETUSERID('')
            localStorage.removeItem('token')
            localStorage.removeItem('userId')
            localStorage.removeItem('userName')
            this.$message({
                message: '已退出！',
                type: 'success'
            });
            this.reload()
        },
        goNews() {
            this.$router.push('/news')
            this.activeIndex = '6'
        },
        goPersion() {
            this.activeIndex = '0'
            this.$router.push('/personal/1')
            console.log(this.activeIndex);
        },
        close() {
            this.$emit('update:dia', this.dialogVisible);
        },
        search() {
            if (this.input) {
                this.SETSEARCH(this.input)
                this.$router.push({
                    name: "search-lesson",
                })
                this.input = ''
                // this.$message.success('搜索成功')
            } else {
                this.$message.warning('请输入相关课程信息')
            }

        }
    },
    watch: {
        dia: {
            handler(newValue, oldValue) {
                this.dialogVisible = newValue
            },
            deep: true,
            immediate: false
        }
    }
};
</script>

<style lang="less" scoped>
/deep/ .el-dropdown-link {
    cursor: pointer;
    color: #409EFF;
}

/deep/ .el-icon-arrow-down {
    font-size: 12px;
}

.lang-select-dropdown {
    width: 100px;
    margin-top: -25px !important;
    // position: relative !important;
    // top: 70px !important;
    // right: 0px !important;
    text-align: center;

    .el-dropdown-menu__item {
        width: 100%;
        position: relative;
        right: 35px;
    }
}

.el-menu {
    background-color: #fff;
    // z-index: 9999;
}

// /deep/ .el-dialog {
//     height: 420px;
// }

.header {
    width: 100%;
    margin: 0 auto;
    min-width: 1250px;
    // margin-left: 39px;
    // width: 100%;
    height: 88px;
    line-height: 88px;
    display: flex;
    background-color: #fff;
    justify-content: space-around;
    // min-width: 1450px;
    position: fixed;
    top: 0;
    z-index: 1999;

    .block {
        margin-top: 19px;
        position: relative;
        right: 30px;
    }
}

.el-menu.el-menu--horizontal {
    border: none;
}

.el-dropdown-menu__item,
.el-menu-item {
    font-size: 16px;
    padding: 0;
    margin-left: 35px;
}

.el-menu--horizontal>.el-menu-item {
    height: 50px;
}

/deep/ .el-submenu__title {
    font-size: 16px;
    margin-left: 35px;
    width: 32px;
    // height: 50px;
    padding: 0;
}

/deep/ .el-menu--horizontal>.el-submenu .el-submenu__title {
    height: 50px;
}

.el-menu--horizontal .el-menu .el-menu-item,
.el-menu--horizontal .el-menu .el-submenu__title {
    font-size: 14px;
    // padding: 10px;
    height: 45px;
    line-height: 45px;
    margin: 0 auto;
    text-align: center;
    border-bottom: 1px solid #ebeef5;
}
</style>

<template>
    <div class="login">
        <el-form :model="user" status-icon :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
            <el-form-item prop="phone">
                <el-input v-model="user.phone" placeholder="请输入手机号"></el-input>
            </el-form-item>
            <el-form-item prop="password">
                <el-input type="password" v-model="user.password" placeholder="请输入密码" autocomplete="off"></el-input>
            </el-form-item>
            <div class="forget">
                <!-- <span>忘记密码</span>
                <span style="padding: 8px;">|</span> -->
                <span @click="goRegister">去注册</span>
            </div>
            <el-form-item>
                <el-button v-show="user.phone && user.password" style="width: 322px;margin-top: 25px;" type="primary"
                    @click=login>登录</el-button>
                <el-button v-show="!user.phone || !user.password" disabled
                    style="width: 322px;margin-top: 25px;position: relative;left: -10px;" type="primary"
                    @click=login>登录</el-button>
            </el-form-item>
            <!-- <span style="color: #999;font-size: 14px;margin-left: 60px;">*若已有雨课堂、学堂在线账号均可登录</span> -->
        </el-form>
        <p>登录即代表阅读并同意 <a @click="openNewLink" style="cursor: pointer;">《服务协议和隐私政策》</a></p>
    </div>
</template>

<script>
import { login } from '@/api/user.js'
import { mapMutations } from 'vuex'
export default {
    name: 'StudyOnlineLogin',
    inject: ['reload'],
    data() {
        return {
            user: {
                phone: '',
                password: ''
            },
            rules: {
                phone: [
                    { pattern: /^1[3456789]\d{9}$/, message: "请输入合法手机号/电话号", trigger: "blur" }
                ],
                password: [{
                    required: true,
                    message: '请输入密码',
                    trigger: 'blur'
                }],
            },
            dialogVisible: this.dia,
            dialogVisible2: this.dia2
        };
    },
    props: ['dia'],

    mounted() { },

    methods: {
        ...mapMutations(['SETUSERID']),
        login() {
            login({
                phone: this.user.phone,
                password: this.user.password
            }).then(res => {
                console.log(res);
                if (res.respCode == 400) {
                    this.$message.warning(res.respMessage)
                } else {
                    this.$message.success(res.respMessage)
                    this.dialogVisible = false
                    this.$emit('update:dia', this.dialogVisible);
                    localStorage.setItem('userId', res.data.userid)
                    localStorage.setItem('userName', res.data.userName)
                    this.SETUSERID(res.data.userid)
                    this.reload()
                    localStorage.setItem('token', res.data.token)
                }
            })
        },
        goRegister() {
            this.dialogVisible = false,
                this.dialogVisible2 = true
            this.$emit('update:dia2', this.dialogVisible2);
            setTimeout(() => {
                this.$emit('update:dia', this.dialogVisible);
            }, 100);
        },
        openNewLink() {
            let routeUrl = this.$router.resolve({
                path: "/protocol"
            })
            window.open(routeUrl.href, '_blank')
        }
    },
};
</script>

<style lang="less" scoped>
.el-form-item {
    // width: 350px;
    position: relative;
    left: -48px;
}

/deep/ .el-input__inner {
    background-color: #f9f9f9;
    border: 1px solid #fff;
}

.login {
    .forget {
        text-align: right;
        margin-right: 50px;

        span {
            font-size: 14px;
            color: #666;
            cursor: pointer;
        }
    }

    p {
        text-align: center;
        margin-top: 30px;
        font-size: 14px;
        color: #999;

        a {
            color: #1769fe;
            text-decoration: none;
            outline: none;
        }

        a:hover {
            text-decoration: underline;
        }
    }
}
</style>

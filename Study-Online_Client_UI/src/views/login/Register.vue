<template>
    <div class="register">
        <el-form :model="user" status-icon :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
            <el-form-item prop="admin">
                <el-input v-model="user.admin" placeholder="请输入昵称"></el-input>
            </el-form-item>
            <el-form-item prop="phone">
                <el-input v-model="user.phone" placeholder="请输入手机号"></el-input>
            </el-form-item>
            <el-form-item prop="password">
                <el-input type="password" v-model="user.password" placeholder="请输入密码" autocomplete="off"></el-input>
            </el-form-item>
            <el-form-item prop="checkPass">
                <el-input type="password" v-model="user.checkPass" placeholder="请再次确认" autocomplete="off"></el-input>
            </el-form-item>
            <div class="forget">
                <!-- <span>忘记密码</span>
                <span style="padding: 8px;">|</span> -->
                <span @click="goLogin">去登陆</span>
            </div>
            <el-form-item>
                <el-button
                    v-show="user.admin && user.phone && user.password && user.checkPass && user.password == user.checkPass"
                    style="width: 322px;margin-top: 25px;" type="primary" @click=register>注册</el-button>
                <el-button v-show="!user.admin || !user.password || !user.checkPass || user.password != user.checkPass"
                    disabled style="width: 322px;margin-top: 25px;position: relative;left: -10px;" type="primary"
                    @click=register>注册</el-button>
            </el-form-item>
            <!-- <span style="color: #999;font-size: 14px;margin-left: 60px;">*若已有雨课堂、学堂在线账号均可登录</span> -->
        </el-form>
        <p>登录即代表阅读并同意 <a @click="openNewLink" style="cursor: pointer;">《服务协议和隐私政策》</a></p>
    </div>
</template>

<script>
import { register } from '@/api/user.js'
import { addScore, addScoreDetail } from '@/api/score.js'
export default {
    name: 'StudyOnlineRegister',
    inject: ['reload'],
    data() {
        var validatePass = (rule, value, callback) => {
            if (value === '') {
                callback(new Error('请输入密码'));
            } else {
                if (this.user.checkPass !== '') {
                    this.$refs.user.validateField('checkPass');
                }
                callback();
            }
        };
        var validatePass2 = (rule, value, callback) => {
            if (value === '') {
                callback(new Error('请再次输入密码'));
            } else if (value !== this.user.password) {
                callback(new Error('两次输入密码不一致!'));
            } else {
                callback();
            }
        };
        return {
            user: {
                admin: '',
                phone: '',
                password: '',
                checkPass: ''
            },
            rules: {
                admin: [{
                    required: true,
                    message: '请输入账号',
                    trigger: 'blur'
                }],
                phone: [
                    { pattern: /^1[3456789]\d{9}$/, message: "请输入合法手机号/电话号", trigger: "blur" }
                ],
                password: [{
                    validator: validatePass,
                    required: true,
                    trigger: 'blur'
                }],
                checkPass: [{
                    validator: validatePass2,
                    required: true,
                    trigger: 'blur'
                }],
            },
            dialogVisible: this.dia,
            dialogVisible2: this.dia2,
            userId: ''

        };
    },

    mounted() {
    },

    methods: {
        register() {
            register({
                phone: this.user.phone,
                loginName: this.user.admin,
                password: this.user.password
            }).then(res => {
                this.userId = res.data
                addScore({
                    userId: this.userId
                }).then(res => {
                    addScoreDetail({
                        score: 100,
                        way: "新用户注册奖励",
                        userid: this.userId
                    }).then(res => { })
                })
                this.$message.success("恭喜您注册成功，已为您自动跳转到登录页~")
                this.goLogin()
            })
        },
        goLogin() {
            this.dialogVisible = true,
                this.dialogVisible2 = false,
                this.$emit('update:dia', this.dialogVisible);

            setTimeout(() => {
                this.$emit('update:dia2', this.dialogVisible2);

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

.register {

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

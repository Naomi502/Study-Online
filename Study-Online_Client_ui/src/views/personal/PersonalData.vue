<template>
    <div class="personal-data">
      <h2 class="page-title">个人信息</h2>
        <el-card class="box-card" shadow="never">
            <div slot="header" class="clearfix">
                <el-button v-if="!isChange" style="float: right; padding: 3px 0" type="text" @click="bianji"> <i
                        class="el-icon-edit"></i>
                    编辑</el-button>
                <el-button v-else style="float: right; padding: 3px 0" type="text" @click="wancheng()"> <i
                        class="el-icon-edit"></i>
                    完成</el-button>
            </div>
            <div class="box">
                <div class="left">
                    <el-form :model="user" :rules="rules" ref="user1">
                        <el-form-item label="姓名" prop="realName">
                            <span v-if="!isChange" style="margin-left: 21px;color: #333;">{{ user.realName ?
                                user.realName : '无' }}</span>
                            <el-input v-else placeholder="请输入姓名" v-model="user.realName" clearable>
                            </el-input>
                        </el-form-item>
                        <el-form-item label="性别" prop="sex">
                            <span style="margin-left: 21px;color: #333;" v-if="!isChange">{{
                                newSex ? newSex : "无" }}</span>
                            <el-select v-else v-model="user.sex" placeholder="请选择性别">
                                <el-option v-for="item in sex" :key="item.value" :label="item.label" :value="item.value">
                                </el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="手机" prop="phone">
                            <span v-if="!isChange" style="margin-left: 21px;color: #333;">{{ user.phone ?
                                user.phone : '无' }}</span>
                            <el-input v-else placeholder="请输入手机号" v-model="user.phone" clearable>
                            </el-input>
                        </el-form-item>
                        <el-form-item label="邮箱" prop="email">
                            <span v-if="!isChange" style="margin-left: 21px;color: #333;">{{ user.email ?
                                user.email : '无' }}</span>
                            <el-input v-else placeholder="请输入邮箱" v-model="user.email" clearable>
                            </el-input>
                        </el-form-item>
                    </el-form>
                </div>
                <div class="right">
                    <el-form :model="user" :rules="rules" ref="user2">
                        <el-form-item label="职称" prop="zhiCheng">
                            <span v-if="!isChange" style="margin-left: 21px;color: #333;">{{ user.zhiCheng ?
                                user.zhiCheng : '无' }}</span>
                            <el-input v-else placeholder="请输入职称" v-model="user.zhiCheng" clearable>
                            </el-input>
                        </el-form-item>
                        <el-form-item label="学历" prop="xueLi">
                            <span v-if="!isChange" style="margin-left: 21px;color: #333;">{{ newXueLi ?
                                newXueLi : '无' }}</span>
                            <el-select v-else v-model="user.xueLi" placeholder="请选择学历">
                                <el-option v-for="item in education" :key="item.id" :label="item.name" :value="item.id">
                                </el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="单位" prop="danWei">
                            <span v-if="!isChange" style="margin-left: 21px;color: #333;">{{ user.danWei ?
                                user.danWei : '无' }}</span>
                            <el-input v-else placeholder="请输入单位" v-model="user.danWei" clearable>
                            </el-input>
                        </el-form-item>
                        <el-form-item label="证号" prop="zhengHao">
                            <span v-if="!isChange" style="margin-left: 21px;color: #333;">{{ user.zhengHao ?
                                user.zhengHao : '无' }}</span>
                            <el-input v-else placeholder="请输入身份证" v-model="user.zhengHao" clearable>
                            </el-input>
                        </el-form-item>
                    </el-form>
                </div>
            </div>
        </el-card>
    </div>
</template>

<script>
import { getUserDetail, updateUser, getXueLiList } from '@/api/user.js'
import { mapGetters } from 'vuex';
export default {
    name: 'StudyOnlinePersonalData',

    data() {
        return {
            isChange: false,
            education: [],
            sex: [{
                value: 1,
                label: '男'
            }, {
                value: 2,
                label: '女'
            }],
            user: {
                realName: '',
                phone: '',
                sex: '',
                xueLi: '',
                zhiCheng: '',
                danWei: '',
                zhengHao: '',
                email: ''
            },
            newXueLi: '',
            newSex: '',
            rules: {
                phone: [
                    { trigger: "blur" },
                    // 这个只能验证手机号
                    // { pattern:/^0{0,1}(13[0-9]|15[7-9]|153|156|18[7-9])[0-9]{8}$/, message: "请输入合法手机号", trigger: "blur" }
                    { pattern: /^((0\d{2,3}-\d{7,8})|(1[3584]\d{9}))$/, message: "请输入合法手机号/电话号", trigger: "blur" }
                ],
                zhengHao: [
                    { trigger: "blur" },
                    { pattern: /(^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$)|(^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{2}$)/, message: "请输入合法身份证号", trigger: "blur" }
                ],
                email: [
                    { trigger: "blur" },
                    { pattern: /^([0-9A-Za-z\-_\.]+)@([0-9a-z]+\.[a-z]{2,3}(\.[a-z]{2})?)$/g, message: "请输入正确的邮箱", trigger: "blur" }
                ],
            }
        };
    },
    created() {
    },

    mounted() {
        this.getUser()
    },
    computed: {
        ...mapGetters(['userId'])
    },
    methods: {
        getUser() {
            getUserDetail(this.userId).then(({ data: res }) => {
                // console.log(res, '23232');
                this.user = res
                console.log(this.user);
                this.sex.filter(v => {
                    if (v.value == res.sex) {
                        this.newSex = v.label
                    }
                })
                getXueLiList().then(({ data: res }) => {
                    // console.log(res);
                    this.education = res
                    res.filter(v => {
                        if (v.id == this.user.xueLi) {
                            this.newXueLi = v.name
                            // console.log(this.newXueLi, "434");
                        }
                    })
                })
            })

        },
        bianji() {
            this.isChange = true
        },
        wancheng() {
            this.$refs["user1"].validate((valid) => {
                console.log(valid, 'v1');
                if (valid) {
                    this.$refs["user2"].validate((valid2) => {
                        console.log(valid2, 'v2');
                        if (valid2) {
                            this.isChange = false,
                                updateUser({
                                    id: this.userId,
                                    realName: this.user.realName,
                                    phone: this.user.phone,
                                    sex: this.user.sex,
                                    xueLi: this.user.xueLi,
                                    zhiCheng: this.user.zhiCheng,
                                    danWei: this.user.danWei,
                                    zhengHao: this.user.zhengHao,
                                    email: this.user.email
                                }).then(res => {
                                    // console.log(res);
                                    this.getUser()
                                    this.$message.success(res.data)
                                })
                        }
                        else {
                            this.$message.warning('请输入正确的信息')
                            // console.log('error submit!!');
                            return false;
                        }
                    })
                } else {
                    this.$message.warning('请输入正确的信息')
                    // console.log('error submit!!');
                    return false;
                }
            });

        }
    },
};
</script>

<style lang="less" scoped>
.page-title {
  font-size: 24px;
  color: #333;
  margin-bottom: 30px;
  padding-bottom: 15px;
  border-bottom: 1px solid #eee;
}
/deep/ .el-card__header {
    border: none;
}

/deep/ .el-input__suffix {
    position: relative;
    height: 35px;
    left: -25px;
}

/deep/ .el-color-picker__icon,
.el-input,
.el-textarea {
    display: inline;
}

/deep/ .el-input__inner {
    width: 190px;
    height: 40px;
    margin-left: 5px;
    // margin-left: 10px;
}

.el-card {
    border: none;
}

.personal-data {
   max-width: 1200px;
    width: 100%;
    height: 100%;
    padding: 20px;
    margin: 0 auto;

    .box-card {
        .box {
            width: 95%;
            margin: 5px auto;
            height: 250px;
            display: flex;
            background-color: #fcfcfc;
            font-size: 14px;
            color: #999;
            font-weight: 400;
            min-width: 820px;

            .left {
                width: 50%;
                height: 100%;
                margin-top: 10px;
                margin-left: 50px;
                display: flex;
                flex-direction: column;
                justify-content: space-evenly;

                // background-color: bisque;
                p {
                    display: flex;
                    flex-direction: row;
                    width: 100%;
                    padding: 10px;

                    span {
                        display: inline-block;
                        width: 20%;
                        // line-height: 40px;
                    }

                    /deep/ .el-input__inner {
                        width: 190px;
                        height: 40px;
                        // margin-left: 10px;
                        // margin-left: -10px;
                    }
                }
            }

            .right {
                width: 50%;
                height: 100%;
                margin-top: 10px;
                margin-left: 50px;
                display: flex;
                flex-direction: column;
                justify-content: space-evenly;

                p {
                    display: flex;
                    flex-direction: row;
                    // width: 380px;
                    padding: 10px;

                    span {
                        display: inline-block;
                        width: 20%;
                        line-height: 40px;
                    }


                }

                // background-color: aquamarine;
            }
        }
    }
}
</style>

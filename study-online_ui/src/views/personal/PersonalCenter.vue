<template>
    <div class="personal-center">
        <Header ref="childCompo" :index="activeIndex" />
        <div class="main">
            <div class="left">
                <el-card shadow="always" class="box-card" style="width: 100%; height: 85vh">
                    <el-upload v-show="imgShow" @mouseleave.native="imgShow = false"
                        style="position: relative;top: 50px;width: 75px;height: 75px;z-index: 9;margin: 0 auto;"
                        class="avatar-uploader" action="http://47.113.150.42:9099/user/upload" :headers="config"
                        :show-file-list="false" :on-success="handleAvatarSuccess" :before-upload="beforeAvatarUpload">
                        <!-- <img width="75px" height="75px" v-if="imageUrl" :src="imageUrl" class="avatar"> -->
                        <span
                            style="display: inline-block;width: 75px;height: 75px;line-height: 75px;border-radius: 50%;
                            color: white;background-color: rgb(0, 0, 0,0.5);font-size: 14px;font-weight: 600;z-index: 99;">更换头像</span>
                    </el-upload>
                    <el-avatar v-if="!imgShow" @mouseenter.native="imgShow = true" style="display: block; margin: 50px auto"
                        :size="75" :src="imgFile"></el-avatar>
                    <el-avatar v-else @mouseenter.native="mouseenter"
                        style="display: block; margin: 50px auto;position: relative;top: -75px;z-index: 0;" :size="75"
                        :src="imgFile"></el-avatar>
                    <div :class="{ name: !imgShow, name2: imgShow }">
                        <span v-show="!isShow" style="display: block; text-align: center">{{ userName }}<i @click="change"
                                class="el-icon-edit"></i>
                        </span>
                        <el-input v-show="isShow" v-model="input" placeholder="请输入昵称" @blur.stop="mousedown"
                            @keyup.enter.native.stop="mousedown"></el-input>
                    </div>
                    <div style="display: flex;flex-direction: row;height: 72px;line-height: 32px;">
                        <span style="display: inline-block;width: 100%;text-align: center;margin: 20px auto;color:#f7892b;">
                            <i class="iconfont icon-jifenduihuan" style="color:#f7892b;"></i>{{ point }}
                            <span v-show="status == 0" style="font-size: 12px;position: relative;top: -2px;display: inline-block;
                              width: 40px;height: 22px;border-radius: 10px;line-height: 21px;
                              cursor: pointer;;background-color: #f7892b;color: white;" @click="signIn">签到</span>
                            <el-tag v-show="status == 1" type="warning"
                                style="padding: 0 5px;position: relative;top: -2px;">今日已签~</el-tag>
                        </span>
                    </div>
                    <div class="row">
                        <span :class="[{ active: activeName == item.name }]" @click="changeMenu(item)" v-for="item in list"
                            :key="item.id">
                            <i :class="item.icon"></i> {{ item.name }}</span>
                    </div>
                </el-card>
            </div>
            <div class="right">
                <div class="content">
                    <PersonalData v-show="selectId == 1" />
                    <PersonalClass v-show="selectId == 2" />
                    <PointsRanking v-show="selectId == 3" />
                </div>
            </div>
        </div>
        <Footer />
    </div>
</template>

<script>
import Header from "@/components/Header.vue";
import Footer from "@/components/Footer.vue";
import PersonalData from "@/views/personal/PersonalData.vue";
import PersonalClass from "@/views/personal/PersonalClass.vue";
import PointsRanking from "./PointsRanking.vue";
import { mapState, mapMutations, mapGetters } from 'vuex'
import { getUserDetail, updateUser } from '@/api/user.js'
import { getMyScore, updateMyScore, addScoreDetail } from '@/api/score.js'
export default {
    name: "StudyOnlinePersonalCenter",
    inject: ["reload"],
    data() {
        return {
            isShow: false,
            userName: '',
            input: "",
            list: [{
                name: "个人资料",
                id: 1,
                icon: "el-icon-user",
            },
            {
                name: "我的课程",
                id: 2,
                icon: "el-icon-reading",
            },
            {
                name: "积分排名",
                id: 3,
                icon: "el-icon-medal",
            },
            ],
            activeName: "个人资料",
            selectId: this.$route.params.id,
            imageUrl: '',
            imgShow: false,
            activeIndex: '0',
            // isSign: false,
            point: '',
            dateFormat: '',
            token: localStorage.getItem('token'),
            imgFile: '',
            status: 1,
        };
    },
    components: {
        Header,
        Footer,
        PersonalData,
        PersonalClass,
        PointsRanking,
    },
    created() {
        // this.isSign = this.isSign2
    },
    mounted() {
        // console.log(this.selectId);
        this.list.filter((i) => {
            if (i.id == this.selectId) {
                this.activeName = i.name;
            }
        });
        this.getUser1()
    },
    computed: {
        // ...mapState(['isSign2']),
        ...mapGetters(['userId']),
        config() {
            return { Authorization: this.token }
        },
    },

    methods: {
        ...mapMutations(['SETISSIGN']),
        callChildFunc() {
            this.$refs.childCompo.customFunc();
        },
        getUser1() {
            getUserDetail(this.userId).then(res => {
                // console.log(res);
                this.userName = res.data.loginName
                this.imgFile = res.data.img
            }),
                getMyScore(localStorage.getItem("userId")).then(({ data: res }) => {
                    this.point = res.score
                    this.status = res.status
                    // console.log(this.status);
                })
        },
        change() {
            this.isShow = true;
        },
        // changeNick() {
        //     if (this.input) {

        //     }
        // },
        mousedown() {
            if (!this.input) {
                if (this.isShow) {
                    this.$message.warning('请输入新的昵称')
                }
            } else {
                localStorage.setItem("userName", this.input)
                updateUser({
                    id: this.userId,
                    loginName: this.input
                }).then(res => {
                    this.$message.success(res.data)
                    this.getUser1()
                    this.callChildFunc()
                        (this.isShow = false)
                })
            }
            (this.input = "");
        },
        // mousedown2() {
        //     if (!this.input) {
        //         this.$message.warning('请输入新的昵称')
        //     } else {
        //         (this.isShow = false),
        //             this.$message.success('修改成功')
        //     }
        //     (this.input = "");
        // },
        changeMenu(item) {
            this.activeName = item.name;
            // console.log(item.id);
            this.selectId = item.id;
            // console.log(this.selectId);
            this.$router.push(`/personal/${this.selectId}`);
        },
        //签到
        signIn() {
            if (this.status != 1) {
                updateMyScore({
                    userId: this.userId,
                    score: this.point + 0.5,
                    status: 1
                }).then(res => {
                    addScoreDetail({
                        score: 0.5,
                        way: "每日签到",
                        userid: localStorage.getItem("userId")
                    }).then(res => { })
                    this.getUser1()
                    this.$message({
                        message: '恭喜你完成今日签到，积分+0.5，明日再来哦~',
                        type: 'success'
                    });
                })
            }


        },

        handleAvatarSuccess(res, file) {
            this.imgShow = false
            this.imageUrl = URL.createObjectURL(file.raw);
            this.imgFile = res.data
            this.$message.success(res.respMessage)
            updateUser({
                id: this.userId,
                img: this.imgFile
            }).then(res => {
                this.callChildFunc()
                // console.log(res);
            })

        },
        beforeAvatarUpload(file) {
            const isJPG = file.type === 'image/jpeg'
            const isPNG = file.type === 'image/png'
            const isLt2M = file.size / 1024 / 1024 < 2

            if (!isJPG && !isPNG) {
                this.$message.error('上传头像图片只能是 JPG或PNG 格式!')
            }
            if (!isLt2M) {
                this.$message.error('上传头像图片大小不能超过 2MB!')
            }
            return (isJPG || isPNG) && isLt2M
        },
    },
    watch: {
        // 根据情况 $route.query 可以换成 $route.params
        "$route.params": {
            // immediate: true, // 第一次的数据，也要当做是一种变化
            // 处理函数（不能修改名字） handler('新的值'，'旧的值')
            handler(new_value, old_value) {
                // 执行代码部分
                this.reload();
            },
        },
    },
};
</script>

<style lang="less" scoped>
/deep/ .el-card__body,
.el-main {
    padding: 0;
}

/deep/ .el-input__inner {
    height: 30px;
}

.text {
    font-size: 14px;
}

.item {
    padding: 18px 0;
}

.box-card {
    width: 480px;
}

.personal-center {
    margin-top: 120px;
    width: 100%;

    .main {
        width: 75%;
        // height: 200vh;
        margin: 0 auto;
        display: flex;
        margin-bottom: 100px;

        .left {
            width: 19%;
            height: 100%;
            min-width: 180px;
            position: relative;
            z-index: 999;

            .img1 {}

            .img2 {}

            .name {
                margin-top: -35px;
            }

            .name2 {
                margin-top: -110px;
            }

            // background-color: aqua;
            .row {
                // margin-top: 5px;
                display: flex;
                flex-direction: column;
                // text-align: center;

                span {
                    display: block;
                    width: 80%;
                    height: 48px;
                    line-height: 48px;
                    padding-left: 40px;
                }

                span:hover {
                    color: #1769fe;
                }

                span.active {
                    border-left: 4px solid #4182fa;
                    background: rgba(80, 150, 245, 0.06);
                    color: #1769fe;
                    font-weight: 500;
                }
            }
        }

        .right {
            width: 81%;
            min-width: 780px;
            height: 85vh;
            animation: load 0.4s linear;
            transform: translateY(0px);
            opacity: 1;

            @keyframes load {
                0% {
                    opacity: 0;
                    transform: translateY(80px)
                }

                100% {
                    opacity: 1;
                    transform: translateY(0px)
                }
            }

            // background-color: rgb(202, 175, 142);
            .content {
                width: 92%;
                margin: 55px auto;
            }
        }
    }
}
</style>

<template>
    <div>
        <div class="hot-class">
            <span>热门课程</span>
            <div class="header">
                <span class="s1" v-for="item in tipList" :key="item.id" @click="ontip(item)"
                    :class="[{ active: activeName == item.name }]">{{ item.name }}</span>
            </div>
            <div style="display: flex;min-width: 1200px;flex-wrap: wrap;margin: auto;  justify-content: center">
                <el-skeleton animated v-show="skeletonShow" style="width: 25%;" v-for="(item, index) in 8" :key="index">
                    <template slot="template">
                        <el-skeleton-item variant="image" style="width: 95%;height: 230px;" />
                        <div style="padding: 14px;">
                            <el-skeleton-item variant="p" style="width: 30%" />
                            <div style="display: flex; align-items: center; justify-items: space-between;">
                                <el-skeleton-item variant="text" style="margin-right: 16px;width: 60%;" />
                                <el-skeleton-item variant="text" style="width:20%;" />
                            </div>
                        </div>
                    </template>
                </el-skeleton>
            </div>
            <div class="content" v-show="!skeletonShow">
                <el-empty v-if="lessons.length == 0" style="margin: 20px auto;" description="该分类下暂无相关课程！"></el-empty>
                <el-card v-else class="box" shadow="hover" v-for="(item, index) in lessons" :key="index"
                    @click.native="toDetail(item)">
                    <div class="top">
                        <!-- <img width="100%" height="100%" :src="img" alt=""> -->
                        <el-image style="width: 100% ;height:200px" :src="item.img"></el-image>
                    </div>
                    <div class="bottom">
                        <div class="introduce">
                            <span style="font-size: 16px; font-weight: 500;
                        overflow: hidden;
                        text-overflow: ellipsis;
                        -webkit-line-clamp: 1;
                        word-wrap: break-word;
                        display: -webkit-box;
                        -webkit-box-orient: vertical;">{{ item.lname }}</span>
                            <span style="color: #666; position: relative; top: -6px;
                        display: inline-block; overflow: hidden;
                        text-overflow: ellipsis;
                        -webkit-line-clamp: 1;
                        word-wrap: break-word;
                        display: -webkit-box;
                        -webkit-box-orient: vertical;
                        ">{{ item.remark }}</span>
                        </div>
                        <div class="school">
                            <span style="display: flex;"> {{ item.school }} <span style="margin-left: 10px;">授课人:{{ item.tname }}</span></span>
                            <span> <i class="el-icon-user"></i> {{ item.dianJi }}</span>
                        </div>
                    </div>
                </el-card>
            </div>
        </div>
    </div>
</template>

<script>
import {
    mapMutations,
    mapState
} from 'vuex';
import {
    getHotCategory,
    getLessons
} from '@/api/lesson.js'
export default {
    name: "StudyOnlineHotClass",
    inject: ['reload'],
    data() {
        return {
            tipList: [],
            activeName: "热门好课",
            id: 1001,
            // img: require('@/assets/class.png'),
            lessons: [],
            skeletonShow: false
        };
    },
    created() {
        if (this.beforeTarget.name) {
            this.activeName = this.beforeTarget.name
            this.id = this.beforeTarget.id
        }
    },
    mounted() {
        this.skeletonShow = true
        getHotCategory().then(({
            data: res
        }) => {
            this.tipList = res
        }),
            this.getLesson()
    },
    computed: {
        ...mapState(['beforeTarget'])
    },

    methods: {
        ...mapMutations(['SETTARGET']),

        getLesson() {
            getLessons(this.id).then(({
                data: res
            }) => {
                this.lessons = res
                setTimeout(() => {
                    this.skeletonShow = false
                }, 150);
                // console.log(this.lessons);
            })
        },

        ontip(i) {
            if (this.id != i.id) {
                this.skeletonShow = true
            }
            this.id = i.id
            this.activeName = i.name;
            this.getLesson()
            this.SETTARGET(i)
        },

        toDetail(item) {
            this.$router.push({
                name: 'class-details',
                query: {
                    id: item.id,
                    img: item.img
                }
            })
        }
    },
};
</script>

<style lang="less" scoped>
/deep/ .el-card__body,
.el-main {
    padding: 0;
}

.hot-class {
    width: 100%;
    // height: 100vh;
    margin-top: 120px;
    animation: load 0.4s linear;
    transform: translateY(0px);
    opacity: 1;

    @keyframes load {
        0% {
            opacity: 0;
            transform: translateY(70px)
        }

        100% {
            opacity: 1;
            transform: translateY(0px)
        }
    }

    // height: 100vh;
    span {
        display: block;
        font-size: 28px;
        margin-bottom: 16px;
    }

    .header {
        width: 100%;
        overflow-x: scroll;
        overflow-y: hidden;
        // height: 100%;
        margin: 20px auto;
        white-space: nowrap;
        /* ul中的内容不换行 */
        // min-width: 1200px;
        // margin-top: 20px;
        height: 68px;
        text-align: center;
        list-style-type: none;
        align-items: center;

        .s1 {
            width: 112px;
            height: 36px;
            line-height: 36px;
            font-size: 14px;
            // text-align: center;
            display: inline-block;
            text-align: center;
            border-radius: 25px;
            white-space: nowrap;
            background-color: rgba(65, 130, 250, 0.1);
            // margin-left: 16px;
            // padding: 8px;
            margin-left: 8px;
            margin-right: 8px;
            cursor: pointer;
        }

        .s1:hover {
            color: #1769fe;
            background: rgba(65, 130, 250, 0.2);
        }

        .s1.active {
            color: #fff !important;
            background-color: #1769fe !important;
            font-weight: 700 !important;
        }
    }

    .content {
        width: 100%;
        margin: 5px auto;
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        flex-wrap: wrap;
        min-width: 1200px;

        .box {
            width: 23.5%;
            height: 30%;
            display: flex;
            flex-direction: column;
            border: 1px solid #ebebeb;
            margin-bottom: 1.75%;
            border-radius: 4px;

            .top {
                width: 100%;
                height: 45%;
                // background-color: #1769fe;
            }

            .bottom {
                width: 100%;
                height: 55%;
                // background-color: aqua;

                .introduce {
                    // margin-top: 20px;
                    position: relative;
                    top: 20px;
                    margin-left: 10px;

                    span {
                        font-size: 14px;
                    }
                }
            }

            .school {
                width: 95%;
                margin: 0 auto;
                margin-top: 48px;
                display: flex;
                flex-direction: row;
                justify-content: space-between;

                span {
                    font-size: 14px;
                    color: #999;
                }
            }
        }
    }
}
</style>

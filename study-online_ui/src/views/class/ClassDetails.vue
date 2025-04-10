<template>
    <div class="class-detail">
        <Header :dia.sync="dia" :index2="activeIndex" />
        <div class="content">
            <div class="left">
                <div class="introduce">
                    <div class="wenzi">
                        <span style="font-size: 34px;color: #333;">课程介绍</span>
                        <span style="margin-top: 15px;color: #666;
                        line-height: 25px;
                        display: inline-block; overflow: hidden;
                        text-overflow: ellipsis;
                        -webkit-line-clamp: 7;
                        word-wrap: break-word;
                        display: -webkit-box;
                        -webkit-box-orient: vertical;
                        ">{{ lesson.introduce }}</span>
                    </div>
                    <el-button v-show="!isShow" style="margin-top: 50px;width: 40%;margin: 0 auto;" type="primary" plain
                        @click="goStudy">加入学习</el-button>
                    <el-button v-show="isShow" style="margin-top: 50px;width: 40%;margin: 0 auto;" type="success" plain
                        @click="goStudy2">进入学习</el-button>
                </div>
            </div>
            <div class="right">
                <Video :img="img" :video="lesson.vedio" />
            </div>
        </div>
        <div class="section">
            <p>课程章节</p>
            <!-- <div class="tree" v-for="(item, index) in 4" :key="index">
            </div> -->
            <Tree :lessonId="id" />
        </div>
        <Footer v-show="footerShow" />
    </div>
</template>

<script>
import Header from '@/components/Header.vue';
import Footer from '@/components/Footer.vue';
import Video from '@/views/video/Video.vue';
import Tree from '@/views/video/Tree.vue';
import { getLessonDetail, getLessonTreeById } from '@/api/lesson.js'
import { joinLesson, getMyLesson } from '@/api/myLesson.js'
import { mapMutations } from 'vuex';
export default {
    name: 'StudyOnlineClassDetails',
    inject: ['reload'],
    data() {
        return {
            id: this.$route.query.id,
            img: this.$route.query.img,
            dia: false,
            activeIndex: '0',
            lesson: {
                introduce: '',
                vedio: '',
                img: ''
            },
            lessonTree: '',
            isShow: false,
            list: [],
            userId: localStorage.getItem("userId"),
            footerShow: true
        };
    },
    components: {
        Header,
        Footer,
        Video,
        Tree
    },

    created() {
        this.footerShow = false

    },

    mounted() {
        setTimeout(() => {
            this.footerShow = true
            // console.log("1");
        }, 100);
        getMyLesson(this.userId).then(({ data: res }) => {
            console.log(res);
            if (res) {
                res.filter(v => {
                    if (v.lessonId == this.id) {
                        this.isShow = true
                        this.list = v
                        console.log(this.list);
                    }
                })
            }
        })
        this.getLesson()
        // console.log(this.$route.query.img);
    },

    methods: {
        ...mapMutations(['SETISCUT']),
      getLesson() {
        getLessonDetail(this.id).then(({ data: res }) => {
          console.log(res);
          this.lesson.introduce = res.introduce
          this.lesson.vedio = res.vedio
        })
      },
        goStudy() {
            if (localStorage.getItem('userName')) {
                joinLesson({
                    userId: localStorage.getItem('userId'),
                    lessonId: this.id
                }).then(res => {
                    localStorage.setItem("video", this.lesson.vedio)
                    this.$message.success(res.respMessage)
                    this.$router.push(`/lesson/${this.id}`)
                })
            } else {
                this.dia = true
                // console.log(this.dia);
            }
        },
        goStudy2() {
            this.SETISCUT(false)
            this.$router.push({
                name: "lesson",
                params: {
                    id: this.id,
                    durations: this.list.durations,
                    treeId: this.list.treeId
                }
            })
        }
    },
};
</script>

<style lang="less" scoped>
/deep/ .el-tree-node__label {
    font-size: 18px;
    color: #333;
    padding: 5px;
}

// .el-tree-node__label{
//     font-size: 14px;
// }
.class-detail {
    width: 100%;

    .content {
        width: 75%;
        margin: 140px auto;
        display: flex;
        flex-direction: row;
        position: relative;
        z-index: 999;
        // background-color: white;
        animation: load 0.3s linear;
        transform: translateY(0px);
        opacity: 1;

        @keyframes load {
            0% {
                opacity: 0;
                transform: translateY(60px)
            }

            100% {
                opacity: 1;
                transform: translateY(0px)
            }
        }

        .left {
            width: 50%;
            height: 320px;
            // background-color: aqua;

            .introduce {
                width: 94%;
                height: 95%;
                font-size: 14px;
                display: flex;
                flex-direction: column;
                justify-content: space-between;

                .wenzi {
                    display: flex;
                    flex-direction: column;
                }
            }
        }

        .right {
            width: 50%;
            // height: 600px;
            // background-color: aquamarine;
        }
    }

    .section {
        width: 75%;
        // height: 500px;
        margin: 30px auto;
        position: relative;
        z-index: 999;
        // background-color: white;
        animation: load 0.3s linear;
        transform: translateY(0px);
        opacity: 1;

        @keyframes load {
            0% {
                opacity: 0;
                transform: translateY(60px)
            }

            100% {
                opacity: 1;
                transform: translateY(0px)
            }
        }

        p {
            font-size: 34px;
            color: #333;
            text-align: center;
            margin-bottom: 51px;
        }

    }
}
</style>

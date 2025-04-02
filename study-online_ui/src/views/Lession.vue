<template>
    <div class="lession">
        <Header :index3="activeIndex" />
        <div class="main">
            <div class="left">
                <el-card class="box-card" shadow="always">
                    <h3>目录</h3>
                    <el-tree style="margin-top: 20px" :data="data" :props="defaultProps" @node-click="handleNodeClick"
                        :accordion="true" node-key="id" :default-expanded-keys="expandedList" @node-expand="nodeExpand"
                        @node-collapse="nodeCollapse"></el-tree>
                </el-card>
            </div>
            <div class="right">
                <span style="
                    display: inline-block;
                    font-size: 20px;
                    color: #333;
                    font-weight: 500;
                    margin-bottom: 20px;
                    ">服务竞争环境</span>
                <p><i></i>视频</p>
                <video-player class="video-player vjs-custom-skin" ref="videoPlayer" :playsinline="true"
                    :options="playerOptions" @play="onPlayerPlay($event, 'play')" @pause="onPlayerPause($event, 'pause')"
                    @timeupdate="onPlayerTimeupdate($event, 'timeupdate')" @ready="playerReadied($event)"
                    @ended="onPlayerEnded($event)">
                </video-player>
                <!-- <span style="margin-top: 8px; font-size: 12px; color: #666">本课程中的部分图片、音频和视频素材来源于网络，仅供教学使用。如有问题，请点击<a
                        href="/" style="color: #1769fe; outline: none; text-decoration: none">
                        这里 </a>反馈。</span> -->
                <p style="margin-top: 20px"><i></i>评论</p>
                <div style="
                    width: 100%;
                    display: flex;
                    flex-direction: row;
                    justify-content: space-between;
                    margin-top: 15px;
                  ">
                    <el-input type="textarea" placeholder="请输入内容" v-model="text"></el-input>
                    <el-button type="primary" plain style="height: 54px" @click="comment">发布</el-button>
                </div>
                <div class="comment">
                    <div class="main-comment" v-for="item in  commentList  " :key="item.id">
                        <div class="d1">
                            <el-avatar v-if="item.user.img
                                " :size="24" :src="item.user.img"></el-avatar>
                            <span style="
                            margin-left: 10px;
                            font-size: 14px;
                            font-weight: 500;
                            color: #333;
                        ">{{ item.user.loginName }}</span>
                        </div>
                        <div class="d2">
                            <span>{{ item.content }}</span>
                            <div class="d3">
                                <span style="font-size: 12px; color: #999; margin-top: 3px">{{
                                    item.time
                                }}</span>
                                <div style="display: flex;flex-direction: row;">
                                    <span style="
                                font-size: 13px;
                                color: #666;
                                font-weight: 400;
                                margin-right: 5px;
                                position: relative;
                                top: 1.5px;
                            ">({{ item.zan }})</span>
                                    <i @click="dianzan(item)" :class="{ active: isInArray(newShowId, item.id) }"
                                        style="margin-right: 10px;font-size: 20px;position: relative;top: -1.5px;"
                                        class="iconfont icon-good"></i>
                                    <i @click="goReply(item)" class="iconfont icon-huifu"
                                        style="font-size: 24px;position: relative;top: -3.5px;"></i>
                                </div>
                            </div>
                            <div style="display: flex;margin-top: 10px;margin-bottom: 10px;" v-show="item.id == replyId">
                                <el-input type="textarea" :placeholder="`回复${item.user.loginName}`"
                                    v-model="replyText"></el-input>
                                <el-button type="primary" plain style="height: 54px" @click="reply">发布</el-button>
                            </div>
                            <div v-show="item.reply.length > 0"
                                style="border-radius: 10px;border: 1px solid #999;margin-top: 10px;">
                                <div v-for="i in item.reply" :key="i.id" style="width: 90%;margin: 10px auto;">
                                    <div class="d1">
                                        <el-avatar :size="24" v-if="i.user.img" :src="i.user.img"></el-avatar>
                                        <span style="
                            margin-left: 10px;
                            font-size: 14px;
                            font-weight: 500;
                            color: #333;
                        ">{{ i.user.loginName }}</span>
                                    </div>
                                    <div class="d2">
                                        <span>{{ i.content }}</span>
                                        <div class="d3">
                                            <span style="font-size: 12px; color: #999; margin-top: 3px">{{
                                                i.time
                                            }}</span>
                                            <div style="display: flex;flex-direction: row;">
                                                <span style="
                                font-size: 13px;
                                color: #666;
                                font-weight: 400;
                                margin-right: 5px;
                                position: relative;
                                top: 1.5px;
                            ">({{ i.zan }})</span>
                                                <i @click="dianzan(i)" :class="{ active: isInArray(newReplyShowId, i.id) }"
                                                    style="margin-right: 10px;font-size: 16px;position: relative;top: 1.5px;"
                                                    class="iconfont icon-good"></i>
                                                <!-- <i @click="goReply(item)" class="iconfont icon-huifu"
                                        style="font-size: 24px;position: relative;top: -3.5px;"></i> -->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div></div>
                </div>
            </div>
        </div>
        <Footer />
    </div>
</template>

<script>
import Header from "@/components/Header.vue";
import Footer from "@/components/Footer.vue";
import Video from "@/components/Video.vue";
import { getLessonTreeById, getVideo } from '@/api/lesson.js'
import { getComment, comment, like } from '@/api/comment.js'
import { updateMyLesson } from '@/api/myLesson.js'
import { updateMyScore, getMyScore, addScoreDetail } from '@/api/score.js'
import {
    videoPlayer
} from 'vue-video-player'
import { createNamespacedHelpers, mapMutations, mapState } from "vuex";
export default {
    name: "StudyOnlineLession",
    inject: ['reload'],
    data() {
        return {
            data: [],
            defaultProps: {
                children: "children",
                label: "name",
            },
            text: "",
            replyText: '',
            videoPath: '',
            commentList: [],
            activeIndex: '0',
            playerOptions: {
                playbackRates: [0.7, 1.0, 1.5, 2.0], //播放速度
                autoplay: false, //如果true,浏览器准备好时开始回放。
                muted: false, // 默认情况下将会消除任何音频。
                loop: false, // 导致视频一结束就重新开始。
                preload: 'auto', // 建议浏览器在<video>加载元素后是否应该开始下载视频数据。auto浏览器选择最佳行为,立即开始加载视频（如果浏览器支持）
                language: 'zh-CN',
                aspectRatio: '16:9', // 将播放器置于流畅模式，并在计算播放器的动态大小时使用该值。值应该代表一个比例 - 用冒号分隔的两个数字（例如"16:9"或"4:3"）
                fluid: true, // 当true时，Video.js player将拥有流体大小。换句话说，它将按比例缩放以适应其容器。
                sources: [{
                    type: "video/mp4",
                    src: localStorage.getItem("video") ? localStorage.getItem("video") : "https:study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4" //你的视频地址（必填）
                }],
                poster: "", //你的封面地址
                // width: document.documentElement.clientWidth,
                notSupportedMessage: '此视频暂无法播放，请稍后再试', //允许覆盖Video.js无法播放媒体源时显示的默认信息。
                controlBar: {
                    timeDivider: true,
                    durationDisplay: true,
                    remainingTimeDisplay: false,
                    fullscreenToggle: true //全屏按钮
                }
            },
            durations: 0, //视频播放时长
            expandedList: 1, //默认展开节点
            // circleUrl: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png",
            pId: this.$route.params.treeId ? this.$route.params.treeId : "",
            // isReply: false,
            replyId: '',
            count: 0,
            // timer: '',//定时器名称
            scoreTimer: '', //积分定时器名称
            scoreTime: 0,  //积分计时器
            score: '',
            userId: localStorage.getItem('userId'),
            lessonId: this.$route.params.id,
            users: [],
            showId: [],
            newShowId: [],
            replyUsers: [],
            replyShowId: [],
            newReplyShowId: [],
            zanComment: [],
            zanReply: [],
            zanComment2: [],
            zanReply2: [],
            noShowId: [],
            newNoShowId: []
            // isCut: false  //是否在本页面切换
        };
    },
    components: {
        Header,
        Footer,
        Video,
        videoPlayer
    },

    created() {
        if (this.defaultList) {
            this.expandedList = this.defaultList.map(Number)
        }
        if (this.treeId) {
            this.pId = this.treeId
        }
        if (this.isCut) {
            this.durations = 0
        } else {
            this.durations = this.$route.params.durations
        }
        // console.log(this.isCut, 'isCut');
    },

    mounted() {
        window.addEventListener('scroll', this.saveScrollPosition)
        this.loadScrollPosition()
        this.getTree(),
            this.getComment();
        // console.log(this.expandedList, "expandedList");
        if (this.pId) {
            getVideo(this.pId).then(({ data: res }) => {
                this.SETEXPANDEDLIST(this.expandedList)
                this.playerOptions.sources.src = res.link
            })
        }

        getMyScore(this.userId).then(({ data: res }) => {
            this.score = res.score
        })
    },

    beforeDestroy() {
        console.log("进入");
        window.removeEventListener('scroll', this.saveScrollPosition)
        // clearInterval(this.timer)
        clearInterval(this.scoreTimer)
        const str = this.expandedList.join(',')
        updateMyLesson({
            durations: this.durations,
            lessonId: this.lessonId,
            expandedList: str
        }).then(res => {
            // console.log("1");
        })
        this.scoreTime = ""
    },

    destroyed() {
        clearInterval(this.scoreTimer)
        // clearInterval(this.timer)
        const str = this.expandedList.join(',')
        updateMyLesson({
            durations: this.durations,
            lessonId: this.lessonId,
            expandedList: str
        }).then(res => {
            // console.log("1");
        })
        this.scoreTime = ""
    },

    computed: {
        ...mapState(['defaultList', 'treeId', 'isCut'])
    },

    // watch: {
    //     newShowId(newVal, oldVal) {
    //         console.log(newVal, 'new');
    //         console.log(oldVal, 'old');
    //     }
    // },

    methods: {
        ...mapMutations(['SETEXPANDEDLIST', 'SETTREEID', 'SETISCUT']),
        getTree() {
            getLessonTreeById(this.lessonId).then(({ data: res }) => {
                this.data = res
            })
        },
        getComment() {
            this.users = [],
                this.replyUsers = []
            this.showId = []
            this.replyShowId = []
            if (this.pId) {
                getComment(this.pId).then(({ data: res }) => {
                    this.commentList = res
                    res.filter(v => {
                        // console.log(v);
                        if (v.users) {
                            var n = v.users.split(",");
                            // console.log(n);
                            this.users.push({
                                id: v.id,
                                users: n
                            })
                            // console.log(this.users);
                        }
                        v.reply.filter(m => {
                            if (m.users) {
                                var x = m.users.split(",");
                                this.replyUsers.push({
                                    id: m.id,
                                    users: x
                                })
                            }
                        })
                    })
                    this.users.filter(u => {
                        // console.log(u.users, 'users');
                        if (this.isInArray(u.users, this.userId)) {
                            this.showId.push(u.id),
                                this.newShowId = [...new Set(this.showId)]
                            // console.log(this.newShowId, 'newShowId');
                        }
                    })
                    this.replyUsers.filter(g => {
                        if (this.isInArray(g.users, this.userId)) {
                            this.replyShowId.push(g.id)
                            this.newReplyShowId = [...new Set(this.replyShowId)]
                        }
                    })
                })
            }
        },
        isInArray(arr, value) {
            for (var i = 0; i < arr.length; i++) {
                if (value == arr[i]) {
                    return true;
                }
            }
            return false;
        },
        comment() {
            if (this.pId) {
                if (this.text) {
                    comment({
                        userId: this.userId,
                        treeId: this.pId,
                        content: this.text
                    }).then(res => {
                        this.$message.success("评论发布成功！")
                        this.getComment()
                        this.text = ""
                    })
                } else {
                    this.$message.warning("请输入要评论的内容哦~")
                }
            } else {
                this.$message.warning("该课程暂无章节，请等上线后再评论哦~")
            }

        },

        dianzan(item) {
            console.log(this.newShowId,"newShowId")
            console.log(item.id,"id")
            console.log(this.isInArray(this.newShowId, item.id) || this.isInArray(this.newReplyShowId, item.id))
            if (this.isInArray(this.newShowId, item.id) || this.isInArray(this.newReplyShowId, item.id)) {
                console.log("取消点赞")
                this.commentList.filter(v => {
                    if (v.id == item.id) {
                        this.zanComment = v.users.split(',')
                        this.zanComment = this.zanComment.filter(v => v != this.userId)
                        this.zanComment = [...new Set(this.zanComment)]
                        this.zanComment = this.zanComment.join(',')
                        like({
                            id: item.id,
                            zan: item.zan - 1>=0?item.zan-1:0,
                            users: this.zanComment
                        }).then(res => {
                            this.users = []
                            let index=this.newShowId.indexOf(item.id)
                            this.newShowId.splice(index,1)
                            this.getComment()
                            this.$message.success('已取消评论点赞')
                        })
                    }
                    v.reply.filter(m => {
                        if (m.id == item.id) {
                            this.zanReply = m.users.split(',')
                            this.zanReply = this.zanReply.filter(x => x != this.userId)
                            this.zanReply = [...new Set(this.zanReply)]
                            this.zanReply = this.zanReply.join(',')
                            like({
                                id: item.id,
                                zan: item.zan - 1>=0?item.zan-1:0,
                                users: this.zanReply
                            }).then(res => {
                                this.replyUsers = []
                                let index=this.newReplyShowId.indexOf(item.id)
                                this.newReplyShowId.splice(index,1)
                                this.getComment()
                                this.$message.success('已取消回复点赞')
                            })
                        }
                    })
                })

            } else {
                console.log("进入点赞")
                // console.log(this.users, '微单赞');
                this.commentList.filter(v => {
                    // console.log(v);
                    if (v.id == item.id) {
                        let cu = v.users
                        if (cu) {
                            cu = cu.split(',')
                        } else {
                            cu = []
                        }
                        cu.push(this.userId)
                        cu = cu.join(',')
                        // console.log(cu);
                        like({
                            id: item.id,
                            zan: item.zan + 1,
                            users: cu
                        }).then(res => {
                            this.users = []

                            this.getComment()
                            this.$message.success('已对评论点赞')
                        })
                    }
                    v.reply.filter(m => {
                        // console.log(m)
                        if (m.id == item.id) {
                            let ru = m.users
                            if (ru) {
                                ru = ru.split(',')
                            } else {
                                ru = []
                            }

                            ru.push(this.userId)
                            ru = ru.join(',')
                            // console.log(ru);
                            like({
                                id: item.id,
                                zan: item.zan + 1,
                                users: ru
                            }).then(res => {
                                this.replyUsers = []
                                this.getComment()
                                this.$message.success('已对回复点赞')
                            })
                        }
                    })
                })
            }


        },
        goReply(item) {
            if (this.count == 0) {
                this.replyId = item.id
            }
            this.count++
            if (item.id == this.replyId) {
                if (this.count % 2 == 0) {
                    this.replyId = ''
                } else {
                    this.replyId = item.id
                }
            } else {
                this.replyId = item.id
            }
        },
        reply() {
            if (this.replyText) {
                comment({
                    userId: this.userId,
                    treeId: this.pId,
                    content: this.replyText,
                    pid: this.replyId
                }).then(res => {
                    this.$message.success("回复评论成功！")
                    this.getComment()
                    this.replyId = ''
                })
            } else {
                this.$message.warning("请输入要回复的内容哦~")
            }

        },
        nodeExpand(data) {
            this.expandedList.push(data.id); // 在节点展开是添加到默认展开数组
        },
        nodeCollapse(data) {
            this.expandedList.splice(this.expandedList.indexOf(data.id), 1); // 收起时删除数组里对应选项
        },
        handleNodeClick(data) {
            // this.defaultShowNodes.push(data.id)
            // console.log(data);
            // this.isCut = !this.isCut
            this.SETISCUT(true)
            if (data.level == 2) {
                this.pId = data.id
                this.SETTREEID(data.id)
                // this.getComment()
                getVideo(data.id).then(({ data: res }) => {
                    // console.log(res);
                    this.SETEXPANDEDLIST(this.expandedList)
                    this.playerOptions.sources.src = res.link
                    localStorage.setItem('expandedList', this.expandedList)
                    localStorage.setItem("video", res.link)
                    // console.log(this.playerOptions.sources.src);
                    this.reload()
                    // console.log(this.playerOptions.sources.src);
                })
            }

        },
        onPlayerEnded(player) {
            // 向后台传值  
            // console.log(this.durations, player)
            //   this.putLearningObj()
        },
        onPlayerPlay(player) {
            // console.log('player play!', player)

            // this.timer = setInterval(() => {

            // }, 1000);
            this.scoreTimer = setInterval(() => {
                this.scoreTime++
                if (this.scoreTime % 60 == 0 && this.scoreTime !== 0) {
                    parseInt(this.scoreTime / 60)
                    updateMyScore({
                        userId: this.userId,
                        score: this.score + parseInt(this.scoreTime / 60)
                    }).then(res => {
                        addScoreDetail({
                            score: 1,
                            way: "观看视频",
                            userid: this.userId
                        }).then(res => { })
                        // this.$message.success("积分+1")
                    })
                }
            }, 1000)

            // console.log(this.scoreTime/60,'scoretime');

        },
        onPlayerPause(player) {
            const str = this.expandedList.join(',')
            // console.log('player pause!', this.durations, player)
            // clearInterval(this.timer)
            clearInterval(this.scoreTimer)
            updateMyLesson({
                durations: this.durations,
                lessonId: this.lessonId,
                expandedList: str
            }).then(res => {
            })
            // 向后台存播放时间
            // this.putLearningObj()
        },

        onPlayerTimeupdate(player) {
            // console.log(player.cache_.currentTime, "player.cache_.currentTime");
            this.durations = player.cache_.currentTime
            // clearInterval(this.timer)
            // this.durations = player.cache_.currentTime
            // sessionStorage.setItem('currentTime'+this.cacheVideoObj.videoId,this.durations); 
        },

        playerReadied(player) {
            player.currentTime(this.durations)
        },
        saveScrollPosition() {
            localStorage.setItem('scrollPosition', window.pageYOffset)
        },
        loadScrollPosition() {
            const scrollPosition = localStorage.getItem('scrollPosition')
            if (scrollPosition) {
                window.scrollTo(0, parseInt(scrollPosition))
                localStorage.removeItem('scrollPosition')
            }
        }
    },
};
</script>

<style lang="less" scoped>
/deep/ .el-textarea__inner {
    // height: 60px;
    width: 99%;
    // overflow: auto;
    // width: 90%;
}

/deep/ .el-tree-node__content {
    padding: 10px;
}

/deep/ .el-card__body {
    max-height: 85vh;
    overflow: auto;
}

/deep/ .el-tree-node__label {
    display: inline-block;
    overflow: hidden;
    text-overflow: ellipsis;
    -webkit-line-clamp: 1;
    word-wrap: break-word;
    // display: -webkit-box;
    // -webkit-box-orient: vertical;
}

.lession {
    width: 100%;
    height: 100%;

    .main {
        width: 81%;
        height: 90vh;
        margin: 120px auto;
        position: relative;
        z-index: 999;
        // background-color: white;
        // background-color: aqua;
        display: flex;
        flex-direction: space-between;

        .left {
            width: 26%;
            margin: 0 auto;
            height: 100%;

            // background-color: aquamarine;
            .box-card {
                height: 100%;
            }
        }

        .right::-webkit-scrollbar {
            display: none;
        }

        .right {
            margin: 0 auto;
            width: 66%;
            height: 100%;
            max-height: 89vh;
            overflow: auto;
            animation: load 0.3s linear;
            transform: translateX(0px);
            opacity: 1;

            @keyframes load {
                0% {
                    opacity: 0;
                    transform: translateX(60px);
                }

                100% {
                    opacity: 1;
                    transform: translateX(0px);
                }
            }

            // background-color: azure;
            p {
                margin-bottom: 10px;

                i {
                    width: 3px;
                    height: 13px;
                    display: inline-block;
                    vertical-align: bottom;
                    background: #333;
                    margin-right: 8px;
                    position: relative;
                    top: -4px;
                }
            }

            .comment {
                width: 90%;
                margin: 0 auto;
                margin-top: 20px;
                border-top: 1px solid #f3f3f3;
                padding-top: 10px;
                border-bottom: 1px solid #f3f3f3;
                padding-bottom: 30px;

                .main-comment {
                    width: 100%;
                    display: flex;
                    flex-direction: column;
                    margin-bottom: 25px;

                    .d1 {
                        display: flex;
                        flex-direction: row;
                        align-items: center;
                    }

                    .d2 {
                        padding-top: 15px;
                        margin-left: 32px;
                        display: flex;
                        flex-direction: column;
                        font-size: 14px;
                        color: #333;
                        font-weight: 400;

                        .d3 {
                            height: 25px;
                            display: flex;
                            flex-direction: row;
                            justify-content: space-between;

                            .active {
                                color: red;
                            }
                        }
                    }
                }
            }
        }
    }
}
</style>

<template>
    <div class="news-report">
        <Header :ai=activeIndex />
        <div class="main">
            <p>热门新闻 <span style="float: right;font-size: 12px;color: #0067b5;cursor: pointer;"
                    @click="$router.push('/newsList')">more</span> </p>
            <div class="top">
                <div class="left" v-for="item in hotNews" :key="item.id">
                    <el-card class="box-card" shadow="hover" @click.native="$router.push(`/newDetail/${item.id}`)">
                        <div class="img">
                            <span style="position: absolute;background-color: #5584b3;color: #fff;height: 32px;width: 98px;
                                text-align: center;line-height: 32px;font-size: 14px;">{{
                                    item.time.slice(0, 10) }}</span>
                            <img width="100%" :src="item.img" alt="" srcset="">
                        </div>
                        <div class="describe">
                            <span style="font-size: 16px; color: #0068b7;padding-top: 8px;padding-left: 15px;">{{ item.title
                            }}</span>
                            <span class="s1">{{ item.content }}</span>
                        </div>
                    </el-card>
                </div>
            </div>
            <div class="bottom">
                <p style="margin-bottom: 12px;">最新新闻 <span
                        style="float: right;font-size: 12px;color: #0067b5;cursor: pointer;"
                        @click="$router.push('/newsList')">more</span> </p>
                <el-card class="box-card" shadow="hover">
                    <div class="news">
                        <p v-for="item in latestNews" :key="item.id"
                            style="border: none;margin-bottom: 5px;width: 90%;margin: 18px auto;"><i
                                style="display: inline-block;width: 5px;height: 5px;border-radius: 50%;background-color: #333;position: relative;top: -2.5px;"></i>
                            <span style="cursor: pointer ;overflow: hidden;" @click="$router.push(`/newDetail/${item.id}`)">
                                {{ item.title }}</span>
                            <span style="font-size: 14px;color: #a0a0a0;float: right;">{{ item.time.slice(0, 10) }}</span>
                        </p>
                    </div>
                </el-card>
            </div>
        </div>
        <Footer v-show="footerShow"/>
    </div>
</template>

<script>
import Header from '@/components/Header.vue';
import Footer from '@/components/Footer.vue';
import { getHotNews, getLatestNews } from '@/api/news.js'
export default {
    name: 'StudyOnlineNewsReport',

    data() {
        return {
            activeIndex: '6',
            hotNews: [],
            latestNews: [],
            footerShow: true
        };
    },
    components: {
        Header,
        Footer
    },
    created() {
        this.footerShow=false
    },

    mounted() {
        this.getNews()
        setTimeout(() => {
            this.footerShow=true
        }, 150);
    },

    methods: {
        getNews() {
            getHotNews().then(({ data: res }) => {
                this.hotNews = res
            })
            getLatestNews().then(({ data: res }) => {
                this.latestNews = res
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

/deep/ .el-card {
    border: none;
}

.news-report {
    width: 100%;
    height: 100%;

    .main {
        // height: 120vh;
        width: 65%;
        margin: 120px auto;
        // background-color: beige;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
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

        // margin-bottom: 30px;

        p {
            margin-bottom: 10px;
            padding-bottom: 10px;
            color: #333;
            border-bottom: 1px solid #ebebeb;
        }

        .top {
            width: 100%;
            height: 55%;
            // background-color: chartreuse;
            display: flex;
            flex-direction: row;
            justify-content: space-between;

            .left {
                width: 48%;
                height: 100%;
                // background-color: aquamarine;

                .box-card {
                    height: 100%;

                    .img {
                        width: 99.5%;
                        margin: 2px auto;
                    }

                    .describe {
                        width: 100%;
                        display: flex;
                        flex-direction: column;
                        justify-content: space-around;
                        // padding: 0 15px;

                        .s1 {
                            // padding-top: 15px;
                            margin-top: 8px;
                            margin-bottom: 20px;
                            display: -webkit-box;
                            overflow: hidden;
                            text-overflow: ellipsis;
                            -webkit-box-orient: vertical;
                            word-break: break-word;
                            word-wrap: break-word;
                            -webkit-line-clamp: 3;
                            font-size: 14px;
                            color: #7d7d7d;
                            line-height: 24px;
                            padding: 0 15px;
                        }

                        // background-color: aqua;
                    }
                }
            }

            .right {
                width: 48%;
                height: 100%;
                // background-color: antiquewhite;

                .box-card {
                    height: 100%;

                    .img {
                        width: 99.5%;
                        margin: 2px auto;
                    }

                    .describe {
                        width: 100%;

                        display: flex;
                        flex-direction: column;
                        justify-content: space-around;
                        // padding: 0 15px;

                        .s1 {
                            // padding-top: 15px;
                            margin-top: 8px;
                            margin-bottom: 10px;
                            display: -webkit-box;
                            overflow: hidden;
                            text-overflow: ellipsis;
                            -webkit-box-orient: vertical;
                            word-break: break-word;
                            word-wrap: break-word;
                            -webkit-line-clamp: 3;
                            font-size: 14px;
                            color: #7d7d7d;
                            line-height: 24px;
                            padding: 0 15px;
                        }
                    }
                }
            }
        }

        .bottom {
            margin-top: 50px;
            width: 100%;
            height: 40%;
            // background-color: cadetblue;

            .box-card {
                height: 100%;
            }
        }
    }
}
</style>

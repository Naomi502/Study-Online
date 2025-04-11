<template>
    <div class="news-list">
        <Header :ai=activeIndex />
        <div class="main">
            <div class="left">
                <span>新闻一览</span>
            </div>
            <div class="right">
                <p><span style="font-size: 17px;color: #333;font-weight: 600;">招标公告</span>
                    <!-- <span
                        style="float: right;font-size: 14px; color: #454545;">当前位置:首页 <el-divider
                            direction="vertical"></el-divider> <span>招标公告</span></span> -->
                </p>
                <div style="width: 100%;margin-top: 10px;">
                    <p style="border: none;padding: 5px 0;border-bottom: 1px dashed #b1b1b1;cursor: pointer;"
                        @click="$router.push(`/newDetail/${item.id}`)" v-for="item in list" :key="item.id"> <span> <i
                                class="el-icon-news"></i> {{ item.title }}</span>
                        <span style="float: right;color: #999;">{{ item.time.slice(0, 10) }}</span>
                    </p>

                </div>
                <div class="block">
                    <el-pagination @current-change="handleCurrentChange" :current-page.sync="currentPage3" :page-size="100"
                        layout="prev, pager, next, jumper" :page-count="Math.ceil(total / pageSize)">
                    </el-pagination>
                </div>
            </div>
        </div>
        <Footer />
    </div>
</template>

<script>
import Header from '@/components/Header.vue';
import Footer from '@/components/Footer.vue';
import { getAllNews } from '@/api/news.js'
export default {
    name: 'StudyOnlineNewsList',

    data() {
        return {
            currentPage3: 5,
            activeIndex: '6',
            list: [],
            total: 0,
            page: 1,
            pageSize: 15,
        };
    },

    components: {
        Header,
        Footer
    },

    mounted() {
        this.getAllNews()
    },

    methods: {
        getAllNews() {
            getAllNews(this.page, this.pageSize).then(({ data: res }) => {
                // console.log(res);
                this.total = res.total
                this.list = res.allNews
                // console.log(this.list);
            })
        },
        handleCurrentChange(val) {
            this.page = val
            // console.log(`当前页: ${val}`);
            this.getAllNews()
        }
    },
};
</script>

<style lang="less" scoped>
.news-list {
    width: 100%;
    height: 100%;

    .main {
        width: 80%;
        margin: 120px auto;
        height: 75vh;
        // background-color: aqua;
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        position: relative;
        z-index: 999;
        background-color: white;
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
            width: 23%;
            height: 56px;
            background-color: #5584b3;

            span {
                margin-left: 15px;
                font-size: 18px;
                color: #fff;
                font-weight: normal;
                line-height: 56px;
                // text-align: center;
            }
        }

        .right {
            width: 74%;
            // background-color: bisque;

            p {
                padding: 10px 0;
                border-bottom: 2px solid #e5e5e5;
            }

            .block {
                float: right;
                margin-top: 15px;
            }
        }
    }
}
</style>

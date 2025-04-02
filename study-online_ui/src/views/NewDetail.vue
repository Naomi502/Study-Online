<template>
    <div class="new-detail">
        <Header :ai=activeIndex />
        <div class="main">
            <p class="p1">{{ newsDetail.title }}</p>
            <h2></h2>
            <p class="p2">
                <span>作者: {{ teacher }}</span>
                <span>时间: {{ time }}</span>
                <span>浏览: {{ newsDetail.dianJi }}</span>
            </p>
            <div class="remark">
                <el-collapse v-model="activeNames" @change="handleChange">
                    <el-collapse-item title="新闻简介" name="1">
                        <div>{{ newsDetail.remark }}</div>
                        <div style="width: 100%; margin: 15px auto;">
                            <img v-if="newsDetail.img" :src="newsDetail.img" style="text-align: center;
                            -webkit-filter: drop-shadow(10px 10px 10px rgba(0,0,0,.5)); 
                            filter: drop-shadow(10px 10px 10px rgba(0,0,0,.5));
                            " width="450px" height="300px" alt="">
                        </div>
                    </el-collapse-item>
                </el-collapse>
            </div>
            <div class="content">
                <p style="font-size: 20px;color: #333;text-align: center;font-family: 微软雅黑;font-weight: bolder;">{{
                    newsDetail.title }}</p>
                <el-card class="box-card" shadow="never">
                    <div style="font-size: 16px;line-height: 60px;">
                        {{ newsDetail.content }}
                    </div>
                    <div class="author">
                        <span style="text-align: end;">{{ teacher }}</span>
                        <span>{{ time }}</span>
                    </div>
                </el-card>
            </div>
        </div>
        <Footer v-show="footerShow" />
    </div>
</template>

<script>
import Header from '@/components/Header.vue';
import Footer from '@/components/Footer.vue';
import { getNewsDetail } from '@/api/news.js'
export default {
    name: 'StudyOnlineNewDetail',

    data() {
        return {
            activeIndex: '6',
            activeNames: ['1'],
            id: this.$route.params.id,
            newsDetail: {},
            teacher: '',
            time: '',
            footerShow: true
        };
    },

    components: {
        Header,
        Footer
    },

    created() {
        this.footerShow = false
    },

    mounted() {
        this.getNewsDetail()
        setTimeout(() => {
            this.footerShow = true
        }, 150);
    },

    methods: {
        getNewsDetail() {
            getNewsDetail(this.id).then(({ data: res }) => {
                this.newsDetail = res
                this.teacher = res.teacher.tname
                this.time = res.time.slice(0, 10)
                console.log(this.newsDetail);
            })
        },
        handleChange(val) {
            // console.log(val);
        }
    },
};
</script>

<style lang="less" scoped>
/deep/ .el-card {
    border: none;
}

/deep/ .el-collapse-item__header {
    border: none;
}

/deep/ .el-collapse-item__wrap {
    border: none;
}

// /deep/ .el-collapse,
// .el-collapse-item__wrap {
//     border: none;
// }

.new-detail {
    width: 100%;

    .main {
        width: 80%;
        height: 100%;
        margin: 140px auto;
        animation: load 0.3s linear;
        transform: translateX(0px);
        position: relative;
        z-index: 999;
        // background-color: white;
        opacity: 1;

        @keyframes load {
            0% {
                opacity: 0;
                transform: translateX(-80px)
            }

            100% {
                opacity: 1;
                transform: translateX(0px)
            }
        }

        // background-color: aquamarine;
        .p1 {
            text-align: center;
            font-size: 22px;
            color: #424242;
            font-weight: normal;
        }

        h2 {
            padding: 5px;
            border-bottom: 2px solid #ECECEC;
        }

        .p2 {
            text-align: center;
            font-size: 12px;
            color: #787878;
            margin-top: 10px;
            padding-bottom: 10px;
            // border-bottom: 1px solid #f1f1f1;

            span {
                padding: 5px;
            }
        }

        .content {
            margin-top: 5px;

            .author {
                float: right;
                display: flex;
                flex-direction: column;
                margin-top: 10px;

                span {
                    font-size: 16px;
                    color: #333;
                    font-family: 宋体;
                    padding: 3px;
                }
            }
        }
    }
}
</style>

<template>
    <div class="search-lesson">
        <Header />
        <div class="main">
            <div class="left">
                <el-card class="box-card">
                    <div slot="header" class="clearfix">
                        <span style="font-size: 18px;font-weight: 600;">筛选 </span>
                        <span> 课程分类</span>
                    </div>
                    <el-button @click="all" type="success"
                        style="width: 112px;height: 36px;margin-left: 8px;margin-bottom: 15px;">全部</el-button>
                    <div v-for="item in category" :key="item.id" class="text item" style="text-align: center;">
                        <span :class="[{ active: activeId == item.id }]" class="ss" @click="clickCategory(item.id)">{{
                            item.name }}</span>
                    </div>
                </el-card>
            </div>
            <div v-if="list.length > 0" class="right">
                <el-card v-for="item in list" :key="item.id" class="box-card" shadow="hover">
                    <div class="text" @click="toDetail(item)">
                        <img width="266px" height="150px" :src="item.img" alt="">
                        <div class="introduce">
                            <div style="display: flex;flex-direction: column;">
                                <span style="font-size: 16px; color: #333;font-weight: 700;">{{ item.lname }}</span>
                                <div style="display: flex;margin-top: 10px;">
                                    <span style="font-size: 14px; color: #b1b1b1;margin-right: 10px;">
                                        <i class="el-icon-school" style="position: relative;top: 1.25px;"></i> {{
                                            item.school }}
                                    </span>
                                    <span style="font-size: 14px; color: #b1b1b1;">
                                        <i class="el-icon-user" style="position: relative;top: 1.25px;"></i> {{ item.dianJi
                                        }} 人
                                    </span>
                                    <span style="font-size: 14px; color: #b1b1b1;margin-left: 10px;">
                                        <i class="el-icon-lollipop" style="position: relative;top: 1.25px;"></i>讲师: {{ item.tname
                                        }}
                                    </span>
                                </div>
                                <span style="
                                margin-top: 15px;
                                font-size: 14px;
                                color: #b1b1b1;
                                overflow: hidden;
                                text-overflow: ellipsis;
                                -webkit-line-clamp: 3;
                                word-wrap: break-word;
                                display: -webkit-box;
                                -webkit-box-orient: vertical;">{{ item.remark }}</span>
                                <span class="s1">免费学习</span>
                            </div>
                        </div>
                    </div>
                </el-card>
                <div class="block">
                    <el-pagination background @current-change="handleCurrentChange" :current-page.sync="currentPage1"
                        :page-size="100" layout="total, prev, pager, next" :page-count="Math.ceil(total / pageSize)">
                    </el-pagination>
                </div>
            </div>
            <el-empty class="right" v-else description="为搜索到相关课程"></el-empty>
        </div>
        <Footer v-show="footerShow" />
    </div>
</template>

<script>
import Header from "@/components/Header.vue";
import Footer from "@/components/Footer.vue";
import { searchLesson, getHotCategory } from '@/api/lesson.js'
import { mapState } from "vuex";
export default {
    name: 'StudyOnlineSearchLesson',

    data() {
        return {
            name: "",
            currentPage1: 1,
            list: [],
            page: 1,
            pageSize: 6,
            total: '',
            footerShow: true,
            category: [],
            activeId: '',
        };
    },
    components: {
        Header,
        Footer
    },

    created() {
        this.footerShow = false
        if (this.search) {
            this.name = this.search
        }
        // console.log(this.search);
    },

    mounted() {

        setTimeout(() => {
            this.footerShow = true
            // console.log("1");
        }, 100);
        console.log(this.name);
        this.getLesson()
        getHotCategory().then(({ data: res }) => {
            this.category = res
            console.log(this.category);
        })
    },

    computed: {
        ...mapState(['search'])
    },

    watch: {
        search(newVal, oldVal) {
            console.log(newVal, 'new');
            console.log(oldVal, 'old');
            if (newVal !== oldVal) {
                this.name = newVal
                this.getLesson()
            }
        }
    },

    methods: {
        getLesson() {
            searchLesson({
                page: this.page,
                pageSize: this.pageSize,
                name: this.name?this.name:undefined
            }).then(({ data: res }) => {
                // console.log(res);
                this.list = res.records,
                    this.total = res.total
                // console.log(this.list);
            })
        },
        handleCurrentChange(val) {
            // console.log(`当前页: ${val}`);
            this.page = val
            this.getLesson()
        },
        clickCategory(id) {
            this.page = 1
            console.log(id);
            this.activeId = id
            searchLesson({
                page: this.page,
                pageSize: this.pageSize,
                name: this.name,
                categoryId: this.activeId
            }).then(({ data: res }) => {
                this.list = res.records,
                    this.total = res.total
            })
        },
        toDetail(item) {
            this.$router.push({
                name: 'class-details',
                query: {
                    id: item.id,
                    img: item.img
                }
            })
        },
        all() {
            this.activeId = '',
                this.page = 1
            this.getLesson()
            this.currentPage1 = 1
        }
    },
};
</script>

<style lang="less" scoped>
.main {
    width: 75%;
    // height: 200vh;
    display: flex;
    flex-direction: row;
    margin: 150px auto;
    justify-content: space-between;
    position: relative;
    z-index: 999;

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

    .left {
        width: 15%;
        height: 100%;
        background-color: aqua;

        .ss {
            width: 112px;
            height: 36px;
            line-height: 36px;
            font-size: 14px;
            display: block;
            text-align: center;
            background-color: rgba(65, 130, 250, 0.1);
            // margin-left: 16px;
            // padding: 8px;
            margin-left: 8px;
            margin-right: 8px;
            margin-bottom: 15px;
            cursor: pointer;
        }

        .ss:hover {
            color: #1769fe;
            background: rgba(65, 130, 250, 0.2);
        }

        .ss.active {
            color: #fff !important;
            background-color: #1769fe !important;
            font-weight: 700 !important;
        }

    }

    .right {
        width: 75%;
        height: 100%;
        padding-bottom: 100px;
        // background-color: aquamarine;

        .block {
            float: right;
            margin-top: 15px;
            margin-right: 25px;
            z-index: 999;
        }

        .box-card {
            width: 90%;
            margin: 0 auto;
            height: 190px;
            display: flex;
            position: relative;
            align-items: center;
            margin-bottom: 25px;

            .text {
                margin-left: 30px;
                display: flex;
                flex-direction: row;
                // justify-content: space-between;

                .introduce {
                    display: flex;
                    flex-direction: column;
                    justify-content: space-between;
                    margin-left: 30px;

                    .s1 {
                        margin-top: 25px;
                        padding-left: 10px;
                        padding-right: 10px;
                        width: 90px;
                        height: 20px;
                        line-height: 18px;
                        display: inline-block;
                        border: 1px solid #1769fe;
                        border-radius: 13px;
                        text-align: center;
                        font-size: 12px;
                        color: #4f8bfa;
                        background: #eef5ff;
                        cursor: pointer;
                    }

                    .s1:hover {
                        color: #1769fe;
                        background: rgba(65, 130, 250, 0.2);
                        // cursor: pointer;
                    }
                }

                .s2 {
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    position: absolute;
                    right: 0;
                    width: 120px;
                    height: 32px;
                    border-radius: 3px;
                    font-size: 16px;
                    cursor: pointer;
                    background: #1769fe;
                    color: #fff;
                    border: 1px solid #1769fe;
                    margin-right: 28px;
                }
            }
        }
    }
}
</style>
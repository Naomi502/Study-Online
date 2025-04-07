<template>
    <div class="personal-class">
        <el-card v-show="list.length != 0" v-for="item in list" :key="item.id" class="box-card" shadow="hover">
            <div class="text">
                <img width="228px" height="128px" :src="item.lesson.img" alt="">
                <div class="introduce">
                    <div style="display: flex;flex-direction: column;">
                        <span style="font-size: 16px; color: #333;font-weight: 700;">{{ item.lesson.lname }}</span>
                        <span class="s1">免费学习</span>
                    </div>
                    <span style="font-size: 12px; color: #b1b1b1;">授课人:{{ item.teacher.tname }}</span>
                    <span style="font-size: 14px; color: #b1b1b1;">
                        {{ item.time }}
                    </span>
                </div>
                <div style="display: flex;align-items: center;">
                    <span class="s2" @click="goLesson(item)">开始学习</span>
                </div>
            </div>
        </el-card>
        <el-empty v-show="list.length == 0">
            <el-button type="primary" @click="$router.push('/')">前往首页加入课程</el-button>
        </el-empty>
    </div>
</template>

<script>
import { getMyLesson } from '@/api/myLesson.js'
import { mapMutations } from 'vuex';
export default {
    name: 'StudyOnlinePersonalClass',

    data() {
        return {
            list: [],
            userId: localStorage.getItem('userId')
        };
    },

    mounted() {
        this.getMyLesson()
    },

    methods: {
        ...mapMutations(['SETEXPANDEDLIST', 'SETISCUT']),
        getMyLesson() {
            getMyLesson(this.userId).then(({ data: res }) => {
                console.log(res);
                this.list = res
            })
        },
        goLesson(item) {
            let n = item.expandedList.split(",")
            // console.log(item.expandedList);
            this.SETEXPANDEDLIST(n)
            this.SETISCUT(false)
            this.$router.push({
                name: 'lesson',
                params: {
                    id: item.lessonId,
                    durations: item.durations,
                    treeId: item.treeId
                }
            })
        }
    },
};
</script>

<style lang="less" scoped>
/deep/ .el-card__header {
    border: none;
}

.el-card {
    border: none;
}

.personal-class {
    width: 100%;
    height: 100%;
    max-height: 85vh;
    overflow: auto;
    margin-top: -54px;
    background-color: white;
    position: relative;
    z-index: 999;

    .box-card {
        width: 90%;
        margin: 0 auto;
        height: 170px;
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
</style>

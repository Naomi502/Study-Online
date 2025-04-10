<template>
    <div class="tree">
        <div v-if="lessonTree.length > 0">
            <div class="main" v-for="(item, index) in lessonTree" :key="item.id">
                <div class="fenlei" @click="active(item)">
                    <div>
                        <span class="s1">{{ index + 1 }}</span>
                        <span style="font-size: 18px; color: #333;">{{ item.name }}</span>
                    </div><a href="http://" target="_blank" rel="noopener noreferrer"></a>
                    <Transition name="icon">
                        <i v-show="item.children" v-if="!item.show" class="el-icon-arrow-down"></i>
                        <i v-else class="el-icon-arrow-up"></i>
                    </Transition>
                </div>
                <div class="more" v-for="i in item.children" :key="i.id">
                    <transition name='sub-menu'>
                        <span v-if="item.id == treeId" style="font-size: 14px;color: #333;"> <span class="icon"></span>{{
                            i.name
                        }}</span>
                    </transition>

                </div>
            </div>
        </div>
        <el-empty v-else description="暂无数据"></el-empty>

    </div>
</template>

<script>
import { getLessonTreeById } from '@/api/lesson.js'
export default {
    name: 'StudyOnlineTree',

    data() {
        return {
            lessonTree: [],
            treeId: '',
            // count: 0
        };
    },
    props: ['lessonId'],
    created() {
    },
    mounted() {
      console.log("5555555")
        this.getTrees()
    },

    methods: {
        getTrees() {
          console.log("666666")
            getLessonTreeById(this.lessonId).then(({ data: res }) => {
              console.log("7777")
              console.log(res)
                this.lessonTree = res
            })
        },
        active(item) {
            if (this.treeId == item.id) {
                this.treeId = ''
            } else {
                this.treeId = item.id
            }
        }
    },
};
</script>

<style lang="less" scoped>
.site-menu-sub {
    padding: 0px;
}

.sub-menu-enter-active,
.sub-menu-leave-active {
    transition: all .9s ease;
    max-height: 500px;
    /* 这里将最大高度设置为折叠元素不可能超越的高度 比如1000px */
}

.sub-menu-enter,
.sub-menu-leave-to {
    opacity: 0;
    max-height: 0px;
}

.tree {
    width: 800px;
    margin: 0 auto;
    margin-bottom: 120px;

    .main {
        line-height: 71px;
        display: flex;
        flex-direction: column;

        .fenlei {
            display: flex;
            align-items: center;
            border-bottom: 1px solid #ebebeb;
            justify-content: space-between;

            .s1 {
                display: inline-block;
                vertical-align: middle;
                font-size: 40px;
                color: #c8c8c8;
                padding: 0 26px 0 15px;
                // width: 86px;
                text-align: right;
            }
        }

        .more {
            width: 88%;
            margin: 0 auto;
            display: flex;
            transition: height 0.3s ease;

            .icon {
                display: inline-block;
                vertical-align: middle;
                width: 8px;
                height: 8px;
                background: #cbcbcb;
                margin-right: 20px;
                content: '';
                border-radius: 50%;
            }
        }

    }
}
</style>

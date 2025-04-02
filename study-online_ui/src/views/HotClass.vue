<template>
  <div>
    <div class="hot-class">
      <span>热门好课</span>
      <div class="header">
        <span class="s1" v-for="item in tipList" :key="item.id" @click="ontip(item)"
              :class="[{ active: activeName == item.name }]">{{ item.name }}</span>
      </div>
      <div style="display: flex; flex-wrap: wrap; margin: auto; justify-content: center">
        <el-skeleton animated v-show="skeletonShow" style="width:300px; padding: 25px;" v-for="(item, index) in 8" :key="index">
          <template slot="template">
            <el-skeleton-item variant="image" style="width: 100%; height: 180px;" />
            <div style="padding: 14px;">
              <el-skeleton-item variant="p" style="width: 30%" />
              <div style="display: flex; align-items: center; justify-content: space-between;">
                <el-skeleton-item variant="text" style="width: 60%;" />
                <el-skeleton-item variant="text" style="width: 20%;" />
              </div>
            </div>
          </template>
        </el-skeleton>
      </div>
      <div class="content" v-show="!skeletonShow">
        <el-empty v-if="lessons.length == 0" style="margin: 20px auto;" description="该分类下暂无相关课程！"></el-empty>
        <el-card v-else class="box" shadow="hover":body-style="{ padding: '10px' }" v-for="(item, index) in lessons" :key="index"
                 @click.native="toDetail(item)">
          <div class="top">
            <el-image style="width: 100%; height: 100%" :src="item.img" fit="cover">
              <div slot="error" class="image-error">
                <i class="el-icon-picture-outline"></i>
              </div>
            </el-image>
          </div>
          <div class="bottom">
            <div class="introduce">
              <span class="title">{{ item.lname }}</span>
              <span class="desc">{{ item.remark }}</span>
            </div>
            <div class="school">
              <span class="info">{{ item.school }}<span class="teacher">授课人:{{ item.tname }}</span></span>
              <span class="count"><i class="el-icon-user"></i>{{ item.dianJi }}</span>
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
.hot-class {
  padding: 60px 5%;
  max-width: 1600px;
  margin: 0 auto;
  animation: load 0.4s linear;
  @keyframes load {
    0% { opacity: 0; transform: translateY(70px); }
    100% { opacity: 1; transform: translateY(0); }
  }
  > span {
    font-size: 28px;
    margin-bottom: 16px;
    font-weight: 600;
    color: #1a1a1a;
  }
  .header {
    overflow-x: auto;
    scrollbar-width: none;
    &::-webkit-scrollbar { display: none; }
    margin: 20px 0 40px;
    height: auto;

    .s1 {
      min-width: 88px;
      height: 36px;
      line-height: 36px;
      font-size: 14px;
      display: inline-block;
      text-align: center;
      border-radius: 18px;
      background: rgba(65, 130, 250, 0.1);
      margin: 0 8px 8px;
      padding: 0 12px;
      transition: all 0.3s;

      &:hover {
        color: #1769fe;
        background: rgba(65, 130, 250, 0.2);
      }

      &.active {
        color: #fff !important;
        background: #1769fe !important;
      }
    }
  }
  .content {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 1.5rem;
    width: 100%;
    .box {
      width: 100%;
      border-radius: 8px;
      overflow: hidden;
      transition: transform 0.3s;
      cursor: pointer;

      &:hover {
        transform: translateY(-5px);
        box-shadow: 0 6px 18px rgba(0,0,0,0.1);
      }
      .top {
        position: relative;
        width: 100%;
        padding-top: 56.25%;
        background: #f5f7fa;

        .el-image {
          position: absolute;
          border-radius: 8px;
          top: 0;
          left: 0;
          height: 100%;
        }

        .image-error {
          position: absolute;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          display: flex;
          align-items: center;
          justify-content: center;
          background: #f0f2f5;
          color: #c0c4cc;
          font-size: 24px;
        }
      }
      .bottom {
        padding: 16px;

        .introduce {
          .title {
            font-size: 16px;
            font-weight: 500;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 2;
            margin-bottom: 8px;
            color: #1a1a1a;
          }

          .desc {
            font-size: 13px;
            color: #666;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 2;
          }
        }
        .school {
          margin-top: 16px;
          display: flex;
          justify-content: space-between;
          align-items: center;
          font-size: 12px;
          color: #999;

          .info {
            flex: 1;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;

            .teacher {
              margin-left: 8px;
              color: #666;
            }
          }

          .count {
            flex-shrink: 0;
            margin-left: 12px;

            i { margin-right: 4px; }
          }
        }
      }
    }
  }
}
@media (max-width: 768px) {
  .hot-class {
    padding: 40px 3%;

    > span { font-size: 24px; }

    .header .s1 {
      min-width: 72px;
      font-size: 13px;
      margin: 0 4px 8px;
    }

    .content {
      grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
      gap: 1rem;
    }
  }
}
@media (max-width: 480px) {
  .school {
    flex-direction: column;
    align-items: flex-start;

    .count { margin-top: 8px; }
  }
}
</style>
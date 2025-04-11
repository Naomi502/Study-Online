<template>
  <div class="dashboard-container">
    <div class="dashboard-text">课程详情</div>
    <div class="main" style="margin-top: 40px;">
      <div class="top" style="width: 90%;margin: auto;">
        <div class="left" style="width: 29%;">
          <el-card class="box" shadow="hover">
            <div class="top2">
              <img width="100%" height="200px" :src="lesson.img" alt="">
              <!-- <el-image style="width: 100%;height: 190px;" :src="lesson.img"></el-image> -->
            </div>
            <div class="bottom2">
              <div class="introduce" style="font-size: 14px;position: relative;
              top: 20px;
              margin-left: 10px;">
                <span style="font-size: 16px; font-weight: 500;
                        overflow: hidden;
                        text-overflow: ellipsis;
                        -webkit-line-clamp: 1;
                        word-wrap: break-word;
                        display: -webkit-box;
                        -webkit-box-orient: vertical;">{{ lesson.lname }}</span>
                <span style="color: #666; position: relative;
                        display: inline-block; overflow: hidden;
                        text-overflow: ellipsis;
                        margin-top: 10px;
                        -webkit-line-clamp: 1;
                        word-wrap: break-word;
                        display: -webkit-box;
                        -webkit-box-orient: vertical;
                        ">{{ lesson.remark }}</span>
              </div>
              <div class="school" style="font-size: 14px;color: #999;
                  width: 90%;
              margin: 0 auto;
              margin-top: 48px;
              display: flex;
              flex-direction: row;
              justify-content: space-between;
              padding-bottom: 20px;">
                <span>{{ lesson.school }} <span style="margin-left: 10px;">授课人:{{ lesson.tname }}</span></span>
                <span> <i class="el-icon-user"></i> {{ lesson.dianJi }}</span>
              </div>
            </div>
          </el-card>
        </div>
        <div class="right" style="width: 70%;">
          <el-card class="box-card" shadow="hover">
            <div class="text" @click="toDetail(item)">
              <img width="266px" height="150px" :src="lesson.img" alt="">
              <div class="introduce">
                <div style="display: flex;flex-direction: column;">
                  <span style="font-size: 16px; color: #333;font-weight: 700;">{{ lesson.lname }}</span>
                  <div style="display: flex;margin-top: 10px;">
                    <span style="font-size: 14px; color: #b1b1b1;margin-right: 10px;">
                      <i class="el-icon-school" style="position: relative;top: 1.25px;"></i> {{
                        lesson.school }}
                    </span>
                    <span style="font-size: 14px; color: #b1b1b1;">
                      <i class="el-icon-user" style="position: relative;top: 1.25px;"></i> {{ lesson.dianJi
                      }} 人
                    </span>
                    <span style="font-size: 14px; color: #b1b1b1;margin-left: 10px;">
                      <i class="el-icon-lollipop" style="position: relative;top: 1.25px;"></i>讲师: {{ lesson.tname
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
                                -webkit-box-orient: vertical;">{{ lesson.remark }}</span>
                  <span class="s1">免费学习</span>
                </div>
              </div>
            </div>
          </el-card>
        </div>
      </div>
      <div class="bottom">
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
                        ">{{ lessonDetail.introduce }}</span>
              </div>
              <!-- <el-button v-show="!isShow" style="margin-top: 50px;width: 40%;margin: 0 auto;" type="primary" plain
                @click="goStudy">加入学习</el-button>
              <el-button v-show="isShow" style="margin-top: 50px;width: 40%;margin: 0 auto;" type="success" plain
                @click="goStudy2">进入学习</el-button> -->
            </div>
          </div>
          <div class="right">
            <Video :img="lesson.img" :video="lessonDetail.vedio" />
          </div>
        </div>

        <div class="section">
          <p>课程章节</p>
          <!-- <div class="tree" v-for="(item, index) in 4" :key="index">
            </div> -->
          <Tree :lessonId="lessonId" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getLessonById, getLessonDetailById } from '@/api/lesson'
import Video from '@/components/Video.vue';
import Tree from '@/components/Tree.vue';
export default {
  name: 'StudyOnlineAdminLessonDetail',

  data() {
    return {
      lessonId: this.$route.query.id,
      lesson: {},
      lessonDetail: {}
    };
  },

  components: {
    Video, Tree
  },

  mounted() {
    this.getLesson()
  },

  methods: {
    getLesson() {
      getLessonById(this.lessonId).then(({ data: res }) => {
        this.lesson = res
      })
      getLessonDetailById(this.lessonId).then(({ data: res }) => {
        this.lessonDetail = res
      })
    }
  },
};
</script>

<style lang="scss" scoped>
::v-deep .el-card__body {
  padding: 0;
}

.dashboard {
  &-container {
    margin: 30px;
  }

  &-text {
    font-size: 30px;
    line-height: 46px;
  }

}

.main {

  .top {
    display: flex;
    flex-direction: row;
    justify-content: space-between;

    .left {}

    .right {
      margin: auto;

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

  .bottom {
    margin-top: 50px;
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
}
</style>

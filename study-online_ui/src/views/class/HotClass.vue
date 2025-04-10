<template>
  <div>
    <div class="hot-class">
      <!-- 轮播图和导航标签容器 -->
      <div class="carousel-and-tabs">
        <el-carousel
            :interval="4000"
            type="card"
            :height="carouselHeight"
            class="responsive-carousel"
        >
          <el-carousel-item v-for="(imageUrl, index) in carouselImages" :key="index">
            <img
                :src="imageUrl"
                alt="课程推荐"
                class="carousel-image"
            >
          </el-carousel-item>
        </el-carousel>

      </div>
      <h2 class="page-title">精选好课</h2>
      <!-- 课程分类导航 -->
      <div class="header">
        <span
            class="category-tab"
            v-for="item in tipList"
            :key="item.id"
            @click="ontip(item)"
            :class="{ active: activeName === item.name }"
        >
          {{ item.name }}
        </span>
      </div>

      <!-- 骨架屏加载状态 -->
      <div class="skeleton-container" v-show="skeletonShow">
        <el-skeleton
            animated
            v-for="(item, index) in 8"
            :key="index"
            class="course-skeleton"
        >
          <template slot="template">
            <el-skeleton-item variant="image" class="skeleton-image" />
            <div class="skeleton-content">
              <el-skeleton-item variant="p" class="skeleton-title" />
              <div class="skeleton-meta">
                <el-skeleton-item variant="text" class="skeleton-text" />
                <el-skeleton-item variant="text" class="skeleton-count" />
              </div>
            </div>
          </template>
        </el-skeleton>
      </div>

      <!-- 课程卡片列表 -->
      <div class="course-container" v-show="!skeletonShow">
        <el-empty
            v-if="lessons.length === 0"
            class="empty-prompt"
            description="该分类下暂无相关课程！"
        ></el-empty>

        <el-card
            v-else
            v-for="(item, index) in lessons"
            :key="index"
            class="course-card"
            shadow="hover"
            :body-style="{ padding: '10px' }"
            @click.native="toDetail(item)"
        >
          <div class="card-top">
            <el-image
                class="course-image"
                :src="item.img"
                fit="cover"
            >
              <div slot="error" class="image-error">
                <i class="el-icon-picture-outline"></i>
              </div>
            </el-image>
          </div>

          <div class="card-bottom">
            <div class="course-info">
              <h3 class="course-title">{{ item.lname }}</h3>
              <p class="course-desc">{{ item.remark }}</p>
            </div>

            <div class="course-meta">
              <span class="meta-school">
                {{ item.school }}
                <span class="meta-teacher">授课人:{{ item.tname }}</span>
              </span>
              <span class="meta-count">
                <i class="el-icon-user"></i>{{ item.dianJi }}
              </span>
            </div>
          </div>
        </el-card>
      </div>
    </div>
  </div>
</template>

<script>
import { mapMutations, mapState } from 'vuex'
import { getHotCategory, getLessons } from '@/api/lesson.js'

export default {
  name: 'StudyOnlineHotClass',
  inject: ['reload'],
  data() {
    return {
      tipList: [],
      activeName: "热门好课",
      id: 1001,
      lessons: [],
      skeletonShow: false,
      activeTab: 'hot-courses',
      carouselHeight: '400px',
      carouselImages: [
        require('@/assets/1.jpg'),
        require('@/assets/2.jpg'),
        require('@/assets/4.jpg')
      ]
    }
  },
  computed: {
    ...mapState(['beforeTarget'])
  },

  created() {
    if (this.beforeTarget?.name) {
      this.activeName = this.beforeTarget.name
      this.id = this.beforeTarget.id
    }
  },
  async mounted() {
    this.skeletonShow = true
    this.handleResize()
    await this.fetchCategories() // 必须确保先获取分类数据
    this.handleResize()
    window.addEventListener('resize', this.handleResize)

    // 关键代码：自动调用ontip
    if(this.tipList.length > 0) {
      const defaultItem = this.tipList.find(item => item.name === "热门好课") || this.tipList[0]
      this.ontip(defaultItem)
    }
    window.addEventListener('resize', this.handleResize)
  },

  beforeDestroy() {
    window.removeEventListener('resize', this.handleResize)
  },
  methods: {
    ...mapMutations(['SETTARGET']),

    handleResize() {
      this.carouselHeight = window.innerWidth < 768
          ? '300px'
          : window.innerWidth < 1024
              ? '350px'
              : '400px'
    },

    async fetchCategories() {
      try {
        const { data } = await getHotCategory()
        this.tipList = data
      } catch (error) {
        console.error('获取分类失败:', error)
      }
    },

    async getLesson() {
      try {
        const { data } = await getLessons(this.id)
        this.lessons = data
        setTimeout(() => {
          this.skeletonShow = false
        }, 150)
      } catch (error) {
        console.error('获取课程失败:', error)
        this.skeletonShow = false
      }
    },

    ontip(item) {
      if (this.id !== item.id) {
        this.skeletonShow = true
      }
      this.id = item.id
      this.activeName = item.name
      this.getLesson()
      this.SETTARGET(item)
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

    handleTabClick(tab) {
      console.log('切换标签:', tab.name)
      // 这里可以添加加载不同课程列表的逻辑
    }
  }
}
</script>

<style lang="less" scoped>
.page-title {
  font-size: 28px;
  color: #333;
  margin-bottom: 30px;
  padding-bottom: 15px;
  border-bottom: 1px solid #eee;
}
.hot-class {
  padding: 60px 20px;
  max-width: 1400px;
  margin: 0 auto;
  animation: load 0.4s linear;

  @keyframes load {
    0% { opacity: 0; transform: translateY(70px); }
    100% { opacity: 1; transform: translateY(0); }
  }
}

.carousel-and-tabs {
  margin: 20px 0 40px;

  // 轮播图响应式处理
  .responsive-carousel {
    ::v-deep .el-carousel__container {
      max-height: 80vh;
    }

    .carousel-image {
      width: 100%;
      height: 100%;
      object-fit: cover;
      border-radius: 8px;
    }
  }

  // 导航标签样式
  .responsive-tabs {
    margin-top: 30px;

    ::v-deep {
      .el-tabs__nav-wrap {
        justify-content: center;
      }

      .el-tabs__nav {
        flex-wrap: wrap;
        row-gap: 10px;
      }

      .el-tabs__item {
        font-size: 16px;
        padding: 0 25px;
      }
    }
  }
}

.header {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin: 20px 0 40px;

  .category-tab {
    flex: 0 0 auto;
    padding: 8px 20px;
    border-radius: 20px;
    font-size: 14px;
    background: rgba(23, 105, 254, 0.1);
    color: #1769fe;
    cursor: pointer;
    transition: all 0.3s;

    &:hover {
      background: rgba(23, 105, 254, 0.2);
    }

    &.active {
      background: #1769fe;
      color: white;
    }
  }
}

.skeleton-container {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 1.5rem;
  padding: 0 15px;

  .course-skeleton {
    border-radius: 8px;
    overflow: hidden;

    ::v-deep {
      .skeleton-image {
        width: 100%;
        height: 180px;
        border-radius: 8px 8px 0 0;
      }

      .skeleton-content {
        padding: 14px;

        .skeleton-title {
          width: 70%;
          height: 20px;
          margin-bottom: 8px;
        }

        .skeleton-meta {
          display: flex;
          justify-content: space-between;

          .skeleton-text {
            width: 60%;
            height: 16px;
          }

          .skeleton-count {
            width: 30%;
            height: 16px;
          }
        }
      }
    }
  }
}

.course-container {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 1.5rem;
  padding: 0 15px;

  .empty-prompt {
    grid-column: 1 / -1;
    margin: 40px 0;
  }

  .course-card {
    border-radius: 8px;
    transition: transform 0.3s, box-shadow 0.3s;

    &:hover {
      transform: translateY(-5px);
      box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    }

    .card-top {
      position: relative;
      padding-top: 56.25%;
      background: #f8f9fa;

      .course-image {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        border-radius: 6px;
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
        color: #c0c4cc;
        font-size: 48px;
        background: #f0f2f5;
      }
    }

    .card-bottom {
      padding: 16px 10px;

      .course-info {
        margin-bottom: 12px;

        .course-title {
          font-size: 16px;
          font-weight: 600;
          color: #1a1a1a;
          margin-bottom: 8px;
          display: -webkit-box;
          -webkit-box-orient: vertical;
          -webkit-line-clamp: 2;
          overflow: hidden;
        }

        .course-desc {
          font-size: 14px;
          color: #666;
          line-height: 1.4;
          display: -webkit-box;
          -webkit-box-orient: vertical;
          -webkit-line-clamp: 2;
          overflow: hidden;
          margin-bottom: 12px;
        }
      }

      .course-meta {
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-size: 12px;

        .meta-school {
          color: #909399;
          overflow: hidden;
          text-overflow: ellipsis;
          white-space: nowrap;

          .meta-teacher {
            margin-left: 8px;
            color: #666;
          }
        }

        .meta-count {
          flex-shrink: 0;
          color: #1769fe;
          margin-left: 12px;

          i {
            margin-right: 4px;
          }
        }
      }
    }
  }
}

@media (max-width: 1200px) {
  .hot-class {
    max-width: 1000px;
  }
}

@media (max-width: 992px) {
  .responsive-carousel {
    ::v-deep .el-carousel__item {
      width: 80% !important;
    }
  }
}

@media (max-width: 768px) {
  .hot-class {
    padding: 40px 15px;

    .header {
      margin: 0 auto;

      .category-tab {
        padding: 6px 16px;
        font-size: 13px;
      }
    }

    .carousel-and-tabs {
      .responsive-tabs {
        ::v-deep .el-tabs__item {
          font-size: 14px;
          padding: 0 15px;
        }
      }
    }
  }

  .skeleton-container,
  .course-container {
    grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
    gap: 1rem;
  }
}

@media (max-width: 480px) {
  .hot-class {
    padding: 30px 10px;

    .carousel-and-tabs {
      .responsive-carousel {
        ::v-deep {
          .el-carousel__item {
            width: 90% !important;
          }
          .el-carousel__arrow {
            display: none;
          }
        }
      }

      .responsive-tabs {
        ::v-deep .el-tabs__item {
          font-size: 13px;
          padding: 0 12px;
        }
      }
    }

    .course-meta {
      flex-direction: column;
      align-items: flex-start !important;

      .meta-count {
        margin-left: 0 !important;
        margin-top: 6px;
      }
    }
  }
}
</style>

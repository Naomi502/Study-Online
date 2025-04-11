<template>
  <div class="news-report">
    <Header :ai="activeIndex" />

    <div class="main">
      <!-- 热门新闻区块 -->
      <section class="news-section">
        <div class="section-header">
          <h2>热门新闻</h2>
          <router-link to="/newsList" class="more-link">查看更多</router-link>
        </div>
        <div class="grid-container">
          <el-card
              v-for="item in hotNews"
              :key="item.id"
              class="news-card"
              shadow="hover"
              @click.native="$router.push(`/newDetail/${item.id}`)"
          >
            <div class="card-image">
              <time class="date-tag">{{ item.time.slice(0, 10) }}</time>
              <img :src="item.img" alt="新闻封面图">
            </div>
            <div class="card-content">
              <h3 class="news-title">{{ item.title }}</h3>
              <p class="news-excerpt">{{ item.content }}</p>
            </div>
          </el-card>
        </div>
      </section>

      <!-- 最新新闻区块 -->
      <section class="news-section">
        <div class="section-header">
          <h2>最新新闻</h2>
          <router-link to="/newsList" class="more-link">查看更多</router-link>
        </div>
        <el-card class="latest-news-card" shadow="hover">
          <ul class="news-list">
            <li
                v-for="item in latestNews"
                :key="item.id"
                class="news-item"
                @click="$router.push(`/newDetail/${item.id}`)"
            >
              <span class="bullet"></span>
              <span class="news-text">{{ item.title }}</span>
              <time class="news-date">{{ item.time.slice(0, 10) }}</time>
            </li>
          </ul>
        </el-card>
      </section>
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
.news-report {
  --primary-color: #0067b5;
  --text-color: #333;
  --secondary-text: #7d7d7d;
  --border-color: #ebebeb;



  .main {
    height: 930px;
    max-width: 1200px;
    margin: 9rem auto;
    padding: 0 1rem;
    animation: load 0.4s linear;
    @keyframes load {
      0% { opacity: 0; transform: translateY(40px); }
      100% { opacity: 1; transform: translateY(0); }
    }
  }

  .section-header {
    display: flex;
    justify-content: space-between;
    align-items: baseline;
    margin-bottom: 1.5rem;
    border-bottom: 1px solid var(--border-color);
    padding-bottom: 0.75rem;

    h2 {
      font-size: 1.25rem;
      color: var(--text-color);
      margin: 0;
    }
  }

  .more-link {
    font-size: 0.875rem;
    color: var(--primary-color);
    text-decoration: none;
    transition: opacity 0.3s;

    &:hover {
      opacity: 0.8;
    }
  }

  // 热门新闻样式
  .grid-container {
    display: grid;
    gap: 1.5rem;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  }

  .news-card {
    cursor: pointer;
    border: none !important;
    transition: transform 0.3s;

    &:hover {
      transform: translateY(-4px);
    }

    .card-image {
      position: relative;
      padding-top: 60%; // 保持图片比例
      overflow: hidden;

      img {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        object-fit: cover;
      }
    }

    .date-tag {
      position: absolute;
      top: 12px;
      left: 12px;
      background: rgba(85, 132, 179, 0.9);
      color: white;
      padding: 0.5rem 1rem;
      font-size: 0.875rem;
      z-index: 1;
    }

    .card-content {
      padding: 1rem;
    }

    .news-title {
      color: var(--primary-color);
      font-size: 1rem;
      margin: 0 0 0.5rem;
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }

    .news-excerpt {
      color: var(--secondary-text);
      font-size: 0.875rem;
      line-height: 1.5;
      display: -webkit-box;
      -webkit-line-clamp: 3;
      -webkit-box-orient: vertical;
      overflow: hidden;
      margin: 0;
    }
  }

  // 最新新闻样式
  .latest-news-card {
    border: none !important;

    .news-list {
      list-style: none;
      padding: 0;
      margin: 0;
    }

    .news-item {
      display: flex;
      align-items: center;
      padding: 0.75rem 0;
      border-bottom: 1px solid #f0f0f0;
      cursor: pointer;
      transition: background 0.3s;

      &:last-child {
        border-bottom: none;
      }

      &:hover {
        background: #f8f8f8;
      }
    }

    .bullet {
      display: inline-block;
      width: 6px;
      height: 6px;
      background: var(--text-color);
      border-radius: 50%;
      margin-right: 0.75rem;
    }

    .news-text {
      flex: 1;
      font-size: 0.9375rem;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .news-date {
      color: #a0a0a0;
      font-size: 0.875rem;
      margin-left: 1rem;
      flex-shrink: 0;
    }
  }

  @media (max-width: 768px) {
    .news-card {
      .date-tag {
        font-size: 0.75rem;
        padding: 0.25rem 0.75rem;
      }
    }

    .news-item {
      flex-wrap: wrap;

      .news-date {
        width: 100%;
        margin-left: 1.5rem;
        margin-top: 0.25rem;
      }
    }
  }
}
</style>
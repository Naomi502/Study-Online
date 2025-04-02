<template>
  <footer class="xt-footer">
    <div class="footer-container">
      <!-- 主要导航区块 -->
      <div class="footer-main">
        <!-- 左导航 -->
        <div class="footer-column">
          <h4 class="footer-title">快速导航</h4>
          <ul class="footer-links">
            <li><a href="#"><i class="el-icon-document"></i>课程入驻</a></li>
            <li><a href="#"><i class="el-icon-office-building"></i>关于我们</a></li>
            <li><a href="#"><i class="el-icon-notebook-1"></i>教科研平台</a></li>
            <li><a @click="openNewLink"><i class="el-icon-notebook-2"></i>服务协议与隐私政策</a></li>
          </ul>
        </div>

        <!-- 中导航 -->
        <div class="footer-column">
          <h4 class="footer-title">支持帮助</h4>
          <ul class="footer-links">
            <li><a href="#"><i class="el-icon-question"></i>帮助中心</a></li>
            <li><a href="#"><i class="el-icon-chat-line-round"></i>在线客服</a></li>
            <li><a href="#"><i class="el-icon-phone-outline"></i>联系我们</a></li>
            <li><a target="_blank" href="http://124.223.101.11:8050/#/login"><i class="el-icon-monitor"></i>管理平台</a></li>
          </ul>
        </div>

        <!-- 右信息 -->
        <div class="footer-column">
          <div class="footer-slogan">
            <h3 class="slogan-main">创新教育 改变世界</h3>
            <p class="slogan-sub">New Education, New World</p>
          </div>
          <div class="footer-qrcode">
            <img src="qrcode.png" alt="微信公众号">
            <p>关注官方公众号</p>
          </div>
        </div>
      </div>

      <!-- 版权信息 -->
      <div class="footer-bottom">
        <div class="copyright">
          <p>版权所有：扬州市职业大学（扬州开放大学） ©2024</p>
          <div class="legal-links">
            <span>苏ICP备13024625号-3</span>
            <span>京公网安备 11010802033054号</span>
            <span>苏公网安备32100302010583号</span>
          </div>
          <div class="address">
            <i class="el-icon-location-outline"></i>扬州市邗江区文昌西路458号
          </div>
        </div>
        <div class="security">
          <img class="badge" src="security-badge.png" alt="安全认证">
        </div>
      </div>
    </div>

    <!-- 返回顶部 -->
    <div class="back-top" @click="scrollToTop">
      <i class="el-icon-caret-top"></i>
    </div>
  </footer>
</template>

<script>
export default {
  methods: {
    openNewLink() {
      const routeUrl = this.$router.resolve({ path: "/protocol" })
      window.open(routeUrl.href, '_blank')
    },
    scrollToTop() {
      window.scrollTo({
        top: 0,
        behavior: 'smooth'
      })
    }
  }
}
</script>

<style lang="less" scoped>
.xt-footer {
  background: #2a2e32;
  color: #b1b1b1;
  padding: 40px 0 20px;
  position: relative;
  font-size: 14px;

  .footer-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
  }

  .footer-main {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
    gap: 30px;
    padding-bottom: 30px;
    border-bottom: 1px solid rgba(255,255,255,0.1);
  }

  .footer-column {

    .footer-title {
      color: #fff;
      font-size: 16px;
      margin-bottom: 20px;
      position: relative;
      padding-left: 24px;

      &::before {
        content: '';
        position: absolute;
        left: 0;
        top: 50%;
        transform: translateY(-50%);
        width: 18px;
        height: 2px;
        background: #1769fe;
      }
    }

    .footer-links {
      list-style: none;
      padding: 0;

      li {
        margin-bottom: 12px;

        a {
          color: inherit;
          text-decoration: none;
          transition: all 0.3s;
          display: flex;
          align-items: center;

          &:hover {
            color: #fff;
            transform: translateX(5px);

            i {
              color: #1769fe;
            }
          }

          i {
            margin-right: 8px;
            font-size: 16px;
            width: 20px;
            transition: color 0.3s;
          }
        }
      }
    }

    .footer-slogan {
      text-align: right;
      margin-bottom: 25px;

      .slogan-main {
        color: #fff;
        font-size: 24px;
        margin: 0 0 8px;
        line-height: 1.3;
      }

      .slogan-sub {
        color: #7d7d7d;
        font-size: 14px;
        margin: 0;
      }
    }

    .footer-qrcode {
      text-align: right;
      img {
        width: 120px;
        height: 120px;
        margin-bottom: 10px;
        border: 2px solid rgba(255,255,255,0.1);
        border-radius: 8px;
      }

      p {
        font-size: 12px;
        color: #7d7d7d;
        margin: 0;
      }
    }
  }

  .footer-bottom {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-top: 25px;
    flex-wrap: wrap;

    .copyright {
      p {
        margin: 5px 0;
        font-size: 13px;
      }

      .legal-links {
        margin: 10px 0;
        display: flex;
        gap: 15px;
        flex-wrap: wrap;
        font-size: 12px;
        color: #666;
      }

      .address {
        font-size: 12px;
        color: #666;
        display: flex;
        align-items: center;

        i {
          margin-right: 6px;
          font-size: 14px;
        }
      }
    }

    .security {
      .badge {
        height: 40px;
        opacity: 0.8;
        transition: opacity 0.3s;

        &:hover {
          opacity: 1;
        }
      }
    }
  }

  .back-top {
    position: fixed;
    right: 30px;
    bottom: 50px;
    width: 40px;
    height: 40px;
    background: rgba(23,105,254,0.9);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: all 0.3s;

    &:hover {
      transform: translateY(-3px);
      box-shadow: 0 5px 15px rgba(23,105,254,0.3);
    }

    i {
      color: #fff;
      font-size: 20px;
    }
  }

  @media (max-width: 768px) {
    padding: 30px 0 15px;

    .footer-main {
      grid-template-columns: 1fr;
      gap: 25px;
    }

    .footer-column {
      text-align: center;

      .footer-title::before {
        display: none;
      }

      .footer-links {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 15px;
      }
    }

    .footer-bottom {
      flex-direction: column;
      text-align: center;

      .legal-links {
        justify-content: center;
      }
    }

    .back-top {
      right: 15px;
      bottom: 30px;
      width: 36px;
      height: 36px;
    }
  }
}
</style>

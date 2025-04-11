import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import "./plugins/element.js";
import {Message} from "element-ui";
import VideoPlayer from "vue-video-player";
import VueParticles from "vue-particles";

require("video.js/dist/video-js.css");
require("vue-video-player/src/custom-theme.css");
Vue.use(VueParticles);
Vue.use(VideoPlayer);

Vue.config.productionTip = false;

//挂载路由导航守卫
router.beforeEach((to, from, next) => {
  //to 表示要访问的路径
  //from 代表从哪一个路径跳转而来
  //next 是一个函数，表示放行
  //    next()  放行    next('/login') 强制跳转
  //获取token
  const tokenStr = localStorage.getItem("token");
  //如果没有获取到token那么返回登录
  if (tokenStr) {
    next();
  } else {
    if (to.path == "/personal" || to.path == "/lesson") {
      Message({
        message: "登录失效",
        type: "warning",
        duration: 3000,
      });
      next("/");
    } else {
      next();
    }
  }
});

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount("#app");

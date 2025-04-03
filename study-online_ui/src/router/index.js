import Vue from "vue";
import VueRouter from "vue-router";

Vue.use(VueRouter);

// 在重写push|replace方法时，先把VueRouter原型对象的push|replace保存一份
let originPush = VueRouter.prototype.push;
let originReplace = VueRouter.prototype.replace;
// 参数1：告诉原来的push | replace方法，你往那里跳转（传递那些参数）
// 参数2：成功回调
// 参数3：失败回调
VueRouter.prototype.push = function (location, resolve, reject) {
  if (resolve && reject) {
    originPush.call(this, location, resolve, reject);
  } else {
    originPush.call(
      this,
      location,
      () => {},
      () => {}
    );
  }
};
VueRouter.prototype.replace = function (location, resolve, reject) {
  if (resolve && reject) {
    originReplace.call(this, location, resolve, reject);
  } else {
    originReplace.call(
      this,
      location,
      () => {},
      () => {}
    );
  }
};

const routes = [
  {
    path: "/",
    redirect: "/home",
  },
  {
    path: "/home",
    name: "home",
    // redirect: '/',
    component: () => import("@/views/HomeView.vue"),
  },
  {
    path: "/detail",
    name: "class-details",
    component: () => import("@/views/ClassDetails.vue"),
  },
  {
    path: "/personal/:id",
    name: "personal-center",
    component: () => import("@/views/PersonalCenter.vue"),
  },
  {
    path: "/lesson/:id",
    name: "lesson",
    component: () => import("@/views/Lession.vue"),
  },
  {
    path: "/Quiz",
    name: "quiz",
    component: () => import("@/views/Quiz.vue"),
  },
  {
    path: "/Shop",
    name: "shop",
    component: () => import("@/views/Shop.vue"),
  },
  {
    path: "/news",
    name: "news-report",
    component: () => import("@/views/NewsReport.vue"),
  },
  {
    path: "/newDetail/:id",
    name: "new-detail",
    component: () => import("@/views/NewDetail.vue"),
  },
  {
    path: "/newsList",
    name: "news-list",
    component: () => import("@/views/NewsList.vue"),
  },
  {
    path: "/searchLesson",
    name: "search-lesson",
    component: () => import("@/views/SearchLesson.vue"),
  },
  {
    path: "/protocol",
    name: "protocol",
    component: () => import("@/views/protocol.vue"),
  },
];

const router = new VueRouter({
  mode:"hash",
  routes,
  scrollBehavior(to, from, scrollBehavior) {
    return { x: 0, y: 0 };
  },
});


export default router;

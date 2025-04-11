import Vue from "vue";
import Router from "vue-router";
import { mapRouteToVueRouter } from "@/utils/route-utils";

Vue.use(Router);

/* Layout */
import Layout from "@/layout";

/**
 * Note: sub-menu only appear when route children.length >= 1
 * Detail see: https://panjiachen.github.io/vue-element-admin-site/guide/essentials/router-and-nav.html
 *
 * hidden: true                   if set true, item will not show in the sidebar(default is false)
 * alwaysShow: true               if set true, will always show the root menu
 *                                if not set alwaysShow, when item has more than one children route,
 *                                it will becomes nested mode, otherwise not show the root menu
 * redirect: noRedirect           if set noRedirect will no redirect in the breadcrumb
 * name:'router-name'             the name is used by <keep-alive> (must set!!!)
 * meta : {
    roles: ['admin','editor']    control the page roles (you can set multiple roles)
    title: 'title'               the name show in sidebar and breadcrumb (recommend set)
    icon: 'svg-name'/'el-icon-x' the icon show in the sidebar
    breadcrumb: false            if set false, the item will hidden in breadcrumb(default is true)
    activeMenu: '/example/list'  if set path, the sidebar will highlight the path you set
  }
 */

/**
 * constantRoutes
 * a base page that does not have permission requirements
 * all roles can be accessed
 */
export const constantRoutes = [
  {
    path: "/login",
    component: () => import("@/views/login/index.vue"),
    hidden: true,
  },

  {
    path: "/404",
    component: () => import("@/views/404"),
    hidden: true,
  },
  // {
  //   path: "/",
  //   component: () => import("@/layout"),
  //   redirect: "/home",
  //   meta: { title: "我的", icon: "user" },
  //   children: [
  //     {
  //       path: "home",
  //       name: "home",
  //       component: () => import("@/views/home/index.vue"),
  //       meta: { title: "首页", icon: "eye" },
  //     },
  //   ],
  // },

  // {
  //   path: "/lesson",
  //   component: Layout,
  //   // redirect: "/lessonTeacher",
  //   meta: { title: "课程管理", icon: "shopping" },
  //   children: [
  //     {
  //       path: "lessonTeacher",
  //       name: "lessonTeacher",
  //       component: () => import("@/views/lesson/myLesson.vue"),
  //       meta: { title: "我的课程", icon: "form" },
  //     },
  //     {
  //       path: "addLesson",
  //       name: "addLesson",
  //       component: () => import("@/views/lesson/addLesson.vue"),
  //       meta: {
  //         title: "添加课程",
  //         icon: "tree",
  //       },
  //     },
  //     {
  //       path: "lessonAdmin",
  //       name: "lessonAdmin",
  //       component: () => import("@/views/lesson/adminLesson.vue"),
  //       meta: {
  //         title: "课程列表",
  //         icon: "tree",
  //       },
  //     },
  //     {
  //       path: "lessonDetail",
  //       name: "lessonDetail",
  //       component: () => import("@/views/lesson/lessonDetail.vue"),
  //       hidden: true,
  //     },
  //   ],
  // },

  // {
  //   path: "/news",
  //   component: Layout,
  //   meta: { title: "新闻管理", icon: "shopping" },
  //   children: [
  //     {
  //       path: "myNews",
  //       name: "myNews",
  //       component: () => import("@/views/news/myNews.vue"),
  //       meta: { title: "我的新闻", icon: "table" },
  //     },
  //     {
  //       path: "addNews",
  //       name: "addNews",
  //       component: () => import("@/views/news/addNews.vue"),
  //       meta: { title: "发布新闻", icon: "table" },
  //     },
  //     {
  //       path: "adminNews",
  //       name: "adminNews",
  //       component: () => import("@/views/news/adminNews.vue"),
  //       meta: { title: "新闻列表", icon: "table" },
  //     },
  //     {
  //       path: "newsDetail",
  //       name: "newsDetail",
  //       component: () => import("@/views/news/newsDetail.vue"),
  //       hidden: true,
  //     },
  //   ],
  // },

  // {
  //   path: "/score",
  //   component: Layout,
  //   meta: { title: "积分管理", icon: "table" },
  //   children: [
  //     {
  //       path: "index",
  //       name: "score",
  //       component: () => import("@/views/score/index.vue"),
  //       meta: { title: "积分列表", icon: "table" },
  //     },
  //   ],
  // },
  // {
  //   path: "/category",
  //   component: Layout,
  //   meta: { title: "分类管理", icon: "table" },
  //   children: [
  //     {
  //       path: "index",
  //       name: "category",
  //       component: () => import("@/views/category/index.vue"),
  //       meta: { title: "分类列表", icon: "table" },
  //     },
  //   ],
  // },

  // {
  //   path: "/comment",
  //   component: Layout,
  //   meta: { title: "评论管理", icon: "table" },
  //   children: [
  //     {
  //       path: "index",
  //       name: "comment",
  //       component: () => import("@/views/comment/index.vue"),
  //       meta: { title: "评论列表", icon: "table" },
  //     },
  //   ],
  // },

  // {
  //   path: "/teacher",
  //   component: Layout,
  //   meta: { title: "权限管理", icon: "table" },
  //   children: [
  //     {
  //       path: "index",
  //       name: "teacher",
  //       component: () => import("@/views/teacher/index.vue"),
  //       meta: { title: "教师列表", icon: "table" },
  //     },
  //   ],
  // },

  // 404 page must be placed at the end !!!
  // { path: "*", redirect: "/404", hidden: true },
];

const createRouter = () =>
  new Router({
    // mode: 'history', // require service support
    scrollBehavior: () => ({ y: 0 }),
    routes: constantRoutes,
  });

const router = createRouter();

// Detail see: https://github.com/vuejs/vue-router/issues/1234#issuecomment-357941465
export function resetRouter() {
  const newRouter = createRouter();
  router.matcher = newRouter.matcher; // reset router
}

export default router;

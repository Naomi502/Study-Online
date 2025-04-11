import router from "./router";
import store from "./store";
import { Message } from "element-ui";
import { mapRouteToVueRouter } from "@/utils/route-utils";
import { resetRouter } from "@/router";
import { getInfo } from "./api/login";
import NProgress from "nprogress"; // progress bar
import "nprogress/nprogress.css"; // progress bar style
import { getToken } from "@/utils/auth"; // get token from cookie
import getPageTitle from "@/utils/get-page-title";

NProgress.configure({ showSpinner: false }); // NProgress Configuration

const whiteList = ["/login", "/auth-redirect"]; // no redirect whitelist
let oneRun = true; //通过oneRun变量控制 避免陷入死循环

router.beforeEach(async (to, from, next) => {
  // start progress bar
  NProgress.start();

  // set page title
  document.title = getPageTitle(to.meta.title);

  // determine whether the user has logged in
  const hasToken = getToken();

  // console.log(hasToken,'token');

  if (hasToken) {
    if (to.path === "/login") {
      // if is logged in, redirect to the home page
      next({ path: "/" });
      NProgress.done(); // hack: https://github.com/PanJiaChen/vue-element-admin/pull/2939
    } else {
      // determine whether the user has obtained his permission roles through getInfo
      const hasRoles = store.getters.menus && store.getters.menus.length > 0;
      // console.log(store.getters.permission_routes,'store.gettersstore.getters');
      // console.log(to.path,hasRoles,'to.path')
      if (hasRoles) {
        next();
      } else {
        try {
          // get user info
          // note: roles must be a object array! such as: ['admin'] or ,['developer','editor']
          // sessionStorage.setItem("menus", JSON.stringify(newRouter));
          if (oneRun) {
            oneRun = false; //必须在creatNewRouter() 执行
            getInfo(localStorage.getItem("roleId")).then(({ data: res }) => {
              console.log(res, "res");
              store.commit(
                "user/SET_TEACHERID",
                localStorage.getItem("teacherId")
              );
              store.commit(
                "user/SET_NAME",
                localStorage.getItem("teacherName")
              );
              store.commit("user/SET_ROLEID", localStorage.getItem("roleId"));
              sessionStorage.setItem("menus", JSON.stringify(newRouter));

              const newRouter = res.map((v) => mapRouteToVueRouter(v));
              store.commit("user/SET_MENUS", newRouter);

              console.log(newRouter, "newRouter");
              resetRouter();
              newRouter.forEach((res) => {
                router.addRoute(res);
                next({
                  ...to,
                  replace: true,
                });
              });
            });
          }
          // console.log(newRouter, "newdwadw");
          // console.log(...newRouter);
          //
          // newRouter.forEach((res) => {
          //   router.addRoute(res);
          // });
          // dynamically add accessible routes
          // console.log(accessRoutes,'accessRoutes')
          // 把404放后面，不然会一直报404
          //这里可以打印出来看一下动态路由格式是否正确
          // console.log(accessRoutes,'accessRoutes===')
          // hack method  to ensure that addRoutes is complete
          // set the replace: true, so the navigation will not leave a history record
          // console.log(accessRoutes,'to');
        } catch (error) {
          // remove token and go to login page to re-login
          await store.dispatch("user/resetToken");
          // console.log(error)
          Message.error("error" || "Has Error");
          console.log(error);
          // next(`/login`);
          NProgress.done();
        }
      }
    }
  } else {
    /* has no token*/

    if (whiteList.indexOf(to.path) !== -1) {
      // in the free login whitelist, go directly
      next();
    } else {
      // other pages that do not have permission to access are redirected to the login page.
      next(`/login`);
      NProgress.done();
    }
  }
});

router.afterEach(() => {
  // finish progress bar
  NProgress.done();
});

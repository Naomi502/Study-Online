import axios from "axios";
import { MessageBox, Message } from "element-ui";
import store from "@/store";
import { getToken } from "@/utils/auth";
import Cookies from 'js-cookie'
import router from "@/router";

// create an axios instance
const service = axios.create({
  // baseURL: process.env.VUE_APP_BASE_API, // url = base url + request url 124.223.101.11
  baseURL: "http://localhost:8099/",
  // withCredentials: true, // send cookies when cross-domain requests
  timeout: 5000, // request timeout
});

// request interceptor
service.interceptors.request.use(
  (config) => {
    // do something before request is sent
    // config.headers["Access-Control-Allow-Origin"] =
    // "http://124.223.101.11:8050";
    if (store.getters.token) {
      // let each request carry token
      // ['X-Token'] is a custom headers key
      // please modify it according to the actual situation
      config.headers["Authorization"] = getToken();
    }
    return config;
  },
  (error) => {
    // do something with request error
    console.log(error); // for debug
    return Promise.reject(error);
  }
);

// response interceptor
service.interceptors.response.use(
  /**
   * If you want to get http information such as headers or status
   * Please return  response => response
   */

  /**
   * Determine the request status by custom code
   * Here is just an example
   * You can also judge the status by HTTP Status Code
   */
  (response) => {
    const res = response.data;

    if (res.code == "50000") {
      localStorage.clear();
      sessionStorage.clear();
      Cookies.remove("vue_admin_template_token");
      Cookies.remove("roleId");
    }
    // console.log(res);
    if (res.respCode == 200) {
      if (res.respMessage) {
        Message({
          message: res.respMessage || "Success",
          type: "success",
          duration: 3000,
        });
      }

      return res;
    } else if (res.respCode == 500 || res.respCode == 400) {
      if (res.respMessage) {
        Message({
          message: res.respMessage || "Error",
          type: "error",
          duration: 3000,
        });
      }
      return Promise.reject(new Error(res.respMessage || "Error"));
      // return res;
    }
  },
  (error) => {
    console.log(error, "err");
    // if (error) {
    //   Cookies.remove("vue_admin_template_token");
    //   localStorage.clear();
    //   sessionStorage.clear();
    //   router.push('/login')
    //   Message({
    //     message: "登录失效！",
    //     type: "warning",
    //     duration: 3000,
    //   });
    // }
    // console.log('err' + error) // for debug
    // Message({
    //   message: error.message,
    //   type: 'error',
    //   duration: 3 * 1000
    // })
    return Promise.reject(error);
  }
);

export default service;

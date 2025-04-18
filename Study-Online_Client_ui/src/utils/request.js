import axios from "axios";
import {Message} from "element-ui";
import router from "@/router";

const request = axios.create({
  //47.113.150.42
  baseURL: "http://localhost:9099", // 注意！！ 这里是全局统一加上了 '/api' 前缀，也就是说所有接口都会加上'/api'前缀在，页面里面写接口的时候就不要加 '/api'了，否则会出现2个'/api'，类似 '/api/api/user'这样的报错，切记！！！
  timeout: 5000,
});

// request 拦截器
// 可以自请求发送前对请求做一些处理
// 比如统一加token，对请求参数统一加密
request.interceptors.request.use(
  (config) => {
    config.headers["Content-Type"] = "application/json;charset=utf-8";
    const token = localStorage.getItem("token");
    config.headers["Authorization"] = token; // 设置请求头
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// response 拦截器
// 可以在接口响应后统一处理结果
request.interceptors.response.use(
  (response) => {
    let res = response.data;
    // console.log(res, "response");
    if (res.code == "50000") {
      localStorage.removeItem("token");
      localStorage.removeItem("userId");
      localStorage.removeItem("userName");
      Message({
        message: "登录失效",
        type: "warning",
        duration: 3000,
      });
      router.push("/");
    }
    // 如果是返回的文件
    if (response.config.responseType === "blob") {
      return res;
    }
    // 兼容服务端返回的字符串数据
    if (typeof res === "string") {
      res = res ? JSON.parse(res) : res;
    }
    return res;
  },
  (error) => {
    console.log("err--" + error); // for debug
    if (error) {
      // localStorage.removeItem("token");
      // localStorage.removeItem("userId");
      // localStorage.removeItem("userName");
      console.log(error);
      // Message({
      //   message: "接口异常",
      //   type: "error",
      //   duration: 3000,
      // });
    }

    return Promise.reject(error);
  }
);

export default request;

import request from "@/utils/request";

//获取课程列表  /login/getInfo
export const getInfo = (roleId) => {
  return request.get(`/login/getInfo?roleId=${roleId}`);
};

//登录  /login/login
export const login = (params) => {
  return request.post(`/login/login`, params);
};

//注册  /login/register
export const register = (params) => {
  return request.post(`/login/register`, params);
};

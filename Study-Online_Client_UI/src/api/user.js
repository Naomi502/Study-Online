import request from "@/utils/request";

//用户登录
export const login = (params) => {
  return request.post(`/user/login`, params);
};

//用户注册
export const register = (params) => {
  return request.post(`/user/register`, params);
};

//查询用户信息
export const getUserDetail = (id) => {
  return request.get(`/user/getUserById/${id}`);
};

//修改用户信息
export const updateUser = (params) => {
  return request.put(`/user/updateUser`, params);
};

//获取学历列表
export const getXueLiList = () => {
  return request.get("/user/getXueLiList");
};



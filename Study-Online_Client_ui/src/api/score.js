import request from "@/utils/request";

//查询所有积分排名
export const getAllScore = () => {
  return request.get(`/score/getAllScore`);
};

//查询我的积分详情
export const getMyScore = (userId) => {
  return request.get(`/score/getMyScore?userId=${userId}`);
};

//更新积分
export const updateMyScore = (params) => {
  return request.put(`/score/updateMyScore`, params);
};

//添加新用户积分
export const addScore = (params) => {
  return request.post("/score/addScore", params);
};

//查询积分明细
export const getScoreDetail = (userId) => {
  return request.get(`/score/getScoreDetail?userId=${userId}`);
};

//添加积分明细
export const addScoreDetail = (params) => {
  return request.post("/score/addScoreDetail", params);
};

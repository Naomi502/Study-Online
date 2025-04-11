import request from "@/utils/request";

//获取积分
export const getScorePage = (data) => {
  return request.get(`/score/getScorePage`, { params: data });
};

//重置积分
export const resetScore = (idList) => {
  return request.put(`/score/resetScore?idList=${idList}`);
};

//修改积分
export const updateScore = (params) => {
  return request.put(`/score/updateScore`, params);
};

//添加积分明细
export const getScoreDetail=(userId)=>{
  return request.get(`/score/getScoreDetail?userId=${userId}`)
}

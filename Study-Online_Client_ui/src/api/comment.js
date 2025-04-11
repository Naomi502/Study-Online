import request from "@/utils/request";

//获取评论
export const getComment = (pId) => {
  return request.get(`/comment/getComment?pId=${pId}`);
};

//评论
export const comment = (params) => {
  return request.post("/comment/comment", params);
};

//点赞
export const like = (params) => {
  return request.put("/comment/like", params);
};

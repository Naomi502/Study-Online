import request from "@/utils/request";

//获取评论
export const getCommentPage = (data) => {
  return request.get(`/comment/getCommentPage`, { params: data });
};

//删除评论
export const deleteCommentByIds = (id) => {
  return request.delete(`/comment/deleteCommentByIds/${id}`);
};

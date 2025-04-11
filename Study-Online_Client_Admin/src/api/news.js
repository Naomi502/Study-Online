import request from "@/utils/request";

//获取新闻
export const getNewsPage = (data) => {
  return request.get(`/news/getNewsPage`, { params: data });
};

//获取未审核的新闻 getNoAuditNews
export const getNoAuditNews = () => {
  return request.get("/news/getNoAuditNews");
};

//更新状态 updateAudit
export const updateAudit = (params) => {
  return request.put("/news/updateAudit", params);
};

//发布新闻
export const releaseNews = (params) => {
  return request.post(`/news/releaseNews`, params);
};

//删除新闻
export const deleteNews = (id) => {
  return request.delete(`/news/deleteNews/${id}`);
};

//查看新闻详情
export const getNewsDetail = (id) => {
  return request.get(`/news/getNewsDetail/${id}`);
};

//修改新闻 /news/updateNews
export const updateNews = (params) => {
  return request.put("/news/updateNews", params);
};

import request from "@/utils/request";

//获取热门新闻
export const getHotNews = () => {
  return request.get(`/news/getHotNews`);
};

//获取最新新闻
export const getLatestNews = () => {
  return request.get("/news/getLatestNews");
};

//分页查询新闻
export const getAllNews = (page, pageSize) => {
  return request.get(`/news/getAllNews?page=${page}&pageSize=${pageSize}`);
};

//获取新闻详情
export const getNewsDetail = (newsId) => {
  return request.get(`/news/getNewsDetail?newsId=${newsId}`);
};

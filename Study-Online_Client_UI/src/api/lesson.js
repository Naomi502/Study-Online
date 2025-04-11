import request from "@/utils/request";

//获取课程分类列表
export const getHotCategory = () => {
  return request.get("/lesson/getHotCategory");
};

//查询热门课程
export const getLessons = (id) => {
  return request.get(`/lesson/getLessons/${id}`);
};

//查询课程列表
export const getLessonTreeById = (lessonId) => {
  return request.get(`/lesson/getLessonTreeById?lessonId=${lessonId}`);
};

//查询课程详情
export const getLessonDetail = (lessonId) => {
  return request.get(`/lesson/getLessonDetail?lessonId=${lessonId}`);
};

//获取视频地址
export const getVideo = (pId) => {
  return request.get(`/lesson/getVideo?pId=${pId}`);
};

//分页搜索商品
export const searchLesson = (data) => {
  return request.get("/lesson/searchLesson", { params: data });
};

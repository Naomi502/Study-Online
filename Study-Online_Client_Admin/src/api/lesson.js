import request from "@/utils/request";

//获取课程列表  /lesson/getLessonPage
export const getLessonPage = (data) => {
  return request.get(`/lesson/getLessonPage`, { params: data });
};

//添加课程 /lesson/addLesson
export const addLesson = (params) => {
  return request.post(`/lesson/addLesson`, params);
};

//添加课程详情  /lesson/addLessonDetail
export const addLessonDetail = (params) => {
  return request.post(`/lesson/addLessonDetail`, params);
};

//添加章节 (不用传parentId，level传1)  //添加课程子链(parentId传章节id，level传2) lessonId传上一步创建的id
export const addLessonTree = (params) => {
  return request.post(`/lesson/addLessonTree`, params);
};

//获取已创建章节 /lesson/getMainTree
export const getMainTree = (lessonId) => {
  return request.get(`/lesson/getMainTree?lessonId=${lessonId}`);
};

//查询总章节及子链 /lesson/getLessonTreeById
export const getLessonTreeById = (lessonId) => {
  return request.get(`/lesson/getLessonTreeById?lessonId=${lessonId}`);
};

//删除课程 /lesson/deleteLesson/{id}
export const deleteLesson = (id) => {
  return request.delete(`/lesson/deleteLesson?id=${id}`);
};

//查询已创建的课程 /lesson/getLessonById
export const getLessonById = (lessonId) => {
  return request.get(`/lesson/getLessonById?lessonId=${lessonId}`);
};

//查询已创建的课程详情 /lesson/getLessonDetailById
export const getLessonDetailById = (lessonId) => {
  return request.get(`/lesson/getLessonDetailById?lessonId=${lessonId}`);
};

//修改课程 /lesson/updateLesson
export const updateLesson = (params) => {
  return request.put("/lesson/updateLesson", params);
};

//修改课程详情 /lesson/updateLessonDetail
export const updateLessonDetail = (params) => {
  return request.put("/lesson/updateLessonDetail", params);
};

//修改课程章节 /lesson/updateLessonTree
export const updateLessonTree = (params) => {
  return request.put("/lesson/updateLessonTree", params);
};

//删除课程章节和子链 /lesson/deleteTree/{id}
export const deleteTree = (id) => {
  return request.delete(`/lesson/deleteTree/${id}`);
};

//添加章节视频 /lesson/addVideo
export const addVideo = (params) => {
  return request.post("/lesson/addVideo", params);
};

//删除章节视频 /lesson/deleteVideo
export const deleteVideo = (treeId) => {
  return request.delete(`/lesson/deleteVideo?treeId=${treeId}`);
};

//获取我的课程类别数量  /lesson/getMyCategoryCount
export const getMyCategoryCount = (teacherId) => {
  return request.get(`/lesson/getMyCategoryCount?teacherId=${teacherId}`);
};

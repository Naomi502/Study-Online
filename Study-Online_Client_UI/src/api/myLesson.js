import request from "@/utils/request";

//查询我的课程
export const getMyLesson = (userId) => {
  return request.get(`/myLesson/getMyLesson?userId=${userId}`);
};

//加入课程
export const joinLesson = (params) => {
  return request.post("/myLesson/joinLesson", params);
};

//修改
export const updateMyLesson = (params) => {
  return request.put("/myLesson/updateMyLesson", params);
};

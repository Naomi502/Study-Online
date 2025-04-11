import request from "@/utils/request";

//获取教师列表
export const getTeacherPage = (data) => {
  return request.get(`/teacher/getTeacherPage`, { params: data });
};

//启用禁用
export const updateTeacherStatus = (id) => {
  return request.put(`/teacher/updateTeacherStatus?id=${id}`);
};

//删除教师
export const deleteTeacher = (id) => {
  return request.delete(`/teacher/deleteTeacher/${id}`);
};

//获取个人信息 getMyDetail
export const getMyDetail = (id) => {
  return request.get(`/teacher/getMyDetail?id=${id}`);
};

//修改个人信息 updateTeacher
export const updateTeacher = (params) => {
  return request.put("/teacher/updateTeacher", params);
};

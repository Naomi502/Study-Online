import request from "@/utils/request";

//获取热门分类
export const getHotCategory = () => {
  return request.get(`/hotCategory/getHotCategory`);
};

//启用禁用
export const updateHotCategoryStatus = (id) => {
  return request.put(`/hotCategory/updateHotCategoryStatus?id=${id}`);
};

//更改名称
export const updateCategoryName = (params) => {
  return request.put(`/hotCategory/updateCategoryName`, params);
};

//添加分类
export const addCategory = (params) => {
  return request.post("/hotCategory/addCategory", params);
};

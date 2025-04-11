const getters = {
  sidebar: (state) => state.app.sidebar,
  device: (state) => state.app.device,
  token: (state) => state.user.token,
  avatar: (state) => state.user.avatar,
  name: (state) =>
    state.user.name ? state.user.name : localStorage.getItem("teacherName"),
  teacherId: (state) =>
    state.user.teacherId
      ? state.user.teacherId
      : localStorage.getItem("teacherId"),

  menus: (state) => state.user.menus,

  roleId: (state) => state.user.roleId,
};
export default getters;

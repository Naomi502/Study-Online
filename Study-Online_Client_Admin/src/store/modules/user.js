// import { login, logout } from '@/api/user'
// import { getInfo, login } from "@/api/login";
import Cookies from 'js-cookie'
import router from "@/router";
import { getInfo, login } from "@/api/login";
import { getToken, setToken, removeToken } from "@/utils/auth";
import { resetRouter } from "@/router";
import { mapRouteToVueRouter } from "@/utils/route-utils";

const getDefaultState = () => {
  return {
    token: getToken(),
    name: "",
    teacherId: "",
    avatar: "",
    menus: [],
    roleId: "",
  };
};

const state = getDefaultState();

const mutations = {
  RESET_STATE: (state) => {
    Object.assign(state, getDefaultState());
  },
  SET_TOKEN: (state, token) => {
    state.token = token;
  },
  SET_NAME: (state, name) => {
    state.name = name;
  },
  SET_AVATAR: (state, avatar) => {
    state.avatar = avatar;
  },
  SET_TEACHERID: (state, teacherId) => {
    state.teacherId = teacherId;
  },
  SET_MENUS: (state, menus) => {
    state.menus = menus;
  },
  SET_ROLEID: (state, roleId) => {
    state.roleId = roleId;
  },
};

const actions = {
  // user login
  login({ commit }, userInfo) {
    const { username, password } = userInfo;
    return new Promise((resolve, reject) => {
      login({ tname: username.trim(), password: password })
        .then((response) => {
          const { data } = response;
          getInfo(data.roleId).then(({ data: res }) => {
            const newRouter = res.map((v) => mapRouteToVueRouter(v));
            commit("SET_MENUS", newRouter);

            // console.log(res, "old");
            // console.log(newRouter, "new");
            sessionStorage.setItem("menus", JSON.stringify(newRouter));
            // console.log(...newRouter);
            resetRouter();
            newRouter.forEach((res) => {
              // console.log(res, "res");
              router.addRoute(res);
            });
          });
          commit("SET_TOKEN", data.token);
          commit("SET_TEACHERID", data.userid);
          commit("SET_NAME", data.userName);
          commit("SET_ROLEID", data.roleId);
          localStorage.setItem("teacherName", data.userName);
          localStorage.setItem("token", data.token);
          localStorage.setItem("teacherId", data.userid);
          localStorage.setItem("roleId", data.roleId);
          Cookies.set("roleId",data.roleId)
          // dispatch("getInfo")

          setToken(data.token);
          resolve();
          this.$router.push("/");
          // this.loading = false;
        })
        .catch((error) => {
          reject(error);
        });
    });
  },

  // get user info
  // getInfo({ commit, state }) {
  //   return new Promise((resolve, reject) => {
  //     getInfo()
  //       .then((response) => {
  //         const { data } = response;
  //         if (!data) {
  //           return reject("Verification failed, please Login again.");
  //         }
  //         const { name, avatar } = data;
  //         commit("SET_NAME", name);
  //         commit("SET_AVATAR", avatar);
  //         resolve(data);
  //       })
  //       .catch((error) => {
  //         reject(error);
  //       });
  //   });
  // },

  // user logout
  logout({ commit, state }) {
    return new Promise((resolve, reject) => {
      removeToken(); // must remove  token  first
      resetRouter();
      commit("RESET_STATE");
      localStorage.clear()
      sessionStorage.clear()
      Cookies.remove("roleId")
      resolve();
    });
  },

  // remove token
  resetToken({ commit }) {
    return new Promise((resolve) => {
      removeToken(); // must remove  token  first
      commit("RESET_STATE");
      resolve();
    });
  },
};

export default {
  namespaced: true,
  state,
  mutations,
  actions,
};

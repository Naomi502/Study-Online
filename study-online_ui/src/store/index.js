import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    isSign2: false,
    beforeTarget: {}, //记录上次点击的按钮
    userId: "",
    defaultList: [], //记录展开节点
    treeId: "",
    isCut: false, //记录切换 
    search: "", //传输搜索内容
  },
  getters: {
    userId(state) {
      return state.userId ? state.userId : localStorage.getItem("userId");
    },
  },
  mutations: {
    SETISSIGN: (state, newValue) => {
      state.isSign2 = newValue;
    },
    SETTARGET: (state, newValue) => {
      state.beforeTarget = newValue;
    },
    SETUSERID: (state, newValue) => {
      state.userId = newValue;
    },
    SETEXPANDEDLIST: (state, newValue) => {
      state.defaultList = newValue;
    },
    SETTREEID: (state, newValue) => {
      state.treeId = newValue;
    },
    SETISCUT: (state, newValue) => {
      state.isCut = newValue;
    },
    SETSEARCH: (state, newValue) => {
      state.search = newValue;
    },
  },
  actions: {},
  modules: {},
});

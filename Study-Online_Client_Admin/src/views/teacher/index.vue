<template>
  <div class="dashboard-container">
    <div class="dashboard-text">教师列表</div>
    <el-card class="box-card" shadow="never" style="margin-top: 20px">
      <div slot="header" class="clearfix">
        <span style="font-size: 22px;line-height: 36px;"><i class="el-icon-search"></i>筛选搜索</span>
        <el-button @click="reset" style="float: right; padding: 10px 10px; margin-left: 15px">重置</el-button>
        <el-button type="primary" @click="onSubmit" style="float: right; padding: 10px 10px">查询结果</el-button>
      </div>
      <el-form :inline="true" :model="formInline" class="demo-form-inline">
        <el-form-item label="输入搜索">
          <el-input v-model="formInline.name" placeholder="教师名称"></el-input>
        </el-form-item>
      </el-form>
    </el-card>
    <el-card style="margin-top: 30px" class="box-card" shadow="never">
      <span style="font-size: 22px"><i class="el-icon-s-order"></i>数据列表</span>
    </el-card>
    <el-table :cell-style="rowClass" :header-cell-style="headClass" border ref="multipleTable" :data="teacherList"
      tooltip-effect="dark" style="width: 100%; margin-top: 30px">
      <!-- <el-table-column type="selection"> </el-table-column> -->
      <el-table-column type="index"> </el-table-column>
      <el-table-column prop="tname" label="姓名"> </el-table-column>
      <el-table-column label="权限">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.roleId == 2" type="success">超级教师</el-tag>
          <el-tag v-else type="warning">普通教师</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="状态">
        <template slot-scope="scope">
          <el-switch v-show="scope.row.roleId != 2" v-model="scope.row.status == 1" @change="changeSwitch(scope.row.id)" active-color="#13ce66"
            inactive-color="#ff4949">
          </el-switch>
          <el-switch v-show="scope.row.roleId == 2" v-model="scope.row.status == 1" @change="changeSwitch(scope.row.id)" active-color="#13ce66" disabled
            inactive-color="#ff4949">
          </el-switch>
        </template>
      </el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button plain type="danger" v-show="scope.row.roleId != 2" size="mini"
            @click="deleteComment(scope.row.id)">删除</el-button>
          <el-button plain type="danger" v-show="scope.row.roleId == 2" style="position: relative;left: -6px;" disabled
            size="mini">无法删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <div style="margin-top: 20px;float: right;">
      <el-pagination style="padding-bottom: 60px;" background @size-change="handleSizeChange"
        @current-change="handleCurrentChange" :page-sizes="[10, 15, 20, 25]" :page-size="100"
        layout="sizes, prev, pager, next" :page-count="Math.ceil(total / pageSize)">
      </el-pagination>
    </div>
  </div>
</template>

<script>
import { getTeacherPage, updateTeacherStatus, deleteTeacher } from '@/api/teacher'
export default {
  name: '',

  data() {
    return {
      page: 1,
      pageSize: 10,
      teacherList: [],
      total: 0,
      formInline: {
        name: ""
      },
      isSearch: false
    };
  },

  mounted() {
    this.getTeacher()
  },

  methods: {
    getTeacher() {
      getTeacherPage({
        page: this.page,
        pageSize: this.pageSize
      }).then(({ data: res }) => {
        this.total = res.total
        this.teacherList = res.records
        console.log(this.teacherList);
      })
    },
    // 表头样式设置
    headClass() {
      return "text-align: center;background:rgb(242,242,242);color:rgb(140,138,140)";
    },
    // 表格样式设置
    rowClass() {
      return "text-align: center;";
    },
    reset() {
      this.formInline.name = ""
      this.isSearch = false
      this.getTeacher()
    },
    onSubmit() {
      this.isSearch = true
      getTeacherPage({
        page: this.page,
        pageSize: this.pageSize,
        name: this.formInline.name
      }).then(({ data: res }) => {
        this.total = res.total
        this.teacherList = res.records
      })
    },
    handleSizeChange(val) {
      console.log(`每页 ${val} 条`);
      this.pageSize = val
      if (!this.isSearch) {
        this.getTeacher()
      } else {
        this.onSubmit()
      }
    },
    handleCurrentChange(val) {
      console.log(`当前页: ${val}`);
      this.page = val
      if (!this.isSearch) {
        this.getTeacher()
      } else {
        this.onSubmit()
      }
    },
    changeSwitch(id) {
      console.log(id);
      updateTeacherStatus(id).then(res => {
        if (!this.isSearch) {
          this.getTeacher()
        } else {
          this.onSubmit()
        }
      })
    },
    deleteComment(id) {
      // console.log(id);
      this.$confirm('此操作将永久删除此教师及其发布过的新闻和课程, 请谨慎考虑！', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteTeacher(id).then(res => {
          if (!this.isSearch) {
            this.getTeacher()
          } else {
            this.onSubmit()
          }
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    }
  },
};
</script>

<style lang="scss" scoped>
.dashboard {
  &-container {
    margin: 30px;
  }

  &-text {
    font-size: 30px;
    line-height: 46px;
  }
}
</style>

<template>
  <div class="dashboard-container">
    <div class="dashboard-text">课程列表</div>
    <el-card class="box-card" shadow="never" style="margin-top: 20px">
      <div slot="header" class="clearfix">
        <span style="font-size: 22px;line-height: 36px;"><i class="el-icon-search"></i>筛选搜索</span>
        <el-button @click="reset" style="float: right; padding: 10px 10px; margin-left: 15px">重置</el-button>
        <el-button type="primary" @click="onSubmit" style="float: right; padding: 10px 10px">查询结果</el-button>
      </div>
      <el-form :inline="true" :model="formInline" class="demo-form-inline">
        <el-form-item label="课程名称">
          <el-input v-model="formInline.lName" placeholder="请输入课程"></el-input>
        </el-form-item>
        <el-form-item label="教师名称">
          <el-input v-model="formInline.tName" placeholder="请输入教师"></el-input>
        </el-form-item>
        <el-form-item label="课程分类" label-width="120px">
          <el-select v-model="categoryFirst" placeholder="全部">
            <el-option v-for="item in formInline.category" @click.native="handleSelectTeam(item.id)" :key="item.id"
              :label="item.name" :value="item.id"></el-option>
            <!-- <el-option label="家用电器" value="tv"></el-option> -->
          </el-select>
        </el-form-item>
      </el-form>
    </el-card>
    <!-- <el-card style="margin-top: 30px" class="box-card" shadow="never">
      <span style="font-size: 22px"><i class="el-icon-s-order"></i>数据列表</span>
      <el-button style="float: right; padding: 10px 10px;margin-top: -5px;" type="primary"
        @click="addLesson">添加课程</el-button>
    </el-card> -->
    <el-table :cell-style="rowClass" :header-cell-style="headClass" border ref="multipleTable" :data="lessonList"
      tooltip-effect="dark" style="width: 100%; margin-top: 30px">
      <!-- <el-table-column type="selection"> </el-table-column> -->
      <el-table-column type="index" fixed> </el-table-column>
      <el-table-column fixed label="标题" width="250">
        <template slot-scope="scope">
          <span style="font-weight: 600;">{{ scope.row.lname }}</span>
        </template>
      </el-table-column>
      <el-table-column label="课程图片" width="300">
        <template slot-scope="scope">
          <img width="300px" height="188px" style="position: relative;left: -10px;" :src="scope.row.img" alt="">
        </template>
      </el-table-column>
      <el-table-column prop="tname" label="发布人" width="150"> </el-table-column>
      <el-table-column label="课程分类" width="150">
        <template slot-scope="scope">
          <el-tag type="warning">{{ scope.row.categoryName }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="school" label="发布学校" width="150"> </el-table-column>
      <el-table-column prop="time" label="发布时间" width="200"></el-table-column>
      <el-table-column label="点击量" width="150">
        <template slot-scope="scope">
          <el-tag type="info">{{ scope.row.dianJi }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="简介" prop="remark" width="400"></el-table-column>
      <el-table-column label="操作" width="180" fixed="right">
        <template slot-scope="scope">
          <el-button type="success" size="mini" plain @click="goUpdate(scope.row.id)">修改</el-button>
          <el-button plain type="danger" size="mini" @click="deleteComment(scope.row.id)">删除</el-button>
        </template>
      </el-table-column>
      <el-table-column label="生成" fixed="right" width="150">
        <template slot-scope="scope">
          <el-button size="mini" plain @click="goDetail(scope.row.id)">查看详情</el-button>
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
import { getLessonPage, deleteLesson } from '@/api/lesson'
import { getHotCategory } from '@/api/category'
export default {
  data() {
    return {
      formInline: {
        lName: '',
        tName: '',
        category: [],
      },
      page: 1,
      pageSize: 10,
      // teacherName: 'isla',
      lessonList: [],
      total: 0,
      categoryFirst: '',
      categoryId: null,
      isSelect: false
    }
  },
  mounted() {
    this.getLesson()
    getHotCategory().then(({ data: res }) => {
      this.formInline.category = res
      // console.log(this.categoryList);
    })
  },
  methods: {
    getLesson() {
      getLessonPage({
        page: this.page,
        pageSize: this.pageSize,
        // tName: this.teacherName
      }).then(({ data: res }) => {
        this.lessonList = res.records
        this.total = res.total
        // console.log(this.lessonList);
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
    handleSelectTeam(id) {
      // console.log(id, 'categoryId');
      this.categoryId = id
    },
    reset() {
      this.isSelect = false
      this.formInline.lName = "",
        this.lessonTypeId = '',
        this.categoryFirst = ""
      this.getLesson()
    },
    onSubmit() {
      this.isSelect = true
      getLessonPage({
        page: this.page,
        pageSize: this.pageSize,
        tName: this.formInline.tName ? this.formInline.tName : undefined,
        lName: this.formInline.lName ? this.formInline.lName : undefined,
        lessonTypeId: this.categoryId ? this.categoryId : undefined,
      }).then(({ data: res }) => {
        this.lessonList = res.records
        this.total = res.total
      })
    },
    goUpdate(id) {
      console.log(id);
      this.$router.push({
        name: "addLesson",
        query: {
          id: id
        },
        params: {
          type: 2
        }
      })
    },
    deleteComment(id) {
      console.log(id);
      this.$confirm('此操作将永久删除该课程所涵盖的所有信息, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteLesson(id).then(res => {
          this.getLesson()
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },
    handleSizeChange(val) {
      console.log(`每页 ${val} 条`);
      this.pageSize = val
      if (!this.isSelect) {
        this.getLesson()
      } else {
        this.onSubmit()
      }
    },
    handleCurrentChange(val) {
      console.log(`当前页: ${val}`);
      this.page = val
      if (!this.isSelect) {
        this.getLesson()
      } else {
        this.onSubmit()
      }
    },
    addLesson() {
      this.$router.push({
        name: 'addLesson',
        params: {
          type: 1
        }
      })
    },
    goDetail(id) {
      // console.log(id);
      this.$router.push({
        name: "lessonDetail",
        query: {
          id: id
        }
      })
    }
  }
};
</script>

<style lang='scss' scoped>
.dashboard {
  &-container {
    margin: 30px;
  }

  &-text {
    font-size: 30px;
    line-height: 46px;
  }

  .text {
    font-size: 14px;
  }

  .item {
    margin-bottom: 18px;
  }

  .clearfix:before,
  .clearfix:after {
    display: table;
    content: "";
  }

  .clearfix:after {
    clear: both;
  }

  .box-card {
    width: 480px;
  }
}
</style>

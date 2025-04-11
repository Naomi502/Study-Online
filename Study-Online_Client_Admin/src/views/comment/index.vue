<template>
  <div class="dashboard-container">
    <div class="dashboard-text">评论列表</div>
    <el-card class="box-card" shadow="never" style="margin-top: 20px">
      <div slot="header" class="clearfix">
        <span style="font-size: 22px;line-height: 36px;"><i class="el-icon-search"></i>筛选搜索</span>
        <el-button @click="reset" style="float: right; padding: 10px 10px; margin-left: 15px">重置</el-button>
        <el-button type="primary" @click="onSubmit" style="float: right; padding: 10px 10px">查询结果</el-button>
      </div>
      <el-form :inline="true" :model="formInline" class="demo-form-inline">
        <el-form-item label="输入搜索">
          <el-input v-model="formInline.name" placeholder="用户名称"></el-input>
        </el-form-item>
      </el-form>
    </el-card>
    <el-card style="margin-top: 30px" class="box-card" shadow="never">
      <span style="font-size: 22px"><i class="el-icon-s-order"></i>数据列表</span>
    </el-card>
    <el-table :cell-style="rowClass" :header-cell-style="headClass" border ref="multipleTable" :data="commentList"
      tooltip-effect="dark" style="width: 100%; margin-top: 30px">
      <!-- <el-table-column type="selection"> </el-table-column> -->
      <el-table-column type="index"> </el-table-column>
      <el-table-column prop="loginName" label="昵称"> </el-table-column>
      <el-table-column prop="time" label="更新日期"> </el-table-column>
      <el-table-column prop="content" label="评论内容"></el-table-column>
      <el-table-column label="类型">
        <template slot-scope="scope">
          <el-tag v-if="!scope.row.parentId">评论</el-tag>
          <el-tag v-else type="warning">回复</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="获赞数">
        <template slot-scope="scope">
          <el-tag type="info">{{ scope.row.zan }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button plain type="danger" size="mini" @click="deleteComment(scope.row)">删除</el-button>
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
</div></template>

<script>
import { getCommentPage, deleteCommentByIds } from '@/api/comment'
export default {
  name: '',

  data() {
    return {
      page: 1,
      pageSize: 10,
      total: 0,
      commentList: [],
      selector2: [
        {
          name: '批量删除',
          id: 1
        },
      ],
      formInline: {
        name: ''
      },
      selectId: 0,
      isSearch: false,
      region: ''
    };
  },

  mounted() {
    this.getComment()
  },

  methods: {
    getComment() {
      console.log("111");
      getCommentPage({
        page: this.page,
        pageSize: this.pageSize
      }).then(({ data: res }) => {
        this.total = res.total
        this.commentList = res.records
        console.log(this.commentList);
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
      this.getComment()
    },
    onSubmit() {
      this.isSearch = true
      getCommentPage({
        page: this.page,
        pageSize: this.pageSize,
        name: this.formInline.name
      }).then(({ data: res }) => {
        this.total = res.total
        this.scoreList = res.records
      })
    },
    handleSelectTeam2(id) {
      console.log(id);
      this.selectId = id;
    },
    batch() {
    },
    handleSizeChange(val) {
      console.log(`每页 ${val} 条`);
      this.pageSize = val
      if (!this.isSearch) {
        this.getComment()
      } else {
        this.onSubmit()
      }
    },
    handleCurrentChange(val) {
      console.log(`当前页: ${val}`);
      this.page = val
      if (!this.isSearch) {
        this.getComment()
      } else {
        this.onSubmit()
      }
    },
    deleteComment(row) {
      console.log(row.id);
      if (!row.parentId) {
        this.$confirm('此操作将永久删除该评论及其对应的回复, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          deleteCommentByIds(row.id).then(res => {
            if (!this.isSearch) {
              this.getComment()
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
      } else {
        this.$confirm('此操作将永久删除此回复, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          deleteCommentByIds(row.id).then(res => {
            if (!this.isSearch) {
              this.getComment()
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

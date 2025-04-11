<template>
  <div class="dashboard-container">
    <div class="dashboard-text">我的新闻</div>
    <el-card style="margin-top: 30px" class="box-card" shadow="never">
      <span style="font-size: 22px"><i class="el-icon-s-order"></i>数据列表</span>
      <el-button style="float: right; padding: 10px 10px" type="primary" @click="addNews">发布新闻</el-button>
    </el-card>
    <el-table :cell-style="rowClass" :header-cell-style="headClass" border ref="multipleTable" :data="newsList"
      tooltip-effect="dark" style="width: 100%; margin-top: 30px">
      <!-- <el-table-column type="selection"> </el-table-column> -->
      <el-table-column type="index" fixed> </el-table-column>
      <el-table-column prop="title" label="标题" width="500"> </el-table-column>
      <el-table-column prop="tname" label="发布人" width="100"> </el-table-column>
      <el-table-column label="类型" width="100">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.isHot == 1" type="danger">热门</el-tag>
          <el-tag v-else type="warning">普通</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="审核状态" width="120">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.isAudit == 1" type="success">已审核</el-tag>
          <el-tag v-else-if="scope.row.isAudit == 0" type="warning">未审核</el-tag>
          <el-tag v-else-if="scope.row.isAudit == 2" type="danger">不通过</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="time" label="发布时间" width="200"></el-table-column>
      <el-table-column label="点击量" width="150">
        <template slot-scope="scope">
          <el-tag type="info">{{ scope.row.dianJi }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="200" fixed="right">
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
import { getNewsPage, deleteNews } from '@/api/news'
import { mapGetters } from 'vuex';
export default {
  data() {
    return {
      page: 1,
      pageSize: 10,
      total: 0,
      newsList: [],
      // teacherName: 'isla'
    };
  },
  computed: {
    ...mapGetters(["name"])
  },
  mounted() {
    this.getNews()
  },
  methods: {
    getNews() {
      getNewsPage({
        page: this.page,
        pageSize: this.pageSize,
        name: this.name
      }).then(({ data: res }) => {
        this.total = res.total,
          this.newsList = res.records
      }).then(({ data: res }) => {
        this.total = res.total
        this.newsList = res.records
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
    handleSizeChange(val) {
      console.log(`每页 ${val} 条`);
      this.pageSize = val
      this.getNews()
    },
    handleCurrentChange(val) {
      console.log(`当前页: ${val}`);
      this.page = val
      this.getNews()
    },
    deleteComment(id) {
      this.$confirm('此操作将永久删除该新闻, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteNews(id).then(res => {
          this.getNews()
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },
    addNews() {
      this.$router.push({
        name: 'addNews',
        params: {
          type: 1
        }
      })
    },
    goUpdate(id) {
      this.$router.push({
        name: 'addNews',
        params: {
          type: 2,
          id: id
        }
      })
    },
    goDetail(id) {
      this.$router.push({
        name: "newsDetail",
        params: {
          id: id
        }
      })
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

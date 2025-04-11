<template>
  <div class="dashboard-container">
    <div class="dashboard-text">积分列表</div>
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
    <el-table :cell-style="rowClass" :header-cell-style="headClass" @select="handleSelect" @select-all="handleSelectAll"
      border ref="multipleTable" :data="scoreList" tooltip-effect="dark" style="width: 100%; margin-top: 30px"
      @selection-change="handleSelectionChange">
      <el-table-column type="selection"> </el-table-column>
      <el-table-column type="index"> </el-table-column>
      <el-table-column prop="loginName" label="昵称"> </el-table-column>
      <el-table-column prop="time" label="更新日期"> </el-table-column>
      <el-table-column label="总积分">
        <template slot-scope="scope">
          <span v-show="scope.row.id != clickId">{{ scope.row.score }}</span>
          <el-input v-show="scope.row.id == clickId" v-model="newScore" placeholder="请输入积分"></el-input>
        </template>
      </el-table-column>
      <el-table-column label="签到">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.status == 1" type="success">今日已签</el-tag>
          <el-tag v-else type="warning">今日未签</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button v-show="scope.row.id != clickId" plain type="primary" size="mini"
            @click="update(scope.row.id)">修改积分</el-button>
          <el-button style="position: relative;left: -5px;" v-show="scope.row.id == clickId" plain type="success"
            size="mini" @click="updateSuccess(scope.row.id)">完成修改</el-button>
          <el-button plain type="warning" size="mini" @click="edit(scope.row.id)">重置积分</el-button>
        </template>
      </el-table-column>
      <el-table-column label="积分明细">
        <template slot-scope="scope">
          <el-button plain size="mini" @click="getScoreDetail(scope.row.userId)">查看积分明细</el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-dialog title="积分明细" :visible.sync="dialogTableVisible">
      <el-table :data="scoreDetail">
        <el-table-column align="center" label="积分奖励">
          <template slot-scope="scope">
            <span>+{{ scope.row.score }}</span>
          </template>
        </el-table-column>
        <el-table-column align="center" prop="time" label="最后更新时间" width="160">
        </el-table-column>
        <el-table-column align="center" prop="way" label="积分获取方式">
        </el-table-column>
      </el-table>
    </el-dialog>
    <div style="display: flex;flex-direction: row;justify-content: space-between;margin-top: 20px;">
      <div>
        <el-select v-model="region" placeholder="批量操作">
          <el-option v-for="item in selector2" :key="item.id" :label="item.name" :value="item.id"
            @click.native="handleSelectTeam2(item.id)"></el-option>
        </el-select>
        <el-button type="primary" style="margin-left: 20px" @click="batch">确定</el-button>
      </div>
      <el-pagination style="padding-bottom: 60px;" background @size-change="handleSizeChange"
        @current-change="handleCurrentChange" :page-sizes="[10, 15, 20, 25]" :page-size="100"
        layout="sizes, prev, pager, next" :page-count="Math.ceil(total / pageSize)">
      </el-pagination>
    </div>
  </div>
</template>

<script>
import { getScorePage, resetScore, updateScore, getScoreDetail } from '@/api/score'
export default {
  name: '',

  data() {
    return {
      page: 1,
      pageSize: 10,
      scoreList: [],
      formInline: {
        name: ''
      },
      selector2: [
        {
          name: '批量重置',
          id: 1
        },
      ],
      selectId: 0,
      total: 0,
      region: '',
      multipleSelection: '',
      selectGoodsId: [],
      isSearch: false,
      newScore: "",
      clickId: '',
      scoreDetail: [],
      dialogTableVisible: false
    };
  },

  mounted() {
    this.getScore()
  },

  methods: {
    getScore() {
      getScorePage({
        page: this.page,
        pageSize: this.pageSize
      }).then(({ data: res }) => {
        this.total = res.total
        this.scoreList = res.records
      })
    },
    getScoreDetail(userId) {
      getScoreDetail(userId).then(({ data: res }) => {
        this.scoreDetail = res
        this.dialogTableVisible = true

      })
      // getScoreDetail()
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
      this.getScore()
    },
    onSubmit() {
      this.isSearch = true
      getScorePage({
        page: this.page,
        pageSize: this.pageSize,
        name: this.formInline.name
      }).then(({ data: res }) => {
        this.total = res.total
        this.scoreList = res.records
      })
    },
    handleSelectTeam2(id) {
      // console.log(id);
      this.selectId = id;
    },
    batch() {
      resetScore(this.selectGoodsId).then(res => {
        if (!this.isSearch) {
          this.getScore()
        } else {
          this.onSubmit()
        }
      })
    },
    handleSizeChange(val) {
      console.log(`每页 ${val} 条`);
      this.pageSize = val
      if (!this.isSearch) {
        this.getScore()
      } else {
        this.onSubmit()
      }
    },
    handleCurrentChange(val) {
      console.log(`当前页: ${val}`);
      this.page = val
      if (!this.isSearch) {
        this.getScore()
      } else {
        this.onSubmit()
      }
    },
    handleSelectionChange(val) {
      // console.log(val);
      this.multipleSelection = val;
    },
    handleSelect(selection, row) {
      this.selectGoodsId = selection.map((x) => x.id);
      // console.log(this.selectGoodsId);
    },
    handleSelectAll(row) {
      this.selectGoodsId = row.map((x) => x.id);
      // console.log(this.selectGoodsId);
    },
    edit(id) {
      // console.log(id);
      resetScore(id).then(res => {
        if (!this.isSearch) {
          this.getScore()
        } else {
          this.onSubmit()
        }
      })
    },
    update(id) {
      this.clickId = id
      // console.log(id);
    },
    updateSuccess(id) {
      if (this.newScore) {
        updateScore({
          id: id,
          score: this.newScore
        }).then(res => {
          this.clickId = ''
          this.newScore = ""
          if (!this.isSearch) {
            this.getScore()
          } else {
            this.onSubmit()
          }
        })
      } else {
        this.$message.warning("请输入新的积分")
      }
    }
  },
};
</script>

<style lang="scss" scoped>
::v-deep .el-table td,
.el-table th {
  height: 65px;
}

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

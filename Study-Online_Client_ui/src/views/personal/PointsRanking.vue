<template>
  <div class="points-ranking">
    <h2 class="page-title">积分排名</h2>
    <el-card class="ranking-card">
      <el-table
          :data="list"
          :row-class-name="tableRowClassName"
          header-align="center"
          stripe
          border
          style="width: 100%"
          :default-sort="{ prop: 'score', order: 'descending' }">

        <el-table-column
            type="index"
            label="排名"
            width="100"
            align="center">
          <template slot-scope="scope">
            <div class="rank-number">
                            <span v-if="scope.$index < 3" class="medal">
                                {{ ['🥇', '🥈', '🥉'][scope.$index] }}
                            </span>
              <span v-else>{{ scope.$index + 1 }}</span>
            </div>
          </template>
        </el-table-column>
        <el-table-column label="用户" align="center">
          <template slot-scope="scope">
            <div class="user-info">
              <el-avatar
                  :size="40"
                  :src="scope.row.user?.img"
                  class="user-avatar"
              />
              <!-- 使用固定宽度的容器并设置文本对齐方式 -->
              <div class="username-container" style="width: 100px; text-align: center;">
                <span class="username">{{ scope.row.user?.loginName }}</span>
              </div>
            </div>
          </template>
        </el-table-column>
        <el-table-column
            prop="time"
            label="最后更新时间"
            align="center"
            width="200"
        />
        <el-table-column
            prop="score"
            label="总积分"
            align="center"
            width="150"
        >
          <template slot-scope="scope">
                        <span class="total-score">
                            {{ scope.row.score }}
                        </span>
          </template>
        </el-table-column>
      </el-table>
      <!-- 浮动用户信息卡 -->
      <div class="floating-card">
        <el-card shadow="hover">
          <div class="current-user-info">
            <div class="user-main">
              <el-avatar
                  :size="50"
                  :src="img"
                  class="current-user-avatar"
              />
              <div class="user-meta">
                <div class="rank-tag">
                  <el-tag type="warning">第 {{ sort }} 名</el-tag>
                </div>
                <div class="username">{{ loginName }}</div>
              </div>
            </div>

            <div class="user-stats">
              <div class="stat-item">
                <span class="label">总积分</span>
                <span class="value">{{ score }}</span>
              </div>
              <div class="stat-item">
                <span class="label">最后更新</span>
                <span class="value">{{ time }}</span>
              </div>
            </div>
            <el-button
                type="primary"
                plain
                @click="dialogTableVisible = true"
                class="detail-btn"
            >
              查看积分明细
            </el-button>
          </div>
        </el-card>
      </div>
    </el-card>
    <!-- 积分明细弹窗 -->
    <el-dialog
        title="积分明细"
        :modal="false"
        :visible.sync="dialogTableVisible"
        width="60%"
        custom-class="score-detail-dialog"
    >
      <el-table
          :data="scoreDetail"
          empty-text="暂无积分记录"
          class="detail-table"
      >
        <el-table-column
            label="积分变动"
            align="center"
            width="120"
        >
          <template slot-scope="scope">
                        <span class="score-change">
                            +{{ scope.row.score }}
                        </span>
          </template>
        </el-table-column>
        <el-table-column
            prop="time"
            label="时间"
            align="center"
            width="180"
        />
        <el-table-column
            prop="way"
            label="获取途径"
            align="center"
        />
      </el-table>
    </el-dialog>
  </div>
</template>

<script>
import { getAllScore, getMyScore, getScoreDetail } from '@/api/score.js'
export default {
  name: 'StudyOnlinePointsRanking',

  data() {
    return {
      list: [],
      myList: {},
      scoreDetail: [],
      img: '',
      score: '',
      loginName: '',
      time: '',
      sort: '',
      userId: localStorage.getItem('userId'),
      dialogTableVisible: false
    };
  },

  mounted() {
    this.getAllScore()
  },

  methods: {
    getAllScore() {
      getAllScore().then(({ data: res }) => {
        // console.log(res);
        this.list = res
      })
      getMyScore(this.userId).then(({ data: res }) => {
        // this.myList = res
        this.img = res.user.img
        this.score = res.score
        this.loginName = res.user.loginName
        this.time = res.time
        // console.log(this.myList);
      })
      getScoreDetail(this.userId).then(({ data: res }) => {
        this.scoreDetail = res
      })
    },
    tableRowClassName({
                        row,
                        rowIndex
                      }) {
      if (row.userId == this.userId) {
        this.sort = rowIndex + 1
      }
      // console.log(row, 'row');
      if (rowIndex === 0) {
        return 'first';
      } else if (rowIndex === 1) {
        return 'second';
      } else if (rowIndex === 2) {
        return 'third';
      }
      return '';
    }

  },
};
</script>

<style lang="less" scoped>
.page-title {
  font-size: 24px;
  color: #333;
  margin-bottom: 30px;
  padding-bottom: 15px;
  border-bottom: 1px solid #eee;
}
.points-ranking {
  max-width: 1200px;
  margin: 0 auto;
  position: relative;
  padding: 20px;
  height: 100vh;
  .ranking-card {
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.04);

    /deep/ .el-card__body {
      padding: 20px;
    }
  }
  .floating-card {
    position: fixed;
    right: 30px;
    bottom: 30px;
    width: 360px;
    z-index: 1000;
    .current-user-info {
      display: flex;
      flex-direction: column;
      gap: 16px;
      .user-main {
        display: flex;
        align-items: center;
        gap: 15px;
        .user-meta {
          flex: 1;
          .username {
            font-size: 16px;
            font-weight: 500;
            color: #303133;
          }

          .rank-tag {
            margin-bottom: 4px;
          }
        }
      }
      .user-stats {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 12px;
        padding: 12px;
        background: #fafafa;
        border-radius: 8px;
        .stat-item {
          display: flex;
          flex-direction: column;
          align-items: center;
          .label {
            font-size: 12px;
            color: #909399;
            margin-bottom: 4px;
          }
          .value {
            text-align: center;
            font-size: 16px;
            font-weight: 500;
            color: #409EFF;
          }
        }
      }
      .detail-btn {
        width: 100%;
        margin-top: 8px;
      }
    }
  }
  /deep/ .el-table {
    border-radius: 8px;
    overflow: hidden;
    th {
      background-color: #f8f9fa !important;
      font-weight: 600;
      color: #606266;
    }
    .medal {
      font-size: 24px;
    }
    .user-info {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 12px;
      .user-avatar {
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }
      .username {
        font-weight: 500;
      }
    }
    .total-score {
      font-weight: 600;
      color: #e6a23c;
    }
  }
  /deep/ .score-detail-dialog {
    border-radius: 12px;
    .detail-table {
      .score-change {
        color: #67c23a;
        font-weight: 500;
      }
    }
  }
}
// 优化排名颜色
/deep/ .el-table {
  .first {
    --rank-color: #fff9e6;
    background: var(--rank-color) !important;

    &:hover > td {
      background: darkslategray(var(--rank-color), 2%) !important;
    }
  }
  .second {
    --rank-color: #f5f5f7;
    background: var(--rank-color) !important;

    &:hover > td {
      background: darkslategray(var(--rank-color), 2%) !important;
    }
  }
  .third {
    --rank-color: #fdf4e9;
    background: var(--rank-color) !important;

    &:hover > td {
      background: darkslategray(var(--rank-color), 2%) !important;
    }
  }
}
</style>
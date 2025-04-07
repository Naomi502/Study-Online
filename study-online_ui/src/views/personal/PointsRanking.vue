<template>
    <div class="points-ranking">
        <el-card class="box-card">
            <el-table :row-class-name="tableRowClassName" header-align="center" :data="list" style="width: 100%"
                :default-sort="{ prop: 'score', order: 'descending' }">
                <el-table-column type="index" width="80">
                </el-table-column>
                <el-table-column align="center" label="姓名">
                    <template slot-scope="scope">
                        <div style="display: flex;flex-direction: row;height: 30px;align-items: center;margin-left: 50px;">
                            <img v-if="scope.row.user" :src="scope.row.user.img" alt=""
                                style="border-radius: 50%;margin-right: 10px;" width="25px" height="25px">
                            <span v-if="scope.row.user">{{ scope.row.user.loginName }}</span>
                        </div>
                    </template>
                </el-table-column>
                <el-table-column align="center" prop="time" label="最后更新时间">
                </el-table-column>
                <el-table-column align="center" prop="score" label="总积分">
                </el-table-column>
            </el-table>
            <div style="height: 60px;"></div>
        </el-card>
        <el-card style="height: 50px;position: relative;top: -50px;">
            <div style="display: flex;align-items: center;justify-content: space-around;">
                <span style="color: red;">{{ sort }}</span>
                <div style="display: flex;align-items: center;">
                    <img :src="img" alt="" width="45px" height="45px"
                        style="border-radius: 50%;margin-right: 10px;margin-top: 2.5px;">
                    <span>{{ loginName }}</span>
                </div>
                <span>{{ time }}</span>
                <span style="color:rgb(203 203 31);">{{ score }}</span>
                <el-button plain @click="dialogTableVisible = true" style="margin-top: 2px;">查看积分明细</el-button>
            </div>
            <el-dialog :modal="false" title="积分明细" :visible.sync="dialogTableVisible">
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
        </el-card>
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
/deep/ .el-table .first {
    background: rgb(254, 255, 219);
}

/deep/ .el-table .second {
    background: #f1f1f1;
}

/deep/ .el-table .third {
    background: #fff6e0;
}

/deep/ .el-card__header {
    border: none;
}

/deep/ .el-table__row>td {
    border: none;
}

/deep/ .el-table::before {
    height: 0px;
}

.el-card {
    border: none;
}

.points-ranking {
    width: 100%;
    height: 100%;
    margin-top: -55px;

    .box-card::-webkit-scrollbar {
        display: none;
    }

    .box-card {
        height: 85vh;
    }
}
</style>

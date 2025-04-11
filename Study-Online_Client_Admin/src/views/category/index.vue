<template>
  <div class="dashboard-container">
    <div class="dashboard-text">热门课程分类</div>
    <el-card style="margin-top: 30px" class="box-card" shadow="never">
      <span style="font-size: 22px"><i class="el-icon-s-order"></i>数据列表</span>
      <el-button style="float: right; padding: 10px 10px;margin-top: -5px;" type="primary" @click="add">添加分类</el-button>
      <el-dialog title="提示" :visible.sync="dialogVisible" width="30%">
        <el-form :rules="rules" :model="ruleForm" ref="ruleForm" label-width="100px" class="demo-ruleForm">
          <el-form-item label="分类名称" prop="name">
            <el-input v-model="ruleForm.name"></el-input>
          </el-form-item>
          <el-form-item style="margin-top: 50px;" label="是否启用" prop="status">
            <el-switch v-model="ruleForm.status" @change="changeSwitch2()" active-color="#13ce66"
              inactive-color="#ff4949">
            </el-switch>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="cancel">取 消</el-button>
          <el-button type="primary" @click="sure('ruleForm')">确 定</el-button>
        </span>
      </el-dialog>
    </el-card>
    <el-table :cell-style="rowClass" :header-cell-style="headClass" border ref="multipleTable" :data="categoryList"
      tooltip-effect="dark" style="width: 100%; margin-top: 30px">
      <el-table-column type="index"> </el-table-column>
      <el-table-column prop="id" label="分类id"> </el-table-column>
      <el-table-column label="分类名称">
        <template slot-scope="scope">
          <span v-show="scope.row.id != clickId">{{ scope.row.name }}</span>
          <el-input v-show="scope.row.id == clickId" v-model="newCategory" placeholder="请输入分类名称"></el-input>
        </template>
      </el-table-column>
      <el-table-column label="状态">
        <template slot-scope="scope">
          <el-switch v-model="scope.row.status == 1" @change="changeSwitch(scope.row.id)" active-color="#13ce66"
            inactive-color="#ff4949">
          </el-switch>
        </template>
      </el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button v-show="scope.row.id != clickId" plain type="primary" size="mini"
            @click="updateCategory(scope.row.id)">修改</el-button>
          <el-button style="position: relative;left: -5px;" v-show="scope.row.id == clickId" plain type="success" size="mini"
            @click="updateSuccess(scope.row.id)">确定</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
import { getHotCategory, updateHotCategoryStatus, updateCategoryName, addCategory } from '@/api/category'
export default {
  name: '',

  data() {
    return {
      categoryList: [],
      clickId: '',
      newCategory: '',
      dialogVisible: false,
      ruleForm: {
        name: "",
        status: false
      },
      rules: {
        name: [
          { required: true, message: '请输入分类名称', trigger: 'blur' },
          { min: 2, max: 6, message: '长度在 2 到 6 个字符', trigger: 'blur' }
        ],
      }
    };
  },

  mounted() {
    this.getCategory()
  },

  methods: {
    getCategory() {
      getHotCategory().then(({ data: res }) => {
        this.categoryList = res
        console.log(this.categoryList);
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
    updateCategory(id) {
      console.log(id);
      this.clickId = id
    },
    changeSwitch(id) {
      console.log(id);
      updateHotCategoryStatus(id).then(res => {
        this.getCategory()
      })
    },
    updateSuccess(id) {
      if (this.newCategory) {
        updateCategoryName({
          id: id,
          name: this.newCategory
        }).then(res => {
          this.clickId = ""
          this.newCategory = ""
          this.getCategory()
        })
      } else {
        this.$message.warning("请输入新的分类名称")
      }
    },
    add() {
      this.dialogVisible = true
    },
    changeSwitch2() {
      console.log(this.ruleForm.status);
    },
    cancel() {
      this.dialogVisible = false
    },
    sure(formName) {
      console.log("sure");
      this.$refs[formName].validate((valid) => {
        if (valid) {
          addCategory({
            name: this.ruleForm.name,
            status: this.ruleForm.status == false ? 0 : 1
          }).then(res => {
            this.ruleForm.name = ""
            this.ruleForm.status = false
            this.dialogVisible = false
            this.getCategory()
          })
        } else {
          console.log('error submit!!');
          return false;
        }
      });
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
}
</style>

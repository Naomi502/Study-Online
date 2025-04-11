<template>
  <div class="dashboard-container">
    <div class="dashboard-text" v-if="!type || type == 1">发布新闻</div>
    <div class="dashboard-text" v-else>修改新闻</div>
    <el-card class="box-card" shadow="never" style="width: 70%;margin: auto; margin-top:20px;">
      <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm"
        style="position: relative;left: -30px;">
        <el-form-item label="发布人">
          <el-button type="info" plain disabled>{{ name }}</el-button>
        </el-form-item>
        <el-form-item label="标题" prop="title">
          <el-input v-model="ruleForm.title" placeholder="请输入标题"></el-input>
        </el-form-item>
        <el-form-item label="简介" prop="remark">
          <el-input v-model="ruleForm.remark" placeholder="请输入简介"></el-input>
        </el-form-item>
        <el-form-item label="内容" prop="content">
          <el-input type="textarea" :autosize="{ minRows: 5 }" placeholder="请输入内容" v-model="ruleForm.content">
          </el-input>
        </el-form-item>
        <el-form-item label="状态">
          <el-button type="success" @click="beHot">设为热门/取消热门</el-button>
        </el-form-item>
        <transition name="fade">
          <el-form-item label="封面图片" v-show="showInput">
            <el-upload :before-upload="beforeAvatarUpload" :headers="config" :on-success="handleAvatarSuccess"
              class="upload-demo" action="http://124.223.101.11:8099/news/upload" :on-preview="handlePreview"
              :on-remove="handleRemove" :before-remove="beforeRemove" multiple :limit="1" :on-exceed="handleExceed"
              :file-list="fileList">
              <el-button size="small" type="primary">点击上传</el-button>
              <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过500kb</div>
            </el-upload>
          </el-form-item>
        </transition>
        <el-form-item style="text-align: center;">
          <el-button type="info" @click="submitForm('ruleForm')">发布</el-button>
          <el-button @click="resetForm('ruleForm')">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import { getToken } from "@/utils/auth"; // get token from cookie
import { releaseNews, getNewsDetail, updateNews } from '@/api/news'
import { mapGetters } from 'vuex';
export default {
  name: '',

  data() {
    return {
      ruleForm: {
        title: "",
        content: "",
        remark: "",
      },
      rules: {
        title: [
          { required: true, message: '请输入标题', trigger: 'blur' }
        ],
        content: [
          { required: true, message: '请输入内容', trigger: 'blur' }
        ],
        remark: [
          { required: true, message: '请输入简介', trigger: 'blur' }
        ],
      },
      // teacherName: this.name,
      fileList: [],
      showInput: false,
      fileImg: '',
      id: '',
      type: '',
    };
  },
  created() {
    this.type = this.$route.params.type
    this.id = this.$route.params.id
  },

  mounted() {
    console.log(this.type);
    if (this.id) {
      getNewsDetail(this.id).then(({ data: res }) => {
        console.log(res);
        this.ruleForm.title = res.title
        this.ruleForm.content = res.content
        this.ruleForm.remark = res.remark
        if (res.img) {
          this.showInput = true
          this.fileList.push({
            name: "热门图片",
            url: res.img
          })
          this.fileImg = res.img
        }
      })
    }
  },
  computed: {
    ...mapGetters(['teacherId', 'name']),
    config() {
      return {
        Authorization: getToken()
      };
    },
  },

  methods: {
    beHot() {
      this.showInput = !this.showInput
      this.fileList = []
    },

    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          if (!this.type || this.type == 1) {
            if (this.fileImg) {
              releaseNews({
                title: this.ruleForm.title,
                img: this.fileImg,
                teacherId: this.teacherId,
                content: this.ruleForm.content,
                remark: this.ruleForm.remark,
                isHot: 1
              }).then(res => {
                this.$router.push('/news/myNews')
              })
            } else {
              releaseNews({
                title: this.ruleForm.title,
                teacherId: this.teacherId,
                content: this.ruleForm.content,
                remark: this.ruleForm.remark,
                isHot: 0
              }).then(res => {
                this.$router.push('/news/myNews')
              })
            }
          } else {
            //修改
            if (this.fileImg) {
              updateNews({
                id: this.id,
                title: this.ruleForm.title,
                img: this.fileImg,
                teacherId: this.teacherId,
                content: this.ruleForm.content,
                remark: this.ruleForm.remark,
                isAudit:0,
                isHot: 1
              }).then(res => {
                this.$router.push('/news/myNews')
              })
            } else {
              updateNews({
                id: this.id,
                title: this.ruleForm.title,
                teacherId: this.teacherId,
                content: this.ruleForm.content,
                remark: this.ruleForm.remark,
                isAudit:0,
                isHot: 0
              }).then(res => {
                this.$router.push('/news/myNews')
              })
            }
          }
        } else {
          console.log('error submit!!');
          return false;
        }
      });
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    },

    handleAvatarSuccess(res, file) {
      this.fileImg = res.data
      console.log(this.fileImg);
      console.log(file, 'file');

    },
    beforeAvatarUpload(file) {
      const isJPG = file.type === 'image/jpeg'
      const isPNG = file.type === 'image/png'
      const isLt2M = file.size / 1024 / 1024 < 2

      if (!isJPG && !isPNG) {
        this.$message.error('上传头像图片只能是 JPG或PNG 格式!')
      }
      if (!isLt2M) {
        this.$message.error('上传头像图片大小不能超过 2MB!')
      }
      return (isJPG || isPNG) && isLt2M
    },

    handleRemove(file, fileList) {
      console.log(file, fileList);
      this.fileImg = ""
    },
    handlePreview(file) {
      console.log(file);
    },
    handleExceed(files, fileList) {
      this.$message.warning(`当前限制选择 1 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`);
    },
    beforeRemove(file, fileList) {
      return this.$confirm(`确定移除 ${file.name}？`);
    }
  },
};
</script>

<style lang="scss" scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s;
}

.fade-enter,
.fade-leave-to {
  opacity: 0;
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

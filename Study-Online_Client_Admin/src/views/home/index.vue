<template>
  <div class="dashboard-container">
    <div class="dashboard-text">我的信息</div>
    <div class="main" style="width: 99%;margin: auto;display: flex;flex-direction: row;justify-content: space-between;">
      <div class="left" style="width: 30%;display: flex;flex-direction: column;">
        <el-card class="box-card" style="width: 100%;margin-top: 40px;height: 315px;">
          <div slot="header" class="clearfix">
            <span>个人资料</span>
            <el-button style="float: right; padding: 3px 0" type="text" @click="dialogVisible = true">修改</el-button>
            <el-dialog title="提示" :visible.sync="dialogVisible" width="30%">
              <el-form :model="newTeacher" :rules="rules" ref="newTeacher" label-width="100px" class="demo-ruleForm"
                style="position: relative;left: -25px;">
                <el-form-item label="学校" prop="school">
                  <el-input v-model="newTeacher.school"></el-input>
                </el-form-item>
                <el-form-item label="学院" prop="xueYuan">
                  <el-input v-model="newTeacher.xueYuan"></el-input>
                </el-form-item>
                <el-form-item label="手机" prop="phone">
                  <el-input v-model="newTeacher.phone"></el-input>
                </el-form-item>
                <el-form-item label="爱好" prop="goodAt">
                  <el-input v-model="newTeacher.goodAt"></el-input>
                </el-form-item>
                <el-form-item label="简介" prop="remark">
                  <el-input type="textarea" placeholder="请输入内容" v-model="newTeacher.remark" maxlength="40"
                    show-word-limit>
                  </el-input>
                </el-form-item>
              </el-form>
              <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="updateTeacher('newTeacher')">确 定</el-button>
              </span>
            </el-dialog>
          </div>
          <div style="display: flex;flex-direction: row;margin-left: 20px;">
            <div>
              <el-upload v-show="imgShow" @mouseleave.native="imgShow = false" :headers="config"
                style="position: relative;width: 85px;height: 85px;z-index: 9;margin: 0 auto;" class="avatar-uploader"
                action="http://124.223.101.11:8099/news/upload" :show-file-list="false" :on-success="handleAvatarSuccess"
                :before-upload="beforeAvatarUpload">
                <!-- <img width="75px" height="75px" v-if="imageUrl" :src="imageUrl" class="avatar"> -->
                <span style="display: inline-block;width: 85px;height: 85px;line-height: 85px;border-radius: 50%;
          color: white;background-color: rgb(0, 0, 0,0.5);font-size: 14px;font-weight: 600;z-index: 99;">更换头像</span>
              </el-upload>
              <el-avatar v-if="!imgShow" @mouseenter.native="imgShow = true" style="display: block; margin: 0 auto"
                :size="85" :src="imgFile"></el-avatar>
              <el-avatar v-else @mouseenter.native="imgShow = true"
                style="display: block; margin: 50px auto;position: relative;top: -135px;z-index: 0;" :size="85"
                :src="imgFile"></el-avatar>
            </div>
            <div style="display: flex;flex-direction: column;font-size: 12px;">
              <p style="font-size: 18px;margin-left: 10px;font-weight: 600;">你好！{{ name }}</p>
              <p v-show="!imgShow" style="color: #666;width: 88%;margin: auto;position: relative;top: -5px;font-size: 12px;
              overflow: hidden;
              text-overflow: ellipsis;
              -webkit-line-clamp: 2;
              word-wrap: break-word;
              display: -webkit-box;
              -webkit-box-orient: vertical;">简介:{{ teacher.remark }}</p>
              <p v-show="imgShow" style="color: #666;width: 88%;margin: auto;position: relative;top: -97.5px;font-size: 12px;
              overflow: hidden;
              text-overflow: ellipsis;
              -webkit-line-clamp: 2;
              word-wrap: break-word;
              display: -webkit-box;
              -webkit-box-orient: vertical;">简介:{{ teacher.remark }}</p>
            </div>
          </div>
          <div v-show="!imgShow"
            style="width: 90%;margin: 30px auto;display: flex;justify-content: space-between;font-size: 14px;">
            <p>学校:{{ teacher.school ? teacher.school : '无' }}</p>
            <p>学院:{{ teacher.xueYuan ? teacher.xueYuan : '无' }}</p>
          </div>
          <div v-show="imgShow"
            style="width: 90%;margin:30px auto;display: flex;justify-content: space-between;position:relative;top: -185px;font-size: 14px;">
            <p>学校:{{ teacher.school ? teacher.school : '无' }}</p>
            <p>学院:{{ teacher.xueYuan ? teacher.xueYuan : '无' }}</p>
          </div>
          <div v-show="!imgShow"
            style="width: 90%;margin:-30px auto;display: flex;justify-content: space-between;font-size: 14px;">
            <p>手机:{{ teacher.phone ? teacher.phone : '无' }}</p>
            <p>爱好:{{ teacher.goodAt ? teacher.goodAt : '无' }}</p>
          </div>
          <div v-show="imgShow"
            style="width: 90%;margin:-30px auto;display: flex;justify-content: space-between;position:relative;top: -185px;font-size: 14px;">
            <p>手机:{{ teacher.phone ? teacher.phone : '无' }}</p>
            <p>爱好:{{ teacher.goodAt ? teacher.goodAt : '无' }}</p>
          </div>
        </el-card>
        <el-card style="width: 100%;margin-top: 30px;">
          <div slot="header" class="clearfix">
            <span>周杰伦《最长的电影》</span>
            <el-button style="float: right; padding: 3px 0" type="text" @click="clickFn">暂停</el-button>
          </div>
          <p style="font-size: 13px;text-align: center;">再给我两分钟 让我把记忆结成冰</p>
          <el-divider content-position="left"><span style="font-weight:600">别融化了眼泪</span></el-divider>
          <p style="font-size: 13px;text-align: center;">你妆都花了要我怎么记得</p>
          <p style="font-size: 13px;text-align: center;">记得你叫我忘了吧 记得你叫我了吧</p>
          <p style="font-size: 13px;text-align: center;">你说你会哭</p>
          <el-divider content-position="right"><span style="font-weight:600">不是因为在乎</span></el-divider>
          <div style="margin-top: 40px;"></div>
          <el-statistic ref="statistic" @finish="hilarity" format="HH:mm:ss" :value="deadline4" title="距离明日："
            time-indices>
          </el-statistic>
        </el-card>
      </div>
      <div class="right" style="width: 69%;margin-top: 40px;">
        <div>
          <el-row :gutter="20">
            <el-col :span="6">
              <div>
                <el-statistic group-separator="," :precision="2" :value="lessonTotal" title="课程总数">
                  <template slot="prefix">
                    <i class="el-icon-s-management" style="color:orange"></i>
                  </template>
                </el-statistic>
              </div>
            </el-col>
            <el-col :span="6">
              <div>
                <el-statistic group-separator="," :precision="2" :value="newsTotal" title="新闻总数">
                  <template slot="prefix">
                    <i class="el-icon-s-order" style="color:orange"></i>
                  </template>
                </el-statistic>
              </div>
            </el-col>
            <el-col :span="6">
              <div>
                <el-statistic group-separator="," :precision="2" decimal-separator="." :value="myLessonTotal"
                  title="我的课程">
                  <template slot="prefix">
                    <i class="el-icon-s-flag" style="color: red"></i>
                  </template>
                  <template slot="suffix">
                    <i class="el-icon-s-flag" style="color: blue"></i>
                  </template>
                </el-statistic>
              </div>
            </el-col>
            <el-col :span="6">
              <div>
                <el-statistic group-separator="," :precision="2" decimal-separator="." :value="myNewsTotal" title="我的新闻">
                  <template slot="prefix">
                    <i class="el-icon-s-flag" style="color: red"></i>
                  </template>
                  <template slot="suffix">
                    <i class="el-icon-s-flag" style="color: blue"></i>
                  </template>
                </el-statistic>
              </div>
            </el-col>
          </el-row>
        </div>
        <el-card style="margin-top: 20px;">
          <div ref="echarts1" style="height: 210px;width: 100%"></div>
        </el-card>
        <div style="margin-top: 55px;">
          <el-collapse v-model="activeNames">
            <el-collapse-item title="让感动一辈子记得" name="1">
              <div>山高水长，怕什么来不及，慌什么到不了，天顺其然，地顺其性，人顺其变，一切都是刚刚好。——《人民日报》</div>
              <div style="margin-top: 10px;">
                热爱是一个人内心最深沉持久的力量，它不是心血来潮的一闪念，也不会因为年节更替而稍纵即逝。相反，在历经时光考验与洗礼后，依然能够让人从中不断汲取营养，直面困难不放弃，跌倒后勇敢站起来，抖擞精神再出发。——《人民日报》
              </div>
            </el-collapse-item>
          </el-collapse>
          <el-divider content-position="left"> 我们希望，瞬间的积淀不要流淌，岁月的馈赠别被消磨，而是在时间的河床上凝聚起沉潜的力量，让我们与时代和社会一起，向阳生长。</el-divider>
        </div>
        <div style="display:flex;margin-top:40px">
          <el-button type="success" @click="$router.push('/lesson/addLesson')">go~添加课程</el-button>
          <el-button type="warning" style="margin-left:30px" @click="$router.push('/news/addNews')">go~发布新闻</el-button>
          <el-button type="warning" style="margin-left:30px" @click="goToHome">go~Web首页</el-button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getToken } from "@/utils/auth"; // get token from cookie
import { getMyDetail, updateTeacher } from '@/api/teacher'
import { getNewsPage } from '@/api/news'
import { getLessonPage, getMyCategoryCount } from '@/api/lesson'
import { mapGetters } from 'vuex';
import * as echarts from 'echarts';
export default {
  name: '',
  data() {
    return {
      imgShow: false,
      teacher: {},
      newTeacher: {
        school: '',
        xueYuan: '',
        remark: '',
        phone: '',
        goodAt: ''
      },
      imgFile: '',
      activeNames: ['1'],
      token: localStorage.getItem('token'),
      like: true,
      value1: 4154.564,
      value2: 2222,
      dialogVisible: false,
      rules: {
        school: [{ max: 15, message: '长度在 15 个字符以内', trigger: 'blur' }],
        xueYuan: [{ max: 15, message: '长度在 15 个字符以内', trigger: 'blur' }],
        remark: [{ max: 40, message: '长度在 40 个字符以内', trigger: 'blur' }],
        phone: [{
          pattern: /^1[3456789]\d{9}$/,
          message: '手机号格式不正确',
          trigger: 'blur'
        }],
        goodAt: [{ min: 2, max: 6, message: '长度在 2到6 个字符', trigger: 'blur' }]
      },
      deadline4: Date.now() + (new Date().setHours(23, 59, 59) - Date.now()),
      stop: true,
      myLessonTotal: "",
      lessonTotal: '',
      myNewsTotal: "",
      newsTotal: ""
    };
  },
  beforeDestroy() {
    window.removeEventListener('resize', this.handleResize)
  },

  mounted() {
    this.getTeacher()
    window.addEventListener('resize', this.handleResize)
    getLessonPage({
      tName: this.name
    }).then(({ data: res }) => {
      this.myLessonTotal = res.total
    })
    getLessonPage().then(({ data: res }) => {
      this.lessonTotal = res.total
    })
    getNewsPage({
      name: this.name
    }).then(({ data: res }) => {
      this.myNewsTotal = res.total
    })
    getNewsPage().then(({ data: res }) => {
      this.newsTotal = res.total
    })

    this.getEcharts()

  },
  computed: {
    ...mapGetters(['teacherId', "name"]),
    config() {
      return { Authorization: getToken() }
    },
  },

  methods: {
    goToHome() {
      window.location.href='http://localhost:8080/'
    },
    getEcharts() {
      getMyCategoryCount(this.teacherId).then(({ data: res }) => {
        const echarts1 = echarts.init(this.$refs.echarts1)
        const echarts1Option = {
          tooltip: {
            trigger: 'axis',
            axisPointer: {
              type: 'shadow'
            }
          },
          grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
          },
          xAxis: [
            {
              type: 'category',
              data: res.map(v => v.name),
              axisTick: {
                alignWithLabel: true
              }
            }
          ],
          yAxis: [
            {
              type: 'value'
            }
          ],
          series: [
            {
              name: 'Direct',
              type: 'bar',
              barWidth: '60%',
              data: res.map(v => v.value)
            }
          ],
        }
        echarts1.setOption(echarts1Option)
      })
    },
    handleResize() {
      //执行页面宽度变化后的操作
      this.getEcharts()
    },
    getTeacher() {
      getMyDetail(this.teacherId).then(({ data: res }) => {
        this.teacher = res
        this.newTeacher = res
        this.imgFile = res.img
        console.log(this.imgFile);
        console.log(this.teacher);
      })
    },
    // handleClose(done) {
    //   // this.$confirm('确认关闭？')
    //   //   .then(_ => {
    //   //     done();
    //   //   })
    //   //   .catch(_ => { });
    // },
    handleAvatarSuccess(res, file) {
      this.imgShow = false
      this.imageUrl = URL.createObjectURL(file.raw);
      this.imgFile = res.data
      this.$message.success(res.respMessage)
      updateTeacher({
        id: this.teacherId,
        img: this.imgFile
      }).then(res => {
        this, getTeacher()
        // console.log(res);
      })
    },
    // callChildMethod() {
    //   this.$refs.childRef.childMethod()
    // },
    updateTeacher(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          updateTeacher({
            id: this.teacherId,
            school: this.teacher.school,
            xueYuan: this.teacher.xueYuan,
            remark: this.teacher.remark,
            phone: this.teacher.phone,
            goodAt: this.teacher.goodAt
          }).then(res => {
            this.getTeacher()
            this.dialogVisible = false
          })
        } else {
          console.log('error submit!!');
          return false;
        }
      });
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
    clickFn() {
      this.$refs.statistic.suspend(this.stop);
      this.stop = !this.stop;
    },
    hilarity() {
      this.$notify({
        title: '提示',
        message: '时间已到，你可知寸金难买寸光阴？',
        duration: 0,
      });
    },
  },
};
</script>

<style lang="scss" scoped>
.like {
  cursor: pointer;
  font-size: 25px;
  display: inline-block;
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

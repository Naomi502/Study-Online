<template>
  <div class="dashboard-container">
    <div class="dashboard-text" v-if="$route.params.type == 2">修改课程</div>
    <div class="dashboard-text" v-else>添加课程</div>
    <el-card class="box-card" shadow="never" style="width: 50%;margin: auto; margin-top:20px;">
      <el-steps align-center :active="active" finish-status="success">
        <el-step title="填写课程基本信息"></el-step>
        <el-step title="填写课程详情"></el-step>
        <el-step title="填写课程子章节"></el-step>
      </el-steps>
      <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm"
        v-show="active === 0">
        <el-form-item label="商品分类" prop="categoryId" style="margin-top: 20px">
          <el-select v-model="categoryId" placeholder="请选择">
            <el-option @click.native="handleSelectTeam(item.id)" v-for="item in selector" :key="item.id"
              :label="item.name" :value="item.id"></el-option>
            <!-- <el-option label="区域二" value="beijing"></el-option> -->
          </el-select>
        </el-form-item>
        <el-form-item label="课程标题" prop="lName">
          <el-input v-model="ruleForm.lName" placeholder="请输入课程标题"></el-input>
        </el-form-item>
        <el-form-item label="发布学校" prop="school">
          <el-input v-model="ruleForm.school" placeholder="请输入发布学校"></el-input>
        </el-form-item>
        <el-form-item label="课程简介" prop="remark">
          <el-input type="textarea" :autosize="{ minRows: 2, maxRows: 3 }" placeholder="请输入课程简介"
            v-model="ruleForm.remark">
          </el-input>
        </el-form-item>
        <el-form-item label="课程封面" required prop="img">
          <el-upload :before-upload="beforeAvatarUpload" :headers="config" :on-success="handleAvatarSuccess" class="upload-demo"
            action="http://124.223.101.11:8099/news/upload" :on-preview="handlePreview" :on-remove="handleRemove"
            :before-remove="beforeRemove" multiple :limit="1" :on-exceed="handleExceed" :file-list="fileList">
            <el-button size="small" type="primary">点击上传</el-button>
            <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过500kb</div>
          </el-upload>
        </el-form-item>
      </el-form>

      <el-form style="margin-top: 20px" v-show="active === 1" :model="ruleForm" :rules="rules" ref="ruleForm"
        label-width="100px" class="demo-ruleForm">
        <el-form-item label="课程介绍" prop="introduce">
          <el-input type="textarea" :autosize="{ minRows: 3 }" v-model="ruleForm.introduce"></el-input>
        </el-form-item>
        <el-form-item label="介绍视频" required prop="vedio">
          <el-upload class="upload-demo" ref="videoUploader" :headers="config" action="http://124.223.101.11:8099/news/upload" :limit="1"
            :on-remove="videoRemove" :before-upload="beforeVideoUpload" :on-exceed="handleVideoExceed"
            :file-list="fileList2" :on-success="handleVideoUploadSuccess">
            <el-button size="small" type="primary">选择文件</el-button>
            <div slot="tip" class="upload-tip">只能上传mp4格式的文件，大小不超过100MB</div>
          </el-upload>
        </el-form-item>
        <el-form-item label="课程章节" required>
          <div v-show="ruleForm.lessonTree" v-for="(item, index) in ruleForm.lessonTree" :key="item.id">
            <span v-show="item.id != actChild">{{ item.name }}</span>
            <el-input style="width: 60%;" v-show="item.id == actChild" placeholder="请输入内容" v-model="treeMainName"
              class="input-with-select">
              <template slot="prepend">第{{ index + 1 }}章</template>
              <el-button slot="append" icon="el-icon-check" @click="updateMainTree(item.id, index)"></el-button>
            </el-input>
            <i v-if="index === ruleForm.lessonTree.length - 1" style="float: right;font-size: 20px;"
              class="el-icon-delete" @click="deleteTree(item)"></i>
            <i style="float: right;margin-right: 15px;font-size: 20px;" class="el-icon-edit-outline"
              @click="updateTree(item.id, index)"></i>
          </div>
          <div style="margin-top: 15px;">
            <el-input style="width: 80%;" placeholder="请输入内容" v-model="tree22" class="input-with-select">
              <template slot="prepend">第{{ lessonIndex }}章</template>
              <el-button slot="append" icon="el-icon-check" @click="addTree"></el-button>
            </el-input>
          </div>
        </el-form-item>
      </el-form>

      <div style="margin-top: 20px;padding-bottom: 40px;width: 95%;" v-show="active === 2" class="upload">
        <div style="margin-top:40px;margin-left: 40px;" v-for="(item, index1) in mainTree" :key="item.id">
          <span style="font-size:22px;font-weight:600">
            {{ item.name }}
          </span>
          <el-button @click="addChildIcon(item.id, item.children)"
            style="font-size:8px;margin-left:10px;position:relative;top:-2px" type="primary" icon="el-icon-edit"
            circle></el-button>
          <div>
            <div style="margin-top:30px" v-for="(i, index2) in item.children" :key="i.id">
              <div>
                <span v-show="i.id != actChild" style="font-size:16px">{{ i.name }}</span>
                <el-input style="width: 60%;" v-show="i.id == actChild" placeholder="请输入内容" v-model="tree"
                  class="input-with-select">
                  <template slot="prepend">{{ index1 + 1 }}.{{ index2 + 1 }}</template>
                  <el-button slot="append" icon="el-icon-check"
                    @click="updateChildTree(i.id, item.id, index1, index2)"></el-button>
                </el-input>
                <i v-if="index2 === item.children.length - 1" style="float: right;font-size: 20px;" class="el-icon-delete"
                  @click="deleteTree(i)"></i>
                <i style="float: right;margin-right: 15px;font-size: 20px;" class="el-icon-edit-outline"
                  @click="updateTree(i.id, index2)"></i>
              </div>
              <el-upload :headers="config" style="margin-top: 15px;padding-bottom: 10px;" class="upload-demo" ref="videoUploader"
                action="http://124.223.101.11:8099/news/upload" :limit="1" :on-remove="videoRemove2()"
                :before-remove="beforeRemove2" :before-upload="beforeVideoUpload" :on-exceed="handleVideoExceed"
                :key="index2" :file-list="fileList3.filter(v => (i.id == v.mainId))"
                :on-success="handleVideoUploadSuccess2">
                <el-button size="small" type="primary" @click="chose(i.id)">选择文件</el-button>
                <div slot="tip" style="font-size: 12px;margin-top: 10px;" class="upload-tip">只能上传mp4格式的文件，大小不超过100MB</div>
              </el-upload>
            </div>
            <transition name="fade">
              <el-input v-show="item.id == activeTreeId" style="margin-top:10px;width: 70%;" placeholder="请输入内容"
                v-model="child" class="input-with-select">
                <template slot="prepend">{{ index1 + 1 }}.{{ childIndex }}</template>
                <el-button slot="append" icon="el-icon-check" @click="addChildrenTree(item.id, index1)"></el-button>
              </el-input>
            </transition>
          </div>
        </div>
      </div>

      <div style="text-align: center">
        <el-button v-show="active <= 2" style="margin-top: 12px" @click="next('ruleForm')">确认后进入下一步
        </el-button>
        <el-button style="margin-top: 30px;" v-show="active > 2" type="primary"
          @click="$router.push('/lesson/lessonTeacher')">提交
        </el-button>
      </div>
    </el-card>
  </div>
</template>

<script>
import { getToken } from "@/utils/auth"; // get token from cookie
import { getHotCategory } from '@/api/category'
import { addLesson, addLessonDetail, addLessonTree, getMainTree, updateLessonTree, getLessonTreeById, getLessonById, getLessonDetailById, updateLesson, updateLessonDetail, deleteTree, addVideo, deleteVideo } from '@/api/lesson'
import { mapGetters } from 'vuex'

export default {
  data() {
    return {
      active: 0,
      ruleForm: {
        lName: "",
        school: "",
        remark: "",
        img: "",
        introduce: "",
        vedio: '',
        isCilck: false,
        lessonTree: []
      },
      tree: "",
      selector: [],
      imageUrl: '',
      categoryId: '',
      fileImg: '',
      treeMainName: "",
      fileList: [],
      fileList2: [],
      fileList3: [],
      lessonDetailId: '',
      treeName: '',
      actChild: "",
      actMain: "",
      idCounter: 0,
      childId: "",
      video: "",
      tree22: '',
      childVideo: '',
      lessonIndex: 1,
      lessonId: this.$route.query.id ? this.$route.query.id : "",
      child: '',
      activeTreeId: "",
      childIndex: 1,
      mainTree: [],
      rules: {
        lName: [
          { required: true, message: '请输入发布学校', trigger: 'blur' },
          { min: 3, max: 30, message: '长度在 3 到 30 个字符', trigger: 'blur' }
        ],
        remark: [
          { required: true, message: '请输入课程简介', trigger: 'blur' },
          { min: 10, max: 90, message: '长度在 10 到 90 个字符', trigger: 'blur' }
        ],
        school: [
          { required: true, message: '请输入发布学校', trigger: 'blur' },
          { min: 3, max: 15, message: '长度在 3 到 15 个字符', trigger: 'blur' }
        ],
        introduce: [
          { required: true, message: '请输入课程介绍', trigger: 'blur' }
        ]
      }
    }
  },
  mounted() {
    // getLessonTreeById(1).then(({ data: res }) => {
    //   console.log(res);
    //   this.mainTree = res
    // })


    console.log(this.$route.params.type);
    getHotCategory().then(({ data: res }) => {
      this.selector = res
    })
    if (this.lessonId) {
      getLessonById(this.lessonId).then(({ data: res }) => {
        console.log(res);
        this.ruleForm.lName = res.lname
        this.ruleForm.school = res.school
        this.ruleForm.remark = res.remark
        this.fileImg = res.img,
          this.categoryId = res.lessonTypeId
        this.fileList.push({
          name: "课程封面",
          url: res.img
        })
      })
    }
  },
  computed: {
    config() {
      return { Authorization: getToken() }
    },
    ...mapGetters(['name', "teacherId"])

  },
  methods: {
    next() {

      if (!this.lessonId) {
        if (this.active == 0) {
          if (this.categoryId && this.ruleForm.lName && this.ruleForm.school && this.fileImg && this.ruleForm.remark) {
            addLesson({
              lessonTypeId: this.categoryId,
              lname: this.ruleForm.lName,
              teacherId: this.teacherId,
              school: this.ruleForm.school,
              img: this.fileImg,
              remark: this.ruleForm.remark
            }).then(res => {
              this.lessonId = res.data
              this.active++
            })
          } else {
            this.$message.warning("请填写完整信息")
          }
        } else if (this.active == 1) {
          if (this.ruleForm.introduce && this.video && this.ruleForm.lessonTree.length > 1) {
            addLessonDetail({
              lessonId: this.lessonId,
              introduce: this.ruleForm.introduce,
              vedio: this.video
            }).then(res => {
              this.active++
              getLessonTreeById(this.lessonId).then(({ data: res }) => {
                console.log(res, '2323');
                this.mainTree = res
              })
            })
          } else {
            this.$message.warning("请输入完整信息")
          }
        } else if (this.active == 2) {
          this.active++
        }
      } else {
        //修改
        if (this.active == 0) {
          updateLesson({
            id: this.lessonId,
            lessonTypeId: this.categoryId,
            lname: this.ruleForm.lName,
            teacherId: this.teacherId,
            school: this.ruleForm.school,
            img: this.fileImg,
            remark: this.ruleForm.remark
          }).then(res => {
            if (this.categoryId && this.ruleForm.lName && this.ruleForm.school && this.fileImg && this.ruleForm.remark) {
              getMainTree(this.lessonId).then(({ data: res }) => {
                this.ruleForm.lessonTree = res
                this.lessonIndex = res.length + 1
              })
              getLessonDetailById(this.lessonId).then(({ data: res }) => {
                // console.log(res,'22');
                this.active++
                this.lessonDetailId = res.id
                this.ruleForm.introduce = res.introduce
                this.video = res.vedio
                this.fileList2.push({
                  name: "介绍视频",
                  url: res.vedio
                })

              })
            } else {
              this.$message.warning("请填写完整信息")
            }
          })
        } else if (this.active == 1) {
          if (this.ruleForm.introduce && this.video && this.ruleForm.lessonTree.length > 1) {
            if (this.lessonDetailId) {
              updateLessonDetail({
                id: this.lessonDetailId,
                lessonId: this.lessonId,
                introduce: this.ruleForm.introduce,
                vedio: this.video
              }).then(res => {
                this.active++
                getLessonTreeById(this.lessonId).then(({ data: res }) => {
                  // console.log(res, '2323');
                  this.mainTree = res
                  this.mainTree.filter(v => {
                    if (v.children) {
                      v.children.filter(m => {
                        if (m.link) {
                          this.fileList3.push({
                            id: ++this.idCounter,
                            mainId: m.id,
                            name: "章节视频",
                            url: m.link
                          })
                          console.log(this.fileList3, 'fileList3');
                        }
                      })
                    }
                  })
                })
              })
            } else {
              addLessonDetail({
                lessonId: this.lessonId,
                introduce: this.ruleForm.introduce,
                vedio: this.video
              }).then(res => {
                this.active++
                getLessonTreeById(this.lessonId).then(({ data: res }) => {
                  console.log(res, '2323');
                  this.mainTree = res
                })
              })
            }

          } else {
            this.$message.warning("请输入完整信息")
          }
        } else if (this.active == 2) {
          this.active++
        } {

        }
      }


    },
    addTree() {
      if (this.tree22) {
        addLessonTree({
          level: 1,
          lessonId: this.lessonId,
          name: `第${this.lessonIndex}章  ${this.tree22}`,
        }).then(res => {
          getMainTree(this.lessonId).then(({ data: res }) => {
            this.ruleForm.lessonTree = res
          })
          this.lessonIndex++
          this.tree22 = ""
        })
      } else {
        this.$message.warning("请输入章节名称")
      }

    },
    deleteTree(i) {
      console.log(i.id);
      if (i.level == 2) {
        this.$confirm('此操作将永久删除该子链所包含的所有课程信息及评论内容, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          deleteTree(i.id).then(res => {
            getLessonTreeById(this.lessonId).then(({ data: res }) => {
              // console.log(res);
              this.mainTree = res
            })
          })
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消删除'
          });
        });
      } else {
        this.$confirm('此操作将永久删除该章节所包含的所有子链及其内容, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          deleteTree(i.id).then(res => {
            this.lessonIndex = this.lessonIndex - 1
            getMainTree(this.lessonId).then(({ data: res }) => {
              this.ruleForm.lessonTree = res
            })
          })
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消删除'
          });
        });

      }
    },
    updateTree(id, index) {
      if (this.actChild == id) {
        this.actChild = ''
      } else {
        this.actChild = id
      }
    },
    updateChildTree(id, mainId, i1, i2) {
      updateLessonTree({
        id: id,
        name: `${i1 + 1}.${i2 + 1}  ${this.tree}`,
        level: 2,
        pid: mainId,
        lessonId: this.lessonId
      }).then(res => {
        this.actChild = ''
        this.tree = ""
        getLessonTreeById(this.lessonId).then(({ data: res }) => {
          // console.log(res);
          this.mainTree = res
        })
      })
    },
    handleSelectTeam(id) {
      console.log(id)
      this.categoryId = id
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
    videoRemove(file, fileList) {
      this.video = ""
    },
    videoRemove2(file, fileList) {
      console.log(file);
      this.childVideo = ""
    },
    handlePreview(file) {
      console.log(file);
    },
    handleExceed(files, fileList) {
      this.$message.warning(`当前限制选择 1 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`);
    },
    beforeRemove(file, fileList) {
      return this.$confirm(`确定移除 ${file.name}？`);
    },
    beforeRemove2(file, fileList) {
      deleteVideo(file.mainId).then(res => { })
      // return this.$confirm(`确定移除 ${file.name}？`);
    },
    beforeVideoUpload(file) {
      const isMP4 = file.type === 'video/mp4';
      const isLt100M = file.size / 1024 / 1024 < 100;

      if (!isMP4) {
        this.$message.error('上传视频只能是 MP4 格式!');
        return false;
      }
      if (!isLt100M) {
        this.$message.error('上传视频大小不能超过 100MB!');
        return false;
      }

      return true;
    },
    handleVideoExceed(files, fileList) {
      this.$message.warning(`只能上传一个文件，文件列表长度为 ${fileList.length}`);
    },
    handleVideoUploadSuccess(res, file) {
      this.video = res.data
      // this.$message.success('上传成功！');
      // 对上传成功后的处理操作
    },
    chose(id) {
      // console.log(id);
      this.childId = id
    },
    handleVideoUploadSuccess2(res, file) {
      this.childVideo = res.data
      addVideo({
        link: res.data,
        treeId: this.childId
      }).then(res => {
      })
      // this.$message.success('上传成功！');
      // 对上传成功后的处理操作
    },
    append(data) {
      const newChild = { id: id++, label: 'testtest', children: [] };
      if (!data.children) {
        this.$set(data, 'children', []);
      }
      data.children.push(newChild);
    },

    remove(node, data) {
      const parent = node.parent;
      const children = parent.data.children || parent.data;
      const index = children.findIndex(d => d.id === data.id);
      children.splice(index, 1);
    },

    renderContent(h, { node, data, store }) {
      return (
        <span class="custom-tree-node">
          <span>{node.label}</span>
          <span>
            <el-button size="mini" type="text" on-click={() => this.append(data)}>添加</el-button>
            <el-button size="mini" type="text" on-click={() => this.remove(node, data)}>删除</el-button>
          </span>
        </span>);
    },
    addChildIcon(id, i) {
      this.childIndex = i.length + 1
      if (this.activeTreeId == id) {
        this.activeTreeId = ""
      } else {
        this.activeTreeId = id
      }
      // console.log(id);
    },
    addChildrenTree(id, index) {
      // console.log(id);
      if (this.child) {
        addLessonTree({
          level: 2,
          lessonId: this.lessonId,
          name: `${index + 1}.${this.childIndex}  ${this.child}`,
          pid: id
        }).then(res => {
          this.childIndex++
          this.child = ""
          getLessonTreeById(this.lessonId).then(({ data: res }) => {
            this.mainTree = res
          })
        })
      } else {
        this.$message.warning("请输入子链名")
      }
    },
    updateMainTree(id, index) {
      console.log(id);
      if (this.treeMainName) {
        updateLessonTree({
          id: id,
          name: `第${index + 1}章  ${this.treeMainName}`,
          level: 1,
          lessonId: this.lessonId
        }).then(res => {
          getMainTree(this.lessonId).then(({ data: res }) => {
            this.actChild = ''
            this.ruleForm.lessonTree = res
          })
        })
      } else {
        this.$message.warning("请输入要修改的章节名")
      }

    }
  }
}
</script>

<style lang="scss">
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.25s;
}

.fade-enter,
.fade-leave-to {
  opacity: 0;
}

.el-button.is-circle {
  padding: 5px;
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

.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.avatar-uploader .el-upload:hover {
  border-color: #409eff;
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}

.avatar {
  width: 178px;
  height: 178px;
  display: block;
}

.upload {
  width: 50%;
  display: flex;
  flex-direction: column;
  justify-content: space-between;

  .label {
    line-height: 178px;
  }
}
</style>

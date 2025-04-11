package com.jd.controller;

import cn.hutool.db.PageResult;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jd.common.OutputObject;
import com.jd.entity.*;
import com.jd.mapper.*;
import com.jd.service.LessonDetailService;
import com.jd.service.TreeService;
import com.jd.service.VideoService;
import com.jd.util.NodeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 *
 * 课程管理
 *
 * @author isla
 * @since 2023-4-29
 */
@RestController
@RequestMapping("/lesson")
public class LessonController {
    @Autowired
    LessonMapper lessonMapper;

    @Autowired
    LessonDetailMapper lessonDetailMapper;

    @Autowired
    TreeMapper treeMapper;

    @Autowired
    TreeService treeService;

    @Autowired
    LessonDetailService lessonDetailService;

    @Autowired
    VideoMapper videoMapper;

    @Autowired
    MylessonMapper mylessonMapper;

    @Autowired
    CommentMapper commentMapper;

    @Autowired
    VideoService videoService;

    /**
     * 分页查询课程(teacher 必传tName)
     *
     * @param
     * @return
     */
    @GetMapping("/getLessonPage")
    public OutputObject getLessonPage(  @RequestParam(value = "page", defaultValue = "1") int page,
                                        @RequestParam(value = "pageSize", defaultValue = "10") int pageSize, LessonQuery query){
        IPage<Lesson> lessonIPage = lessonMapper.selectLessonPage(new Page<>(page, pageSize), query);
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),null,lessonIPage);
    }

    /**
     * 删除课程
     *
     * @param
     * @return
     */
    @DeleteMapping("/deleteLesson")
    public OutputObject deleteLesson(@RequestParam("id") int id){

        lessonDetailMapper.deleteByLessonId(id);

        treeMapper.deleteByLessonId(id);

        mylessonMapper.deleteByLessonId(id);

        int i = lessonMapper.deleteByLessonId(id);

        if (i==1){
            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"删除成功",i);
        }else {
            return new OutputObject(String.valueOf(HttpStatus.INTERNAL_SERVER_ERROR.value()),"删除失败",i);
        }
    }

    /**
     * 添加课程
     *
     * @param
     * @return
     */
    @PostMapping("/addLesson")
    public OutputObject addLesson(@RequestBody Lesson lesson){
        int insert = lessonMapper.insert(lesson);
        if (insert==1){
            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"添加课程成功",lesson.getId());
        }else {
            return new OutputObject(String.valueOf(HttpStatus.INTERNAL_SERVER_ERROR.value()),"添加课程失败",lesson.getId());
        }
    }

    /**
     * 添加课程详情 (传上一步创建的lessonId)
     *
     * @param
     * @return
     */
    @PostMapping("/addLessonDetail")
    public OutputObject addLessonDetail(@RequestBody LessonDetail lessonDetail){
        int insert = lessonDetailMapper.insert(lessonDetail);
        if (insert==1){
            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"添加课程详情成功",insert);
        }else {
            return new OutputObject(String.valueOf(HttpStatus.INTERNAL_SERVER_ERROR.value()),"添加课程详情失败",insert);
        }
    }

    /**
     * 添加课程章节(不用传parentId，level传1)//添加课程子链(parentId传章节id，level传2) lessonId传上一步创建的id
     *
     * @param
     * @return
     */
    @PostMapping("/addLessonTree")
    public OutputObject addLessonTree(@RequestBody Tree tree){
        int insert = treeMapper.insert(tree);
        if (insert==1){
            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"添加课程章节成功",insert);
        }else {
            return new OutputObject(String.valueOf(HttpStatus.INTERNAL_SERVER_ERROR.value()),"添加课程章节失败",insert);
        }
    }

    /**
     * 查询已创建的章节
     *
     * @param
     * @return
     */
    @GetMapping("/getMainTree")
    public OutputObject getMainTree(@RequestParam("lessonId") int id){
        LambdaQueryWrapper<Tree> lqw=new LambdaQueryWrapper<>();
        lqw.eq(Tree::getLessonId,id).eq(Tree::getLevel,1);
        List<Tree> list = treeService.list(lqw);
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),null,list);
    }

    /**
     * 查询已创建的课程
     *
     * @param
     * @return
     */
    @GetMapping("/getLessonById")
    public OutputObject getLessonById(@RequestParam("lessonId") int id){
        Lesson lessonById = lessonMapper.getLessonById(id);
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),null,lessonById);
    }

    /**
     * 查询已创建的详情
     *
     * @param
     * @return
     */
    @GetMapping("/getLessonDetailById")
    public OutputObject getLessonDetailById(@RequestParam("lessonId") int id){
        LambdaQueryWrapper<LessonDetail> lqw=new LambdaQueryWrapper<>();
        lqw.eq(LessonDetail::getLessonId,id);
//        List<LessonDetail> list = lessonDetailService.list(lqw);
        LessonDetail lessonDetail = lessonDetailMapper.selectOne(lqw);
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),null,lessonDetail);
    }

    /**
     * 查询课程章节列表
     *
     * @param
     * @return
     */
    @GetMapping("/getLessonTreeById")
    public OutputObject getLessonTree(@RequestParam("lessonId") Integer lessonId,Tree tree){

        List<Tree> tree1 = treeMapper.getTree(lessonId);
        List<Tree> rootNode = NodeUtil.getChilNode(tree1,tree);
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),null,rootNode);
    }

    /**
     * 修改课程
     *
     * @param
     * @return
     */
    @PutMapping("updateLesson")
    public OutputObject updateLesson(@RequestBody Lesson lesson){
        int i = lessonMapper.updateById(lesson);
        if (i==1){
            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"修改课程信息成功",i);
        }else {
            return new OutputObject(String.valueOf(HttpStatus.INTERNAL_SERVER_ERROR.value()),"修改课程信息失败",i);
        }
    }

    /**
     * 修改课程详情
     *
     * @param
     * @return
     */
    @PutMapping("updateLessonDetail")
    public OutputObject updateLessonDetail(@RequestBody LessonDetail lessonDetail){
        int i = lessonDetailMapper.updateById(lessonDetail);
        if (i==1){
            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"修改课程详情成功",i);
        }else {
            return new OutputObject(String.valueOf(HttpStatus.INTERNAL_SERVER_ERROR.value()),"修改课程详情失败",i);
        }
    }

    /**
     * 修改课程章节
     *
     * @param
     * @return
     */
    @PutMapping("updateLessonTree")
    public OutputObject updateLessonTree(@RequestBody Tree tree){
        int i = treeMapper.updateById(tree);
        if (i==1){
            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"修改课程章节成功",i);
        }else {
            return new OutputObject(String.valueOf(HttpStatus.INTERNAL_SERVER_ERROR.value()),"修改课程章节失败",i);
        }
    }

    /**
     * 删除课程章节和子链
     *
     * @param
     * @return
     */
    @DeleteMapping("deleteTree/{id}")
    public OutputObject deleteTree(@PathVariable int id){
       videoMapper.deleteByTreeId(id);
       commentMapper.deleteByTreeId(id);

        int i = treeMapper.deleteById(id);

        if (i==1){
            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"删除章节成功",i);
        }else {
            return new OutputObject(String.valueOf(HttpStatus.INTERNAL_SERVER_ERROR.value()),"删除章节失败",i);
        }
    }

    /**
     * 添加章节视频
     *
     * @param
     * @return
     */
    @PostMapping("/addVideo")
    public OutputObject addVideo(@RequestBody Video video){
        int insert = videoMapper.insert(video);
        if (insert==1){
            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"视频上传成功",insert);
        }else {
            return new OutputObject(String.valueOf(HttpStatus.INTERNAL_SERVER_ERROR.value()),"删除章节失败",insert);
        }
    }

    /**
     * 删除章节视频
     *
     * @param
     * @return
     */
    @DeleteMapping("/deleteVideo")
    public OutputObject deleteVideo(@RequestParam("treeId") int id){
        // 构建删除条件
        LambdaQueryWrapper<Video> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Video::getTreeId, id);
        // 执行删除操作
        int count = videoMapper.delete(queryWrapper);
        if (count==1){
            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"删除视频成功",count);
        }else {
            return new OutputObject(String.valueOf(HttpStatus.INTERNAL_SERVER_ERROR.value()),"删除章节失败",count);
        }
    }

    /**
     * 获取我发布的课程类别分布
     *
     * @param
     * @return
     */
    @GetMapping("/getMyCategoryCount")
    public OutputObject getMyCategoryCount(@RequestParam("teacherId") int id){
        List<MyCategoryCount> categoryCount = lessonMapper.getCategoryCount(id);
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),null,categoryCount);
    }
}

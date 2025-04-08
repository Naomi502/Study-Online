package com.jd.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jd.common.CustomException;
import com.jd.common.OutputObject;
import com.jd.entity.*;
import com.jd.mapper.*;
import com.jd.service.*;
import com.jd.util.NodeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 *
 * 课程
 *
 * @author isla
 * @since 2023-4-23
 */
@RestController
@RequestMapping("/lesson")
public class LessonController {

    @Autowired
    HotcategoryService hotcategoryService;

    @Autowired
    LessonService lessonService;

    @Autowired
    TreeService treeService;

    @Autowired
    LessonDetailMapper lessonDetailMapper;

    @Autowired
    TreeMapper treeMapper;

    @Autowired
    VideoMapper videoMapper;

    @Autowired
    HotcategoryMapper hotcategoryMapper;

    @Autowired
    TeacherService teacherService;

    @Autowired
    LessonMapper lessonMapper;

    /**
     * 查询热门课程分类
     *
     * @param
     * @return
     */
    @GetMapping("/getHotCategory")
    public OutputObject getHotCategory(){
        QueryWrapper<HotCategory> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("status",1);
        List<HotCategory> hotCategories = hotcategoryMapper.selectList(queryWrapper);
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),"查询成功",hotCategories);
    }

    /**
     * 查询热门课程
     *
     * @param id
     * @return
     */
    @GetMapping("/getLessons/{id}")
    public OutputObject getLessons(@PathVariable int id){
        LambdaQueryWrapper<Lesson> lqw=new LambdaQueryWrapper<>();
        lqw.eq(Lesson::getLessonTypeId,id).orderByAsc(Lesson::getTime).last("LIMIT 8");
        List<Lesson> list = lessonService.list(lqw);

        //获取teacher表中的name字段，并关联到查询结果中
        list.forEach(lesson -> {
            Teacher teacher = teacherService.getById(lesson.getTeacherId());
            lesson.setTName(teacher.getTName());
        });
//        List<Lesson> list = lessonService.list(lqw);
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),"查询成功",list);
    }

    /**
     * 查询课程列表
     *
     * @param
     * @return
     */
    @GetMapping("/getLessonTreeById")
    public OutputObject getLessonTree(@RequestParam("lessonId") Integer lessonId,Tree tree){
        System.out.println("1111");
        LambdaQueryWrapper<Tree> lqw=new LambdaQueryWrapper<>();
        lqw.eq(Tree::getLessonId,lessonId);
//        List<Tree> list = treeMapper.selectList(null);
        List<Tree> list = treeService.list(lqw);
        List<Tree> rootNode = NodeUtil.getChilNode(list,tree);
        System.out.println("22222");

        System.out.println(new OutputObject(String.valueOf(HttpStatus.OK.value()),"查询成功",rootNode));
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),"查询成功",rootNode);
    }

    /**
     * 查询课程详情
     *
     * @param lessonId
     * @return
     */
@GetMapping("/getLessonDetail")
    public OutputObject getLessonDetail(@RequestParam("lessonId") Integer lessonId){
    LambdaQueryWrapper<LessonDetail> lqw=new LambdaQueryWrapper<>();
    lqw.eq(LessonDetail::getLessonId,lessonId);
    LessonDetail lessonDetail = lessonDetailMapper.selectOne(lqw);
    return new OutputObject(String.valueOf(HttpStatus.OK.value()),"查询成功",lessonDetail);
}

    /**
     * 修改展示状态
     *
     * @param id,status
     * @return
     */
//    @PutMapping("/updateTreeShow")
//    public OutputObject updateTreeShow(@RequestParam("id") Integer id,@RequestParam("status") Integer status){
//        try {
//            treeService.updateTreeShow(id, status);
//            if (status == 1) {
//                return new OutputObject(String.valueOf(HttpStatus.OK.value()),"ok","展示");
//            } else {
//                return new OutputObject(String.valueOf(HttpStatus.OK.value()),"ok","不展示");
//            }
//        } catch (Exception e) {
//            throw new CustomException("添加账号失败", 0);
//        }
//    }

    /**
     * 获取视频地址
     *
     * @param pId
     * @return
     */
    @GetMapping("/getVideo")
    public OutputObject getVideo(@RequestParam("pId") int pId){
        LambdaQueryWrapper<Video> lqw=new LambdaQueryWrapper<>();
        lqw.eq(Video::getTreeId,pId);
        Video video = videoMapper.selectOne(lqw);
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),"查询成功",video);
    }

    /**
     * 分页搜索商品
     *
     * @param
     * @return
     */
    @GetMapping("/searchLesson")
    public OutputObject getScorePage(@RequestParam(value = "name",required = false) String name,
                                     @RequestParam(value = "categoryId",required = false) Integer id,
                                     @RequestParam(value = "page", defaultValue = "1") int page,
                                     @RequestParam(value = "pageSize", defaultValue = "10") int pageSize){
        IPage<Lesson> scoreIPage = lessonMapper.selectCommentByUserName(new Page<>(page, pageSize), name,id);
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),null,scoreIPage);
    }
}

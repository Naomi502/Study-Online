package com.jd.controller;

import com.jd.common.OutputObject;
import com.jd.entity.Mylesson;
import com.jd.mapper.MylessonMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;

/**
 *
 * 我的课程
 *
 * @author isla
 * @since 2023-4-24
 */
@RestController
@RequestMapping("/myLesson")
public class MylessonController {

    @Autowired
    MylessonMapper mylessonMapper;


    /**
     * 获取已加入的课程
     *
     * @param userId
     * @return
     */
    @GetMapping("/getMyLesson")
    public OutputObject getMyLesson(@RequestParam("userId") int userId){
        List<Mylesson> mylessons = mylessonMapper.getMyLesson(userId);
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),"查询成功",mylessons);
    }

    /**
     * 获取加入课程
     *
     * @param mylesson
     * @return
     */
    @PostMapping("/joinLesson")
    public OutputObject joinLesson(@RequestBody Mylesson mylesson){
        int insert = mylessonMapper.insert(mylesson);
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),"加入课程成功",insert);
    }

    /**
     * 修改课程信息
     *
     * @param mylesson
     * @return
     */
   @PutMapping("/updateMyLesson")
    public OutputObject updateMyLesson(@RequestBody Mylesson mylesson){
       int i = mylessonMapper.updateMyLessonByLessonId(mylesson);
       return new OutputObject(String.valueOf(HttpStatus.OK.value()),"已更新视频状态",i);
   }
}

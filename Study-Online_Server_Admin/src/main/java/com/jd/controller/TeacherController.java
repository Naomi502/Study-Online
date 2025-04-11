package com.jd.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jd.common.CustomException;
import com.jd.common.OutputObject;
import com.jd.entity.*;
import com.jd.mapper.LessonMapper;
import com.jd.mapper.NewsMapper;
import com.jd.mapper.TeacherMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;

/**
 *
 * 教师管理
 *
 * @author isla
 * @since 2023-4-29
 */
@RestController
@RequestMapping("/teacher")


public class TeacherController {
    @Autowired
    TeacherMapper teacherMapper;

    @Autowired
    NewsMapper newsMapper;

    @Autowired
    LessonMapper lessonMapper;

    /**
     * 分页查询教师
     *
     * @param
     * @return
     */
    @GetMapping("/getTeacherPage")
    public OutputObject getTeacherPage(@RequestParam(value = "name",required = false) String name,
                                        @RequestParam(value = "page", defaultValue = "1") int page,
                                        @RequestParam(value = "pageSize", defaultValue = "10") int pageSize){
        IPage<Teacher> scoreIPage = teacherMapper.selectTeacherByName(new Page<>(page, pageSize), name);
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),null,scoreIPage);
    }

    /**
     * 启用禁用
     *
     * @param
     * @return
     */
    @PutMapping("/updateTeacherStatus")
    public OutputObject updateTeacherStatus(@RequestParam("id") int id){
        // 创建UpdateWrapper对象
        UpdateWrapper<Teacher> updateWrapper = new UpdateWrapper<>();
        // 设置更新条件
        updateWrapper.eq("id", id);
        // 设置更新内容
        updateWrapper.setSql("status=1-status");
        // 执行更新操作
        int result = teacherMapper.update(null, updateWrapper);
        Teacher teacher = teacherMapper.selectById(id);
        int status = teacher.getStatus();
        // 判断更新结果
        if (result > 0) {
            if (status==1){
                return new OutputObject(String.valueOf(HttpStatus.OK.value()),"已启用",result);
            }else {
                return new OutputObject(String.valueOf(HttpStatus.OK.value()),"已禁用",result);
            }
        } else {
            return new OutputObject(String.valueOf(HttpStatus.INTERNAL_SERVER_ERROR.value()),"更新失败",result);
        }
    }

    /**
     * 删除教师
     *
     * @param
     * @return
     */
    @DeleteMapping("/deleteTeacher/{id}")
    public OutputObject deleteTeacher(@PathVariable int id){
        Teacher teacher = teacherMapper.selectById(id);
        Integer status = teacher.getStatus();
        if (status==1){
            return new OutputObject(String.valueOf(HttpStatus.INTERNAL_SERVER_ERROR.value()),"账号启用中,无法删除",status);
        }
        newsMapper.deleteByTeacherId(id);

        lessonMapper.deleteByTeacherId(id);

        int i = teacherMapper.deleteByTeacherId(id);

        if (i==1){
            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"删除成功",i);
        }else{
            return new OutputObject(String.valueOf(HttpStatus.INTERNAL_SERVER_ERROR.value()),"删除失败",i);
        }
    }


    /**
     * 查询教师个人信息
     *
     * @param
     * @return
     */
    @GetMapping("/getMyDetail")
    public OutputObject getMyDetail(@RequestParam("id") int id){
        Teacher teacher = teacherMapper.selectById(id);
        HashMap<String,Object> hs =new HashMap<>();
        hs.put("id",teacher.getId());
        hs.put("img",teacher.getImg());
//        hs.put("roleId",teacher.getRoleId());
        hs.put("school",teacher.getSchool());
        hs.put("tname",teacher.getTName());
        hs.put("xueYuan",teacher.getXueYuan());
        hs.put("goodAt",teacher.getGoodAt());
        hs.put("phone",teacher.getPhone());
        hs.put("remark",teacher.getRemark());
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),null,hs);
    }

    /**
     * 修改信息
     *
     * @param
     * @return
     */
    @PutMapping("/updateTeacher")
    public OutputObject updateTeacher(@RequestBody Teacher teacher){
        try {
            teacherMapper.updateById(teacher);
        } catch (Exception e) {
            throw new CustomException("修改用户失败",0);
        }
            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"修改成功","修改用户信息成功");
    }

}

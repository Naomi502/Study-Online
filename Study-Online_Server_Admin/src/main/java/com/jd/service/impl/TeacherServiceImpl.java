package com.jd.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jd.common.OutputObject;
import com.jd.mapper.TeacherMapper;
import com.jd.entity.Teacher;
import com.jd.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

/**
 * 教师表(Teacher)表服务实现类
 *
 * @author makejava
 * @since 2023-04-29 16:52:57
 */
@Service("teacherService")
public class TeacherServiceImpl extends ServiceImpl<TeacherMapper, Teacher> implements TeacherService {

}


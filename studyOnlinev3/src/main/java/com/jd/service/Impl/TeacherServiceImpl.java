package com.jd.service.Impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jd.mapper.TeacherMapper;
import com.jd.entity.Teacher;
import com.jd.service.TeacherService;
import org.springframework.stereotype.Service;

/**
 * 教师表(Teacher)表服务实现类
 *
 * @author makejava
 * @since 2023-04-25 16:35:21
 */
@Service("teacherService")
public class TeacherServiceImpl extends ServiceImpl<TeacherMapper, Teacher> implements TeacherService {

}


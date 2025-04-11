package com.jd.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jd.mapper.LessonMapper;
import com.jd.entity.Lesson;
import com.jd.service.LessonService;
import org.springframework.stereotype.Service;

/**
 * 课程表(Lesson)表服务实现类
 *
 * @author makejava
 * @since 2023-04-29 18:12:44
 */
@Service("lessonService")
public class LessonServiceImpl extends ServiceImpl<LessonMapper, Lesson> implements LessonService {

}


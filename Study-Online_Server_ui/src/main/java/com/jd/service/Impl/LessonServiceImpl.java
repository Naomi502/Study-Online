package com.jd.service.Impl;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jd.entity.Teacher;
import com.jd.mapper.LessonMapper;
import com.jd.entity.Lesson;
import com.jd.service.LessonService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * 课程表(Lesson)表服务实现类
 *
 * @author makejava
 * @since 2023-04-22 00:43:59
 */
@Service("lessonService")
public class LessonServiceImpl extends ServiceImpl<LessonMapper, Lesson> implements LessonService {

    @Resource
    private LessonMapper lessonMapper;

    @Override
    public Page getLessonPage(Integer page, Integer pageSize, String name, Integer categoryId) {
        Page pageInfo=new Page(page,pageSize);
        LambdaQueryWrapper<Lesson> lqw=new LambdaQueryWrapper<>();
        lqw.like(ObjectUtil.isNotEmpty(name),Lesson::getLName,name);
        lqw.eq(ObjectUtil.isNotEmpty(categoryId),Lesson::getLessonTypeId,categoryId);
        Page selectPage = (Page) lessonMapper.selectPage(pageInfo, lqw);

        return selectPage;
    }
}


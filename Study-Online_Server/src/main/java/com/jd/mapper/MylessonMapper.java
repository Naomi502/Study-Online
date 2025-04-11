package com.jd.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jd.entity.Mylesson;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 我的课程(Mylesson)表数据库访问层
 *
 * @author makejava
 * @since 2023-04-23 18:38:06
 */
@Mapper
public interface MylessonMapper extends BaseMapper<Mylesson> {
List<Mylesson> getMyLesson(int userId);

int updateMyLessonByLessonId(Mylesson mylesson);
}


package com.jd.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jd.entity.Comment;
import com.jd.entity.Lesson;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

/**
 * 课程表(Lesson)表数据库访问层
 *
 * @author makejava
 * @since 2023-04-22 00:42:50
 */
@Mapper
public interface LessonMapper extends BaseMapper<Lesson> {

    IPage<Lesson> selectCommentByUserName(Page<?> page, @Param("name") String name,@Param("id") Integer id);
//    List<Lesson> selectList(int id);
}


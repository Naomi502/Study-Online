package com.jd.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jd.entity.*;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;



/**
 * 课程表(Lesson)表数据库访问层
 *
 * @author makejava
 * @since 2023-04-29 18:12:44
 */
@Mapper
public interface LessonMapper extends BaseMapper<Lesson> {
    // 分页查询课程列表
    IPage<Lesson> selectLessonPage(Page<?> page, @Param("query") LessonQuery query);

    Lesson getLessonById(Integer id);

    @Delete(" DELETE FROM lesson WHERE Id = #{id}")
    int deleteByLessonId(int id);

    @Delete("  DELETE FROM lesson WHERE teacher_id = #{id}")
    void deleteByTeacherId(int id);

    List<MyCategoryCount> getCategoryCount(int id);
}


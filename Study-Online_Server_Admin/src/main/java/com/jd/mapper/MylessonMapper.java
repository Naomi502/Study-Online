package com.jd.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jd.entity.Mylesson;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
/**
 * 我的课程(Mylesson)表数据库访问层
 *
 * @author makejava
 * @since 2023-04-29 21:30:00
 */
@Mapper
public interface MylessonMapper extends BaseMapper<Mylesson> {

    @Delete("  DELETE FROM mylesson WHERE lesson_id = #{id}")
    void deleteByLessonId(int id);
}


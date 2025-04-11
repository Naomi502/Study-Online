package com.jd.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jd.entity.LessonDetail;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
/**
 * (LessonDetail)表数据库访问层
 *
 * @author makejava
 * @since 2023-04-29 18:12:54
 */
@Mapper
public interface LessonDetailMapper extends BaseMapper<LessonDetail> {

    @Delete(" DELETE FROM lesson_detail WHERE lesson_id = #{id}")
    void deleteByLessonId(int id);
}


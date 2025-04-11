package com.jd.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jd.entity.Tree;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * (Tree)表数据库访问层
 *
 * @author makejava
 * @since 2023-04-29 20:11:11
 */
@Mapper
public interface TreeMapper extends BaseMapper<Tree> {

    @Delete("DELETE FROM tree WHERE lesson_id = #{id}")
    void deleteByLessonId(int id);

    List<Tree> getTree(int id);
}


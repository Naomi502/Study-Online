package com.jd.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jd.entity.Comment;
import com.jd.entity.News;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 * 新闻表(News)表数据库访问层
 *
 * @author makejava
 * @since 2023-04-29 17:30:03
 */
@Mapper
public interface NewsMapper extends BaseMapper<News> {
    IPage<News> selectNewsByUserName(Page<?> page, @Param("name") String name);

    IPage<News> selectNoAuditNews(Page<?> page);

    News getNewsDetail(int id);

    @Delete("  DELETE FROM news WHERE teacher_id = #{id}")
    void deleteByTeacherId(int id);
}


package com.jd.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jd.entity.News;
import com.jd.entity.Score;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 新闻表(News)表数据库访问层
 *
 * @author makejava
 * @since 2023-04-25 16:36:03
 */
@Mapper
public interface NewsMapper extends BaseMapper<News> {

    //分页查询所有新闻
    List<News> getAllNews(Integer pageBegin,Integer pageSize);

    //获取热门新闻
    List<News> getHotNews();

    //获取6条最新新闻
    List<News> getLatestNews();

    News getNewsDetail(int id);

    int getTotal();
}


package com.jd.service.Impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jd.mapper.NewsMapper;
import com.jd.entity.News;
import com.jd.service.NewsService;
import org.springframework.stereotype.Service;

/**
 * 新闻表(News)表服务实现类
 *
 * @author makejava
 * @since 2023-04-25 16:36:03
 */
@Service("newsService")
public class NewsServiceImpl extends ServiceImpl<NewsMapper, News> implements NewsService {

}


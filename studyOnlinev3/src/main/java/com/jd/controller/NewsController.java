package com.jd.controller;

import com.jd.common.OutputObject;
import com.jd.entity.News;
import com.jd.mapper.NewsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * 新闻资讯
 *
 * @author isla
 * @since 2023-4-24
 */
@RestController
@RequestMapping("/news")
public class NewsController {

    @Autowired
    NewsMapper newsMapper;

    /**
     * 分页查询新闻
     *
     * @param
     * @return
     */
    @GetMapping("/getAllNews")
    public OutputObject getAllNews(@RequestParam("page") Integer page, @RequestParam("pageSize") Integer pageSize){
        Integer pageBegin = (page-1) * pageSize;
        List<News> allNews = newsMapper.getAllNews(pageBegin, pageSize);
        int total = newsMapper.getTotal();
        HashMap<String,Object> hs =new HashMap<>();
        hs.put("total",total);
        hs.put("allNews",allNews);
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),"查询成功",hs);
    }

    /**
     * 查询最近两条热门新闻
     *
     * @param
     * @return
     */
    @GetMapping("/getHotNews")
    public OutputObject getHotNews(){
        List<News> hotNews = newsMapper.getHotNews();
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),"查询成功",hotNews);
    }

    /**
     * 查询最新六条新闻数据
     *
     * @param
     * @return
     */
    @GetMapping("/getLatestNews")
    public OutputObject getLatestNews(){
        List<News> latestNews = newsMapper.getLatestNews();
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),"查询成功",latestNews);
    }

    /**
     * 查询新闻详情
     *
     * @param id
     * @return
     */
    @GetMapping("/getNewsDetail")
    public OutputObject getNewsDetail(@RequestParam("newsId") int id){
        News newsDetail = newsMapper.getNewsDetail(id);
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),"查询成功",newsDetail);
    }

}

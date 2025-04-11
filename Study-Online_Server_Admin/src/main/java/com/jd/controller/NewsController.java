package com.jd.controller;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jd.common.OutputObject;
import com.jd.common.uploadUtil;
import com.jd.entity.News;
import com.jd.entity.Score;
import com.jd.entity.Teacher;
import com.jd.mapper.NewsMapper;
import com.jd.service.NewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

/**
 *
 * 新闻管理
 *
 * @author isla
 * @since 2023-4-29
 */
@RestController
@RequestMapping("/news")
public class NewsController {


    @Autowired
    NewsMapper newsMapper;

    @Autowired
    NewsService newsService;

    /**
     * 分页查询新闻(teacher 必传tName)
     *
     * @param
     * @return
     */
    @GetMapping("/getNewsPage")
    public OutputObject getNewsPage(@RequestParam(value = "name",required = false) String name,
                                        @RequestParam(value = "page", defaultValue = "1") int page,
                                        @RequestParam(value = "pageSize", defaultValue = "10") int pageSize){
        IPage<News> scoreIPage = newsMapper.selectNewsByUserName(new Page<>(page, pageSize), name);
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),null,scoreIPage);
    }


    /**
     * 分页查询未审核的新闻
     *
     * @param
     * @return
     */
    @GetMapping("/getNoAuditNews")
    public OutputObject getNoAuditNews(@RequestParam(value = "page", defaultValue = "1") int page,
                                    @RequestParam(value = "pageSize", defaultValue = "10") int pageSize){
        IPage<News> scoreIPage = newsMapper.selectNoAuditNews(new Page<>(page, pageSize));
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),null,scoreIPage);
    }

    /**
     * 更新审核状态
     *
     * @param
     * @return
     */
    @PutMapping("/updateAudit")
    public OutputObject updateAudit(@RequestBody News news){
        int i = newsMapper.updateById(news);
        int audit=news.getIsAudit();
        if (i==1){
            if (audit==1){
                return new OutputObject(String.valueOf(HttpStatus.OK.value()),"审核通过",i);
            }else{
                return new OutputObject(String.valueOf(HttpStatus.OK.value()),"审核不通过",i);
            }
        }else{
            return new OutputObject(String.valueOf(HttpStatus.INTERNAL_SERVER_ERROR.value()),"审核失败",i);
        }
    }


    /**
     * 查询详情
     *
     * @param
     * @return
     */
    @GetMapping("/getNewsDetail/{id}")
    public OutputObject getNewsDetail(@PathVariable int id){
        News news = newsMapper.getNewsDetail(id);
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),null,news);
    }

    /**
     * 删除新闻
     *
     * @param
     * @return
     */
    @DeleteMapping("/deleteNews/{id}")
    public OutputObject deleteNews(@PathVariable int id){
        int i = newsMapper.deleteById(id);
        if (i==1){
            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"删除成功",i);
        }else{
            return new OutputObject(String.valueOf(HttpStatus.INTERNAL_SERVER_ERROR.value()),"删除失败",i);
        }
    }

    /**
     * 发布新闻(传title,teacherId,content,remark)  传img就得传isHot=1
     *
     * @param
     * @return
     */
    @PostMapping("/releaseNews")
    public OutputObject releaseNews(@RequestBody News news){
        int insert = newsMapper.insert(news);
        if (insert==1){
            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"发布成功",insert);
        }else{
            return new OutputObject(String.valueOf(HttpStatus.INTERNAL_SERVER_ERROR.value()),"发布失败",insert);
        }
    }

    /**
     * 修改新闻
     *
     * @param
     * @return
     */
    @PutMapping("/updateNews")
    public OutputObject updateNews(@RequestBody News news){
        int i = newsMapper.updateById(news);
        if (i==1){
            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"修改成功",i);
        }else{
            return new OutputObject(String.valueOf(HttpStatus.INTERNAL_SERVER_ERROR.value()),"修改失败",i);
        }
    }

    /**
     * 热门图片上传
     *
     * @param
     * @return
     */
    @PostMapping("/upload")
    public OutputObject uploadHeadImg(MultipartFile file) throws IOException {
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),"文件上传成功", uploadUtil.uploadImage(file));
    }
}

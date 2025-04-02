package com.jd.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.jd.entity.Lesson;

/**
 * (LessonDetail)表服务接口
 *
 * @author makejava
 * @since 2023-04-22 16:45:10
 */
public interface LessonService extends IService<Lesson> {
    Page getLessonPage(Integer page, Integer pageSize, String name, Integer categoryId);
}


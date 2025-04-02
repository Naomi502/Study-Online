package com.jd.service.Impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jd.mapper.LessonDetailMapper;
import com.jd.entity.LessonDetail;
import com.jd.service.LessonDetailService;
import org.springframework.stereotype.Service;

/**
 * (LessonDetail)表服务实现类
 *
 * @author makejava
 * @since 2023-04-22 18:16:35
 */
@Service("lessonDetailService")
public class LessonDetailServiceImpl extends ServiceImpl<LessonDetailMapper, LessonDetail> implements LessonDetailService {

}


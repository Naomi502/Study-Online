package com.jd.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jd.mapper.LessonDetailMapper;
import com.jd.entity.LessonDetail;
import com.jd.service.LessonDetailService;
import org.springframework.stereotype.Service;

/**
 * (LessonDetail)表服务实现类
 *
 * @author makejava
 * @since 2023-04-29 18:12:54
 */
@Service("lessonDetailService")
public class LessonDetailServiceImpl extends ServiceImpl<LessonDetailMapper, LessonDetail> implements LessonDetailService {

}


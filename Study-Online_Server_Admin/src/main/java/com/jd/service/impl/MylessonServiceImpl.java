package com.jd.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jd.mapper.MylessonMapper;
import com.jd.entity.Mylesson;
import com.jd.service.MylessonService;
import org.springframework.stereotype.Service;

/**
 * 我的课程(Mylesson)表服务实现类
 *
 * @author makejava
 * @since 2023-04-29 21:30:00
 */
@Service("mylessonService")
public class MylessonServiceImpl extends ServiceImpl<MylessonMapper, Mylesson> implements MylessonService {

}


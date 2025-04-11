package com.jd.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jd.mapper.ScoreDetailMapper;
import com.jd.entity.ScoreDetail;
import com.jd.service.ScoreDetailService;
import org.springframework.stereotype.Service;

/**
 * (ScoreDetail)表服务实现类
 *
 * @author makejava
 * @since 2023-05-08 23:39:34
 */
@Service("scoreDetailService")
public class ScoreDetailServiceImpl extends ServiceImpl<ScoreDetailMapper, ScoreDetail> implements ScoreDetailService {

}


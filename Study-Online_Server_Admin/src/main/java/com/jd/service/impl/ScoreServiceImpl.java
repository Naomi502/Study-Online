package com.jd.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jd.entity.Score;
import com.jd.mapper.ScoreMapper;
import com.jd.service.ScoreService;
import org.springframework.stereotype.Service;

/**
 * 积分表(Score)表服务实现类
 *
 * @author makejava
 * @since 2023-04-29 14:43:35
 */
@Service("scoreService")
public class ScoreServiceImpl extends ServiceImpl<ScoreMapper, Score> implements ScoreService {

}


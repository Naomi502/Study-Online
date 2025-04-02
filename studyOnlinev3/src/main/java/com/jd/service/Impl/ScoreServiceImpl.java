package com.jd.service.Impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jd.mapper.ScoreMapper;
import com.jd.entity.Score;
import com.jd.service.ScoreService;
import org.springframework.stereotype.Service;

/**
 * 积分表(Score)表服务实现类
 *
 * @author makejava
 * @since 2023-04-24 19:49:49
 */
@Service("scoreService")
public class ScoreServiceImpl extends ServiceImpl<ScoreMapper, Score> implements ScoreService {

}


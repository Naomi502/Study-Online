package com.jd.controller;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.jd.entity.Score;
import com.jd.mapper.ScoreMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TimerController {

    @Autowired
    ScoreMapper scoreMapper;

    @Scheduled(cron = "0 0 0 * * ?")
    protected void updateScoreStatus() {
        UpdateWrapper<Score> updateWrapper = new UpdateWrapper<>();
        updateWrapper.set("status", 0);
        scoreMapper.update(null, updateWrapper);
    }
}

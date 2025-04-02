package com.jd.util;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.jd.entity.Score;
import com.jd.mapper.ScoreMapper;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Component;

@Component
public class DailyResetTask extends QuartzJobBean {

    @Autowired
    ScoreMapper scoreMapper;

    @Override
    protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
        UpdateWrapper<Score> updateWrapper = new UpdateWrapper<>();
        updateWrapper.set("status", 0);
        scoreMapper.update(null, updateWrapper);
    }
}

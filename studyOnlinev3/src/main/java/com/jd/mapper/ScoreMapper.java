package com.jd.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jd.entity.Mylesson;
import com.jd.entity.Score;
import com.jd.entity.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 积分表(Score)表数据库访问层
 *
 * @author makejava
 * @since 2023-04-24 19:49:49
 */
@Mapper
public interface ScoreMapper extends BaseMapper<Score> {
int updateMyScoreById(Score score);

    List<Score> getAllScore();

    Score getMyScore(int userId);
}


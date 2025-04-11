package com.jd.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jd.entity.Score;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 * 积分表(Score)表数据库访问层
 *
 * @author makejava
 * @since 2023-04-29 14:43:35
 */
@Mapper
public interface ScoreMapper extends BaseMapper<Score> {

    IPage<Score> selectScoreByUserName(Page<?> page, @Param("name") String name);

}


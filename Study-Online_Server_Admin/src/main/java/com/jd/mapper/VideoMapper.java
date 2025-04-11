package com.jd.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jd.entity.Video;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
/**
 * 视频表(Video)表数据库访问层
 *
 * @author makejava
 * @since 2023-04-29 21:29:26
 */
@Mapper
public interface VideoMapper extends BaseMapper<Video> {
    @Delete("  DELETE FROM video WHERE tree_id = #{id}")
    void deleteByTreeId(int id);
}


package com.jd.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jd.entity.HotCategory;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * (HotCategory)表数据库访问层
 *
 * @author makejava
 * @since 2023-04-29 15:42:41
 */
@Mapper
public interface HotCategoryMapper extends BaseMapper<HotCategory> {
    int updateNameById(HotCategory hotCategory);
}


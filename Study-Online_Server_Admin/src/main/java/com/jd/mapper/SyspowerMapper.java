package com.jd.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jd.entity.Syspower;
import org.apache.ibatis.annotations.Mapper;
/**
 * 用户权限对照表(Syspower)表数据库访问层
 *
 * @author makejava
 * @since 2023-05-03 17:21:19
 */
@Mapper
public interface SyspowerMapper extends BaseMapper<Syspower> {

}


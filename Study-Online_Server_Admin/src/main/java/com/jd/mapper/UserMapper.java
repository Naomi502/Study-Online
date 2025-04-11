package com.jd.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jd.entity.User;
import org.apache.ibatis.annotations.Mapper;
/**
 * 用户表(User)表数据库访问层
 *
 * @author makejava
 * @since 2023-04-29 14:54:08
 */
@Mapper
public interface UserMapper extends BaseMapper<User> {

}


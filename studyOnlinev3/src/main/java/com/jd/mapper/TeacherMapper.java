package com.jd.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jd.entity.Teacher;
import org.apache.ibatis.annotations.Mapper;
/**
 * 教师表(Teacher)表数据库访问层
 *
 * @author makejava
 * @since 2023-04-25 16:35:21
 */
@Mapper
public interface TeacherMapper extends BaseMapper<Teacher> {

}


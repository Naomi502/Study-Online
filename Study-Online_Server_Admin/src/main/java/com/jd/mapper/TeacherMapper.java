package com.jd.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jd.entity.Comment;
import com.jd.entity.Teacher;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 * 教师表(Teacher)表数据库访问层
 *
 * @author makejava
 * @since 2023-04-29 16:52:57
 */
@Mapper
public interface TeacherMapper extends BaseMapper<Teacher> {
    IPage<Teacher> selectTeacherByName(Page<?> page, @Param("name") String name);

    @Delete(" DELETE FROM teacher WHERE Id = #{id}")
    int deleteByTeacherId(int id);

//    @Delete("delete from `study-online`.teacher where id=#{id}")
//    int deleteByIdAndStatus(@Param("id") int id, @Param("status") Integer status);

}


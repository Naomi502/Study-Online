package com.jd.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jd.entity.Comment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 评论表(Comment)表数据库访问层
 *
 * @author makejava
 * @since 2023-04-23 01:03:16
 */
@Mapper
public interface CommentMapper extends BaseMapper<Comment> {
 List<Comment> getByPIdComment(Integer pId);

}


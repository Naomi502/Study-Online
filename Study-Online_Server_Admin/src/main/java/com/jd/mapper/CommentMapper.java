package com.jd.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jd.entity.Comment;
import com.jd.entity.Score;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 评论表(Comment)表数据库访问层
 *
 * @author makejava
 * @since 2023-04-29 16:32:07
 */
@Mapper
public interface CommentMapper extends BaseMapper<Comment> {

    IPage<Comment> selectCommentByUserName(Page<?> page, @Param("name") String name);

    @Delete("DELETE FROM comment WHERE id IN (${ids})")
    int deleteByIds(@Param("ids") String ids);

    void deleteCommentsById(List<Long> ids);

    void deleteCommentsByParentId(Long parentId);

    @Delete("  DELETE FROM comment WHERE tree_id = #{id}")
    void deleteByTreeId(int id);
}


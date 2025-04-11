package com.jd.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jd.mapper.CommentMapper;
import com.jd.entity.Comment;
import com.jd.service.CommentService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 评论表(Comment)表服务实现类
 *
 * @author makejava
 * @since 2023-04-29 16:32:07
 */
@Service("commentService")
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements CommentService {

    @Autowired
    CommentMapper commentMapper;
    @Override
    public int batchDeleteByIds(List<Integer> ids) {
        String idsStr = StringUtils.join(ids, ",");
        return commentMapper.deleteByIds(idsStr);
    }

    @Override
    public void deleteCommentsById(List<Long> ids) {
        // 删除评论
        commentMapper.deleteCommentsById(ids);
        // 递归删除评论的子评论
        for (Long id : ids) {
            deleteCommentsByParentId(id);
        }
    }

    @Override
    public void deleteCommentsByParentId(Long parentId) {
        QueryWrapper<Comment> wrapper = new QueryWrapper<>();
        wrapper.eq("parent_id", parentId);
        List<Comment> comments = commentMapper.selectList(wrapper);
        for (Comment comment : comments) {
            commentMapper.deleteById(comment.getId());
            deleteCommentsByParentId(comment.getId());
        }

    }
}


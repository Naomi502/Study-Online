package com.jd.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.jd.entity.Comment;

import java.util.List;

/**
 * 评论表(Comment)表服务接口
 *
 * @author makejava
 * @since 2023-04-29 16:32:07
 */
public interface CommentService extends IService<Comment> {
    int batchDeleteByIds(List<Integer> ids);

     void deleteCommentsById(List<Long> ids);

     void deleteCommentsByParentId(Long parentId);
}


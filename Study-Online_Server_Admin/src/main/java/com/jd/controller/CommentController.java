package com.jd.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jd.common.OutputObject;
import com.jd.entity.Comment;
import com.jd.entity.Score;
import com.jd.entity.Tree;
import com.jd.mapper.CommentMapper;
import com.jd.service.CommentService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 *
 * 评论管理
 *
 * @author isla
 * @since 2023-4-29
 */
@RestController
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    CommentMapper commentMapper;

    @Autowired
    CommentService commentService;

    /**
     * 分页查询评论
     *
     * @param
     * @return
     */
    @GetMapping("/getCommentPage")
    public OutputObject getScorePage(@RequestParam(value = "name",required = false) String name,
                                        @RequestParam(value = "page", defaultValue = "1") int page,
                                        @RequestParam(value = "pageSize", defaultValue = "10") int pageSize){
        IPage<Comment> scoreIPage = commentMapper.selectCommentByUserName(new Page<>(page, pageSize), name);
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),null,scoreIPage);
    }

    /**
     * 批量删除评论
     *
     * @param
     * @return
     */
    @DeleteMapping("/deleteCommentByIds/{id}")
    public OutputObject deleteCommentByIds(@PathVariable("id") Long id){
//        int count = commentService.batchDeleteByIds(comment.getIds());
        // 获取要删除的评论ID列表
        List<Long> ids = new ArrayList<>();
        ids.add(id);
        QueryWrapper<Comment> wrapper = new QueryWrapper<>();
        wrapper.eq("parent_id", id);
        List<Comment> comments = commentMapper.selectList(wrapper);
        for (Comment comment : comments) {
            ids.add(comment.getId());
        }
        // 删除评论
        commentService.deleteCommentsById(ids);
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),"删除成功","");
    }
}

package com.jd.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.jd.common.CustomException;
import com.jd.common.OutputObject;
import com.jd.common.ReturnCode;
import com.jd.entity.Comment;
import com.jd.entity.HotCategory;
import com.jd.entity.Lesson;
import com.jd.entity.LessonDetail;
import com.jd.mapper.CommentMapper;
import com.jd.util.NodeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * 评论
 *
 * @author isla
 * @since 2023-4-24
 */
@RestController
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    CommentMapper commentMapper;

    /**
     * 查询评论
     *
     * @param pId
     * @return
     */
    @GetMapping("/getComment")
    public OutputObject getComment(@RequestParam("pId") Integer pId){
        List<Comment> comment = commentMapper.getByPIdComment(pId);
        Map<Integer, Comment> map = new HashMap<>();
        List<Comment> result = new ArrayList<>();
        for (Comment c : comment) {
            if (c.getPid() == null) {
                result.add(c);
            }
            map.put(c.getId(), c);
        }
        for (Comment c : comment) {
            if (c.getPid() != null) {
                Comment parent = map.get(c.getPid());

                if (parent == null) {
                    continue;
                }

                if (parent.getId().intValue() == c.getId().intValue()) {
                    continue;
                }
                if (parent.getReply() == null) {
                    parent.setReply(new ArrayList<>());
                }
                parent.getReply().add(c);
            }
        }
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),"查询成功",result);
    }

    /**
     * 用户评论
     *
     * @param comment
     * @return
     */
    @PostMapping("/comment")
    public OutputObject comment(@RequestBody Comment comment){
        int insert = commentMapper.insert(comment);
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),"评论成功",insert);
    }

    /**
     * 用户点赞
     *
     * @param comment
     * @return
     */
    @PutMapping("like")
    public OutputObject like(@RequestBody Comment comment){
        try{
            commentMapper.updateById(comment);
        }catch (Exception e){
            return new OutputObject(ReturnCode.FAIL,"点赞失败","");
        }
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),"点赞成功","");
//        if (comment.getIsZan()==1){
//            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"点赞成功","");
//        }else {
//            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"取消点赞","");
//        }
    }
}

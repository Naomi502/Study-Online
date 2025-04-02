package com.jd.entity;


import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 评论表(Comment)表实体类
 *
 * @author makejava
 * @since 2023-04-23 01:02:48
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Comment implements Serializable {
    private Integer id;
    
    /**
     * 内容
     **/
    private String content;
    
    /**
     * 用户
     **/
    private Integer userId;
    
    /**
     * 点赞数
     **/
    private Integer zan;

    /**
     * 章节子节点id
     **/
    private Integer treeId;
    
    /**
     * 时间
     **/
    @TableField(value = "time",fill =FieldFill.INSERT)
    private Date time;


    private String users;

    private User user;

    @TableField(value = "parent_id")
    private Integer pid;

    @TableField(exist = false)
    private List<Comment> reply = new ArrayList<>();
    
public Serializable pkVal() {
          return null;
      }
}



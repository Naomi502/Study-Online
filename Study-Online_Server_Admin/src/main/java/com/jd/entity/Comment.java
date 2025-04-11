package com.jd.entity;


import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import java.io.Serializable;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.util.Date;
import java.util.List;

/**
 * 评论表(Comment)表实体类
 *
 * @author makejava
 * @since 2023-04-29 16:32:07
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Comment implements Serializable {
    private Long id;
    
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
     * 时间
     **/
    private Date time;
    
    /**
     * 章节子节点id
     **/
    private Integer treeId;
    
    /**
     * 子节点
     **/
    private Integer parentId;
    
    /**
     * 对该评论点过赞的用户
     **/
    private String users;

    @TableField(select = false)
    private User user;

    @TableField(select = false)
    private String loginName;

//    private List<Integer> ids;


    
public Serializable pkVal() {
          return null;
      }
}



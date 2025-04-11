package com.jd.entity;


import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import java.io.Serializable;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * (Tree)表实体类
 *
 * @author makejava
 * @since 2023-04-29 20:11:11
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Tree implements Serializable {
    private int id;

    private String name;

    @TableField(value = "parent_id")
    private int pid;

    private int level;

    private String introduce;

    private int lessonId;

    @TableField(exist = false)
    private List<Tree> children = new ArrayList<>();

    @TableField(select = false)
    private String link;

//    @TableField(select = false)
//    private int videoId;

    
public Serializable pkVal() {
          return null;
      }

}



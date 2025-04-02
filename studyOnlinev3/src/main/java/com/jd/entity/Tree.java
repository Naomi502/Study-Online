package com.jd.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class Tree {
    private int id;

    private String name;

    @TableField(value = "parent_id")
    private int pid;

    private int level;

    private String introduce;


    private int lessonId;

    @TableField(exist = false)
    private List<Tree> children = new ArrayList<>();

}

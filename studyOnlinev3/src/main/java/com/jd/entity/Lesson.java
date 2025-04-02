package com.jd.entity;


import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 课程表(Lesson)表实体类
 *
 * @author makejava
 * @since 2023-04-22 00:43:26
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Lesson implements Serializable {
    private Integer id;
    
    /**
     * 课程名称
     **/
    private String lName;
    
    /**
     * 分类
     **/
    private Integer lessonTypeId;
    
    /**
     * 上传用户
     **/
    private Integer userId;
    
    /**
     * 讲授教师
     **/
//    @TableField(select = false)
    private String teacherId;
    
    /**
     * 学校
     **/
    private String school;
    
    /**
     * 上传时间
     **/
    private Date time;
    
    /**
     * 封面
     **/
    private String img;
    
    /**
     * 点击量
     **/
    private String dianJi;
    
    /**
     * 点赞数
     **/
    private Integer zan;
    
    /**
     * 简介
     **/
    private String remark;

    @TableField(select = false)
    private String tName;
    
public Serializable pkVal() {
          return null;
      }
}



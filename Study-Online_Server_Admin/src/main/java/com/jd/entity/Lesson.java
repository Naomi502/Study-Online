package com.jd.entity;


import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import java.io.Serializable;

import com.baomidou.mybatisplus.annotation.Version;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.util.Date;

/**
 * 课程表(Lesson)表实体类
 *
 * @author makejava
 * @since 2023-04-29 18:22:02
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
    private String teacherId;
    
    /**
     * 学校
     **/
    private String school;
    
    /**
     * 上传时间
     **/
    @TableField(value = "time",fill =FieldFill.INSERT_UPDATE)
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

    private Teacher teacher;

    private String tName;

    /**
     * 热门课程名字
     **/
    private String categoryName;
public Serializable pkVal() {
          return null;
      }
}



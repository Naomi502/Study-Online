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
 * 教师表(Teacher)表实体类
 *
 * @author makejava
 * @since 2023-04-25 16:35:21
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Teacher implements Serializable {
    private Integer id;
    
    /**
     * 姓名 （管理端登录名）
     **/
    private String tName;
    
    /**
     * 单位：学校
     **/
    private String school;
    
    /**
     * 学院
     **/
    private String xueYuan;
    
    /**
     * 职称
     **/
    private String zhiCheng;
    
    /**
     * 出生日期
     **/
    private Date birthday;
    
    /**
     * 擅长
     **/
    private String goodAt;
    
    /**
     * 图片
     **/
    private String img;
    
    /**
     * 简介
     **/
    private String remark;
    
    /**
     * 用户角色0为普通教师 1为超级管理员
     **/
    private Integer roleId;
    
    /**
     * 用户密码
     **/
    private String password;
    
public Serializable pkVal() {
          return null;
      }
}



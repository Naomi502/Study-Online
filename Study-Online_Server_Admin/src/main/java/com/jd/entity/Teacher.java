package com.jd.entity;


import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.experimental.Accessors;

import java.util.Date;

/**
 * 教师表(Teacher)表实体类
 *
 * @author makejava
 * @since 2023-04-29 16:54:20
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Teacher implements Serializable {
    private static final long serialVersionUID=1L;

    private Integer id;
    
    /**
     * 姓名 
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
     * 用户角色1为普通教师 2为超级管理员
     **/
    private Integer roleId;
    
    /**
     * 用户密码
     **/
    private String password;
    
    /**
     * 是否启用
     **/
    private Integer status;
    
    /**
     * 登录手机号
     **/
    private String  phone;

    private String salt;

    public Teacher(String tName, String password) {
        this.tName = tName;
        this.password = password;
    }
public Serializable pkVal() {
          return null;
      }
}



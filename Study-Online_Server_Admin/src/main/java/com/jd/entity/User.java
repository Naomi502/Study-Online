package com.jd.entity;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 用户表(User)表实体类
 *
 * @author makejava
 * @since 2023-04-29 14:54:08
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class User implements Serializable {
    /**
     * 加密盐值
     **/
    private String salt;
    
    private Integer id;
    
    /**
     * 登录名
     **/
    private String loginName;
    
    /**
     * 用户角色
     **/
    private Integer roleId;
    
    /**
     * 登录密码
     **/
    private String password;
    
    /**
     * 真实姓名
     **/
    private String realName;
    
    /**
     * 联系电话
     **/
    private String phone;
    
    /**
     * 性别
     **/
    private Integer sex;
    
    /**
     * 学历
     **/
    private Integer xueLi;
    
    /**
     * 职称
     **/
    private String zhiCheng;
    
    /**
     * 单位
     **/
    private String danWei;
    
    /**
     * 身份证
     **/
    private String zhengHao;
    
    /**
     * 电子邮箱
     **/
    private String email;
    
    /**
     * 状态（1正常、0禁用）
     **/
    private Integer userStatus;
    
    /**
     * 说明
     **/
    private String remark;
    
    /**
     * 图片
     **/
    private String img;
    
    /**
     * 审核（0未审核 1审核通过 2未通过）	
     **/
    private Integer shenHe;
    
public Serializable pkVal() {
          return null;
      }
}



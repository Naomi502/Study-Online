package com.jd.entity;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

/**
 * 积分表(Score)表实体类
 *
 * @author makejava
 * @since 2023-04-29 14:43:39
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Score implements Serializable {
    private Integer id;
    
    /**
     * 用户
     **/
    private Integer userId;
    
    /**
     * 加入时间
     **/
    private Date time;
    
    /**
     * 积分
     **/
    private Double score;
    
    /**
     * 每日是否签到 0为未签 ，1为已签
     **/
    private Integer status;

    private User user;

    private String loginName; // loginName
    
public Serializable pkVal() {
          return null;
      }
}



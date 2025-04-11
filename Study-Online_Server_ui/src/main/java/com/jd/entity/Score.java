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
 * 积分表(Score)表实体类
 *
 * @author makejava
 * @since 2023-04-24 19:47:25
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
    @TableField(value = "time",fill =FieldFill.INSERT_UPDATE)
    private Date time;
    
    /**
     * 积分
     **/
    private Double score;

    /**
     * 每日签到
     **/
    private int status;

    @TableField(select = false)
    private User user;
    
public Serializable pkVal() {
          return null;
      }
}



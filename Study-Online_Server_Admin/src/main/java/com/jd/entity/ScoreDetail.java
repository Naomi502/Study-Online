package com.jd.entity;


import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import java.io.Serializable;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.util.Date;

/**
 * (ScoreDetail)表实体类
 *
 * @author makejava
 * @since 2023-05-08 23:39:34
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ScoreDetail implements Serializable {
    private Integer id;
    
    /**
     * 加分
     **/
    private String score;
    
    /**
     * 方式
     **/
    private String way;
    
    /**
     * 用户id
     **/
    private Integer userid;
    
    /**
     * 时间
     **/
    @TableField(value = "time",fill =FieldFill.INSERT_UPDATE)
    private Date time;
    
public Serializable pkVal() {
          return null;
      }
}



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
 * 新闻表(News)表实体类
 *
 * @author makejava
 * @since 2023-04-25 16:36:03
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class News implements Serializable {
    private Integer id;
    
    /**
     * 是否热门展示(0否 1是)
     **/
    private Integer isHot;
    
    /**
     * 标题
     **/
    private String title;
    
    /**
     * 老师id （作者）
     **/
    private Integer teacherId;
    
    /**
     * 封面
     **/
    private String img;
    
    /**
     * 时间
     **/
    @TableField(value = "time",fill =FieldFill.INSERT_UPDATE)
    private Date time;
    
    /**
     * 点击量
     **/
    private Integer dianJi;
    
    /**
     * 内容
     **/
    private String content;
    
    /**
     * 简介
     **/
    private String remark;

    /**
     * 是否审核
     **/
    private Integer isAudit;

//    private int total;




    private Teacher teacher;
    
public Serializable pkVal() {
          return null;
      }
}



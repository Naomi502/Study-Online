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
 * 视频表(Video)表实体类
 *
 * @author makejava
 * @since 2023-04-22 23:31:27
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Video implements Serializable {
    private Integer id;
    
    /**
     * 连接地址
     **/
    private String link;
    
    /**
     * 上传时间
     **/
    private Date time;
    
    /**
     * 上传人
     **/
    private Integer userId;
    
    /**
     * 简介
     **/
    private String remark;
    
    /**
     * 子链id
     **/
    private Integer treeId;
    
public Serializable pkVal() {
          return null;
      }
}



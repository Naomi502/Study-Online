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
 * (LessonDetail)表实体类
 *
 * @author makejava
 * @since 2023-04-22 18:15:32
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class LessonDetail implements Serializable {
    private Integer id;
    
    /**
     * 课程介绍
     **/
    private String introduce;
    
    /**
     * 视频
     **/
    private String vedio;
    
    /**
     * 课程id
     **/
    private Integer lessonId;
    
public Serializable pkVal() {
          return null;
      }
}



package com.jd.entity;


import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

/**
 * 我的课程(Mylesson)表实体类
 *
 * @author makejava
 * @since 2023-04-23 18:33:29
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Mylesson implements Serializable {
    private Integer id;
    
    /**
     * 课程Id
     **/
    private Integer lessonId;
    
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
     * 是否完成 0为未完成 1为完成
     **/
    private Integer isFinish;
    
    /**
     * 视频播放时间
     **/
    private Integer durations;
    
    /**
     * 默认展开节点
     **/
    private String expandedList;

    private Integer treeId;

    private Lesson lesson;

    private Teacher teacher;

    @TableField(select = false)
    private String tName;

public Serializable pkVal() {
          return null;
      }
}



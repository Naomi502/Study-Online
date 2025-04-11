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
 * 我的课程(Mylesson)表实体类
 *
 * @author makejava
 * @since 2023-04-29 21:30:00
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
    private Date time;
    
    /**
     * 是否完成
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
    
    /**
     * 子链id
     **/
    private Integer treeId;
    
public Serializable pkVal() {
          return null;
      }
}



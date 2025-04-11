package com.jd.entity;


import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import java.io.Serializable;

import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Data;


import java.util.Date;

/**
 * (HotCategory)表实体类
 *
 * @author makejava
 * @since 2023-04-29 15:42:41
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class HotCategory implements Serializable {
    /**
     * 热门课程id
     **/
    private Integer id;
    
    /**
     * 热门课程名字
     **/
    private String name;
    
    /**
     * 是否启用 0否 1是
     **/
    private Integer status;
    
public Serializable pkVal() {
          return null;
      }
}



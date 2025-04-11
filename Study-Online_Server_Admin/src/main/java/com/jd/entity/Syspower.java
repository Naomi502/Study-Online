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
 * 用户权限对照表(Syspower)表实体类
 *
 * @author makejava
 * @since 2023-05-03 17:21:19
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Syspower implements Serializable {
    private Integer id;
    
    /**
     * 用户Id
     **/
    private Integer roleId;
    
    /**
     * 功能Id
     **/
    private Integer menuId;
    
public Serializable pkVal() {
          return null;
      }
}



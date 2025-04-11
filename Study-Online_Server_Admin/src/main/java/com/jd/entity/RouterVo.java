package com.jd.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * 路由需要的数据格式
 */
@Data
@JsonInclude(JsonInclude.Include.NON_EMPTY)
public class RouterVo {

    private Integer menuId;

    private Integer parentId;

    private String path;

    private Boolean hidden;

    private String name;

    private String component;

    private String redirect;

    private boolean alwaysShow;

//    @TableField(select = false)
    private Meta meta;

    @TableField(select = false)
    private List<RouterVo> children;

}
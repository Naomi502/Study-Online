package com.jd.config;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class EntityFillConfig implements MetaObjectHandler {

    /**
     * 添加操作
     *
     * @param metaObject
     */
    @Override
    public void insertFill(MetaObject metaObject) {
        //设置属性值
        this.setFieldValByName("time", new Date(), metaObject);
        this.setFieldValByName("time", new Date(), metaObject);
    }

    /**
     * 修改操作
     *
     * @param metaObject
     */
    @Override
    public void updateFill(MetaObject metaObject) {
        //设置属性值
        this.setFieldValByName("time", new Date(), metaObject);
    }
}
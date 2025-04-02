package com.jd.service.Impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jd.mapper.HotcategoryMapper;
import com.jd.entity.HotCategory;
import com.jd.service.HotcategoryService;
import org.springframework.stereotype.Service;

/**
 * (Hotcategory)表服务实现类
 *
 * @author makejava
 * @since 2023-04-22 00:22:33
 */
@Service("hotcategoryService")
public class HotcategoryServiceImpl extends ServiceImpl<HotcategoryMapper, HotCategory> implements HotcategoryService {

}


package com.jd.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jd.mapper.HotCategoryMapper;
import com.jd.entity.HotCategory;
import com.jd.service.HotCategoryService;
import org.springframework.stereotype.Service;

/**
 * (HotCategory)表服务实现类
 *
 * @author makejava
 * @since 2023-04-29 15:42:41
 */
@Service("hotCategoryService")
public class HotCategoryServiceImpl extends ServiceImpl<HotCategoryMapper, HotCategory> implements HotCategoryService {

}


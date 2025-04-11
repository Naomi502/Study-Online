package com.jd.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jd.mapper.TreeMapper;
import com.jd.entity.Tree;
import com.jd.service.TreeService;
import org.springframework.stereotype.Service;

/**
 * (Tree)表服务实现类
 *
 * @author makejava
 * @since 2023-04-29 20:11:11
 */
@Service("treeService")
public class TreeServiceImpl extends ServiceImpl<TreeMapper, Tree> implements TreeService {

}


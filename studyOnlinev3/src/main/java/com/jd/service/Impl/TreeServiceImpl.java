package com.jd.service.Impl;


import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jd.mapper.TreeMapper;
import com.jd.entity.Tree;
import com.jd.service.TreeService;
import org.springframework.stereotype.Service;

/**
 * @author yjw
 * @date 2020/7/28
 */
@Service
public class TreeServiceImpl extends ServiceImpl<TreeMapper, Tree> implements TreeService {

}
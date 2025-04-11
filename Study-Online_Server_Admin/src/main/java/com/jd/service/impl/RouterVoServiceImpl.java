package com.jd.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jd.entity.RouterVo;
import com.jd.mapper.RouterVoMapper;
import com.jd.service.RouterVoService;
import org.springframework.stereotype.Service;

@Service("routerVoService")
public class RouterVoServiceImpl extends ServiceImpl<RouterVoMapper, RouterVo> implements RouterVoService {
}

    package com.jd.service.Impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jd.mapper.VideoMapper;
import com.jd.entity.Video;
import com.jd.service.VideoService;
import org.springframework.stereotype.Service;

/**
 * 视频表(Video)表服务实现类
 *
 * @author makejava
 * @since 2023-04-22 23:33:05
 */
@Service("videoService")
public class VideoServiceImpl extends ServiceImpl<VideoMapper, Video> implements VideoService {

}


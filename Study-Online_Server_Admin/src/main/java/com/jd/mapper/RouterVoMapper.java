package com.jd.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jd.entity.Mylesson;
import com.jd.entity.RouterVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface RouterVoMapper extends BaseMapper<RouterVo> {

    List<RouterVo> getRouter(@Param("roleId") Integer id);

}

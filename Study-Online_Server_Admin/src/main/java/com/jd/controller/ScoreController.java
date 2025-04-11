package com.jd.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jd.common.OutputObject;
import com.jd.entity.Score;
import com.jd.entity.ScoreDetail;
import com.jd.mapper.ScoreDetailMapper;
import com.jd.mapper.ScoreMapper;
import com.jd.service.ScoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 *
 * 积分管理
 *
 * @author isla
 * @since 2023-4-29
 */
@RestController
@RequestMapping("/score")
public class ScoreController {
    @Autowired
    ScoreMapper scoreMapper;

    @Autowired
    ScoreService scoreService;

    @Autowired
    ScoreDetailMapper scoreDetailMapper;

    /**
     * 分页查询积分
     *
     * @param
     * @return
     */
    @GetMapping("/getScorePage")
    public OutputObject getScorePage(@RequestParam(value = "name",required = false) String name,
                                    @RequestParam(value = "page", defaultValue = "1") int page,
                                    @RequestParam(value = "pageSize", defaultValue = "10") int pageSize){
        IPage<Score> scoreIPage = scoreMapper.selectScoreByUserName(new Page<>(page, pageSize), name);
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),null,scoreIPage);
    }

    /**
     * 批量重置积分
     *
     * @param
     * @return
     */
    @PutMapping("/resetScore")
    public OutputObject resetScore(@RequestParam List<Integer> idList){
        UpdateWrapper<Score> updateWrapper = new UpdateWrapper<>();
        updateWrapper.in("id", idList); // 设置更新条件，使用in方法表示要更新的ID在idList中
        updateWrapper.set("score", 100); // 设置修改的字段和值
        boolean result = scoreService.update(updateWrapper);
        if (result){
            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"重置成功","已更新");
        }else{
            return new OutputObject(String.valueOf(HttpStatus.INTERNAL_SERVER_ERROR.value()),"重置失败","未更新");
        }
    }

    /**
     * 修改积分
     *
     * @param
     * @return
     */
    @PutMapping("/updateScore")
    public OutputObject updateScore(@RequestBody Score score){
        int i = scoreMapper.updateById(score);
        if (i==1){
            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"修改成功","已更新");
        }else{
            return new OutputObject(String.valueOf(HttpStatus.INTERNAL_SERVER_ERROR.value()),"修改失败","未更新");
        }
    }

    /**
     * 获取用户积分明细
     *
     * @param
     * @return
     */
    @GetMapping("/getScoreDetail")
    public OutputObject getScoreDetail(@RequestParam("userId") int id){
        LambdaQueryWrapper<ScoreDetail> lqw=new LambdaQueryWrapper<>();
        lqw.eq(ScoreDetail::getUserid,id).orderByDesc(ScoreDetail::getTime);;
        List<ScoreDetail> scoreDetails = scoreDetailMapper.selectList(lqw);
        return new OutputObject(String.valueOf(HttpStatus.OK.value()), null, scoreDetails);
    }
}

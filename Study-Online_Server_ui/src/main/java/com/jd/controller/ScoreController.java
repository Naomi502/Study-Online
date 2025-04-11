package com.jd.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.jd.common.OutputObject;
import com.jd.entity.*;
import com.jd.mapper.ScoreDetailMapper;
import com.jd.mapper.ScoreMapper;
import com.jd.service.ScoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;

/**
 *
 * 积分
 *
 * @author isla
 * @since 2023-4-25
 */
@RestController
@RequestMapping("/score")
public class ScoreController {

    @Autowired
    ScoreService scoreService;

    @Autowired
    ScoreMapper scoreMapper;

    @Autowired
    ScoreDetailMapper scoreDetailMapper;


    /**
     * 获取从高到低的所有积分列表
     *
     * @param
     * @return
     */
    @GetMapping("/getAllScore")
    public OutputObject getAllScore(){
        List<Score> allScore = scoreMapper.getAllScore();
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),"查询成功",allScore);
    }

    /**
     * 获取我的积分详情
     *
     * @param userId
     * @return
     */
    @GetMapping("/getMyScore")
    public OutputObject getMyScore(@RequestParam("userId") int userId){
        Score myScore = scoreMapper.getMyScore(userId);

        return new OutputObject(String.valueOf(HttpStatus.OK.value()),"查询成功",myScore);
    }

    /**
     * 更新积分
     *
     * @param score
     * @return
     */
    @PutMapping("/updateMyScore")
    public OutputObject updateMyScore(@RequestBody Score score){
    int i = scoreMapper.updateMyScoreById(score);
    return new OutputObject(String.valueOf(HttpStatus.OK.value()),"更新成功",i);
}

    /**
     * 增添新用户积分
     *
     * @param score
     * @return
     */
    @PostMapping("/addScore")
    public OutputObject addScore(@RequestBody Score score) {
        int insert = scoreMapper.insert(score);
        return new OutputObject(String.valueOf(HttpStatus.OK.value()), "添加成功", insert);
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
        return new OutputObject(String.valueOf(HttpStatus.OK.value()), "查询成功", scoreDetails);
    }

    /**
     * 添加积分明细
     *
     * @param
     * @return
     */
    @PostMapping("/addScoreDetail")
    public OutputObject addScoreDetail(@RequestBody ScoreDetail scoreDetail){
        int insert = scoreDetailMapper.insert(scoreDetail);
        if (insert==1){
            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"添加成功",insert);
        }else {
            return new OutputObject(String.valueOf(HttpStatus.INTERNAL_SERVER_ERROR.value()),"添加失败",insert);
        }
    }
}

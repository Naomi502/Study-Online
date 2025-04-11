package com.jd.controller;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.jd.common.OutputObject;
import com.jd.entity.HotCategory;
import com.jd.mapper.HotCategoryMapper;
import com.jd.service.HotCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 *
 * 热门分类管理
 *
 * @author isla
 * @since 2023-4-29
 */
@RestController
@RequestMapping("/hotCategory")
public class HotCategoryController {
    @Autowired
    HotCategoryService hotCategoryService;

    @Autowired
    HotCategoryMapper hotCategoryMapper;

    /**
     * 查询热门分类列表
     *
     * @param
     * @return
     */
    @GetMapping("/getHotCategory")
    public OutputObject getHotCategory(){
        List<HotCategory> list = hotCategoryService.list();
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),null,list);
    }

    /**
     * 启用禁用
     *
     * @param
     * @return
     */
    @PutMapping("/updateHotCategoryStatus")
    public OutputObject updateHotCategoryStatus(@RequestParam("id") int id){
        // 创建UpdateWrapper对象
        UpdateWrapper<HotCategory> updateWrapper = new UpdateWrapper<>();
        // 设置更新条件
        updateWrapper.eq("id", id);
        // 设置更新内容
        updateWrapper.setSql("status=1-status");
        // 执行更新操作
        int result = hotCategoryMapper.update(null, updateWrapper);
        HotCategory hotCategory = hotCategoryMapper.selectById(id);
        int status = hotCategory.getStatus();
        // 判断更新结果
        if (result > 0) {
            if (status==1){
                return new OutputObject(String.valueOf(HttpStatus.OK.value()),"已启用",result);
            }else {
                return new OutputObject(String.valueOf(HttpStatus.OK.value()),"已禁用",result);
            }
        } else {
            return new OutputObject(String.valueOf(HttpStatus.INTERNAL_SERVER_ERROR.value()),"更新失败",result);
        }
    }

    /**
     * 更改名称
     *
     * @param
     * @return
     */
    @PutMapping("updateCategoryName")
    public OutputObject updateCategoryName(@RequestBody HotCategory hotCategory){
        int i = hotCategoryMapper.updateNameById(hotCategory);
        if (i==1){
            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"修改成功",i);
        }else {
            return new OutputObject(String.valueOf(HttpStatus.INTERNAL_SERVER_ERROR.value()),"修改失败",i);
        }
    }

    /**
     * 添加分类
     *
     * @param
     * @return
     */
    @PostMapping("addCategory")
    public OutputObject addCategory(@RequestBody HotCategory hotCategory){
        int insert = hotCategoryMapper.insert(hotCategory);
        if (insert==1){
            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"添加成功",insert);
        }else {
            return new OutputObject(String.valueOf(HttpStatus.INTERNAL_SERVER_ERROR.value()),"添加失败",insert);
        }
    }
}

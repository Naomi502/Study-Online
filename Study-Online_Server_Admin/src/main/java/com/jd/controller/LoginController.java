package com.jd.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jd.common.*;
import com.jd.entity.*;
import com.jd.mapper.RouterVoMapper;
import com.jd.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import com.jd.util.MenuUtil;

import java.util.HashMap;
import java.util.List;

/**
 *
 * 登录
 *
 * @author isla
 * @since 2023-4-29
 */
@RestController
@RequestMapping("/login")
public class LoginController {

    @Autowired
    RouterVoMapper routerVoMapper;

    @Autowired
    TeacherService teacherService;
    /**
     * 获取路由菜单
     *
     * @param
     * @return
     */
    @GetMapping("/getInfo")
    public OutputObject getInfo(@RequestParam("roleId") int roleId){
        List<RouterVo> routerVos = routerVoMapper.getRouter(roleId);
        List<RouterVo> routerVos1 = MenuUtil.generateMenu(routerVos);
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),null,routerVos1);
    }


    /**
     * 登录
     *
     * @param
     * @return
     */
    @PostMapping("login")
    @ResponseBody
    public OutputObject login(@RequestBody Teacher teacher){
        QueryWrapper<Teacher> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq(teacher.getTName() != null, "T_Name", teacher.getTName()).eq("status",1);
        Teacher one = teacherService.getOne(queryWrapper);
        // 通过用户名从数据库中查询出该用户
        if (one == null){
            return new OutputObject(ReturnCode.FAIL,"用户不存在或禁用中","登录失败");
        }
        // 密码校验
        String s = (MD5Utils.md5(teacher.getPassword()+one.getSalt()));
        if (one.getPassword().equals(s)==false){
            return new OutputObject(ReturnCode.FAIL,"密码不正确","登录失败");
        }
        queryWrapper.in(teacher.getPassword() != null, "password", s);

        String token = TokenUtil.sign(new Teacher(teacher.getTName(),s));
        HashMap<String,Object> hs =new HashMap<>();
        hs.put("token",token);
        hs.put("userid",one.getId());
        hs.put("roleId",one.getRoleId());
        hs.put("userName",one.getTName());
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),"登录成功",hs);

    }


    /**
     * 用户注册
     * @param teacher
     * @return
     */
    @PostMapping("register")
    @ResponseBody
    public OutputObject addUser(@RequestBody Teacher teacher) {
        try {
            // 查询用户名是否存在
            QueryWrapper<Teacher> queryWrapper = new QueryWrapper<>();
            QueryWrapper<Teacher> loginName = queryWrapper.eq("T_Name", teacher.getTName());
//            QueryWrapper<Teacher> phone = queryWrapper.eq("phone", teacher.getPhone());
            Teacher one = teacherService.getOne(loginName);
//            Teacher one1 = teacherService.getOne(phone);
            if (one!=null){
                return new OutputObject(String.valueOf(HttpStatus.OK.value()),"该用户名已存在",null);
            }
//            else if (one1!=null){
//                return new OutputObject(String.valueOf(HttpStatus.OK.value()),"该用户已注册",null);
//            }
            // 设置盐
            String salt = UUIDUtils.getUUID();
            teacher.setSalt(salt);
            // 设置密码加密
            String s = MD5Utils.md5(teacher.getPassword()+salt);
            // 设置用户默认头像Teacher
            teacher.setPassword(s);
//            user.setHeadImg(ReturnCode.DEFAULT_IMG_USER);
            teacherService.save(teacher);
            Integer id = teacher.getId();
            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"注册成功",id);
        } catch (Exception e) {
            e.printStackTrace();
            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"该用户已注册",null);
        }
    }

}

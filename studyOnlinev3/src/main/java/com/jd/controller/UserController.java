package com.jd.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.jd.common.*;
import com.jd.entity.User;
import com.jd.entity.XueLi;
import com.jd.service.UserService;
import com.jd.service.XueLiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

/**
 *
 * 用户
 *
 * @author 朱少杰
 * @since 2020-06-04
 */
@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private XueLiService xueLiService;

    @PostMapping("login")
    @ResponseBody
    public OutputObject login(@RequestBody User user){
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
//        queryWrapper.eq(user.getLoginName() != null, "Login_Name", user.getLoginName());
        queryWrapper.eq(user.getPhone() != null, "Phone", user.getPhone());
        User users = userService.getOne(queryWrapper);
        // 通过用户名从数据库中查询出该用户
        if (users == null){
            return new OutputObject(ReturnCode.FAIL,"用户不存在","登录失败");
        }
        // 密码校验
        String s = (MD5Utils.md5(user.getPassword()+users.getSalt()));
        if (users.getPassword().equals(s)==false){
            return new OutputObject(ReturnCode.FAIL,"密码不正确","登录失败");
        }
        queryWrapper.in(user.getPassword() != null, "passwd", s);

        String token = TokenUtil.sign(new User(user.getPhone(),s));
        HashMap<String,Object> hs =new HashMap<>();
        hs.put("token",token);
        hs.put("userid",users.getId());
        hs.put("userName",users.getLoginName());
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),"登录成功",hs);

    }

    /**
     * 用户注册
     * @param user
     * @return
     */
    @PostMapping("register")
    @ResponseBody
    public OutputObject addUser(@RequestBody User user) {
        try {
            // 查询用户名是否存在
            QueryWrapper<User> queryWrapper = new QueryWrapper<>();
            QueryWrapper<User> loginName = queryWrapper.eq("Login_Name", user.getLoginName());
            QueryWrapper<User> phone = queryWrapper.eq("Phone", user.getPhone());
            User one = userService.getOne(loginName);
            User one1 = userService.getOne(phone);
            if (one!=null){
                return new OutputObject(String.valueOf(HttpStatus.OK.value()),"该用户名已存在",null);
            }else if (one1!=null){
                return new OutputObject(String.valueOf(HttpStatus.OK.value()),"该用户已注册",null);
            }
            // 设置盐
            String salt = UUIDUtils.getUUID();
            user.setSalt(salt);
            // 设置密码加密
            String s = MD5Utils.md5(user.getPassword()+salt);
            // 设置用户默认头像
            user.setPassword(s);
//            user.setHeadImg(ReturnCode.DEFAULT_IMG_USER);
            userService.save(user);
            Integer id = user.getId();
            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"注册成功",id);
        } catch (Exception e) {
            e.printStackTrace();
            return new OutputObject(String.valueOf(HttpStatus.OK.value()),"该用户已注册",null);
        }
    }
//    @RequestMapping("/index")
//    public String index() {
//        return "Hello World! 欢迎来到 spring boot application";
//    }
    /**
     * 查询用户信息
     *
     * @param id
     * @return
     */
  @GetMapping("/getUserById/{id}")
   public OutputObject getUserById(@PathVariable Integer id){
       User byId = userService.getById(id);
      HashMap<String,Object> hs =new HashMap<>();
      hs.put("id",byId.getId());
      hs.put("loginName",byId.getLoginName());
      hs.put("realName",byId.getRealName());
      hs.put("phone",byId.getPhone());
      hs.put("sex",byId.getSex());
      hs.put("xueLi",byId.getXueLi());
      hs.put("zhiCheng",byId.getZhiCheng());
      hs.put("email",byId.getEmail());
      hs.put("img",byId.getImg());
      hs.put("danWei",byId.getDanWei());
      hs.put("zhengHao",byId.getZhengHao());
       return new OutputObject(String.valueOf(HttpStatus.OK.value()),"查询成功",hs);
  }


    /**
     * 修改用户信息
     *
     * @param user
     * @return
     */
    @PutMapping("/updateUser")
    public OutputObject updateUser(@RequestBody User user){
        try {
            userService.updateById(user);
        } catch (Exception e) {
            throw new CustomException("修改用户失败",0);
        }
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),"修改成功","修改用户信息成功");
    }


    /**
     * 查询学历分类列表
     *
     * @param
     * @return
     */
    @GetMapping("/getXueLiList")
    public OutputObject getXueLiList(){
        List<XueLi> list = xueLiService.list();
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),"查询成功",list);
    }

    /**
     * 用户头像上传
     *
     * @param
     * @return
     */
    @PostMapping("/upload")
    public OutputObject uploadHeadImg(MultipartFile file) throws IOException {
        return new OutputObject(String.valueOf(HttpStatus.OK.value()),"头像修改成功",uploadUtil.uploadImage(file));
    }
}


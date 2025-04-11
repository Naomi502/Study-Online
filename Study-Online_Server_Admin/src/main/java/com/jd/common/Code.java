package com.jd.common;

public class Code {
    /**
     * 登陆与注册的状态码
     */
    //登录账号不存在
    public final static int LOGIN_USER_ERROR=20001;
    //登录密码错误
    public final static int LOGIN_PASSWORD_ERROR=20002;

    //注册时，账号用户名已存在
    public final static int REGISTER_USER_ERROR=20011;
    //注册时，手机号码已被注册
    public final static int REGISTER_PHONE_ERROR=20012;

    //删除购物车的时候，传过来的id为空
    public final static int DELETE_CART_IDS=30001;

    //没有token(用户登录信息过期)
    public final static  int AUTHORIZE_TOKEN_ERROR=100001;
    //token验证过期(用户token失效，请重新登录)
    public final static  int AUTHORIZE_TOKEN_EXPIRED=100002;

    //结算商品的时候，结算的商品为空的话，抛出异常；
    public final static  int CARD_NULL_ERROR=400001;

    //上传头像异常
    public final static  int UPLOAD_HEADPORTRAIT_ERROR=500001;

    public final static  int UPDATE_USERINFO_ERROR=500002;

}

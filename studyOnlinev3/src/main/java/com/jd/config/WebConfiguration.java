package com.jd.config;

import com.jd.config.interceptor.TokenInterceptor;
import org.mybatis.logging.Logger;
import org.mybatis.logging.LoggerFactory;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.concurrent.ConcurrentTaskExecutor;
import org.springframework.web.servlet.config.annotation.AsyncSupportConfigurer;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Executors;

/**
 * 跨域请求支持/token拦截
 * tip:只能写在一个配置类里
 */
@Configuration
public class WebConfiguration implements WebMvcConfigurer {

    private TokenInterceptor tokenInterceptor;

    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    //构造方法
    public WebConfiguration(TokenInterceptor tokenInterceptor){
        this.tokenInterceptor = tokenInterceptor;
    }

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowCredentials(true)
                .allowedHeaders("*")
                .maxAge(3600)
                .allowedMethods("GET","POST","DELETE","PUT")
                .allowedOriginPatterns("*");
//        logger.info("====解决跨域问题成功！！！====");

    }

    @Override
    public void configureAsyncSupport(AsyncSupportConfigurer configurer){
        configurer.setTaskExecutor(new ConcurrentTaskExecutor(Executors.newFixedThreadPool(3)));
        configurer.setDefaultTimeout(30000);
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry){
        List<String> excludePath = new ArrayList<>();
        // 排除拦截
        excludePath.add("/user/login");  //登录
        excludePath.add("/user/register");  //注册
        excludePath.add("/lesson/getHotCategory");  //获取热门课程分类
        excludePath.add("/lesson/getLessons/**");  //查询热门课程
        excludePath.add("/lesson/getLessonTreeById/**");  //查询课程列表
        excludePath.add("/lesson/getLessonDetail");  //查询课程详情
        excludePath.add("/lesson/searchLesson"); //分页搜索商品
        excludePath.add("/score/addScore"); //注册添加积分
        excludePath.add("/myLesson/getMyLesson");
        excludePath.add(("/news/**"));
        excludePath.add("/webjars/**");
        excludePath.add("/static/**");  //静态资源
        excludePath.add("/assets/**");  //静态资源
//        logger.info("====通过登录拦截器====");
        registry.addInterceptor(tokenInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns(excludePath);
        WebMvcConfigurer.super.addInterceptors(registry);
    }
}

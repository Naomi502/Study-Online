package com.jd.config;

import com.baomidou.mybatisplus.extension.plugins.PaginationInterceptor;
import org.mybatis.logging.Logger;
import org.mybatis.logging.LoggerFactory;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @Author: zhushaojie
 * @Date: 2019/11/23 19:16
 */
@Configuration
@ConditionalOnClass(value = {PaginationInterceptor.class})
public class MybatisPlusConfig {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Bean
    public PaginationInterceptor paginationInterceptor() {
//        logger.info("====Mybatis Plus====");
        return new PaginationInterceptor();
    }
}

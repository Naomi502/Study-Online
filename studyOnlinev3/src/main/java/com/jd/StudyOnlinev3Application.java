package com.jd;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
@MapperScan(basePackages = {"com.jd*.mapper"})
public class StudyOnlinev3Application {

    public static void main(String[] args) {
        SpringApplication.run(StudyOnlinev3Application.class, args);
    }

}

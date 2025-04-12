package com.jd.common;

import lombok.Data;

/**
 * 自定义业务异常
 */
@Data
public class CustomException extends RuntimeException {
//    private String message;
    private Integer code;

    public CustomException(String message, Integer code){
        super(message);
        this.code = code;
    }


    public CustomException(String message){
        super(message);
    }

//    public CustomException(String message, Integer code){
//        super(message);
//        this.code=code;
//    }


    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

}

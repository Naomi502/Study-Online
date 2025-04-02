package com.jd.common;


import java.util.UUID;

/**
 * @author zsj
 * @version 1.0
 * @className com.deyi.govaffair.util.UUIDUtils
 * @date: 2019/8/20 10:36
 * @description TODO
 */
public class UUIDUtils {

    public static String getUUID() {
        return UUID.randomUUID().toString().replace("-","");
    }

    public static void main(String[] args) {
        System.out.println(getUUID());
    }
}

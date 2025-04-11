package com.jd.common;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

@Data
public class PageInfo<T> implements Serializable {
    Integer page;
    Integer pageSize;
    Integer total;
    List<T> data;

}

package com.jd.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LessonQuery {
    private Integer page;
    private Integer pageSize;
    private String lName; // 课程名称
    private Long lessonTypeId; // 课程类型ID
    private String tName; // 教师名称
}

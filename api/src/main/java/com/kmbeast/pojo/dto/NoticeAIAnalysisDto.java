package com.kmbeast.pojo.dto;

import lombok.Data;

@Data  // 确保有这个注解
public class NoticeAIAnalysisDto {
    private Long id;
    private String title;
    private String content;
}
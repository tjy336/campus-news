package com.kmbeast.pojo.dto;

import lombok.Data;
import java.util.List;

@Data  // 确保有这个注解
public class NoticeQualityResultDto {
    private Integer score;
    private String level;
    private List<String> suggestions;
}
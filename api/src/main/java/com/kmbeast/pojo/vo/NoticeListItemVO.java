package com.kmbeast.pojo.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 公告列表项VO类
 */
@Data
public class NoticeListItemVO {
    /**
     * 公告ID
     */
    private Integer id;
    /**
     * 公告标题
     */
    private String title;
    /**
     * 发布时间
     */
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy/MM/dd HH:mm:ss")
    private LocalDateTime createTime;
}

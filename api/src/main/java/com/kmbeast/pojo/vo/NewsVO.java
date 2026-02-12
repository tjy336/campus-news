package com.kmbeast.pojo.vo;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 新闻详情VO
 */
@Data
public class NewsVO {

    private Integer id;

    private String title;

    private String content;

    private String cover;

    private String summary;

    private LocalDateTime createTime;

    private Integer newsTypeId;

    private String newsTypeName;

    // ========== 新增字段 ==========

    /**
     * 阅读量
     */
    private Integer readCount;

    /**
     * 点赞量
     */
    private Integer likeCount;

    /**
     * 分类
     */
    private String category;

    /**
     * 图片
     */
    private String image;
}
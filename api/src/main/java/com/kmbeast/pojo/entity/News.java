package com.kmbeast.pojo.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 新闻实体类
 */
@Data
@TableName("news")
public class News {

    @TableId(type = IdType.AUTO)
    private Integer id;

    private String title;

    private String content;

    private String cover;

    private String summary;

    @TableField("news_type_id")
    private Integer newsTypeId;

    @TableField("create_time")
    private LocalDateTime createTime;

    @TableField("is_show")
    private Boolean isShow;

    // ========== 新增字段 ==========

    /**
     * 阅读量
     */
    @TableField("read_count")
    private Integer readCount;

    /**
     * 点赞量
     */
    @TableField("like_count")
    private Integer likeCount;

    /**
     * 分类（用于前端筛选）
     */
    @TableField("category")
    private String category;

    /**
     * 图片URL
     */
    @TableField("image")
    private String image;
}
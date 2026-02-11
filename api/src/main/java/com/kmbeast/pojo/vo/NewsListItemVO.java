package com.kmbeast.pojo.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 新闻列表项VO类
 */
@Data
public class NewsListItemVO {
    /**
     * 新闻ID
     */
    private Integer id;
    /**
     * 新闻标题
     */
    private String title;
    /**
     * 摘要
     */
    private String summary;
    /**
     * 新闻封面
     */
    private String cover;
    /**
     * 所属的类别ID
     */
    private Integer newsTypeId;
    /**
     * 所属模块
     */
    private String newsTypeName;
    /**
     * 展出状态
     */
    private Boolean isShow;
    /**
     * 阅读量
     */
    private Integer viewCount;
    /**
     * 收藏量
     */
    private Integer collectionCount;
    /**
     * 点赞量
     */
    private Integer upvoteCount;
    /**
     * 发布时间
     */
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy/MM/dd HH:mm:ss")
    private LocalDateTime createTime;
}

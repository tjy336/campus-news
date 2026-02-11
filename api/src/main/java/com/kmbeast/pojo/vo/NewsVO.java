package com.kmbeast.pojo.vo;

import com.kmbeast.pojo.entity.News;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 新闻VO类
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class NewsVO extends News {
    /**
     * 新闻类别名
     */
    private String newsTypeName;
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
}

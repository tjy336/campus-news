package com.kmbeast.pojo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 新闻实体，关联数据库 news 表
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "news")
public class News {
    /**
     * 新闻ID
     */
    @TableId(type = IdType.AUTO)
    private Integer id;
    /**
     * 新闻类别ID
     */
    private Integer newsTypeId;
    /**
     * 标题
     */
    private String title;
    /**
     * 摘要
     */
    private String summary;
    /**
     * 内容
     */
    private String content;
    /**
     * 封面
     */
    private String cover;
    /**
     * 是否展示
     */
    private Boolean isShow;
    /**
     * 发布时间
     */
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
}

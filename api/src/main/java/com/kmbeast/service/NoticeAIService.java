package com.kmbeast.service;

import com.kmbeast.pojo.dto.NoticeAIAnalysisDto;
import com.kmbeast.pojo.dto.NoticeQualityResultDto;
import java.util.List;
import java.util.Map;

public interface NoticeAIService {

    /**
     * 智能分类
     */
    String autoClassify(String title, String content);

    /**
     * 提取关键词
     */
    List<String> extractKeywords(String content);

    /**
     * 质量检测
     */
    NoticeQualityResultDto checkQuality(String title, String content);

    /**
     * 智能摘要
     */
    String generateSummary(String content);

    /**
     * 完整AI分析
     */
    Map<String, Object> fullAnalysis(NoticeAIAnalysisDto dto);

    /**
     * 保存分析结果到数据库
     */
    void analyzeAndSave(Long id);
}
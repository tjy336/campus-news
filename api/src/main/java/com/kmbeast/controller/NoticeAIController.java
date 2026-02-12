package com.kmbeast.controller;

import com.kmbeast.pojo.api.Result;
import com.kmbeast.pojo.dto.NoticeAIAnalysisDto;
import com.kmbeast.pojo.dto.NoticeQualityResultDto;
import com.kmbeast.service.NoticeAIService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/notice/ai")
public class NoticeAIController {

    @Resource
    private NoticeAIService noticeAIService;

    /**
     * 完整AI分析
     */
    @PostMapping("/analyze")
    public Result<Map<String, Object>> analyze(@RequestBody NoticeAIAnalysisDto dto) {
        try {
            Map<String, Object> data = noticeAIService.fullAnalysis(dto);
            return Result.success(data);
        } catch (Exception e) {
            return Result.error("AI分析失败：" + e.getMessage());
        }
    }

    /**
     * 质量检测
     */
    @PostMapping("/quality-check")
    public Result<NoticeQualityResultDto> qualityCheck(@RequestBody NoticeAIAnalysisDto dto) {
        try {
            NoticeQualityResultDto data = noticeAIService.checkQuality(
                    dto.getTitle(),
                    dto.getContent()
            );
            return Result.success(data);
        } catch (Exception e) {
            return Result.error("质量检测失败：" + e.getMessage());
        }
    }

    /**
     * 智能分类
     */
    @PostMapping("/classify")
    public Result<String> classify(@RequestBody NoticeAIAnalysisDto dto) {
        try {
            String category = noticeAIService.autoClassify(dto.getTitle(), dto.getContent());
            return Result.success(category);
        } catch (Exception e) {
            return Result.error("分类失败：" + e.getMessage());
        }
    }

    /**
     * 提取关键词
     */
    @PostMapping("/keywords")
    public Result<List<String>> extractKeywords(@RequestBody NoticeAIAnalysisDto dto) {
        try {
            List<String> keywords = noticeAIService.extractKeywords(dto.getContent());
            return Result.success(keywords);
        } catch (Exception e) {
            return Result.error("关键词提取失败：" + e.getMessage());
        }
    }

    /**
     * 智能摘要
     */
    @PostMapping("/summary")
    public Result<String> summary(@RequestBody NoticeAIAnalysisDto dto) {
        try {
            String summary = noticeAIService.generateSummary(dto.getContent());
            return Result.success(summary);
        } catch (Exception e) {
            return Result.error("摘要生成失败：" + e.getMessage());
        }
    }
}
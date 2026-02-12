package com.kmbeast.service.impl;

import com.alibaba.fastjson.JSON;
import com.kmbeast.mapper.NoticeMapper;
import com.kmbeast.pojo.dto.NoticeAIAnalysisDto;
import com.kmbeast.pojo.dto.NoticeQualityResultDto;
import com.kmbeast.pojo.entity.Notice;
import com.kmbeast.service.NoticeAIService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Service
public class NoticeAIServiceImpl implements NoticeAIService {

    @Autowired
    private NoticeMapper noticeMapper;

    // ==================== 分类关键词 ====================
    private static final Map<String, List<String>> CATEGORY_KEYWORDS = new LinkedHashMap<>();

    static {
        CATEGORY_KEYWORDS.put("教学通知", Arrays.asList("考试", "成绩", "课程", "教学", "教室", "老师", "教授", "学分", "选课", "教材"));
        CATEGORY_KEYWORDS.put("行政通知", Arrays.asList("会议", "文件", "通知", "审批", "盖章", "办公室", "行政", "财务", "报销", "人事"));
        CATEGORY_KEYWORDS.put("校园活动", Arrays.asList("活动", "比赛", "讲座", "文艺", "社团", "晚会", "运动会", "招聘", "宣讲会", "志愿"));
        CATEGORY_KEYWORDS.put("后勤服务", Arrays.asList("食堂", "宿舍", "维修", "水电", "网络", "校园卡", "空调", "浴室", "门禁", "医疗"));
        CATEGORY_KEYWORDS.put("紧急通知", Arrays.asList("紧急", "重要", "立即", "马上", "速", "务必", "暂停", "取消", "调整", "变更"));
    }

    @Override
    public String autoClassify(String title, String content) {
        if (title == null) title = "";
        if (content == null) content = "";

        String text = (title + " " + content).toLowerCase();

        // 优先匹配紧急通知
        for (String keyword : CATEGORY_KEYWORDS.get("紧急通知")) {
            if (text.contains(keyword.toLowerCase())) {
                return "紧急通知";
            }
        }

        // 其他分类计分
        Map<String, Integer> scores = new HashMap<>();
        for (Map.Entry<String, List<String>> entry : CATEGORY_KEYWORDS.entrySet()) {
            int score = 0;
            for (String keyword : entry.getValue()) {
                if (text.contains(keyword.toLowerCase())) {
                    score++;
                }
            }
            scores.put(entry.getKey(), score);
        }

        // 返回分数最高的分类
        String category = scores.entrySet().stream()
                .max(Map.Entry.comparingByValue())
                .map(Map.Entry::getKey)
                .orElse("其他通知");

        return category;
    }

    @Override
    public List<String> extractKeywords(String content) {
        if (content == null || content.trim().isEmpty()) {
            return new ArrayList<>();
        }

        // 去除HTML标签
        String plainText = content.replaceAll("<[^>]*>", " ")
                .replaceAll("\\s+", " ")
                .trim();

        List<String> words = new ArrayList<>();

        // 提取中文词（2字以上）
        Pattern chinesePattern = Pattern.compile("[\\u4e00-\\u9fa5]{2,}");
        java.util.regex.Matcher chineseMatcher = chinesePattern.matcher(plainText);
        while (chineseMatcher.find()) {
            words.add(chineseMatcher.group());
        }

        // 提取英文词
        Pattern englishPattern = Pattern.compile("[a-zA-Z]{3,}");
        java.util.regex.Matcher englishMatcher = englishPattern.matcher(plainText);
        while (englishMatcher.find()) {
            words.add(englishMatcher.group().toLowerCase());
        }

        // 停用词
        List<String> stopWords = Arrays.asList("这个", "那个", "可以", "我们", "你们", "他们", "因为", "所以", "但是", "还是");

        // 统计词频
        Map<String, Integer> wordFreq = new HashMap<>();
        for (String word : words) {
            if (word.length() >= 2 && !stopWords.contains(word)) {
                wordFreq.put(word, wordFreq.getOrDefault(word, 0) + 1);
            }
        }

        // 返回前5个高频词
        return wordFreq.entrySet().stream()
                .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
                .limit(5)
                .map(Map.Entry::getKey)
                .collect(Collectors.toList());
    }

    @Override
    public NoticeQualityResultDto checkQuality(String title, String content) {
        NoticeQualityResultDto result = new NoticeQualityResultDto();
        int score = 100;
        List<String> suggestions = new ArrayList<>();

        // 标题检测
        if (title == null || title.trim().isEmpty()) {
            score -= 30;
            suggestions.add("标题不能为空");
        } else {
            int titleLen = title.trim().length();
            if (titleLen < 5) {
                score -= 15;
                suggestions.add("标题过短（" + titleLen + "字），建议不少于5个字");
            } else if (titleLen > 50) {
                score -= 10;
                suggestions.add("标题过长（" + titleLen + "字），建议精简到50字以内");
            } else {
                suggestions.add("标题长度合适");
            }
        }

        // 内容检测
        if (content == null || content.trim().isEmpty()) {
            score -= 50;
            suggestions.add("内容不能为空");
        } else {
            String plainText = content.replaceAll("<[^>]*>", "")
                    .replaceAll("\\s+", "")
                    .trim();
            int contentLen = plainText.length();

            if (contentLen < 50) {
                score -= 25;
                suggestions.add("内容过短（" + contentLen + "字），建议补充详细信息");
            } else if (contentLen < 100) {
                score -= 10;
                suggestions.add("内容长度尚可，建议丰富到100字以上");
            } else if (contentLen > 5000) {
                score -= 5;
                suggestions.add("内容较长，建议适当分段");
            } else {
                suggestions.add("内容长度合适（" + contentLen + "字）");
            }

            // 段落检测
            int paragraphCount = content.split("<p>|<br>|\\n|\\r\\n").length;
            if (paragraphCount < 2) {
                score -= 10;
                suggestions.add("建议使用分段，提高可读性");
            }
        }

        // 最终评分
        if (score < 0) score = 0;
        if (score > 100) score = 100;

        result.setScore(score);
        result.setSuggestions(suggestions);

        // 等级评定
        if (score >= 85) {
            result.setLevel("优秀");
        } else if (score >= 70) {
            result.setLevel("良好");
        } else if (score >= 60) {
            result.setLevel("合格");
        } else {
            result.setLevel("需要改进");
        }

        return result;
    }

    @Override
    public String generateSummary(String content) {
        if (content == null || content.trim().isEmpty()) {
            return "暂无内容";
        }

        String plainText = content.replaceAll("<[^>]*>", " ")
                .replaceAll("\\s+", " ")
                .trim();

        if (plainText.length() <= 100) {
            return plainText;
        }

        String summary = plainText.substring(0, 100);

        // 在完整句子处截断
        int lastPeriod = summary.lastIndexOf("。");
        int lastQuestion = summary.lastIndexOf("？");
        int lastExclamation = summary.lastIndexOf("！");

        int cutIndex = Math.max(Math.max(lastPeriod, lastQuestion), lastExclamation);
        if (cutIndex > 30) {
            summary = summary.substring(0, cutIndex + 1);
        }

        return summary + "...";
    }

    @Override
    public Map<String, Object> fullAnalysis(NoticeAIAnalysisDto dto) {
        Map<String, Object> result = new HashMap<>();

        result.put("category", autoClassify(dto.getTitle(), dto.getContent()));
        result.put("keywords", extractKeywords(dto.getContent()));
        result.put("summary", generateSummary(dto.getContent()));
        result.put("quality", checkQuality(dto.getTitle(), dto.getContent()));

        return result;
    }

    @Override
    @Transactional
    public void analyzeAndSave(Long id) {
        Notice notice = noticeMapper.selectById(id);
        if (notice == null) {
            throw new RuntimeException("公告不存在");
        }

        // 注意：这里需要先在Notice实体类中添加这些字段！
        // 先注释掉，等实体类添加完字段再取消注释
        /*
        String category = autoClassify(notice.getTitle(), notice.getContent());
        List<String> keywords = extractKeywords(notice.getContent());
        String summary = generateSummary(notice.getContent());
        NoticeQualityResultDto quality = checkQuality(notice.getTitle(), notice.getContent());

        notice.setAiCategory(category);
        notice.setAiKeywords(JSON.toJSONString(keywords));
        notice.setAiSummary(summary);
        notice.setQualityScore(quality.getScore());
        notice.setQualityLevel(quality.getLevel());
        notice.setAnalyzeTime(new Date());

        noticeMapper.updateById(notice);
        */
    }
}
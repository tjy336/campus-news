package com.kmbeast.controller;

import com.kmbeast.aop.Pager;
import com.kmbeast.pojo.api.Result;
import com.kmbeast.pojo.dto.NewsQueryDto;
import com.kmbeast.pojo.entity.News;
import com.kmbeast.pojo.vo.NewsListItemVO;
import com.kmbeast.pojo.vo.NewsVO;
import com.kmbeast.pojo.vo.OptionsVO;
import com.kmbeast.service.NewsService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 新闻控制器
 */
@RestController
@RequestMapping("/news")
public class NewsController {

    @Resource
    private NewsService newsService;

    /**
     * 新增
     */
    @PostMapping("/saveEntity")
    public Result<String> saveEntity(@RequestBody News news) {
        return newsService.saveEntity(news);
    }

    /**
     * 修改
     */
    @PutMapping("/updateEntity")
    public Result<String> updateEntity(@RequestBody News news) {
        return newsService.updateEntity(news);
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete/{id}")
    public Result<String> deleteEntity(@PathVariable Integer id) {
        return newsService.deleteByNewsId(id);
    }

    /**
     * 通过ID查询详情
     */
    @GetMapping("/{id}")
    public Result<NewsVO> getByNewsId(@PathVariable Integer id) {
        return newsService.getByNewsId(id);
    }

    /**
     * 查询新闻列表
     */
    @Pager
    @PostMapping("/list")
    public Result<List<NewsListItemVO>> list(@RequestBody NewsQueryDto newsQueryDto) {
        return newsService.list(newsQueryDto);
    }

    /**
     * 查询用户收藏的新闻信息
     */
    @Pager
    @PostMapping("/collectionList")
    public Result<List<NewsListItemVO>> collectionList(@RequestBody NewsQueryDto newsQueryDto) {
        return newsService.collectionList(newsQueryDto);
    }

    /**
     * 修改新闻的展出状态
     */
    @Pager
    @PutMapping("/setShowStatus")
    public Result<String> setShowStatus(@RequestBody News news) {
        return newsService.setShowStatus(news);
    }

    /**
     * 查询新闻类型数据
     */
    @GetMapping("/types")
    public Result<List<OptionsVO>> types() {
        return newsService.types();
    }

    /**
     * 查询推荐的新闻
     */
    @GetMapping("/recommend/{count}")
    public Result<List<NewsListItemVO>> recommend(@PathVariable Integer count) {
        return newsService.recommend(count);
    }

    /**
     * 获取最热新闻
     */
    @GetMapping("/hot")
    public Result<List<NewsListItemVO>> getHotNews() {
        return newsService.getHotNews();
    }

    /**
     * 按分类获取新闻
     */
    @GetMapping("/category/{category}")
    public Result<List<NewsListItemVO>> getNewsByCategory(@PathVariable String category) {
        return newsService.getNewsByCategory(category);
    }

    /**
     * 增加新闻阅读量
     */
    @PutMapping("/incrementReadCount/{id}")
    public Result<String> incrementReadCount(@PathVariable Integer id) {
        return newsService.incrementReadCount(id);
    }
}
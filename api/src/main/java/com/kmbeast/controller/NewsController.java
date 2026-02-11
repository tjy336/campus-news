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
     *
     * @param news 实体数据
     * @return Result<String>
     */
    @PostMapping(value = "/saveEntity")
    @ResponseBody
    public Result<String> saveEntity(@RequestBody News news) {
        return newsService.saveEntity(news);
    }

    /**
     * 修改
     *
     * @param news 实体数据
     * @return Result<String>
     */
    @PutMapping(value = "/updateEntity")
    @ResponseBody
    public Result<String> updateEntity(@RequestBody News news) {
        return newsService.updateEntity(news);
    }

    /**
     * 删除
     *
     * @param id 新闻ID
     * @return Result<String>
     */
    @DeleteMapping(value = "/{id}")
    @ResponseBody
    public Result<String> updateEntity(@PathVariable Integer id) {
        return newsService.deleteByNewsId(id);
    }

    /**
     * 通过ID查询详情
     *
     * @param id 新闻ID
     * @return Result<NewsVO> 响应结果
     */
    @GetMapping(value = "/{id}")
    @ResponseBody
    public Result<NewsVO> getByNewsId(@PathVariable Integer id) {
        return newsService.getByNewsId(id);
    }

    /**
     * 查询新闻列表数据
     *
     * @param newsQueryDto 查询参数
     * @return Result<List < NewsListItemVO>> 响应结果
     */
    @Pager
    @PostMapping(value = "/list")
    @ResponseBody
    public Result<List<NewsListItemVO>> list(@RequestBody NewsQueryDto newsQueryDto) {
        return newsService.list(newsQueryDto);
    }

    /**
     * 查询用户收藏的新闻信息
     *
     * @param newsQueryDto 查询参数
     * @return Result<List < NewsListItemVO>> 响应结果
     */
    @Pager
    @PostMapping(value = "/collectionList")
    @ResponseBody
    public Result<List<NewsListItemVO>> collectionList(@RequestBody NewsQueryDto newsQueryDto) {
        return newsService.collectionList(newsQueryDto);
    }

    /**
     * 修改新闻的展出状态
     *
     * @param news 实体
     * @return Result<String> 响应结果
     */
    @Pager
    @PutMapping(value = "/setShowStatus")
    @ResponseBody
    public Result<String> setShowStatus(@RequestBody News news) {
        return newsService.setShowStatus(news);
    }

    /**
     * 查询新闻类型数据
     *
     * @return Result<List < OptionsVO>> 响应结果
     */
    @GetMapping(value = "/types")
    @ResponseBody
    public Result<List<OptionsVO>> types() {
        return newsService.types();
    }


    /**
     * 查询推荐的新闻
     *
     * @param count 查询的条数
     * @return Result<List < NewsListItemVO>> 响应结果
     */
    @GetMapping(value = "/recommend/{count}")
    @ResponseBody
    public Result<List<NewsListItemVO>> recommend(@PathVariable Integer count) {
        return newsService.recommend(count);
    }

}


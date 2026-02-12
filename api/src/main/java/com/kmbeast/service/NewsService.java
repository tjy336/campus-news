package com.kmbeast.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.kmbeast.pojo.api.Result;
import com.kmbeast.pojo.dto.NewsQueryDto;
import com.kmbeast.pojo.entity.News;
import com.kmbeast.pojo.vo.NewsListItemVO;
import com.kmbeast.pojo.vo.NewsVO;
import com.kmbeast.pojo.vo.OptionsVO;

import java.util.List;

/**
 * 新闻业务逻辑接口
 */
public interface NewsService extends IService<News> {

    Result<String> saveEntity(News news);

    Result<String> updateEntity(News news);

    Result<String> deleteByNewsId(Integer id);

    Result<NewsVO> getByNewsId(Integer id);

    Result<List<NewsListItemVO>> list(NewsQueryDto newsQueryDto);

    Result<List<OptionsVO>> types();

    Result<String> setShowStatus(News news);

    Result<List<NewsListItemVO>> collectionList(NewsQueryDto newsQueryDto);

    Result<List<NewsListItemVO>> recommend(Integer count);

    /**
     * ========== 新增接口 ==========
     */

    /**
     * 获取最热新闻（按阅读量排序）
     * @return Result<List<NewsListItemVO>> 最热新闻列表
     */
    Result<List<NewsListItemVO>> getHotNews();

    /**
     * 按分类获取新闻
     * @param category 分类名称
     * @return Result<List<NewsListItemVO>> 分类新闻列表
     */
    Result<List<NewsListItemVO>> getNewsByCategory(String category);

    /**
     * 增加新闻阅读量
     * @param id 新闻ID
     * @return Result<String> 操作结果
     */
    Result<String> incrementReadCount(Integer id);
}
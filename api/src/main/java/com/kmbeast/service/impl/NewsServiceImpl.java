package com.kmbeast.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.kmbeast.context.LocalThreadHolder;
import com.kmbeast.mapper.ActionOperationMapper;
import com.kmbeast.mapper.NewsMapper;
import com.kmbeast.pojo.api.ApiResult;
import com.kmbeast.pojo.api.Result;
import com.kmbeast.pojo.dto.ActionOperationQueryDto;
import com.kmbeast.pojo.dto.NewsQueryDto;
import com.kmbeast.pojo.em.NewsTypeEnum;
import com.kmbeast.pojo.em.RoleEnum;
import com.kmbeast.pojo.entity.ActionOperation;
import com.kmbeast.pojo.entity.News;
import com.kmbeast.pojo.vo.NewsListItemVO;
import com.kmbeast.pojo.vo.NewsVO;
import com.kmbeast.pojo.vo.OptionsVO;
import com.kmbeast.pojo.vo.ScoreVO;
import com.kmbeast.service.NewsService;
import com.kmbeast.utils.AssertUtils;
import com.kmbeast.utils.UserBasedCFUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 新闻业务逻辑接口实现类
 */
@Service
public class NewsServiceImpl extends ServiceImpl<NewsMapper, News> implements NewsService {

    private final static Boolean IS_SHOW = true; // 展示位
    //    private final static Boolean IS_HIDDEN = false; // 隐藏位
    private final static Integer VIEW_OPERATION = 3; // 收藏行为类型

    @Resource
    private ActionOperationMapper actionOperationMapper;


    /**
     * 参数校验
     *
     * @param news 实体
     */
    private void validParam(News news) {
        AssertUtils.notNull(news, "新闻不能为空");
        AssertUtils.notNull(news.getNewsTypeId(), "新闻类别不能为空");
        AssertUtils.hasText(news.getTitle(), "新闻标题不能为空");
        AssertUtils.hasText(news.getCover(), "封面必须上传");
        AssertUtils.hasText(news.getSummary(), "摘要必须上传");
        // 内容的字数限制
        AssertUtils.isTrue(news.getTitle().length() < 30, "标题请控制在30字以内");
        AssertUtils.isTrue(news.getSummary().length() < 200, "摘要请控制在200字以内");
    }

    /**
     * 新闻新增
     *
     * @param news 实体
     * @return Result<String>
     */
    public Result<String> saveEntity(News news) {
        // 参数校验
        validParam(news);
        // 初始值设置
//        news.setIsShow(IS_SHOW); // 管理员最新发布的新闻，默认是展示状态
        news.setCreateTime(LocalDateTime.now()); // 设置发布时间
        // 管理员才有权限进行新闻的新增
        AssertUtils.validAuth(RoleEnum.ADMIN.getRole());
        // 新闻新增操作
        save(news);
        return ApiResult.success();
    }

    /**
     * 新闻修改
     *
     * @param news 实体
     * @return Result<String>
     */
    @Override
    public Result<String> updateEntity(News news) {
        // 参数校验
        validParam(news);
        // 管理员才有权限进行新闻的修改
        AssertUtils.validAuth(RoleEnum.ADMIN.getRole());
        // 修改新闻信息
        updateById(news);
        return ApiResult.success();
    }

    /**
     * 通过新闻ID删除新闻
     *
     * @param id 主键ID
     * @return Result<String>
     */
    @Override
    public Result<String> deleteByNewsId(Integer id) {
        AssertUtils.notNull(id, "ID不能为空");
        // 管理员才有权限进行新闻的删除
        AssertUtils.validAuth(RoleEnum.ADMIN.getRole());
        removeById(id);
        return ApiResult.success();
    }

    /**
     * 通过新闻ID查询新闻详情
     *
     * @param id 主键ID
     * @return Result<NewsVO>
     */
    @Override
    public Result<NewsVO> getByNewsId(Integer id) {
        AssertUtils.notNull(id, "ID不能为空");
        NewsVO newsVO = this.baseMapper.getById(id);
        AssertUtils.notNull(newsVO, "新闻数据不存在");
        newsVO.setNewsTypeName(
                NewsTypeEnum.getNameById(newsVO.getNewsTypeId())
        ); // 设置新闻类别名

        // 增加阅读量
        try {
            News news = this.baseMapper.selectById(id);
            if (news != null) {
                news.setReadCount(news.getReadCount() == null ? 1 : news.getReadCount() + 1);
                this.baseMapper.updateById(news);
                newsVO.setReadCount(news.getReadCount());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ApiResult.success(newsVO);
    }

    /**
     * 查询新闻列表
     *
     * @param newsQueryDto 新闻查询条件类
     * @return Result<List < NewsListItemVO>>
     */
    @Override
    public Result<List<NewsListItemVO>> list(NewsQueryDto newsQueryDto) {
        AssertUtils.notNull(newsQueryDto, "查询条件不能为空");
        // 用户查询列表，只能查管理员选择展出的内容;管理员不需要设置
        if (!RoleEnum.ADMIN.getRole().equals(LocalThreadHolder.getRoleId())) {
            newsQueryDto.setIsShow(IS_SHOW);
        }
        AssertUtils.notNull(newsQueryDto.getCurrent(), "当前页不能为空");
        AssertUtils.notNull(newsQueryDto.getSize(), "页面大小不能为空");
        List<NewsListItemVO> newsListItemVOS = this.baseMapper.list(newsQueryDto);
        Integer count = this.baseMapper.listPageCount(newsQueryDto);
        // 处理新闻类别
        dealNewsTypes(newsListItemVOS);
        return ApiResult.success(newsListItemVOS, count);
    }

    private void dealNewsTypes(List<NewsListItemVO> newsListItemVOS) {
        for (NewsListItemVO newsListItemVO : newsListItemVOS) {
            String name = NewsTypeEnum.getNameById(newsListItemVO.getNewsTypeId());
            newsListItemVO.setNewsTypeName(name);
        }
    }

    /**
     * 查询新闻类型数据
     *
     * @return Result<List < OptionsVO>> 响应结果
     */
    @Override
    public Result<List<OptionsVO>> types() {
        NewsTypeEnum[] newsTypeEnums = NewsTypeEnum.values();
        List<OptionsVO> optionsVOS = new ArrayList<>();
        for (NewsTypeEnum newsTypeEnum : newsTypeEnums) {
            OptionsVO optionsVO = new OptionsVO(
                    newsTypeEnum.getId(),
                    newsTypeEnum.getName()
            );
            optionsVOS.add(optionsVO);
        }
        return ApiResult.success(optionsVOS);
    }

    /**
     * 修改新闻的展出状态
     *
     * @param news 实体
     * @return Result<String> 响应结果
     */
    @Override
    public Result<String> setShowStatus(News news) {
        AssertUtils.notNull(news, "新闻数据不能为空");
        // 管理员才有权限进行新闻的展出或隐藏
        AssertUtils.validAuth(RoleEnum.ADMIN.getRole());
        updateById(news);
        return ApiResult.success();
    }

    /**
     * 查询用户收藏的新闻信息
     *
     * @param newsQueryDto 查询参数
     * @return Result<List < NewsListItemVO>> 响应结果
     */
    @Override
    public Result<List<NewsListItemVO>> collectionList(NewsQueryDto newsQueryDto) {
        ActionOperationQueryDto actionOperationQueryDto = new ActionOperationQueryDto();
        actionOperationQueryDto.setUserId(LocalThreadHolder.getUserId()); // 当前操作者的用户ID
        actionOperationQueryDto.setType(VIEW_OPERATION);
        List<ActionOperation> actionOperations = actionOperationMapper.list(actionOperationQueryDto);
        if (actionOperations.isEmpty()) { // 用户没有收藏任何的新闻信息
            return ApiResult.success();
        }
        // 获取用户收藏的新闻ID列表
        List<Integer> newsIds = actionOperations.stream()
                .map(ActionOperation::getNewsId)
                .collect(Collectors.toList());
        newsQueryDto.setIds(newsIds);
        List<NewsListItemVO> newsListItemVOS = this.baseMapper.list(newsQueryDto);
        Integer count = this.baseMapper.listPageCount(newsQueryDto);
        return ApiResult.success(newsListItemVOS, count);
    }

    /**
     * 查询推荐的新闻
     *
     * @param count 查询的条数
     * @return Result<List < NewsListItemVO>> 响应结果
     */
    @Override
    public Result<List<NewsListItemVO>> recommend(Integer count) {
        // 查询用户对于新闻的“兴趣评分集”
        List<ScoreVO> scoreVOS = actionOperationMapper.getScore();
        // 查询新闻的ID列表
        List<Integer> newsIds = this.baseMapper.getIds();
        if (newsIds.isEmpty()) {
            return ApiResult.success(new ArrayList<>());
        }
        // 评分转成算法工具类里面需要的评分数据集
        List<UserBasedCFUtil.Score> scoreList = scoreVOS.stream().map(
                scoreVO -> new UserBasedCFUtil.Score(
                        scoreVO.getUserId(),
                        scoreVO.getContentId(),
                        scoreVO.getScore()
                )
        ).collect(Collectors.toList());
        // 构建用户对于物品的评分矩阵
        Map<Integer, Map<Integer, Double>> integerMapMap = UserBasedCFUtil.buildUserItemMatrix(
                newsIds,
                scoreList
        );
        UserBasedCFUtil userBasedCFUtil = new UserBasedCFUtil(integerMapMap);
        // 向用户推荐的新闻ID集合
        List<Integer> newsRecommendIds = userBasedCFUtil.recommendItems(
                LocalThreadHolder.getUserId(), // 向该用户推荐 - 当前操作者用户ID
                count
        );
        if (newsRecommendIds.isEmpty()) { // 算不回来，证明用户并未产生对于内容的相关性 - "冷启动"问题
            NewsQueryDto newsQueryDto = new NewsQueryDto();
            newsQueryDto.setCurrent(0); // 从第一条开始
            newsQueryDto.setSize(count); // 页面大小直接用前端传过来的
            newsQueryDto.setSortField("doubleSort"); // 多重排序 - 按照“热度值（阅读、收藏、点赞）”排序
            return ApiResult.success(this.baseMapper.list(newsQueryDto));
        }
        NewsQueryDto newsQueryDto = new NewsQueryDto();
        newsQueryDto.setIds(newsRecommendIds);
        List<NewsListItemVO> newsListItemVOS = this.baseMapper.list(newsQueryDto);
        return ApiResult.success(newsListItemVOS);
    }

    // ====================== 新增接口实现 ======================

    /**
     * 获取最热新闻（按阅读量排序）
     *
     * @return Result<List < NewsListItemVO>> 最热新闻列表
     */
    @Override
    public Result<List<NewsListItemVO>> getHotNews() {
        try {
            QueryWrapper<News> wrapper = new QueryWrapper<>();
            wrapper.orderByDesc("read_count")  // 按阅读量倒序
                    .last("LIMIT 5");          // 取前5条
            List<News> newsList = this.baseMapper.selectList(wrapper);

            // 转换为VO
            List<NewsListItemVO> voList = newsList.stream()
                    .map(this::convertToNewsListItemVO)
                    .collect(Collectors.toList());

            return ApiResult.success(voList);
        } catch (Exception e) {
            e.printStackTrace();
            return ApiResult.error("获取最热新闻失败：" + e.getMessage());
        }
    }

    /**
     * 按分类获取新闻
     *
     * @param category 分类名称
     * @return Result<List < NewsListItemVO>> 分类新闻列表
     */
    @Override
    public Result<List<NewsListItemVO>> getNewsByCategory(String category) {
        try {
            QueryWrapper<News> wrapper = new QueryWrapper<>();
            wrapper.eq("category", category)    // 按分类筛选
                    .orderByDesc("create_time")  // 按时间倒序
                    .last("LIMIT 10");           // 取前10条
            List<News> newsList = this.baseMapper.selectList(wrapper);

            // 转换为VO
            List<NewsListItemVO> voList = newsList.stream()
                    .map(this::convertToNewsListItemVO)
                    .collect(Collectors.toList());

            return ApiResult.success(voList);
        } catch (Exception e) {
            e.printStackTrace();
            return ApiResult.error("获取分类新闻失败：" + e.getMessage());
        }
    }

    /**
     * 增加新闻阅读量
     *
     * @param id 新闻ID
     * @return Result<String> 操作结果
     */
    @Override
    public Result<String> incrementReadCount(Integer id) {
        try {
            News news = this.baseMapper.selectById(id);
            if (news == null) {
                return ApiResult.error("新闻不存在");
            }
            news.setReadCount(news.getReadCount() == null ? 1 : news.getReadCount() + 1);
            this.baseMapper.updateById(news);
            return ApiResult.success("阅读量+1成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ApiResult.error("增加阅读量失败：" + e.getMessage());
        }
    }

    /**
     * 新闻实体转VO
     *
     * @param news 新闻实体
     * @return NewsListItemVO
     */
    private NewsListItemVO convertToNewsListItemVO(News news) {
        if (news == null) {
            return null;
        }
        NewsListItemVO vo = new NewsListItemVO();
        vo.setId(news.getId());
        vo.setTitle(news.getTitle());
        vo.setContent(news.getContent());
        vo.setCover(news.getCover());
        vo.setSummary(news.getSummary());
        vo.setCreateTime(news.getCreateTime());
        vo.setReadCount(news.getReadCount() == null ? 0 : news.getReadCount());
        vo.setLikeCount(news.getLikeCount() == null ? 0 : news.getLikeCount());
        vo.setNewsTypeId(news.getNewsTypeId());
        // 设置新闻类型名称
        if (news.getNewsTypeId() != null) {
            vo.setNewsTypeName(NewsTypeEnum.getNameById(news.getNewsTypeId()));
        }
        // 设置分类（如果数据库有category字段）
        // vo.setCategory(news.getCategory());
        // 设置图片（如果有image字段）
        // vo.setImage(news.getImage());
        return vo;
    }
}
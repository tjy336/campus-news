package com.kmbeast.service.impl;

import com.kmbeast.mapper.*;
import com.kmbeast.pojo.api.ApiResult;
import com.kmbeast.pojo.api.Result;
import com.kmbeast.pojo.dto.*;
import com.kmbeast.pojo.entity.ActionOperation;
import com.kmbeast.pojo.vo.OptionsVO;
import com.kmbeast.service.DashboardService;
import com.kmbeast.utils.AssertUtils;
import com.kmbeast.utils.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 公告业务逻辑接口实现类
 */
@Service
public class DashboardServiceImpl implements DashboardService {

    @Resource
    private UserMapper userMapper;
    @Resource
    private NewsMapper newsMapper;
    @Resource
    private NoticeMapper noticeMapper;
    @Resource
    private EvaluationsMapper evaluationsMapper;
    @Autowired
    private ActionOperationMapper actionOperationMapper;

    /**
     * 查询静态数据
     *
     * @return Result<List < OptionsVO>>
     */
    @Override
    public Result<List<OptionsVO>> countStaticValue() {
        int userCount = userMapper.queryCount(new UserQueryDto());
        int newsCount = newsMapper.listPageCount(new NewsQueryDto());
        int evaluationsCount = evaluationsMapper.queryCount(new EvaluationsQueryDto());
        int noticeCount = noticeMapper.listPageCount(new NoticeQueryDto());
        List<OptionsVO> optionsVOList = new ArrayList<>();
        optionsVOList.add(new OptionsVO(userCount, "用户（人）"));
        optionsVOList.add(new OptionsVO(newsCount, "新闻（篇）"));
        optionsVOList.add(new OptionsVO(evaluationsCount, "评论（条）"));
        optionsVOList.add(new OptionsVO(noticeCount, "公告（篇）"));
        return ApiResult.success(optionsVOList);
    }

    /**
     * 查询新闻选择项
     *
     * @return Result<List < OptionsVO>>
     */
    @Override
    public Result<List<OptionsVO>> newsOptions() {
        List<OptionsVO> newsOptions = newsMapper.listOptions();
        return ApiResult.success(newsOptions);
    }

    /**
     * 查询新闻选择项
     *
     * @return Result<List < OptionsVO>>
     */
    @Override
    public Result<List<OptionsVO>> newsFlowIndex(ActionOperationQueryDto actionOperationQueryDto) {
        // 查询参数校验
        validParam(actionOperationQueryDto);
        // 封装查询时间范围：前端传天数Integer类型 -> LocalDateTime类型的开始时间、结束时间
        QueryDto queryDto = DateUtil.startAndEndTime(actionOperationQueryDto.getDays());
        actionOperationQueryDto.setStartTime(queryDto.getStartTime());
        actionOperationQueryDto.setEndTime(queryDto.getEndTime());
        // 查询指定时间之内的流量数据
        List<ActionOperation> actionOperations = actionOperationMapper.list(actionOperationQueryDto);
        if (actionOperations.isEmpty()) {
            return ApiResult.success(new ArrayList<>());
        }
        List<LocalDateTime> dateTimeList = actionOperations.stream().map(ActionOperation::getCreateTime).collect(Collectors.toList());
        // 封装成折线图所需要的数据格式
        List<OptionsVO> optionsVOS = DateUtil.countDatesRange(actionOperationQueryDto.getDays(), dateTimeList);
        return ApiResult.success(optionsVOS);
    }

    private void validParam(ActionOperationQueryDto actionOperationQueryDto) {
        AssertUtils.notNull(actionOperationQueryDto, "查询不能为空");
        AssertUtils.notNull(actionOperationQueryDto.getNewsId(), "新闻ID不能为空");
        AssertUtils.notNull(actionOperationQueryDto.getType(), "行为类型不能为空");
        AssertUtils.notNull(actionOperationQueryDto.getDays(), "查询天数不能为空");
    }
}

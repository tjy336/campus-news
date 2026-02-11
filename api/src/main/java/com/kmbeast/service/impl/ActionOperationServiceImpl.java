package com.kmbeast.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.kmbeast.context.LocalThreadHolder;
import com.kmbeast.mapper.ActionOperationMapper;
import com.kmbeast.pojo.api.ApiResult;
import com.kmbeast.pojo.api.Result;
import com.kmbeast.pojo.dto.ActionOperationQueryDto;
import com.kmbeast.pojo.entity.ActionOperation;
import com.kmbeast.service.ActionOperationService;
import com.kmbeast.utils.AssertUtils;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 行为操作业务逻辑接口实现类
 */
@Service
public class ActionOperationServiceImpl extends ServiceImpl<ActionOperationMapper, ActionOperation> implements ActionOperationService {

    /**
     * 行为操作：适用于点赞场景、适用于收藏场景
     *
     * @param actionOperation 实体数据
     * @return Result<String>
     */
    @Override
    public Result<String> operation(ActionOperation actionOperation) {
        AssertUtils.notNull(actionOperation,"数据不能为空");
        AssertUtils.notNull(actionOperation.getNewsId(),"新闻ID不能为空");
        AssertUtils.notNull(actionOperation.getType(),"行为类型不能为空");
        // 构建行为操作的查询条件类
        ActionOperationQueryDto actionOperationQueryDto = new ActionOperationQueryDto();
        actionOperationQueryDto.setNewsId(actionOperation.getNewsId());
        actionOperationQueryDto.setType(actionOperation.getType());
        actionOperationQueryDto.setUserId(LocalThreadHolder.getUserId());
        List<ActionOperation> actionOperations = this.baseMapper.list(actionOperationQueryDto);
        if (!actionOperations.isEmpty()) { // 已经存在 -> 删除
            ActionOperation operation = actionOperations.get(0);
            Integer id = operation.getId();
            removeById(id);
            return ApiResult.success();
        }
        return saveEntity(actionOperation);
    }

    /**
     * 新增
     *
     * @param actionOperation 实体
     * @return Result<String>
     */
    @Override
    public Result<String> saveEntity(ActionOperation actionOperation) {
        actionOperation.setCreateTime(LocalDateTime.now()); // 新增时间
        actionOperation.setUserId(LocalThreadHolder.getUserId()); // 操作者用户ID
        save(actionOperation);
        return ApiResult.success();
    }

    /**
     * 查询
     *
     * @param dto 查询条件类
     * @return Result<List < ActionOperation>>
     */
    @Override
    public Result<List<ActionOperation>> listQuery(ActionOperationQueryDto dto) {
        AssertUtils.notNull(dto,"查询条件不能为空");
        AssertUtils.notNull(dto.getNewsId(),"新闻ID不能为空");
        AssertUtils.notNull(dto.getType(),"行为类型不能为空");
        dto.setUserId(LocalThreadHolder.getUserId());
        List<ActionOperation> actionOperations = this.baseMapper.list(dto);
        Integer count = this.baseMapper.listPageCount(dto);
        return ApiResult.success(actionOperations, count);
    }
}

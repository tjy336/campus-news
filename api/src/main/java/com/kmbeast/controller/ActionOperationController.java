package com.kmbeast.controller;

import com.kmbeast.aop.Pager;
import com.kmbeast.pojo.api.Result;
import com.kmbeast.pojo.dto.ActionOperationQueryDto;
import com.kmbeast.pojo.entity.ActionOperation;
import com.kmbeast.service.ActionOperationService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 行为操作信息控制器
 */
@RestController
@RequestMapping("/action-operation")
public class ActionOperationController {

    @Resource
    private ActionOperationService actionOperationService;

    /**
     * 新增
     *
     * @param actionOperation 实体数据
     * @return Result<String>
     */
    @PostMapping(value = "/saveEntity")
    @ResponseBody
    public Result<String> saveEntity(@RequestBody ActionOperation actionOperation) {
        return actionOperationService.saveEntity(actionOperation);
    }

    /**
     * 行为操作：适用于点赞场景、适用于收藏场景
     *
     * @param actionOperation 实体数据
     * @return Result<String>
     */
    @PostMapping(value = "/operation")
    @ResponseBody
    public Result<String> operation(@RequestBody ActionOperation actionOperation) {
        return actionOperationService.operation(actionOperation);
    }

    /**
     * 查询行为操作信息列表数据
     *
     * @param dto 查询参数
     * @return Result<List < ActionOperation>> 响应结果
     */
    @Pager
    @PostMapping(value = "/list")
    @ResponseBody
    public Result<List<ActionOperation>> listQuery(@RequestBody ActionOperationQueryDto dto) {
        return actionOperationService.listQuery(dto);
    }

}


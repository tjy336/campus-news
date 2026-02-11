package com.kmbeast.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.kmbeast.pojo.api.Result;
import com.kmbeast.pojo.dto.ActionOperationQueryDto;
import com.kmbeast.pojo.entity.ActionOperation;

import java.util.List;

/**
 * 行为操作业务逻辑接口
 */
public interface ActionOperationService extends IService<ActionOperation> {

    Result<String> saveEntity(ActionOperation actionOperation);

    Result<List<ActionOperation>> listQuery(ActionOperationQueryDto dto);

    Result<String> operation(ActionOperation actionOperation);

}

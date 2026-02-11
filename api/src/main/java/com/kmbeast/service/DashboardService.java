package com.kmbeast.service;

import com.kmbeast.pojo.api.Result;
import com.kmbeast.pojo.dto.ActionOperationQueryDto;
import com.kmbeast.pojo.vo.OptionsVO;

import java.util.List;

/**
 * 仪表盘业务逻辑接口
 */
public interface DashboardService {

    Result<List<OptionsVO>> countStaticValue();

    Result<List<OptionsVO>> newsOptions();

    Result<List<OptionsVO>> newsFlowIndex(ActionOperationQueryDto actionOperationQueryDto);


}

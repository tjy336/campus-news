package com.kmbeast.controller;

import com.kmbeast.pojo.api.Result;
import com.kmbeast.pojo.dto.ActionOperationQueryDto;
import com.kmbeast.pojo.vo.OptionsVO;
import com.kmbeast.service.DashboardService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 仪表盘控制器
 */
@RestController
@RequestMapping("/dashboard")
public class DashboardController {

    @Resource
    private DashboardService dashboardService;

    /**
     * 查询静态数据
     *
     * @return Result<List < OptionsVO>>
     */
    @GetMapping("/countStaticValue")
    public Result<List<OptionsVO>> countStaticValue() {
        return dashboardService.countStaticValue();
    }

    /**
     * 查询新闻选择项
     *
     * @return Result<List < OptionsVO>>
     */
    @GetMapping("/newsOptions")
    public Result<List<OptionsVO>> newsOptions() {
        return dashboardService.newsOptions();
    }

    /**
     * 查询新闻选择项
     *
     * @return Result<List < OptionsVO>>
     */
    @PostMapping("/newsFlowIndex")
    public Result<List<OptionsVO>> newsFlowIndex(@RequestBody ActionOperationQueryDto actionOperationQueryDto) {
        return dashboardService.newsFlowIndex(actionOperationQueryDto);
    }

}


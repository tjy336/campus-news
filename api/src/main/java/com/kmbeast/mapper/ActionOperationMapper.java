package com.kmbeast.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kmbeast.pojo.dto.ActionOperationQueryDto;
import com.kmbeast.pojo.entity.ActionOperation;
import com.kmbeast.pojo.vo.ScoreVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 行为操作持久化接口
 */
@Mapper
public interface ActionOperationMapper extends BaseMapper<ActionOperation> {

    List<ScoreVO> getScore();

    List<ActionOperation> list(ActionOperationQueryDto dto);

    Integer listPageCount(ActionOperationQueryDto dto);

}

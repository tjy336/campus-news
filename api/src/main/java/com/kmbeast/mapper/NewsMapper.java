package com.kmbeast.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kmbeast.pojo.dto.NewsQueryDto;
import com.kmbeast.pojo.entity.News;
import com.kmbeast.pojo.vo.NewsListItemVO;
import com.kmbeast.pojo.vo.NewsVO;
import com.kmbeast.pojo.vo.OptionsVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 新闻持久化接口
 */
@Mapper
public interface NewsMapper extends BaseMapper<News> {

    NewsVO getById(@Param(value = "id") Integer id);

    List<NewsListItemVO> list(NewsQueryDto newsQueryDto);

    Integer listPageCount(NewsQueryDto newsQueryDto);

    List<OptionsVO> listOptions();

    List<Integer> getIds();

}

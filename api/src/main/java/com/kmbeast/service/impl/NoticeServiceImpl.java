package com.kmbeast.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.kmbeast.mapper.NoticeMapper;
import com.kmbeast.pojo.api.ApiResult;
import com.kmbeast.pojo.api.Result;
import com.kmbeast.pojo.dto.NoticeQueryDto;
import com.kmbeast.pojo.entity.Notice;
import com.kmbeast.pojo.vo.NoticeListItemVO;
import com.kmbeast.service.NoticeService;
import com.kmbeast.utils.AssertUtils;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 公告业务逻辑接口实现类
 */
@Service
public class NoticeServiceImpl extends ServiceImpl<NoticeMapper, Notice> implements NoticeService {

    /**
     * 新增
     *
     * @param notice 实体
     * @return Result<String>
     */
    @Override
    public Result<String> saveEntity(Notice notice) {
        // 先做参数校验
        validParam(notice);
        // 设置公告的新增时间
        notice.setCreateTime(LocalDateTime.now());
        save(notice);
        return ApiResult.success();
    }

    /**
     * 参数校验
     *
     * @param notice 实体数据
     */
    private void validParam(Notice notice) {
        AssertUtils.notNull(notice, "实体数据不为空");
        AssertUtils.hasText(notice.getTitle(), "公告标题不能为空");
        AssertUtils.isTrue(notice.getTitle().length() < 30, "公告标题请控制在30字以内");
    }

    /**
     * 公告修改
     *
     * @param notice 公告信息
     * @return Result<String>
     */
    @Override
    public Result<String> updateEntity(Notice notice) {
        // 先做参数校验
        validParam(notice);
        updateById(notice);
        return ApiResult.success();
    }

    /**
     * 公告删除
     *
     * @param id 主键ID
     * @return Result<String>
     */
    @Override
    public Result<String> deleteByNoticeId(Integer id) {
        AssertUtils.notNull(id, "ID不能为空");
        removeById(id);
        return ApiResult.success();
    }

    /**
     * 通过ID查询公告详情
     *
     * @param id 主键ID
     * @return Result<Notice>
     */
    @Override
    public Result<Notice> getByNoticeId(Integer id) {
        AssertUtils.notNull(id, "ID不能为空");
        Notice notice = getById(id);
        return ApiResult.success(notice);
    }

    /**
     * 查询公告列表
     *
     * @param noticeQueryDto 查询条件类
     * @return Result<List < NoticeListItemVO>>
     */
    @Override
    public Result<List<NoticeListItemVO>> listQuery(NoticeQueryDto noticeQueryDto) {
        AssertUtils.notNull(noticeQueryDto, "查询条件类不能为空");
        AssertUtils.notNull(noticeQueryDto.getCurrent(), "当前页不能为空");
        AssertUtils.notNull(noticeQueryDto.getSize(), "页面大小不能为空");
        List<NoticeListItemVO> noticeListItemVOS = this.baseMapper.list(noticeQueryDto);
        Integer count = this.baseMapper.listPageCount(noticeQueryDto);
        return ApiResult.success(noticeListItemVOS, count);
    }
}

package com.kmbeast.controller;

import com.kmbeast.aop.Pager;
import com.kmbeast.pojo.api.Result;
import com.kmbeast.pojo.dto.NoticeQueryDto;
import com.kmbeast.pojo.entity.Notice;
import com.kmbeast.pojo.vo.NoticeListItemVO;
import com.kmbeast.service.NoticeService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 公告信息控制器
 */
@RestController
@RequestMapping("/notice")
public class NoticeController {

    @Resource
    private NoticeService noticeService;

    /**
     * 新增
     *
     * @param notice 实体数据
     * @return Result<String>
     */
    @PostMapping(value = "/saveEntity")
    @ResponseBody
    public Result<String> saveEntity(@RequestBody Notice notice) {
        return noticeService.saveEntity(notice);
    }

    /**
     * 修改
     *
     * @param notice 实体数据
     * @return Result<String>
     */
    @PutMapping(value = "/updateEntity")
    @ResponseBody
    public Result<String> updateEntity(@RequestBody Notice notice) {
        return noticeService.updateEntity(notice);
    }

    /**
     * 删除
     *
     * @param id 公告信息ID
     * @return Result<String>
     */
    @DeleteMapping(value = "/{id}")
    @ResponseBody
    public Result<String> updateEntity(@PathVariable Integer id) {
        return noticeService.deleteByNoticeId(id);
    }

    /**
     * 通过ID查询详情
     *
     * @param id 公告信息ID
     * @return Result<Notice> 响应结果
     */
    @GetMapping(value = "/{id}")
    @ResponseBody
    public Result<Notice> getByNoticeId(@PathVariable Integer id) {
        return noticeService.getByNoticeId(id);
    }

    /**
     * 查询公告信息列表数据
     *
     * @param noticeQueryDto 查询参数
     * @return Result<List < NoticeListItemVO>> 响应结果
     */
    @Pager
    @PostMapping(value = "/list")
    @ResponseBody
    public Result<List<NoticeListItemVO>> listQuery(@RequestBody NoticeQueryDto noticeQueryDto) {
        return noticeService.listQuery(noticeQueryDto);
    }

}


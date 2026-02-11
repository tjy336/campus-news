package com.kmbeast.pojo.em;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 新闻类别枚举类
 */
@Getter
@AllArgsConstructor
public enum NewsTypeEnum {

    TYPE_1(1, "校园政务"),
    TYPE_2(2, "教学科研"),
    TYPE_3(3, "校园活动"),
    TYPE_4(4, "校园建设"),
    TYPE_5(5, "安全公益");

    /**
     * 类型ID
     */
    private final Integer id;
    /**
     * 类别名
     */
    private final String name;

    /**
     * 通过新闻类别ID查询名称
     *
     * @param id 新闻类别ID
     * @return String 新闻类别名
     */
    public static String getNameById(Integer id) {
        if (id == null) {
            return null;
        }
        for (NewsTypeEnum newsTypeEnum : NewsTypeEnum.values()) {
            if (newsTypeEnum.getId().equals(id)) {
                return newsTypeEnum.getName();
            }
        }
        return null;
    }

}

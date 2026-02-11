<template>
    <div class="health-news-container">
        <div class="left">
            <div class="recommend">
                <Carousel @obj-detail="newsClick" :carouselItems="carouselItems" />
            </div>
            <div class="content">
                <div style="display: flex;justify-content: space-between;align-items: center;">
                    <div class="left-type">
                        <!-- 新闻类别 -->
                        <div class="types">
                            <div :style="{
                                backgroundColor: selectedType.value === type.value ? 'rgb(36, 136, 17)' : '',
                                color: selectedType.value === type.value ? 'rgb(255,255,255)' : ''
                            }" @click="typeChange(type)" class="type-item" v-for="(type, index) in newsTypeList"
                                :key="index">
                                {{ type.label }}
                            </div>
                        </div>
                    </div>
                    <div style="display: flex;justify-content: flex-end;">
                        <AutoInput style="width: 200px;" placeholder="搜索校园新闻" @listener="listener" />
                    </div>
                </div>
                <!-- 新闻列表 -->
                <div>
                    <div class="health-news">
                        <div v-if="!newsList.length">
                            <el-empty description="暂无新闻信息"></el-empty>
                        </div>
                        <div @click="newsClick(healthNews)" class="item" v-for="(healthNews, index) in newsList"
                            :key="index">
                            <img class="cover" :src="healthNews.cover" alt="" srcset="">
                            <span class="view-count">{{ healthNews.newsTypeName }}</span>
                            <div class="title">{{ healthNews.title }}</div>
                        </div>
                    </div>
                    <div class="pager">
                        <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
                            :current-page="healthNewsQueryDto.current" :page-sizes="[10, 20]"
                            :page-size="healthNewsQueryDto.size" layout="total, sizes, prev, pager, next, jumper"
                            :total="total"></el-pagination>
                    </div>
                </div>
            </div>
        </div>
        <div class="right">
            <h3 style="margin-top: 0;margin-left: 8px;">最热新闻</h3>
            <div class="item" @click="newsClick(healthNews)" v-for="(healthNews, index) in healthNewsTopList"
                :key="index">
                <img class="cover" :src="healthNews.cover" alt="" srcset=""></img>
                <div class="title">{{ healthNews.title }}</div>
            </div>

        </div>

    </div>
</template>

<script>
import AutoInput from "@/components/AutoInput.vue"; // 导入封装好的输入框组件
import Carousel from "@/components/Carousel"
export default {
    components: { Carousel, AutoInput },
    data() {
        return {
            carouselItems: [],
            selectedType: {},
            newsTypeList: [],
            newsList: [],
            healthNewsTopList: [],
            total: 0,
            healthNewsQueryDto: {
                newsTypeId: null,
                current: 1,
                size: 10,
            },
            defaultRecommendCount: 3, // 默认向用户推荐的健康新闻条数
        }
    },
    created() {
        this.fetchNewsTypes();
        // this.fetchRecommendHealthNews(this.defaultRecommendCount);
        this.fetchNewsTop(1, 3); // 查4条
        this.fetchRecommendHealthNews(this.defaultRecommendCount);
    },
    methods: {
        // 输入框组件输入回传
        listener(text) {
            this.healthNewsQueryDto.title = text; // 赋值查询条件的内容
            this.fetchNews(); // 重新加载数据
        },
        newsClick(news) {
            window.open(`/news-detail?id=${news.id}`);
        },
        handleSizeChange(size) {
            this.healthNewsQueryDto.size = size;
            this.healthNewsQueryDto.current = 1;
            this.fetchNews();
        },
        handleCurrentChange(current) {
            this.healthNewsQueryDto.current = current;
            this.fetchNews();
        },
        typeChange(type) {
            this.selectedType = type;
            this.healthNewsQueryDto.newsTypeId = type.value;
            this.fetchNews();
        },
        async fetchRecommendHealthNews(count) {
            try {
                const { data } = await this.$axios.get(`/news/recommend/${count}`);
                this.carouselItems = data.map(entity => {
                    return {
                        id: entity.id,
                        title: entity.title,
                        subtitle: entity.summary,
                        image: entity.cover
                    }
                })
            } catch (error) {
                this.$message.info(error.message);
            }
        },
        async fetchNewsTypes() {
            try {
                const { data } = await this.$axios.get('/news/types');
                this.newsTypeList = data;
                this.newsTypeList.unshift({ value: null, label: "全部" });
                this.typeChange(this.newsTypeList[0]);
            } catch (error) {
                this.$message.info(error.message);
            }
        },
        async fetchNews() {
            try {
                const { data, total } = await this.$axios.post('/news/list', this.healthNewsQueryDto);
                this.newsList = data;
                this.total = total;
            } catch (error) {
                this.$message.info(error.message);
            }
        },
        async fetchNewsTop(current, size) {
            try {
                const queryDto = {
                    current,
                    size,
                    sortField: 'doubleSort',
                }
                const { data } = await this.$axios.post('/news/list', queryDto);
                this.healthNewsTopList = data;
            } catch (error) {
                this.$message.info(error.message);
            }
        }
    }
}
</script>

<style scoped lang="scss">
.health-news-container {
    display: flex;
    gap: 30px;
    margin-block: 30px;

    .left {
        width: 80%;
        box-sizing: border-box;
    }

    .right {
        width: 20%;
        box-sizing: border-box;
        box-shadow: 0 4px 6px rgb(240, 240, 240);
        padding: 20px;

        .item {
            margin-bottom: 10px;
            cursor: pointer;
            padding: 10px;

            &:hover {
                transform: translateY(-2px);
            }

            .cover {
                width: 100%;
                height: 110px;
                border-radius: 5px;
            }
        }
    }

    // .recommend {
    //     background-color: rgb(246, 246, 246);
    // }

    .content {

        .left-type {
            .types {
                padding-block: 20px;
                display: flex;
                flex-wrap: wrap;
                align-items: center;
                gap: 20px;

                .type-item {
                    padding: 6px 12px;
                    border-radius: 20px;
                    cursor: pointer;

                    &:hover {
                        background-color: rgb(246, 246, 246);
                    }
                }
            }
        }

        .pager {
            display: flex;
            justify-content: flex-end;
        }


        .health-news {
            display: flex;
            flex-wrap: wrap;
            padding: 20px 0;
            gap: 15px;
            /* 添加间距 */
        }

        .health-news .item {
            flex: 0 0 calc(20% - 15px);
            /* 每行5个，减去间距 */
            max-width: calc(20% - 15px);
            /* 防止flex布局在某些情况下失效 */
            box-sizing: border-box;
            cursor: pointer;
            transition: transform 0.3s ease;
            position: relative;
        }

        .view-count {
            position: absolute;
            top: 0;
            left: 0;
            color: rgb(255, 255, 255);
            display: inline-block;
            // border-radius: 5px;
            border-top-left-radius: 5px;
            border-bottom-right-radius: 5px;
            padding: 2px 8px;
            font-size: 12px;
            font-weight: 600;
            background-color: rgba(0, 0, 0, 0.6);

            i {
                margin-right: 4px;
            }
        }

        .health-news .item:hover {
            transform: translateY(-5px);
        }

        .health-news .cover {
            width: 100%;
            height: 110px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 10px;
        }

        .health-news .title {
            font-size: 16px;
            font-weight: 500;
            white-space: nowrap;
            /* 不换行 */
            overflow: hidden;
            /* 超出隐藏 */
            text-overflow: ellipsis;
            /* 显示省略号 */
            padding: 0 5px;
        }
    }
}
</style>
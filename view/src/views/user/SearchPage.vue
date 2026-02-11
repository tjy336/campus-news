<template>
    <div class="search-container">
        <!-- 搜索结果 -->
        <div class="result-container">
            <div>
                搜索结果
                <span class="result">{{ total }}</span>
                条
            </div>
            <div class="search-block">
                <input @keyup.enter="fetchNewsList" v-model="newsQueryDto.title" placeholder="搜索新闻..." type="text">
                <div @click="fetchNewsList">
                    <i class="el-icon-search"></i>
                </div>
            </div>
        </div>
        <!-- 内容区域 -->
        <div>
            <div class="health-news">
                <div v-if="!newsList.length">
                    <el-empty description="暂无新闻信息"></el-empty>
                </div>
                <div @click="newsClick(healthNews)" class="item" v-for="(healthNews, index) in newsList" :key="index">
                    <img class="cover" :src="healthNews.cover" alt="" srcset="">
                    <span class="view-count">{{ healthNews.newsTypeName }}</span>
                    <div class="title">{{ healthNews.title }}</div>
                </div>
            </div>
        </div>
        <!-- 分页区域 -->
        <div class="pager">
            <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
                :current-page="newsQueryDto.current" :page-sizes="[12, 24]" :page-size="newsQueryDto.size"
                layout="total, sizes, prev, pager, next, jumper" :total="total"></el-pagination>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            newsList: [],
            newsQueryDto: {
                title: '',
                current: 1, // 默认第一页
                size: 12, // 默认一页10条
            },
            total: 0,
        }
    },
    async created() {
        this.newsQueryDto.title = this.$router.currentRoute.query.key;
        this.fetchNewsList(); // 通过关键词查询新闻数据列表
    },
    methods: {
        newsClick(news) {
            window.open(`/news-detail?id=${news.id}`);
        },
        // 分页 - 处理页面当前页切换
        handleCurrentChange(current) {
            this.newsQueryDto.current = current; // 当前页选中
            this.fetchNewsList(); // 重新加载页面数据
        },
        handleSizeChange(size) {
            this.newsQueryDto.size = size; // 当前页面大小重置
            this.newsQueryDto.currrent = 1; // 当前页设置为第一页
            this.fetchNewsList(); // 重新加载页面数据
        },
        async fetchNewsList() {
            try {
                const { data, total } = await this.$axios.post(`/news/list`, this.newsQueryDto);
                this.newsList = data;
                this.total = total;
            } catch (error) {
                this.$message.warning(error.message);
                console.error('查询新闻数据列表异常:', error);
            }
        },
    }
}
</script>

<style scoped lang="scss">

.search-block {
    display: flex;
    align-items: center;
    background-color: rgb(246, 246, 246);
    box-shadow: 0 4px 6px rgb(240,240,240);
    padding: 6px 10px;
    border-radius: 20px;

    input {
        outline: none;
        border: none;
        font-size: 14px;
        background-color: rgb(246, 246, 246);
    }

    div {

        &:hover {
            cursor: pointer;
        }
    }
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
    max-width: calc(25% - 15px);
    /* 防止flex布局在某些情况下失效 */
    box-sizing: border-box;
    cursor: pointer;
    transition: transform 0.3s ease;
    position: relative;
}

.health-news .item:hover {
    transform: translateY(-5px);
}

.health-news .cover {
    width: 100%;
    height: 120px;
    object-fit: cover;
    border-radius: 8px;
    margin-bottom: 10px;
}

.health-news .title {
    font-size: 18px;
    font-weight: 500;
    white-space: nowrap;
    /* 不换行 */
    overflow: hidden;
    /* 超出隐藏 */
    text-overflow: ellipsis;
    /* 显示省略号 */
    padding: 0 5px;
}

.result-container {
    font-size: 22px;
    margin-bottom: 20px;
    display: flex;
    justify-content: space-between;

    .result {
        font-size: 34px;
        font-weight: bold;
    }
}

.search-container {
    width: 800px;
    margin: 0 auto;
    padding: 30px 10px;
    box-sizing: border-box;
}

.pager {
    margin-block: 20px;
}
</style>
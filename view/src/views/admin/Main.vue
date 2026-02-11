<template>
    <div class="dashboard-container">
        <!-- 加载状态 -->
        <div v-if="loading" class="loading-container">
            <i class="el-icon-loading"></i>
            <span>数据加载中...</span>
        </div>
        
        <!-- 错误状态 -->
        <div v-else-if="loadError" class="error-container">
            <i class="el-icon-error"></i>
            <span>数据加载失败，请</span>
            <el-button type="text" @click="retryLoading">重试</el-button>
        </div>
        
        <!-- 正常内容 -->
        <template v-else>
            <!-- 静态数据及流量指标折线图 -->
            <div class="left">
                <!-- 静态数据 -->
                <div class="static-value" v-if="staticValues.length">
                    <div class="item" v-for="(item, index) in staticValues" :key="index">
                        <div class="value">{{ item.value || 0 }}</div>
                        <div class="label">{{ item.label }}</div>
                    </div>
                </div>
                
                <!-- 新闻流量指标 -->
                <div class="flow-index">
                    <!-- 选中新闻项信息 -->
                    <div class="selected-news" v-if="newsOptions.length">
                        <div class="title"><i class="el-icon-document"></i>{{ newsItem.label || '请选择新闻' }}</div>
                        <el-select @change="selctedNewsOptions" size="mini" style="width: 300px;"
                            v-model="actionOperationQueryDto.newsId" placeholder="请选择">
                            <el-option v-for="item in newsOptions" :key="item.value" :label="item.label"
                                :value="item.value">
                            </el-option>
                        </el-select>
                    </div>
                    
                    <!-- 选中的查询指标项 -->
                    <div class="action-operation" v-if="actionOperationList.length">
                        <div :style="{
                            borderBottom: actionItem.type === item.type ? '2px solid rgb(51,51,51)' : '',
                            color: actionItem.type === item.type ? 'rgb(51,51,51)' : '',
                            fontWeight: actionItem.type === item.type ? '600' : ''
                        }" @click="selectedActionOperation(item)" class="item" v-for="item in actionOperationList"
                            :key="item.value">
                            {{ item.label }}
                        </div>
                    </div>
                    
                    <!-- 新闻流量指标趋势 -->
                    <div v-if="values.length && date.length">
                        <LineChart @on-selected="onSelected" :tag="operationTag" :values="values" :date="date"
                            :tooltipFormatter="customTooltipFormat" :height="height" />
                    </div>
                    <div v-else class="no-data">
                        <i class="el-icon-data-line"></i>
                        <span>暂无数据</span>
                    </div>
                </div>
            </div>
            
            <!-- 最新上架的新闻 -->
            <div class="right">
                <div style="font-size: 24px;margin-bottom: 10px;font-weight: 600;">最新新闻</div>
                <template v-if="newsList.length">
                    <div style="margin-bottom: 10px;" v-for="item in newsList" :key="item.id">
                        <img style="width: 100%;height: 140px;border-radius: 5px;object-fit: cover;" 
                             :src="item.cover || ''" alt="新闻封面" >
                        <div @click="newsClick(item)" class="news-title">
                            {{ item.title }}
                        </div>
                    </div>
                </template>
                <div v-else class="no-news">
                    <i class="el-icon-news"></i>
                    <span>暂无最新新闻</span>
                </div>
            </div>
        </template>
    </div>
</template>

<script>
import LineChart from "@/components/LineChart"
export default {
    components: { LineChart },
    data() {
        return {
            loading: true,
            loadError: false,
            operationTag: '流量指标',
            values: [],
            date: [],
            height: '330px',
            newsItem: {},
            staticValues: [],
            newsOptions: [],
            actionItem: {},
            actionOperationList: [
                { type: 1, label: '点赞' },
                { type: 2, label: '阅读' },
                { type: 3, label: '收藏' },
            ],
            actionOperationQueryDto: {
                newsId: null,
                type: 1,
                days: 365, // 默认查询一年
            },
            newsList: [],
        }
    },
    async created() {
        await this.loadData();
    },

    methods: {
        async loadData() {
            this.loading = true;
            this.loadError = false;
            
            try {
                // 使用Promise.all并行加载独立数据
                await Promise.all([
                    this.fetchFreshStaticData(),
                    this.fetchFreshNewsOptions(),
                    this.fetchLastNews()
                ]);
                
                // 确保有新闻选项后再设置默认值
                if (this.newsOptions.length) {
                    this.actionOperationQueryDto.newsId = this.newsOptions[0].value;
                    this.newsItem = this.newsOptions[0];
                    await this.selectedActionOperation(this.actionOperationList[0]);
                }
            } catch (error) {
                console.error('数据加载失败:', error);
                this.loadError = true;
                this.$message.error('数据加载失败，请稍后重试');
            } finally {
                this.loading = false;
            }
        },
        
        retryLoading() {
            this.loadData();
        },
        
        newsClick(item) {
            if (item && item.id) {
                window.open(`/admin-news-detail?id=${item.id}`);
            }
        },
        onSelected(days) {
            this.actionOperationQueryDto.days = days;
            this.fetchNewsFlowIndex();
        },
        customTooltipFormat(param) {
            if (!param || !param.length) return '';
            
            const typeMap = {
                1: '点赞',
                2: '阅读',
                3: '收藏'
            };
            const typeText = typeMap[this.actionOperationQueryDto.type] || '';
            
            return '<div style="padding:6px 20px">' +
                '<div>' + (param[0].axisValue || '') + '</div>' +
                '<div>' + (param[0].data || 0) + '人' + typeText + '</div>' +
                '</div>'
        },
        async selectedActionOperation(item) {
            if (!item) return;
            
            this.actionItem = item;
            this.actionOperationQueryDto.type = item.type;
            await this.fetchNewsFlowIndex();
            this.operationTag = this.actionOperationQueryDto.days + '天内【' + item.label + '行为】变化';
        },
        selctedNewsOptions() {
            if (!this.actionOperationQueryDto.newsId) return;
            
            const selectedNews = this.newsOptions.find(entity => entity.value === this.actionOperationQueryDto.newsId);
            if (selectedNews) {
                this.newsItem = selectedNews;
                this.fetchNewsFlowIndex();
            }
        },
        async fetchFreshStaticData() {
            try {
                const { data } = await this.$axios.get('/dashboard/countStaticValue');
                this.staticValues = data || [];
            } catch (error) {
                console.error('查询静态数据信息异常:', error);
                this.staticValues = [];
                throw error;
            }
        },
        async fetchFreshNewsOptions() {
            try {
                const { data } = await this.$axios.get('/dashboard/newsOptions');
                this.newsOptions = data || [];
            } catch (error) {
                console.error('查询新闻选择数据信息异常:', error);
                this.newsOptions = [];
                throw error;
            }
        },
        async fetchNewsFlowIndex() {
            if (!this.actionOperationQueryDto.newsId) return;
            
            try {
                const { data } = await this.$axios.post('/dashboard/newsFlowIndex', this.actionOperationQueryDto);
                this.values = data ? data.map(entity => entity.value) : [];
                this.date = data ? data.map(entity => entity.label) : [];
            } catch (error) {
                console.error('查询新闻流量指标信息异常:', error);
                this.values = [];
                this.date = [];
            }
        },
        async fetchLastNews() {
            try {
                const newsQueryDto = {
                    current: 1,
                    size: 3,
                }
                const { data } = await this.$axios.post('/news/list', newsQueryDto);
                this.newsList = data || [];
            } catch (error) {
                console.error('查询最新新闻数据信息异常:', error);
                this.newsList = [];
                throw error;
            }
        },
    }
};
</script>

<style scoped lang="scss">
.dashboard-container {
    display: flex;
    padding-inline: 30px;
    box-sizing: border-box;
    gap: 30px;
    position: relative;
    min-height: 400px;

    .loading-container, .error-container {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 100%;
        height: 400px;
        font-size: 16px;
        color: #999;
        
        i {
            margin-right: 8px;
            font-size: 20px;
        }
    }
    
    .error-container {
        color: #f56c6c;
    }

    .right {
        width: 25%;
        box-shadow: 0 6px 12px rgb(240,240,240);
        padding: 10px 30px;
        box-sizing: border-box;
        border-radius: 5px;
        
        .no-news {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 200px;
            color: #999;
            
            i {
                font-size: 40px;
                margin-bottom: 10px;
            }
        }
        
        .news-title {
            cursor: pointer;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            margin-top: 8px;
            
            &:hover {
                color: #409EFF;
            }
        }
    }

    .left {
        width: 75%;

        .static-value {
            background-color: rgb(246, 246, 246);
            border-radius: 5px;
            padding: 20px 10px;
            box-sizing: border-box;
            display: flex;
            justify-content: space-evenly;

            .item {
                text-align: center;
                .value {
                    font-size: 26px;
                    font-weight: bold;
                    color: #333;
                }
                
                .label {
                    font-size: 14px;
                    color: #666;
                    margin-top: 5px;
                }
            }
        }

        .flow-index {
            margin-block: 20px;

            .action-operation {
                display: flex;
                margin-block: 10px;
                gap: 24px;
                cursor: pointer;

                .item {
                    border-bottom: 2px solid transparent;
                    padding: 4px 10px;
                    font-size: 16px;
                    color: #666;
                    transition: all 0.2s;
                    
                    &:hover {
                        color: #333;
                    }
                }
            }
            
            .no-data {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                height: 330px;
                color: #999;
                border: 1px dashed #ddd;
                border-radius: 4px;
                
                i {
                    font-size: 40px;
                    margin-bottom: 10px;
                }
            }

            .selected-news {
                display: flex;
                align-items: center;
                justify-content: space-between;
                background-color: rgb(246, 246, 246);
                padding: 10px;
                box-sizing: border-box;
                border-radius: 5px;

                .title {
                    font-size: 14px;
                    color: rgb(51, 51, 51);

                    i {
                        margin-right: 6px;
                    }
                }
            }
        }
    }
}

@media (max-width: 1200px) {
    .dashboard-container {
        flex-direction: column;
        
        .left, .right {
            width: 100%;
        }
        
        .right {
            margin-top: 20px;
        }
    }
}
</style>
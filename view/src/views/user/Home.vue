<template>
  <div class="home">
    <!-- 轮播图区域 -->
    <div class="carousel-container">
      <el-carousel :interval="4000" type="card" height="300px">
        <el-carousel-item v-for="item in carouselList" :key="item.id">
          <div class="carousel-item" @click="viewNews(item.id)">
            <img :src="item.cover || item.image || 'https://picsum.photos/800/400?random=' + item.id" :alt="item.title" />
            <div class="carousel-title">
              <h3>{{ item.title }}</h3>
            </div>
          </div>
        </el-carousel-item>
      </el-carousel>
    </div>

    <!-- 主要内容区域 -->
    <div class="main-content">
      <!-- 左侧新闻列表 -->
      <div class="news-section">
        <div class="section-header">
          <h2>最新新闻</h2>
          <el-button type="text" @click="goToNewsList">更多</el-button>
        </div>
        
        <!-- 分类标签 -->
        <div class="category-tabs">
          <el-tabs v-model="activeCategory" @tab-click="handleCategoryChange">
            <el-tab-pane label="全部" name="all"></el-tab-pane>
            <el-tab-pane label="校园政务" name="campus_affairs"></el-tab-pane>
            <el-tab-pane label="教学科研" name="teaching"></el-tab-pane>
            <el-tab-pane label="校园活动" name="activities"></el-tab-pane>
            <el-tab-pane label="校园建设" name="construction"></el-tab-pane>
            <el-tab-pane label="安全公益" name="safety"></el-tab-pane>
          </el-tabs>
        </div>

        <!-- 新闻列表 -->
        <div class="news-list">
          <div v-for="item in newsList" :key="item.id" class="news-item" @click="viewNews(item.id)">
            <div class="news-cover">
              <img :src="item.cover || item.image || 'https://picsum.photos/120/80?random=' + item.id" :alt="item.title" />
            </div>
            <div class="news-info">
              <h3 class="news-title">
                {{ item.title }}
                <span v-if="item.readCount > 200" class="hot-tag">热门</span>
                <span v-if="isNewNews(item.createTime)" class="new-tag">新</span>
              </h3>
              <p class="news-summary">{{ item.summary || (item.content ? item.content.replace(/<[^>]*>/g, '').slice(0, 60) + '...' : '暂无摘要') }}</p>
              <div class="news-meta">
                <span><i class="el-icon-time"></i> {{ item.createTime }}</span>
                <span><i class="el-icon-view"></i> {{ item.readCount || 0 }}</span>
                <span><i class="el-icon-star-off"></i> {{ item.likeCount || 0 }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 右侧侧边栏 -->
      <div class="sidebar">
        <!-- 系统公告 -->
        <div class="sidebar-card">
          <div class="card-header">
            <h3><i class="el-icon-bell"></i> 系统公告</h3>
            <el-button type="text" @click="goToNoticeList">更多</el-button>
          </div>
          <div class="notice-list">
            <div v-for="item in noticeList" :key="item.id" class="notice-item" @click="viewNotice(item.id)">
              <i class="el-icon-document-copy"></i>
              <span class="notice-title">{{ item.title }}</span>
              <span class="notice-time">{{ formatTime(item.createTime) }}</span>
            </div>
          </div>
        </div>

        <!-- 最热新闻 -->
        <div class="sidebar-card">
          <div class="card-header">
            <h3><i class="el-icon-fire"></i> 最热新闻</h3>
          </div>
          <div class="hot-news-list">
            <div v-for="(item, index) in hotNewsList" :key="item.id" class="hot-news-item" @click="viewNews(item.id)">
              <span class="hot-rank" :class="'rank-' + (index + 1)">{{ index + 1 }}</span>
              <span class="hot-title">{{ item.title }}</span>
              <span class="hot-count">{{ item.readCount || 0 }}阅读</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Home',
  data() {
    return {
      carouselList: [],
      activeCategory: 'all',
      newsList: [],
      noticeList: [],
      hotNewsList: []
    };
  },
  created() {
    this.fetchCarousel();
    this.fetchNewsList();
    this.fetchNoticeList();
    this.fetchHotNews();
  },
  methods: {
    // 获取轮播图数据
    async fetchCarousel() {
      try {
        const res = await this.$axios.get('/news/recommend/3');
        if (res.data && res.data.data) {
          this.carouselList = res.data.data;
        }
      } catch (error) {
        console.error('获取轮播图失败:', error);
      }
    },

    // 获取新闻列表
    async fetchNewsList() {
      try {
        const res = await this.$axios.post('/news/list', {
          current: 1,
          size: 10
        });
        
        if (res.data && res.data.data) {
          this.newsList = res.data.data;
        }
      } catch (error) {
        console.error('获取新闻列表失败:', error);
      }
    },

    // 获取公告列表
    async fetchNoticeList() {
      try {
        const res = await this.$axios.post('/notice/list', {
          current: 1,
          size: 5
        });
        
        if (res.data && res.data.data) {
          this.noticeList = res.data.data;
        }
      } catch (error) {
        console.error('获取公告列表失败:', error);
      }
    },

    // 获取最热新闻
    async fetchHotNews() {
      try {
        const res = await this.$axios.get('/news/hot');
        if (res.data && res.data.data) {
          this.hotNewsList = res.data.data;
        }
      } catch (error) {
        console.error('获取最热新闻失败:', error);
      }
    },

    // 分类切换
    handleCategoryChange() {
      this.fetchNewsList();
    },

    // 查看新闻详情（关键方法）
    viewNews(id) {
      console.log('点击新闻，ID:', id);
      if (!id) {
        this.$message.error('新闻ID不存在');
        return;
      }
      // 路由跳转
      this.$router.push(`/news/${id}`).catch(err => {
        console.error('路由跳转失败:', err);
        this.$message.error('页面跳转失败');
      });
    },

    // 查看公告详情
    viewNotice(id) {
      this.$router.push(`/notice/${id}`);
    },

    // 更多新闻
    goToNewsList() {
      this.$router.push('/news-list');
    },

    // 更多公告
    goToNoticeList() {
      this.$router.push('/notice-list');
    },

    // 判断是否为新闻（3天内）
    isNewNews(createTime) {
      if (!createTime) return false;
      const newsDate = new Date(createTime);
      const now = new Date();
      const diffDays = (now - newsDate) / (1000 * 60 * 60 * 24);
      return diffDays <= 3;
    },

    // 格式化时间
    formatTime(time) {
      if (!time) return '';
      return time.slice(5, 10);
    }
  }
};
</script>

<style scoped lang="scss">
.home {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}

/* 轮播图样式 */
.carousel-container {
  margin-bottom: 30px;
  
  .carousel-item {
    position: relative;
    height: 100%;
    cursor: pointer;
    
    img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      border-radius: 8px;
    }
    
    .carousel-title {
      position: absolute;
      bottom: 0;
      left: 0;
      right: 0;
      padding: 12px;
      background: linear-gradient(to top, rgba(0,0,0,0.8), transparent);
      border-radius: 0 0 8px 8px;
      
      h3 {
        margin: 0;
        color: white;
        font-size: 16px;
      }
    }
  }
}

/* 主内容区 - 双栏布局 */
.main-content {
  display: flex;
  gap: 24px;
}

/* 左侧新闻区 */
.news-section {
  flex: 1;
  
  .section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 16px;
    
    h2 {
      margin: 0;
      font-size: 20px;
      font-weight: 600;
    }
  }
}

.news-list {
  margin-top: 16px;
}

.news-item {
  display: flex;
  padding: 16px;
  border-bottom: 1px solid #f0f0f0;
  cursor: pointer;
  
  &:hover {
    background-color: #fafafa;
  }
  
  .news-cover {
    width: 120px;
    height: 80px;
    margin-right: 16px;
    
    img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      border-radius: 4px;
    }
  }
  
  .news-info {
    flex: 1;
    
    .news-title {
      margin: 0 0 8px;
      font-size: 16px;
      font-weight: 500;
      
      .hot-tag {
        margin-left: 8px;
        padding: 2px 6px;
        background: #f56c6c;
        color: white;
        font-size: 12px;
        border-radius: 4px;
      }
      
      .new-tag {
        margin-left: 8px;
        padding: 2px 6px;
        background: #67c23a;
        color: white;
        font-size: 12px;
        border-radius: 4px;
      }
    }
    
    .news-summary {
      margin: 0 0 8px;
      color: #666;
      font-size: 14px;
      line-height: 1.5;
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }
    
    .news-meta {
      color: #999;
      font-size: 13px;
      
      span {
        margin-right: 16px;
        
        i {
          margin-right: 4px;
        }
      }
    }
  }
}

/* 右侧边栏 */
.sidebar {
  width: 300px;
  
  .sidebar-card {
    background: white;
    border-radius: 8px;
    padding: 16px;
    margin-bottom: 20px;
    box-shadow: 0 2px 12px rgba(0,0,0,0.04);
    
    .card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 12px;
      
      h3 {
        margin: 0;
        font-size: 16px;
        font-weight: 600;
        
        i {
          margin-right: 6px;
          color: #409eff;
        }
      }
    }
  }
  
  .notice-list {
    .notice-item {
      display: flex;
      align-items: center;
      padding: 8px 0;
      cursor: pointer;
      border-bottom: 1px solid #f5f5f5;
      
      &:last-child {
        border-bottom: none;
      }
      
      i {
        margin-right: 8px;
        color: #999;
      }
      
      .notice-title {
        flex: 1;
        font-size: 14px;
        color: #333;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        
        &:hover {
          color: #409eff;
        }
      }
      
      .notice-time {
        font-size: 12px;
        color: #999;
      }
    }
  }
  
  .hot-news-list {
    .hot-news-item {
      display: flex;
      align-items: center;
      padding: 8px 0;
      cursor: pointer;
      
      .hot-rank {
        width: 24px;
        height: 24px;
        line-height: 24px;
        text-align: center;
        background: #f5f5f5;
        border-radius: 4px;
        font-size: 13px;
        font-weight: 600;
        margin-right: 10px;
        
        &.rank-1 {
          background: #fef0f0;
          color: #f56c6c;
        }
        
        &.rank-2 {
          background: #fdf6ec;
          color: #e6a23c;
        }
        
        &.rank-3 {
          background: #f4f4f5;
          color: #909399;
        }
      }
      
      .hot-title {
        flex: 1;
        font-size: 14px;
        color: #333;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        
        &:hover {
          color: #409eff;
        }
      }
      
      .hot-count {
        font-size: 12px;
        color: #999;
        margin-left: 8px;
      }
    }
  }
}

/* 响应式 */
@media (max-width: 768px) {
  .main-content {
    flex-direction: column;
  }
  
  .sidebar {
    width: 100%;
  }
}
</style>
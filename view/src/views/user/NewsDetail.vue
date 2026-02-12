<template>
    <div class="news-detail-container">
      <!-- 顶部导航栏 - 与首页保持一致 -->
      <div class="top-nav">
        <div class="nav-logo">
          <h2>📰 校园新闻</h2>
        </div>
        <div class="nav-search">
          <el-input
            placeholder="搜索新闻、公告、活动..."
            prefix-icon="el-icon-search"
            v-model="searchKeyword"
            @keyup.enter="handleSearch"
            clearable
          >
          </el-input>
        </div>
        <div class="nav-user">
          <el-dropdown @command="handleUserCommand">
            <span class="user-info">
              <el-avatar :size="36" :src="userAvatar" icon="el-icon-user-solid"></el-avatar>
              <span class="user-name">{{ userName || '用户' }}</span>
              <i class="el-icon-arrow-down"></i>
            </span>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item command="profile">个人信息</el-dropdown-item>
              <el-dropdown-item command="favorites">我的收藏</el-dropdown-item>
              <el-dropdown-item command="logout" divided>退出登录</el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </div>
      </div>
  
      <!-- 新闻详情主体 -->
      <div class="detail-main">
        <!-- 左侧新闻内容 -->
        <div class="detail-content">
          <div class="content-wrapper">
            <!-- 标题区 -->
            <div class="detail-header">
              <h1 class="detail-title">{{ newsDetail.title || '新闻详情' }}</h1>
              <div class="detail-meta">
                <span class="meta-item">
                  <i class="el-icon-time"></i> {{ newsDetail.createTime || '2025-08-21' }}
                </span>
                <span class="meta-item">
                  <i class="el-icon-view"></i> {{ newsDetail.readCount || 0 }} 阅读
                </span>
                <span class="meta-item">
                  <i class="el-icon-star-off"></i> {{ newsDetail.likeCount || 0 }} 点赞
                </span>
                <span class="meta-item">
                  <i class="el-icon-chat-dot-round"></i> {{ newsDetail.commentCount || 0 }} 评论
                </span>
              </div>
            </div>
  
            <!-- 封面图 -->
            <div v-if="newsDetail.image" class="detail-cover">
              <img :src="newsDetail.image" :alt="newsDetail.title">
            </div>
  
            <!-- 正文内容 -->
            <div class="detail-body" v-html="newsDetail.content || '<p>暂无内容</p>'"></div>
  
            <!-- 标签区 -->
            <div v-if="newsDetail.tags && newsDetail.tags.length" class="detail-tags">
              <el-tag 
                v-for="tag in newsDetail.tags" 
                :key="tag"
                size="small"
                type="info"
                effect="plain"
              >
                {{ tag }}
              </el-tag>
            </div>
  
            <!-- 操作区 -->
            <div class="detail-actions">
              <el-button 
                :type="isLiked ? 'danger' : 'default'"
                :icon="isLiked ? 'el-icon-star-on' : 'el-icon-star-off'"
                @click="handleLike"
                round
              >
                {{ isLiked ? '已收藏' : '收藏' }}
              </el-button>
              <el-button 
                type="primary" 
                icon="el-icon-share"
                round
                @click="handleShare"
              >
                分享
              </el-button>
              <el-button 
                type="text"
                icon="el-icon-back"
                @click="goBack"
              >
                返回列表
              </el-button>
            </div>
  
            <!-- 评论区 -->
            <div class="comment-section">
              <div class="comment-header">
                <h3><i class="el-icon-chat-dot-round"></i> 评论 ({{ commentList.length }})</h3>
              </div>
              
              <!-- 发表评论 -->
              <div class="comment-input">
                <el-input
                  type="textarea"
                  :rows="3"
                  placeholder="写下你的评论..."
                  v-model="newComment"
                >
                </el-input>
                <div class="comment-submit">
                  <el-button type="primary" @click="submitComment">发表评论</el-button>
                </div>
              </div>
  
              <!-- 评论列表 -->
              <div class="comment-list">
                <div v-for="comment in commentList" :key="comment.id" class="comment-item">
                  <div class="comment-avatar">
                    <el-avatar :size="40" :src="comment.avatar" icon="el-icon-user-solid"></el-avatar>
                  </div>
                  <div class="comment-content">
                    <div class="comment-user">
                      <span class="username">{{ comment.username }}</span>
                      <span class="time">{{ comment.createTime }}</span>
                    </div>
                    <div class="comment-text">{{ comment.content }}</div>
                    <div class="comment-actions">
                      <el-button type="text" icon="el-icon-chat-dot-round" @click="replyComment(comment)">回复</el-button>
                      <el-button 
                        type="text" 
                        :icon="comment.isLiked ? 'el-icon-star-on' : 'el-icon-star-off'"
                        @click="likeComment(comment)"
                      >
                        {{ comment.likeCount || 0 }}
                      </el-button>
                    </div>
                    
                    <!-- 回复列表 -->
                    <div v-if="comment.replies && comment.replies.length" class="reply-list">
                      <div v-for="reply in comment.replies" :key="reply.id" class="reply-item">
                        <div class="reply-avatar">
                          <el-avatar :size="32" :src="reply.avatar" icon="el-icon-user-solid"></el-avatar>
                        </div>
                        <div class="reply-content">
                          <div class="reply-user">
                            <span class="username">{{ reply.username }}</span>
                            <span class="time">{{ reply.createTime }}</span>
                          </div>
                          <div class="reply-text">{{ reply.content }}</div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
  
        <!-- 右侧推荐栏 -->
        <div class="detail-sidebar">
          <!-- 作者信息 -->
          <div class="sidebar-card author-card">
            <div class="author-info">
              <el-avatar :size="60" :src="newsDetail.authorAvatar" icon="el-icon-user-solid"></el-avatar>
              <div class="author-detail">
                <h4>{{ newsDetail.authorName || '校园新闻部' }}</h4>
                <p>{{ newsDetail.authorBio || '官方新闻发布平台' }}</p>
              </div>
            </div>
            <div class="author-stats">
              <div class="stat-item">
                <div class="stat-value">{{ authorStats.articles }}</div>
                <div class="stat-label">文章</div>
              </div>
              <div class="stat-item">
                <div class="stat-value">{{ authorStats.followers }}</div>
                <div class="stat-label">粉丝</div>
              </div>
              <div class="stat-item">
                <div class="stat-value">{{ authorStats.likes }}</div>
                <div class="stat-label">获赞</div>
              </div>
            </div>
            <el-button type="primary" plain size="small" block>关注</el-button>
          </div>
  
          <!-- 相关推荐 -->
          <div class="sidebar-card">
            <div class="card-header">
              <h3><i class="el-icon-reading"></i> 相关推荐</h3>
            </div>
            <div class="recommend-list">
              <div v-for="item in recommendNews" :key="item.id" class="recommend-item" @click="viewNews(item.id)">
                <div class="recommend-image">
                  <img :src="item.image || 'https://picsum.photos/60/60?random=' + item.id" :alt="item.title">
                </div>
                <div class="recommend-info">
                  <h4 class="recommend-title">{{ item.title }}</h4>
                  <div class="recommend-meta">
                    <span><i class="el-icon-view"></i> {{ item.readCount || 0 }}</span>
                    <span><i class="el-icon-time"></i> {{ item.createTime | formatDate }}</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
  
          <!-- 热门标签 -->
          <div class="sidebar-card">
            <div class="card-header">
              <h3><i class="el-icon-collection-tag"></i> 热门标签</h3>
            </div>
            <div class="tag-cloud">
              <el-tag 
                v-for="tag in hotTags" 
                :key="tag.name"
                size="small"
                :type="tag.type"
                effect="plain"
                class="hot-tag"
                @click="searchByTag(tag.name)"
              >
                {{ tag.name }}
              </el-tag>
            </div>
          </div>
  
          <!-- 校园日历（小尺寸） -->
          <div class="sidebar-card calendar-mini">
            <div class="card-header">
              <h3><i class="el-icon-date"></i> 校园日历</h3>
            </div>
            <div class="mini-calendar">
              <div class="calendar-date">{{ currentDate }}</div>
              <div class="calendar-events">
                <div v-for="event in campusEvents" :key="event.id" class="event-item">
                  <span class="event-dot" :style="{ background: event.color }"></span>
                  <span class="event-title">{{ event.title }}</span>
                  <span class="event-time">{{ event.time }}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    name: 'NewsDetail',
    data() {
      return {
        searchKeyword: '',
        userName: localStorage.getItem('username') || '用户',
        userAvatar: '',
        newsDetail: {},
        isLiked: false,
        newComment: '',
        commentList: [],
        recommendNews: [],
        hotTags: [
          { name: '校园活动', type: 'success' },
          { name: '学术科研', type: 'primary' },
          { name: '通知公告', type: 'warning' },
          { name: '招生就业', type: 'danger' },
          { name: '创新创业', type: 'info' },
          { name: '国际交流', type: '' }
        ],
        authorStats: {
          articles: 128,
          followers: 2560,
          likes: 8900
        },
        campusEvents: [
          { id: 1, title: '秋季运动会开幕式', time: '09-15', color: '#4361ee' },
          { id: 2, title: '校园招聘会', time: '09-20', color: '#52c41a' },
          { id: 3, title: '学术讲座：人工智能前沿', time: '09-22', color: '#fa8c16' }
        ]
      };
    },
    computed: {
      currentDate() {
        const date = new Date();
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        const weekdays = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'];
        const weekday = weekdays[date.getDay()];
        return `${year}年${month}月${day}日 ${weekday}`;
      }
    },
    created() {
      console.log('========== 新闻详情页加载 ==========');
      console.log('路由参数:', this.$route.params);
      console.log('新闻ID:', this.$route.params.id);
      this.fetchNewsDetail();
      this.fetchRecommendNews();
      this.fetchComments();
    },
    methods: {
      // 获取新闻详情
      async fetchNewsDetail() {
        const newsId = this.$route.params.id;
        console.log('正在请求新闻详情，ID:', newsId);
        
        if (!newsId) {
          this.$message.error('新闻ID不存在');
          return;
        }
        
        try {
          const res = await this.$axios.get(`/news/${newsId}`);
          console.log('新闻详情响应:', res);
          
          if (res.data && res.data.code === 200 && res.data.data) {
            this.newsDetail = res.data.data;
            console.log('新闻详情加载成功:', this.newsDetail);
          } else {
            console.error('新闻详情返回数据格式错误:', res.data);
            this.$message.error('获取新闻详情失败');
          }
        } catch (error) {
          console.error('获取新闻详情异常:', error);
          this.$message.error('网络错误，请稍后重试');
        }
      },
      
      // 获取相关推荐
      async fetchRecommendNews() {
        try {
          const res = await this.$axios.get('/news/recommend/5');
          if (res.data && res.data.code === 200 && res.data.data) {
            this.recommendNews = res.data.data.slice(0, 5);
          }
        } catch (error) {
          console.error('获取推荐新闻失败:', error);
        }
      },
      
      // 获取评论列表
      async fetchComments() {
        const newsId = this.$route.params.id;
        try {
          const res = await this.$axios.get(`/comment/list?newsId=${newsId}`);
          if (res.data && res.data.code === 200 && res.data.data) {
            this.commentList = res.data.data;
          }
        } catch (error) {
          console.error('获取评论失败:', error);
        }
      },
      
      // 收藏/取消收藏
      handleLike() {
        this.isLiked = !this.isLiked;
        this.$message.success(this.isLiked ? '收藏成功' : '已取消收藏');
      },
      
      // 分享
      handleShare() {
        this.$message.info('分享功能开发中');
      },
      
      // 返回上一页
      goBack() {
        this.$router.go(-1);
      },
      
      // 查看新闻
      viewNews(id) {
        this.$router.push(`/news/${id}`);
      },
      
      // 发表评论
      submitComment() {
        if (!this.newComment.trim()) {
          this.$message.warning('请输入评论内容');
          return;
        }
        this.$message.success('评论发表成功');
        this.newComment = '';
      },
      
      // 回复评论
      replyComment(comment) {
        this.$message.info('回复功能开发中');
      },
      
      // 点赞评论
      likeComment(comment) {
        comment.isLiked = !comment.isLiked;
        comment.likeCount = (comment.likeCount || 0) + (comment.isLiked ? 1 : -1);
      },
      
      // 按标签搜索
      searchByTag(tag) {
        this.$router.push({ path: '/search', query: { tag } });
      },
      
      handleSearch() {
        if (this.searchKeyword.trim()) {
          this.$router.push({ path: '/search', query: { keyword: this.searchKeyword } });
        }
      },
      
      handleUserCommand(command) {
        switch (command) {
          case 'profile':
            this.$router.push('/user/profile');
            break;
          case 'favorites':
            this.$router.push('/user/favorites');
            break;
          case 'logout':
            this.$confirm('确定退出登录吗？', '提示', {
              confirmButtonText: '确定',
              cancelButtonText: '取消',
              type: 'warning'
            }).then(() => {
              localStorage.removeItem('token');
              localStorage.removeItem('username');
              this.$router.push('/login');
            });
            break;
        }
      }
    },
    filters: {
      formatDate(date) {
        return date ? date.slice(5, 10) : '';
      }
    }
  };
  </script>
  
  <style scoped lang="scss">
  .news-detail-container {
    min-height: 100vh;
    background: #f5f7fa;
  }
  
  /* ===== 顶部导航（复用首页样式） ===== */
  .top-nav {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 12px 40px;
    background: white;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.02);
    position: sticky;
    top: 0;
    z-index: 100;
    
    .nav-logo h2 {
      margin: 0;
      font-size: 22px;
      font-weight: 600;
      color: #1e2f3e;
      letter-spacing: 1px;
    }
    
    .nav-search {
      width: 400px;
      
      ::v-deep .el-input__inner {
        border-radius: 40px;
        border: 1px solid #edf2f7;
        background: #fafcfd;
        
        &:focus {
          border-color: #3a7ca5;
          background: white;
          box-shadow: 0 0 0 3px rgba(58, 124, 165, 0.05);
        }
      }
    }
    
    .nav-user .user-info {
      display: flex;
      align-items: center;
      gap: 10px;
      cursor: pointer;
      
      .user-name {
        font-size: 14px;
        color: #2e3b4e;
      }
    }
  }
  
  /* ===== 详情主体 ===== */
  .detail-main {
    display: flex;
    gap: 24px;
    padding: 24px 40px;
    max-width: 1440px;
    margin: 0 auto;
  }
  
  /* ===== 左侧新闻内容 ===== */
  .detail-content {
    flex: 1;
    width: 0;
    
    .content-wrapper {
      background: white;
      border-radius: 20px;
      padding: 40px;
      box-shadow: 0 4px 16px rgba(0, 0, 0, 0.02);
    }
  }
  
  .detail-header {
    margin-bottom: 32px;
    
    .detail-title {
      font-size: 32px;
      font-weight: 600;
      color: #1e2f3e;
      margin: 0 0 20px;
      line-height: 1.4;
    }
    
    .detail-meta {
      display: flex;
      gap: 24px;
      color: #64748b;
      font-size: 14px;
      padding-bottom: 20px;
      border-bottom: 1px solid #f0f3f7;
      
      .meta-item {
        display: flex;
        align-items: center;
        
        i {
          margin-right: 6px;
          color: #94a3b8;
        }
      }
    }
  }
  
  .detail-cover {
    margin-bottom: 32px;
    border-radius: 16px;
    overflow: hidden;
    
    img {
      width: 100%;
      max-height: 400px;
      object-fit: cover;
    }
  }
  
  .detail-body {
    font-size: 16px;
    line-height: 1.8;
    color: #33475b;
    margin-bottom: 32px;
    
    ::v-deep p {
      margin: 0 0 20px;
    }
    
    ::v-deep img {
      max-width: 100%;
      border-radius: 12px;
      margin: 16px 0;
    }
    
    ::v-deep h2, ::v-deep h3 {
      margin: 32px 0 16px;
      color: #1e2f3e;
    }
  }
  
  .detail-tags {
    margin-bottom: 32px;
    padding-bottom: 32px;
    border-bottom: 1px solid #f0f3f7;
    
    .el-tag {
      margin-right: 12px;
      padding: 0 16px;
      height: 32px;
      line-height: 30px;
      border-radius: 16px;
    }
  }
  
  .detail-actions {
    display: flex;
    gap: 16px;
    margin-bottom: 48px;
    padding-bottom: 32px;
    border-bottom: 1px solid #f0f3f7;
  }
  
  /* ===== 评论样式 ===== */
  .comment-section {
    .comment-header {
      h3 {
        font-size: 18px;
        font-weight: 600;
        color: #1e2f3e;
        margin: 0 0 24px;
        
        i {
          margin-right: 8px;
          color: #3a7ca5;
        }
      }
    }
    
    .comment-input {
      margin-bottom: 32px;
      
      ::v-deep .el-textarea__inner {
        border-radius: 16px;
        border-color: #edf2f7;
        padding: 16px;
        
        &:focus {
          border-color: #3a7ca5;
          box-shadow: 0 0 0 3px rgba(58, 124, 165, 0.05);
        }
      }
      
      .comment-submit {
        margin-top: 12px;
        display: flex;
        justify-content: flex-end;
      }
    }
    
    .comment-item {
      display: flex;
      gap: 16px;
      padding: 20px 0;
      border-bottom: 1px solid #f1f5f9;
      
      &:last-child {
        border-bottom: none;
      }
      
      .comment-content {
        flex: 1;
        
        .comment-user {
          display: flex;
          align-items: baseline;
          gap: 12px;
          margin-bottom: 8px;
          
          .username {
            font-weight: 600;
            color: #1e2f3e;
          }
          
          .time {
            font-size: 12px;
            color: #94a3b8;
          }
        }
        
        .comment-text {
          font-size: 15px;
          color: #33475b;
          line-height: 1.6;
          margin-bottom: 12px;
        }
        
        .comment-actions {
          display: flex;
          gap: 16px;
          
          .el-button--text {
            color: #64748b;
            
            &:hover {
              color: #2a5fa9;
            }
          }
        }
      }
    }
    
    .reply-list {
      margin-top: 16px;
      margin-left: 32px;
      padding-left: 16px;
      border-left: 2px solid #edf2f7;
      
      .reply-item {
        display: flex;
        gap: 12px;
        padding: 12px 0;
        
        .reply-content {
          flex: 1;
          
          .reply-user {
            display: flex;
            align-items: baseline;
            gap: 12px;
            margin-bottom: 4px;
            
            .username {
              font-weight: 600;
              color: #1e2f3e;
              font-size: 14px;
            }
            
            .time {
              font-size: 12px;
              color: #94a3b8;
            }
          }
          
          .reply-text {
            font-size: 14px;
            color: #475569;
          }
        }
      }
    }
  }
  
  /* ===== 右侧侧边栏 ===== */
  .detail-sidebar {
    width: 320px;
    flex-shrink: 0;
    
    .sidebar-card {
      background: white;
      border-radius: 20px;
      padding: 24px;
      margin-bottom: 24px;
      box-shadow: 0 4px 16px rgba(0, 0, 0, 0.02);
      
      &:last-child {
        margin-bottom: 0;
      }
      
      .card-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 20px;
        
        h3 {
          margin: 0;
          font-size: 16px;
          font-weight: 600;
          color: #1e2f3e;
          display: flex;
          align-items: center;
          gap: 8px;
          
          i {
            color: #3a7ca5;
          }
        }
      }
    }
    
    .author-card {
      .author-info {
        display: flex;
        gap: 16px;
        margin-bottom: 20px;
        
        .author-detail {
          flex: 1;
          
          h4 {
            margin: 0 0 4px;
            font-size: 16px;
            font-weight: 600;
            color: #1e2f3e;
          }
          
          p {
            margin: 0;
            font-size: 13px;
            color: #64748b;
          }
        }
      }
      
      .author-stats {
        display: flex;
        justify-content: space-around;
        margin-bottom: 20px;
        padding: 16px 0;
        border-top: 1px solid #f1f5f9;
        border-bottom: 1px solid #f1f5f9;
        
        .stat-item {
          text-align: center;
          
          .stat-value {
            font-size: 18px;
            font-weight: 600;
            color: #1e2f3e;
          }
          
          .stat-label {
            font-size: 12px;
            color: #64748b;
            margin-top: 4px;
          }
        }
      }
    }
    
    .recommend-list {
      .recommend-item {
        display: flex;
        gap: 12px;
        padding: 12px 0;
        cursor: pointer;
        border-bottom: 1px solid #f1f5f9;
        
        &:last-child {
          border-bottom: none;
        }
        
        .recommend-image {
          width: 60px;
          height: 60px;
          border-radius: 12px;
          overflow: hidden;
          flex-shrink: 0;
          
          img {
            width: 100%;
            height: 100%;
            object-fit: cover;
          }
        }
        
        .recommend-info {
          flex: 1;
          
          .recommend-title {
            margin: 0 0 6px;
            font-size: 14px;
            font-weight: 500;
            color: #33475b;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            
            &:hover {
              color: #2a5fa9;
            }
          }
          
          .recommend-meta {
            display: flex;
            gap: 12px;
            font-size: 12px;
            color: #94a3b8;
            
            i {
              margin-right: 2px;
            }
          }
        }
      }
    }
    
    .tag-cloud {
      display: flex;
      flex-wrap: wrap;
      gap: 8px;
      
      .hot-tag {
        cursor: pointer;
        border-radius: 20px;
        
        &:hover {
          transform: translateY(-2px);
          box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
        }
      }
    }
    
    .calendar-mini {
      .calendar-date {
        font-size: 14px;
        font-weight: 600;
        color: #1e2f3e;
        margin-bottom: 16px;
      }
      
      .calendar-events {
        .event-item {
          display: flex;
          align-items: center;
          gap: 8px;
          padding: 6px 0;
          
          .event-dot {
            width: 6px;
            height: 6px;
            border-radius: 3px;
          }
          
          .event-title {
            flex: 1;
            font-size: 13px;
            color: #33475b;
          }
          
          .event-time {
            font-size: 12px;
            color: #94a3b8;
          }
        }
      }
    }
  }
  
  /* ===== 响应式 ===== */
  @media (max-width: 1024px) {
    .top-nav {
      padding: 12px 20px;
      .nav-search {
        width: 280px;
      }
    }
    
    .detail-main {
      padding: 20px;
      flex-direction: column;
    }
    
    .detail-sidebar {
      width: 100%;
    }
  }
  
  @media (max-width: 768px) {
    .top-nav {
      flex-wrap: wrap;
      .nav-search {
        width: 100%;
        order: 3;
        margin-top: 12px;
      }
    }
  }
  </style>
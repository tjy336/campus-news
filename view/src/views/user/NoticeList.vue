<template>
  <div class="notice-container">
    <!-- 顶部导航栏 - 与首页保持一致 -->
    <div class="top-nav">
      <div class="nav-logo">
        <h2>📰 校园新闻</h2>
      </div>
      <div class="nav-search">
        <AutoInput placeholder="搜索公告..." @listener="listener" />
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

    <!-- 主内容区 -->
    <div class="main-content">
      <!-- 左侧公告列表（卡片式） -->
      <div class="notice-list-section">
        <!-- 分类统计卡片 -->
        <div class="stats-cards">
          <el-row :gutter="20">
            <el-col :span="8">
              <div class="stat-item">
                <div class="stat-icon" style="background: #e9f0fe; color: #2a5fa9;">
                  <i class="el-icon-document"></i>
                </div>
                <div class="stat-info">
                  <div class="stat-label">总公告数</div>
                  <div class="stat-value">{{ apiResult.total }}</div>
                </div>
              </div>
            </el-col>
            <el-col :span="8">
              <div class="stat-item">
                <div class="stat-icon" style="background: #ecf9f0; color: #2e7d5e;">
                  <i class="el-icon-star-on"></i>
                </div>
                <div class="stat-info">
                  <div class="stat-label">优质公告</div>
                  <div class="stat-value">{{ highQualityCount }}</div>
                </div>
              </div>
            </el-col>
            <el-col :span="8">
              <div class="stat-item">
                <div class="stat-icon" style="background: #fff4e5; color: #b45f1b;">
                  <i class="el-icon-warning"></i>
                </div>
                <div class="stat-info">
                  <div class="stat-label">紧急公告</div>
                  <div class="stat-value">{{ urgentCount }}</div>
                </div>
              </div>
            </el-col>
          </el-row>
        </div>

        <!-- 公告卡片列表 -->
        <div class="notice-cards">
          <div v-for="item in apiResult.data" :key="item.id" class="notice-card">
            <div class="card-header">
              <div class="card-title-wrapper">
                <h3 class="card-title" @click="viewNotice(item.id)">
                  <i class="el-icon-document-copy"></i>
                  {{ item.title }}
                </h3>
                <div class="card-tags">
                  <el-tag v-if="item.aiCategory" size="mini" type="success" effect="plain">
                    {{ item.aiCategory }}
                  </el-tag>
                  <el-tag v-if="item.qualityLevel === '优秀'" size="mini" type="success" effect="plain">
                    优质
                  </el-tag>
                  <el-tag v-if="item.qualityLevel === '需要改进'" size="mini" type="danger" effect="plain">
                    需改进
                  </el-tag>
                </div>
              </div>
              <div class="card-time">
                <i class="el-icon-time"></i> {{ item.createTime }}
              </div>
            </div>

            <!-- AI关键词标签 -->
            <div v-if="item.aiKeywords" class="card-keywords">
              <el-tag 
                v-for="tag in getKeywordsArray(item.aiKeywords)" 
                :key="tag"
                size="mini"
                type="info"
                effect="plain"
                class="keyword-tag"
              >
                {{ tag }}
              </el-tag>
            </div>

            <!-- 质量进度条 -->
            <div v-if="item.qualityScore" class="card-quality">
              <div class="quality-label">
                <span>质量评分</span>
                <span :class="getScoreClass(item.qualityScore)">{{ item.qualityScore }}分</span>
              </div>
              <el-progress 
                :percentage="item.qualityScore" 
                :color="getProgressColor(item.qualityScore)"
                :show-text="false"
                :stroke-width="6"
              ></el-progress>
            </div>

            <!-- 操作按钮 -->
            <div class="card-actions">
              <el-button 
                @click="viewNotice(item.id)" 
                size="mini" 
                type="text" 
                icon="el-icon-view"
              >
                查看详情
              </el-button>
              <el-button 
                @click="analyzeNotice(item)" 
                size="mini" 
                type="text" 
                icon="el-icon-cpu"
              >
                AI分析
              </el-button>
              <el-button 
                @click="checkQuality(item)" 
                size="mini" 
                type="text" 
                icon="el-icon-check"
              >
                质量检测
              </el-button>
            </div>
          </div>
        </div>

        <!-- 分页 -->
        <div class="pagination-wrapper">
          <el-pagination 
            @size-change="handleSizeChange" 
            @current-change="handleCurrentChange"
            :current-page="noticeQueryDto.current" 
            :page-sizes="[10, 20, 50]" 
            :page-size="noticeQueryDto.size"
            layout="total, sizes, prev, pager, next, jumper" 
            :total="apiResult.total">
          </el-pagination>
        </div>
      </div>

      <!-- 右侧侧边栏 - 与首页保持一致 -->
      <div class="right-sidebar">
        <!-- 公告分类统计 -->
        <div class="sidebar-card">
          <div class="card-header">
            <h3><i class="el-icon-pie-chart"></i> 公告分类</h3>
          </div>
          <div class="category-stats">
            <div v-for="(item, index) in categoryStats" :key="index" class="category-item">
              <span class="category-name">{{ item.name }}</span>
              <span class="category-count">{{ item.count }}篇</span>
              <el-progress 
                :percentage="item.percent" 
                :color="item.color"
                :show-text="false"
                :stroke-width="4"
              ></el-progress>
            </div>
          </div>
        </div>

        <!-- 公告质量分布 -->
        <div class="sidebar-card">
          <div class="card-header">
            <h3><i class="el-icon-data-line"></i> 质量分布</h3>
          </div>
          <div class="quality-distribution">
            <div v-for="(item, index) in qualityLevels" :key="index" class="quality-item">
              <span class="quality-name">{{ item.name }}</span>
              <span class="quality-count">{{ item.count }}篇</span>
              <span class="quality-percent">{{ item.percent }}%</span>
            </div>
          </div>
        </div>

        <!-- 最近更新 -->
        <div class="sidebar-card">
          <div class="card-header">
            <h3><i class="el-icon-time"></i> 最近更新</h3>
            <a @click="fetchFreshData">刷新</a>
          </div>
          <div class="recent-list">
            <div v-for="item in apiResult.data.slice(0, 5)" :key="item.id" class="recent-item" @click="viewNotice(item.id)">
              <i class="el-icon-document-copy"></i>
              <span class="recent-title">{{ item.title }}</span>
              <span class="recent-time">{{ item.createTime | formatTime }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- ========== AI智能分析对话框 ========== -->
    <el-dialog 
      title="🤖 AI智能分析" 
      :visible.sync="aiDialogVisible" 
      width="550px"
      :close-on-click-modal="false">
      
      <div v-if="aiAnalysisResult" class="ai-analysis">
        <div class="analysis-section">
          <div class="section-title">
            <i class="el-icon-collection-tag"></i>
            <span>智能分类</span>
          </div>
          <div class="section-content">
            <el-tag size="medium" type="success" effect="dark">
              {{ aiAnalysisResult.category }}
            </el-tag>
          </div>
        </div>
        
        <div class="analysis-section">
          <div class="section-title">
            <i class="el-icon-key"></i>
            <span>关键词提取</span>
          </div>
          <div class="section-content">
            <el-tag 
              v-for="(keyword, index) in aiAnalysisResult.keywords" 
              :key="index"
              size="small"
              type="info"
              effect="plain"
              style="margin-right: 8px; margin-bottom: 5px;">
              {{ keyword }}
            </el-tag>
            <span v-if="aiAnalysisResult.keywords.length === 0" class="empty-text">无关键词</span>
          </div>
        </div>
        
        <div class="analysis-section">
          <div class="section-title">
            <i class="el-icon-document"></i>
            <span>智能摘要</span>
          </div>
          <div class="section-content summary-box">
            {{ aiAnalysisResult.summary }}
          </div>
        </div>
      </div>
      
      <div v-else class="loading-container">
        <i class="el-icon-loading"></i> AI分析中...
      </div>
      
      <span slot="footer">
        <el-button @click="aiDialogVisible = false">关 闭</el-button>
      </span>
    </el-dialog>

    <!-- ========== 质量检测对话框 ========== -->
    <el-dialog 
      title="📊 质量检测报告" 
      :visible.sync="qualityDialogVisible" 
      width="500px">
      
      <div v-if="qualityResult" class="quality-analysis">
        <div class="score-section">
          <el-progress 
            type="circle" 
            :percentage="qualityResult.score" 
            :width="100"
            :status="getScoreStatus(qualityResult.score)">
          </el-progress>
          <div class="score-info">
            <div class="score-value">综合评分: {{ qualityResult.score }}分</div>
            <el-tag :type="getLevelType(qualityResult.level)" size="medium">
              {{ qualityResult.level }}
            </el-tag>
          </div>
        </div>
        
        <div class="suggestions-section">
          <div class="section-title">
            <i class="el-icon-info"></i>
            <span>改进建议</span>
          </div>
          <ul class="suggestions-list">
            <li v-for="(suggestion, index) in qualityResult.suggestions" :key="index">
              {{ suggestion }}
            </li>
          </ul>
        </div>
      </div>
      
      <div v-else class="loading-container">
        <i class="el-icon-loading"></i> 检测中...
      </div>
      
      <span slot="footer">
        <el-button @click="qualityDialogVisible = false">关 闭</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import AutoInput from "@/components/AutoInput.vue";

export default {
  components: { AutoInput },
  data() {
    return {
      userName: '张三',
      userAvatar: '',
      id: null,
      apiResult: {
        data: [],
        total: 0,
      },
      notice: {
        title: '',
      },
      noticeQueryDto: {
        current: 1,
        size: 10,
        title: ''
      },
      aiDialogVisible: false,
      qualityDialogVisible: false,
      aiAnalysisResult: null,
      qualityResult: null,
      highQualityCount: 0,
      urgentCount: 0,
      categoryStats: [],
      qualityLevels: []
    };
  },
  created() {
    this.fetchFreshData();
  },
  methods: {
    async viewNotice(id) {
      try {
        const { data } = await this.$axios.get(`/notice/${id}`);
        this.notice = { ...data };
      } catch (error) {
        this.$message.warning(error.message);
        console.error('查询公告详情异常:', error);
      }
    },
    
    listener(text) {
      this.noticeQueryDto.title = text;
      this.noticeQueryDto.current = 1;
      this.fetchFreshData();
    },
    
    async fetchFreshData() {
      try {
        const { data, total } = await this.$axios.post('/notice/list', this.noticeQueryDto);
        this.apiResult.data = data || [];
        this.apiResult.total = total || 0;
        
        if (data && data.length > 0) {
          this.viewNotice(data[0].id);
        }
        
        this.calculateStats();
      } catch (error) {
        console.error('查询公告信息异常:', error);
      }
    },
    
    calculateStats() {
      // 计算优质公告
      this.highQualityCount = this.apiResult.data.filter(item => 
        item.qualityScore && item.qualityScore >= 80
      ).length;
      
      // 计算紧急公告 - 修复可选链语法
      this.urgentCount = this.apiResult.data.filter(item => {
        const hasEmergencyCategory = item.aiCategory === '紧急通知';
        const hasEmergencyInTitle = item.title && item.title.includes('紧急');
        const hasEmergencyInContent = item.content && item.content.includes('紧急');
        return hasEmergencyCategory || hasEmergencyInTitle || hasEmergencyInContent;
      }).length;
      
      // 计算分类统计
      const categories = {};
      this.apiResult.data.forEach(item => {
        const cat = item.aiCategory || '未分类';
        categories[cat] = (categories[cat] || 0) + 1;
      });
      
      const colors = ['#2a5fa9', '#2e7d5e', '#b45f1b', '#8b5cf6', '#d53f8c'];
      let index = 0;
      this.categoryStats = Object.entries(categories).map(([name, count]) => {
        const percent = this.apiResult.total > 0 ? ((count / this.apiResult.total) * 100).toFixed(1) : 0;
        return {
          name,
          count,
          percent,
          color: colors[index++ % colors.length]
        };
      });
      
      // 计算质量分布
      const levels = {
        '优秀': { count: 0 },
        '良好': { count: 0 },
        '合格': { count: 0 },
        '需要改进': { count: 0 },
        '未评分': { count: 0 }
      };
      
      this.apiResult.data.forEach(item => {
        const level = item.qualityLevel || '未评分';
        if (levels[level]) levels[level].count++;
      });
      
      this.qualityLevels = Object.entries(levels)
        .map(([name, data]) => {
          const percent = this.apiResult.total > 0 ? ((data.count / this.apiResult.total) * 100).toFixed(1) : 0;
          return { name, count: data.count, percent };
        })
        .filter(item => item.count > 0);
    },
    
    getKeywordsArray(keywords) {
      try {
        if (!keywords) return [];
        return JSON.parse(keywords) || [];
      } catch {
        return [];
      }
    },
    
    getScoreClass(score) {
      if (score >= 85) return 'score-excellent';
      if (score >= 70) return 'score-good';
      if (score >= 60) return 'score-ok';
      return 'score-poor';
    },
    
    getProgressColor(score) {
      if (score >= 85) return '#67c23a';
      if (score >= 70) return '#409eff';
      if (score >= 60) return '#e6a23c';
      return '#f56c6c';
    },
    
    async analyzeNotice(row) {
      this.aiDialogVisible = true;
      this.aiAnalysisResult = null;
      
      try {
        const { data } = await this.$axios.post('/notice/ai/analyze', {
          title: row.title,
          content: row.content
        });
        this.aiAnalysisResult = data;
      } catch (error) {
        console.error('AI分析失败:', error);
        this.$message.error('AI分析失败：' + (error.message || '请稍后重试'));
        this.aiDialogVisible = false;
      }
    },
    
    async checkQuality(row) {
      this.qualityDialogVisible = true;
      this.qualityResult = null;
      
      try {
        const { data } = await this.$axios.post('/notice/ai/quality-check', {
          title: row.title,
          content: row.content
        });
        this.qualityResult = data;
      } catch (error) {
        console.error('质量检测失败:', error);
        this.$message.error('质量检测失败：' + (error.message || '请稍后重试'));
        this.qualityDialogVisible = false;
      }
    },
    
    getScoreStatus(score) {
      if (score >= 85) return 'success';
      if (score >= 70) return '';
      if (score >= 60) return 'warning';
      return 'exception';
    },
    
    getLevelType(level) {
      if (level.includes('优秀')) return 'success';
      if (level.includes('良好')) return '';
      if (level.includes('合格')) return 'warning';
      return 'danger';
    },
    
    handleSizeChange(size) {
      this.noticeQueryDto.size = size;
      this.noticeQueryDto.current = 1;
      this.fetchFreshData();
    },
    
    handleCurrentChange(current) {
      this.noticeQueryDto.current = current;
      this.fetchFreshData();
    },
    
    handleUserCommand(command) {
      if (command === 'logout') {
        this.$confirm('确定退出登录吗？', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          localStorage.removeItem('token');
          this.$router.push('/login');
        });
      }
    }
  },
  filters: {
    formatTime(time) {
      return time ? time.slice(5, 10) : '';
    }
  }
};
</script>

<style scoped lang="scss">
.notice-container {
  min-height: 100vh;
  background: #f5f7fa;
}

/* ===== 顶部导航 ===== */
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

/* ===== 主内容区 ===== */
.main-content {
  display: flex;
  gap: 24px;
  padding: 24px 40px;
  max-width: 1440px;
  margin: 0 auto;
}

/* ===== 左侧公告列表区 ===== */
.notice-list-section {
  flex: 1;
  width: 0;
}

.stats-cards {
  margin-bottom: 24px;
  
  .stat-item {
    background: white;
    border-radius: 16px;
    padding: 20px;
    display: flex;
    align-items: center;
    gap: 16px;
    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.02);
    
    .stat-icon {
      width: 48px;
      height: 48px;
      border-radius: 14px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 24px;
    }
    
    .stat-info {
      .stat-label {
        font-size: 13px;
        color: #64748b;
        margin-bottom: 4px;
      }
      
      .stat-value {
        font-size: 24px;
        font-weight: 600;
        color: #1e2f3e;
        line-height: 1;
      }
    }
  }
}

.notice-cards {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.notice-card {
  background: white;
  border-radius: 20px;
  padding: 20px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.02);
  transition: all 0.3s;
  border: 1px solid rgba(0, 0, 0, 0.02);
  
  &:hover {
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.04);
    transform: translateY(-2px);
  }
  
  .card-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 12px;
    
    .card-title-wrapper {
      flex: 1;
      
      .card-title {
        margin: 0 0 8px;
        font-size: 18px;
        font-weight: 600;
        color: #1e2f3e;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 8px;
        
        i {
          color: #5f7d95;
          font-size: 18px;
        }
        
        &:hover {
          color: #2a5fa9;
          
          i {
            color: #2a5fa9;
          }
        }
      }
      
      .card-tags {
        display: flex;
        gap: 8px;
        flex-wrap: wrap;
      }
    }
    
    .card-time {
      font-size: 14px;
      color: #94a3b8;
      white-space: nowrap;
      margin-left: 16px;
      
      i {
        margin-right: 4px;
      }
    }
  }
  
  .card-keywords {
    margin-bottom: 16px;
    
    .keyword-tag {
      margin-right: 8px;
      margin-bottom: 4px;
    }
  }
  
  .card-quality {
    margin-bottom: 16px;
    padding: 12px;
    background: #f8fafc;
    border-radius: 12px;
    
    .quality-label {
      display: flex;
      justify-content: space-between;
      margin-bottom: 8px;
      font-size: 13px;
      
      span:first-child {
        color: #64748b;
      }
      
      .score-excellent { color: #67c23a; font-weight: 600; }
      .score-good { color: #409eff; font-weight: 600; }
      .score-ok { color: #e6a23c; font-weight: 600; }
      .score-poor { color: #f56c6c; font-weight: 600; }
    }
  }
  
  .card-actions {
    display: flex;
    gap: 16px;
    padding-top: 12px;
    border-top: 1px solid #f0f3f7;
    
    ::v-deep .el-button--text {
      color: #64748b;
      
      &:hover {
        color: #2a5fa9;
      }
      
      i {
        margin-right: 4px;
      }
    }
  }
}

.pagination-wrapper {
  margin-top: 32px;
  display: flex;
  justify-content: flex-end;
}

/* ===== 右侧侧边栏 ===== */
.right-sidebar {
  width: 320px;
  flex-shrink: 0;
  
  .sidebar-card {
    background: white;
    border-radius: 20px;
    padding: 20px;
    margin-bottom: 24px;
    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.02);
    
    .card-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 16px;
      
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
      
      a {
        color: #64748b;
        font-size: 13px;
        cursor: pointer;
        
        &:hover {
          color: #2a5fa9;
        }
      }
    }
  }
  
  .category-stats {
    .category-item {
      margin-bottom: 16px;
      
      &:last-child {
        margin-bottom: 0;
      }
      
      .category-name {
        font-size: 14px;
        color: #33475b;
        margin-bottom: 4px;
        display: inline-block;
      }
      
      .category-count {
        float: right;
        font-size: 14px;
        font-weight: 600;
        color: #1e2f3e;
      }
      
      ::v-deep .el-progress {
        margin-top: 6px;
      }
    }
  }
  
  .quality-distribution {
    .quality-item {
      display: flex;
      align-items: center;
      padding: 8px 0;
      border-bottom: 1px solid #f1f5f9;
      
      &:last-child {
        border-bottom: none;
      }
      
      .quality-name {
        flex: 1;
        font-size: 14px;
        color: #33475b;
      }
      
      .quality-count {
        width: 40px;
        font-size: 14px;
        font-weight: 600;
        color: #1e2f3e;
      }
      
      .quality-percent {
        width: 50px;
        font-size: 13px;
        color: #64748b;
      }
    }
  }
  
  .recent-list {
    .recent-item {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 10px 0;
      cursor: pointer;
      border-bottom: 1px solid #f1f5f9;
      
      &:last-child {
        border-bottom: none;
      }
      
      i {
        color: #5f7d95;
        font-size: 14px;
      }
      
      .recent-title {
        flex: 1;
        font-size: 14px;
        color: #33475b;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        
        &:hover {
          color: #2a5fa9;
        }
      }
      
      .recent-time {
        font-size: 12px;
        color: #94a3b8;
      }
    }
  }
}

/* ===== AI对话框样式 ===== */
::v-deep .el-dialog {
  border-radius: 28px;
  box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.15);
  overflow: hidden;
  
  .el-dialog__header {
    padding: 24px 28px 16px;
    border-bottom: 1px solid #f0f4fa;
    
    .el-dialog__title {
      font-size: 18px;
      font-weight: 600;
      color: #1e2b3a;
    }
  }
  
  .el-dialog__body {
    padding: 28px !important;
  }
  
  .el-dialog__footer {
    padding: 16px 28px 24px;
    border-top: 1px solid #f0f4fa;
    
    .el-button {
      border-radius: 40px;
      padding: 10px 28px;
      border: none;
      background: #f0f5fa;
      color: #405b6a;
      
      &:hover {
        background: #e1eaf0;
        color: #1e3b4a;
      }
    }
  }
}

.ai-analysis, .quality-analysis {
  padding: 8px 0;
}

.analysis-section {
  margin-bottom: 28px;
  
  &:last-child {
    margin-bottom: 0;
  }
}

.section-title {
  display: flex;
  align-items: center;
  margin-bottom: 16px;
  font-size: 15px;
  font-weight: 600;
  color: #1e2f3e;
  
  i {
    margin-right: 10px;
    font-size: 20px;
    color: #3a7ca5;
  }
}

.summary-box {
  background: #f9fcfe;
  padding: 20px 22px;
  border-radius: 18px;
  border-left: 4px solid #3a7ca5;
  line-height: 1.8;
  color: #2c3f4f;
  font-size: 15px;
}

.score-section {
  display: flex;
  align-items: center;
  margin-bottom: 28px;
  padding-bottom: 24px;
  border-bottom: 1px solid #edf2f7;
}

.score-info {
  margin-left: 28px;
}

.score-value {
  font-size: 20px;
  font-weight: 600;
  color: #1e2f3e;
  margin-bottom: 8px;
}

.suggestions-list {
  list-style: none;
  padding: 0;
  margin: 16px 0 0;
  
  li {
    padding: 12px 18px;
    margin-bottom: 10px;
    background: #f9fcfe;
    color: #4f6b7a;
    border-radius: 14px;
    border-left: 4px solid #e1a23b;
    font-size: 14px;
  }
}

.loading-container {
  text-align: center;
  padding: 48px 20px;
  color: #5f7d9c;
}

/* ===== 响应式 ===== */
@media (max-width: 1024px) {
  .top-nav {
    padding: 12px 20px;
    
    .nav-search {
      width: 280px;
    }
  }
  
  .main-content {
    padding: 20px;
    flex-direction: column;
  }
  
  .right-sidebar {
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
  
  .stats-cards {
    .el-row {
      display: flex;
      flex-direction: column;
      gap: 12px;
    }
    
    .el-col {
      width: 100%;
    }
  }
  
  .card-header {
    flex-direction: column;
    
    .card-time {
      margin-left: 0 !important;
      margin-top: 8px;
    }
  }
}
</style>
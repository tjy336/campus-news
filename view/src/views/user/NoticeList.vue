<template>
  <div class="container">
    <div class="notice-left">
      <div class="top-header">
        <div class="nav-left">
        </div>
        <div class="nav-right">
          <div>
            <AutoInput placeholder="搜索公告" @listener="listener" />
          </div>
        </div>
      </div>
      <!-- 表格及分页信息 -->
      <div>
        <el-table :data="apiResult.data">
          <el-table-column prop="title" label="标题">
            <template #default="scope">
              <el-tooltip class="item" effect="dark" :content="scope.row.title" placement="right">
                <div class="text-ellipsis">
                  <i class="el-icon-document-copy" style="margin-right: 6px;"></i>
                  {{ scope.row.title }}
                </div>
              </el-tooltip>
            </template>
          </el-table-column>
          <el-table-column prop="createTime" :sortable="true" width="168" label="发布时间"></el-table-column>
          <el-table-column label="" width="150" align="center">
            <template #default="scope">
              <el-button @click="viewNotice(scope.row.id)" size="mini" type="success" icon="el-icon-view" circle></el-button>
            </template>
          </el-table-column>
        </el-table>
        <!-- 分页组件区域 -->
        <div class="pager">
          <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
            :current-page="noticeQueryDto.current" :page-sizes="[10, 20]" :page-size="noticeQueryDto.size"
            layout="total, sizes, prev, pager, next, jumper" :total="apiResult.total"></el-pagination>
        </div>
      </div>
    </div>
    <div class="content-detail">
      <div class="title">
        {{ notice.title }}
      </div>
      <div v-html="notice.content"></div>
    </div>

  </div>
</template>

<script>
// B站 「程序员辰星」原创出品
import AutoInput from "@/components/AutoInput.vue"; // 自己封装好的输入框组件
export default {
  components: { AutoInput }, // 注册组件
  data() {
    return {
      id: null, // 页面即将删除的数据ID
      apiResult: { // 后端返回的查询数据的响应数据
        data: [], // 数据项
        total: 0, // 符合条件的数据总想 - 初始赋值为0
      },
      notice: {
        title: '',
      },
      noticeQueryDto: { // 搜索条件
        current: 1, // 当前页 - 初始是第一页
        size: 10, // 页面显示大小 - 初始是10条
      },
    };
  },
  created() {
    this.fetchFreshData();
  },
  methods: {
    async viewNotice(id) {
      try {
        const { data } = await this.$axios.get(`/notice/${id}`);
        // 设置初始值
        this.notice = { ...data };
      } catch (error) {
        this.$message.warning(error.message);
        console.error('查询公告详情异常:', error);
      }

    },
    // 输入框组件输入回传
    listener(text) {
      this.noticeQueryDto.title = text; // 赋值查询条件的内容
      this.fetchFreshData(); // 重新加载数据
    },
    // 查询公告数据
    async fetchFreshData() {
      try {
        const { data, total } = await this.$axios.post('/notice/list', this.noticeQueryDto);
        this.apiResult.data = data;
        this.apiResult.total = total;
        this.viewNotice(data[0].id);
      } catch (error) {
        console.error('查询公告信息异常:', error);
      }
    },
    // 分页 - 处理页面页数切换
    handleSizeChange(size) {
      this.noticeQueryDto.size = size; // 当前页面大小重置
      this.noticeQueryDto.currrent = 1; // 当前页设置为第一页
      this.fetchFreshData(); // 重新加载页面数据
    },
    // 分页 - 处理页面当前页切换
    handleCurrentChange(current) {
      this.noticeQueryDto.current = current; // 当前页选中
      this.fetchFreshData(); // 重新加载页面数据
    },
  },
};
</script>
<style scoped lang="scss">

.text-ellipsis {
  white-space: nowrap;
  /* 禁止换行 */
  overflow: hidden;
  /* 隐藏溢出内容 */
  text-overflow: ellipsis;
  /* 显示省略号 */
  max-width: 220px;
  /* 根据需要设置最大宽度 */
}

.pager {
  margin-block: 20px;
}

/* 默认隐藏操作按钮 */
.operate-buttons {
  //opacity: 0;
  transition: opacity 0.3s;
  /* 添加过渡效果 */
  cursor: pointer;

  i {
    padding: 8px;
    border-radius: 6px;
    transition: all .5s ease;

    &:hover {
      background-color: rgb(236, 237, 238);
    }
  }

}

/* 行悬停时显示操作按钮 */


.container {
  margin: 10px 20px;
  display: flex;
  gap: 30px;

  .notice-left {
    width: 55%;
  }

  .content-detail {
    width: 45%;
    padding: 20px 30px;
    box-sizing: border-box;
    box-shadow: 0 8px 12px rgb(240,240,240);
    .title{
      font-size: 30px;
      font-weight: 600;
    }
  }
}

.top-header {
  margin-block: 10px;
  padding-inline: 10px;
  border-radius: 5px;
  display: flex;
  justify-content: space-between;
  align-items: center;

  .nav-left,
  .nav-right {
    display: flex;
    justify-content: left;
    align-items: center;
    gap: 10px;
  }

  .nav-left {
    display: flex;
  }

}
</style>
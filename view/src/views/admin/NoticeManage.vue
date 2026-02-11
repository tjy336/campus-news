<template>
  <div class="container">
    <div class="top-header">
      <div class="nav-left">
      </div>
      <div class="nav-right">
        <div>
          <AutoInput placeholder="搜索公告" @listener="listener" />
        </div>
        <div class="primary-bt" @click="savenoticeOperation">
          <i class="el-icon-plus"></i>
          新增校园公告
        </div>
      </div>
    </div>
    <!-- 表格及分页信息 -->
    <div>
      <el-table :data="apiResult.data">
        <el-table-column prop="title" label="标题">
          <template #default="scope">
            <div class="over-text">
              {{ scope.row.title }}
            </div>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" :sortable="true" width="168" label="发布时间"></el-table-column>
        <el-table-column label="操作" width="150" align="center">
          <template #default="scope">
            <div class="operate-buttons">
              <el-dropdown trigger="click" placement="bottom-end">
                <span class="el-dropdown-link">
                  <i class="el-icon-more"></i>
                </span>
                <el-dropdown-menu slot="dropdown">
                  <el-dropdown-item @click.native="handleEdit(scope.row)" icon="el-icon-edit">修改</el-dropdown-item>
                  <el-dropdown-item @click.native="handleDelete(scope.row)" icon="el-icon-delete">删除</el-dropdown-item>
                </el-dropdown-menu>
              </el-dropdown>
            </div>
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

    <!-- 删除确认弹窗 -->
    <el-dialog title="删除校园公告" :show-close="false" :visible.sync="dialogDeletedVisible" width="20%">
      <span>确定删除校园公告数据？</span>
      <span slot="footer" class="dialog-footer">
        <el-button size="mini" @click="dialogDeletedVisible = false">取消</el-button>
        <el-button size="mini" type="primary" @click="confirmDeleted">确定</el-button>
      </span>
    </el-dialog>

    <!-- 公告操作抽屉 -->
    <el-drawer :title="isCreateModel ? '新增' : '修改'" :visible.sync="drawer" size="45%" :direction="direction"
      :before-close="handleClose">
      <div style="padding: 10px 20px;">
        <el-form ref="form" :model="notice" label-width="80px">
          <el-form-item label="*公告标题">
            <div>
              <el-input placeholder="请输入标题（30字以内）" v-model="notice.title" clearable>
              </el-input>
            </div>
          </el-form-item>
          <el-form-item label="*公告内容">
            <div>
              <Editor @on-listener="onListener" :receiveContent="content" height="300px" :api="fileUploadPath" />
            </div>
          </el-form-item>
          <el-form-item>
            <el-button v-if="isCreateModel" size="mini" type="primary" @click="onSubmit">立即提交</el-button>
            <el-button v-else size="mini" type="primary" @click="onUpdate">立即修改</el-button>
            <el-button size="mini" @click="handleClose">取消</el-button>
          </el-form-item>
        </el-form>
      </div>

    </el-drawer>

  </div>
</template>

<script>
// B站 「程序员辰星」原创出品
import AutoInput from "@/components/AutoInput.vue"; // 自己封装好的输入框组件
import Editor from "@/components/Editor.vue";
export default {
  components: { AutoInput, Editor }, // 注册组件
  data() {
    return {
      isCreateModel: true, // 是不是新增模式
      fileUploadPath: '/api/v1.0/campus-notice-api/file/upload',
      drawer: false, // 操作抽屉的控制开关变量
      direction: 'rtl', // 操作弹窗显示方向：从右往左
      id: null, // 页面即将删除的数据ID
      apiResult: { // 后端返回的查询数据的响应数据
        data: [], // 数据项
        total: 0, // 符合条件的数据总想 - 初始赋值为0
      },
      notice: {
        title: '',
      },
      content: '', // 公告内容
      noticeQueryDto: { // 搜索条件
        current: 1, // 当前页 - 初始是第一页
        size: 10, // 页面显示大小 - 初始是10条
      },
      dialogDeletedVisible: false, // 删除弹窗控制开关变量 - 初始是关（false）
    };
  },
  created() {
    this.fetchFreshData();
  },
  methods: {
    async handleShowChange(data) {
      try {
        const notice = {
          id: data.id,
          isShow: data.isShow
        }
        await this.$axios.put('/notice/setShowStatus', notice);
        this.$message.success(data.isShow ? "公告展出成功" : '公告已隐藏');
      } catch (error) {
        this.$message.warning(error.message);
        console.error('修改公告展出状态异常:', error);
      }
    },
    // 修改操作
    async handleEdit(param) {
      try {
        const { data } = await this.$axios.get(`/notice/${param.id}`);
        // 打开抽屉
        this.drawer = true;
        // 设置成编辑模式
        this.isCreateModel = false;
        // 设置初始值
        this.notice = { ...data };
        // 设置内容
        this.content = data.content;
      } catch (error) {
        this.$message.warning(error.message);
        console.error('查询公告详情异常:', error);
      }

    },
    // 富文本内容回传
    onListener(text) {
      this.content = text;
    },
    async onUpdate() {
      try {
        this.notice.content = this.content;
        await this.$axios.put('/notice/updateEntity', this.notice);
        this.$message.success('公告修改成功');
        this.handleClose();
        this.fetchFreshData();
      } catch (error) {
        this.$message.warning(error.message);
        console.error('修改公告异常:', error);
      }
    },
    async onSubmit() {
      try {
        this.notice.content = this.content;
        await this.$axios.post('/notice/saveEntity', this.notice);
        this.$message.success('公告新增成功');
        this.handleClose();
        this.fetchFreshData();
      } catch (error) {
        this.$message.warning(error.message);
        console.error('新增公告异常:', error);
      }
    },
    savenoticeOperation() {
      this.drawer = true;
    },
    handleClose() {
      this.drawer = false; // 关闭弹窗
      this.content = ''; // 清除内容
      this.isCreateModel = true; // 恢复成新增模式
      this.notice = {}; // 公告数据清除
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
    // 表格点击删除公告
    handleDelete(row) {
      this.dialogDeletedVisible = true; // 开启删除弹窗确认
      this.id = row.id;
    },
    // 校园公告删除
    async confirmDeleted() {
      try {
        const { code } = await this.$axios.delete(`/notice/${this.id}`);
        if (code === 200) {
          this.$notify.success({
            title: '公告删除',
            message: '删除成功',
            position: 'buttom-right',
            suration: 1000,
          });
          this.dialogDeletedVisible = false; // 关闭删除确认弹窗
          this.id = null; // 将标识ID置位
          this.fetchFreshData(); // 删除校园公告数据之后，重新加载校园公告数据
        }
      } catch (error) {
        console.log("删除校园公告数据异常：", error);
      }
    }
  },
};
</script>
<style scoped lang="scss">
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
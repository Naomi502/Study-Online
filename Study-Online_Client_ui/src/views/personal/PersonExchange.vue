<template>
  <div class="exchange-container">
    <h2 class="page-title">我的兑换</h2>
    <div class="exchange-list">
      <div class="exchange-card" v-for="(item, index) in exchangeList" :key="index">
        <div class="product-info">
          <img :src="item.image" alt="商品图片" class="product-image">
          <div class="product-details">
            <h3 class="product-name">{{ item.name }}</h3>
            <p class="product-desc">{{ item.description }}</p>
            <p class="exchange-time">兑换时间: {{ item.time }}</p>
          </div>
        </div>
        <div class="status-section">
          <span class="status-badge" :class="getStatusClass(item.status)">
            {{ getStatusText(item.status) }}
          </span>
          <button
              class="action-btn"
              v-if="item.status === 1"
              @click="confirmReceipt(item.id)"
          >
            确认收货
          </button>
          <button
              class="action-btn secondary"
              v-if="item.status === 3 || item.status === 4"
              @click="viewLogistics(item.id)"
          >
            查看物流
          </button>
        </div>
      </div>
      <div class="empty-tip" v-if="exchangeList.length === 0">
        <img src="https://placeholder.com/300" alt="无兑换记录">
        <p>暂无兑换记录</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'PersonalExchange',
  data() {
    return {
      exchangeList: []
    }
  },
  created() {
    // 从本地存储获取兑换记录
    const storedExchangeList = JSON.parse(localStorage.getItem('exchangeList'));
    if (storedExchangeList) {
      this.exchangeList = storedExchangeList;
    }
  },
  methods: {
    getStatusClass(status) {
      const statusMap = {
        1: 'status-pending',
        2: 'status-shipped',
        3: 'status-transit',
        4: 'status-completed'
      }
      return statusMap[status] || ''
    },
    getStatusText(status) {
      const textMap = {

        1: '待领取',
        3: '已领取',
        4: '已领取',
        2: '已领取'
      }
      return textMap[status] || '未知状态'
    },
    confirmReceipt(id) {
      this.$confirm('确认收到商品了吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        const index = this.exchangeList.findIndex(item => item.id === id);
        if (index!== -1) {
          this.exchangeList[index].status = 4;
          // 更新本地存储
          localStorage.setItem('exchangeList', JSON.stringify(this.exchangeList));
        }
        this.$message.success('收货确认成功');
      })
    },
    viewLogistics(id) {
      this.$message.info(`查看ID为${id}的物流信息`);
    },
    deleteAllExchanges() {
      localStorage.removeItem('exchangeList');
      this.exchangeList = [];
      this.$message.success('所有兑换记录已删除');
    }
  }
}
</script>

<style scoped>
/* 保持原有的样式不变 */
.exchange-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}
.page-title {
  font-size: 24px;
  color: #333;
  margin-bottom: 30px;
  padding-bottom: 15px;
  border-bottom: 1px solid #eee;
}
.exchange-list {
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.04);
}
.exchange-card {
  padding: 20px;
  border-bottom: 1px solid #f5f5f5;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.exchange-card:last-child {
  border-bottom: none;
}
.product-info {
  display: flex;
  align-items: center;
  flex: 1;
}
.product-image {
  width: 80px;
  height: 80px;
  object-fit: cover;
  border-radius: 4px;
  margin-right: 20px;
}
.product-details {
  flex: 1;
}
.product-name {
  font-size: 16px;
  color: #333;
  margin: 0 0 8px 0;
}
.product-desc {
  font-size: 14px;
  color: #999;
  margin: 0 0 8px 0;
}
.exchange-time {
  font-size: 12px;
  color: #ccc;
  margin: 0;
}
.status-section {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  min-width: 120px;
}
.status-badge {
  display: inline-block;
  padding: 4px 10px;
  border-radius: 12px;
  font-size: 12px;
  margin-bottom: 10px;
}
.status-pending {
  background: #fff3e0;
  color: #ff9800;
}
.status-shipped {
  background: #e3f2fd;
  color: #2196f3;
}
.status-transit {
  background: #e8f5e9;
  color: #4caf50;
}
.status-completed {
  background: #f5f5f5;
  color: #9e9e9e;
}
.action-btn {
  padding: 6px 12px;
  background: #4a90e2;
  color: white;
  border: none;
  border-radius: 4px;
  font-size: 12px;
  cursor: pointer;
  transition: opacity 0.3s;
}
.action-btn:hover {
  opacity: 0.9;
}
.action-btn.secondary {
  background: #f5f5f5;
  color: #666;
}
.empty-tip {
  text-align: center;
  padding: 50px 0;
}
.empty-tip img {
  width: 120px;
  opacity: 0.6;
  margin-bottom: 20px;
}
.empty-tip p {
  color: #999;
  font-size: 14px;
}
</style>
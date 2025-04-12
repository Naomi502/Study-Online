<template>
  <div class="app">
    <Header :ai="activeIndex = 3" />
    <div class="container animated-container">
      <h2 class="section-title">积分商城</h2>
      <div class="prize-grid">
        <PrizeCard
            v-for="(prize, index) in prizes"
            :key="prize.id || index"
            :prize="prize"
            @exchange="handleExchange"
        />
      </div>
    </div>
    <AddressModal
        :visible="showModal"
        :prize="selectedPrize"
        @close="closeModal"
        @submit="handleSubmit"
    />
    <Footer/>
  </div>
</template>

<script>
import Header from '@/components/Header.vue'
import PrizeCard from '@/views/mall/PrizeCard.vue'
import AddressModal from '@/views/mall/AddressModal.vue'
import Footer from '@/components/Footer.vue'
import { prizes } from '@/data/prizes.js'

export default {
  name: 'IntegralMall',
  components: {
    Header,
    Footer,
    PrizeCard,
    AddressModal
  },
  data() {
    return {
      prizes: Array.isArray(prizes) ? prizes : [],
      showModal: false,
      selectedPrize: null
    }
  },
  methods: {
    handleExchange(prize) {
      this.selectedPrize = prize;
      this.showModal = true;
    },
    closeModal() {
      this.showModal = false;
    },
    async handleSubmit(formData) {
      try {

        console.log('开始兑换', formData); // 调试信息
        const exchangeList = JSON.parse(localStorage.getItem('exchangeList')) || [];
        const newExchangeItem = {
          id: Date.now(),
          name: formData.prize.name,
          description: formData.prize.description,
          image: formData.prize.image,
          time: new Date().toLocaleString(),
          status: 1,
          addressInfo: {
            name: formData.name,
            phone: formData.phone,
            address: formData.address
          }
        };
        exchangeList.unshift(newExchangeItem);
        localStorage.setItem('exchangeList', JSON.stringify(exchangeList));
        console.log('本地存储完成'); // 调试信息
        this.$message(`兑换成功！兑换短信将发送至：${formData.phone}`);

      } catch (error) {
        console.error('兑换失败:', error);
        this.$message.error('兑换失败，请稍后重试');
      } finally {
        this.closeModal();
      }
    }
  }
}
</script>

<style scoped>
.app {
  z-index: 0;
  background-color: #ffffff;
  position: relative;
}

.animated-container {
  animation: fadeInUp 0.8s ease-out;
  opacity: 0;
  animation-fill-mode: forwards;
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.container {
  position: relative;
  max-width: 1400px;
  margin: 200px auto;
  padding: 20px;
}

.section-title {
  color: #333;
  font-size: 24px;
  margin-bottom: 30px;
  padding-left: 10px;
  border-left: 4px solid #4a90e2;
}

.prize-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 50px;
  padding: 20px 0;
}
</style>
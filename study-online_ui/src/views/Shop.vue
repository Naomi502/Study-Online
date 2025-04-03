<template>
  <div class="app">
    <Header/>
    <div class="container animated-container">
      <h2 class="section-title">积分商城</h2>
      <div class="prize-grid">
        <PrizeCard
            v-for="(prize, index) in prizes"
            :key="index"
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
import PrizeCard from '@/views/PrizeCard.vue'
import AddressModal from '@/views/AddressModal.vue'
import Footer from '@/components/Footer.vue'
import { prizes } from '@/data/prizes.js'

export default {
  name: 'App',
  components: {
    Header,
    Footer,
    PrizeCard,
    AddressModal
  },
  data() {
    return {
      labCount: Math.floor(Math.random() * 50) + 10, // 随机实验室数量10-60
      prizes: prizes,
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
    handleSubmit(formData) {
      console.log('兑换信息:', formData);
      alert(`兑换${formData.prize.name}成功!\n我们将尽快发货至:\n${formData.address}\n收货人: ${formData.name}\n电话: ${formData.phone}`);
      this.closeModal();
    }
  }
}
</script>

<style scoped>
.app {
  z-index: 5000;
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
  margin: 0px auto;
  margin-bottom: 200px;
  margin-top: 200px;
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
}
</style>
<template>
  <div class="prize-card" :class="{ 'highlight': prize.highlight }">
    <div class="prize-header">
      <h3>{{ prize.name }}</h3>
      <span class="tag" v-if="prize.tag">{{ prize.tag }}</span>
    </div>
    <div class="prize-card-image" >
      <img style="width: 269px; height: 160px; border-radius: 10px;":src="prize.image" :alt="prize.name" />
    </div>
    <div class="prize-content">
      <p class="description" v-if="prize.description">{{ prize.description }}</p>
      <div class="price-section">
        <span class="price">{{ prize.price }}</span>
        <span class="original-price" v-if="prize.originalPrice">{{ prize.originalPrice }}</span>
      </div>
      <div class="time-left" v-if="prize.timeLeft">
        剩余时间: {{ prize.timeLeft }}
      </div>
    </div>
    <button class="exchange-btn" @click="exchange">
      {{ prize.buttonText || '立即兑换' }}
    </button>
  </div>
</template>

<script>
export default {
  name: 'PrizeCard',
  props: {
    prize: {
      type: Object,
      required: true
    }
  },
  methods: {
    exchange() {
      this.$emit('exchange', this.prize);
    }
  }
}
</script>

<style scoped>
.prize-card {
  background: white;
  border-radius: 10px;
  padding: 20px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
  display: flex;
  flex-direction: column;
  transition: transform 0.3s, box-shadow 0.3s;
}

.prize-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
}

.prize-card.highlight {
  border: 2px solid #ff9800;
  position: relative;
  overflow: hidden;
}

.prize-card.highlight::before {
  content: '热门';
  position: absolute;
  top: 10px;
  right: -25px;
  background: #ff9800;
  color: white;
  padding: 2px 30px;
  transform: rotate(45deg);
  font-size: 12px;
}

.prize-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 15px;
  border-bottom: 1px solid #eee;
  padding-bottom: 10px;
}

.prize-header h3 {
  margin: 0;
  color: #333;
  font-size: 18px;
}

.tag {
  background: #e3f2fd;
  color: #1976d2;
  padding: 3px 8px;
  border-radius: 4px;
  font-size: 12px;
}

.description {
  color: #666;
  font-size: 14px;
  margin: 10px 0;
}

.price-section {
  margin: 15px 0;
}

.price {
  font-size: 24px;
  color: #ff5722;
  font-weight: bold;
}

.original-price {
  font-size: 14px;
  color: #999;
  text-decoration: line-through;
  margin-left: 8px;
}

.time-left {
  font-size: 12px;
  color: #888;
  margin-bottom: 15px;
}

.exchange-btn {
  background: linear-gradient(135deg, #4a90e2, #6a5acd);
  color: white;
  border: none;
  padding: 10px;
  border-radius: 5px;
  cursor: pointer;
  font-size: 16px;
  margin-top: auto;
  transition: opacity 0.3s;
}

.exchange-btn:hover {
  opacity: 0.9;
}
</style>
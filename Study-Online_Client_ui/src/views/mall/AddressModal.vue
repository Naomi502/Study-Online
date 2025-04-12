<template>
  <div class="modal-overlay" v-if="visible">
    <div class="modal-container">
      <div class="modal-header">
        <h3>填写收货信息</h3>
        <button class="close-btn" @click="close">&times;</button>
      </div>
      <div class="modal-content">
        <form @submit.prevent="submitForm">
          <div class="form-group">
            <label>收货人姓名</label>
            <input
                type="text"
                v-model="form.name"
                placeholder="请输入姓名"
                required
            >
          </div>
          <div class="form-group">
            <label>手机号码</label>
            <input
                type="tel"
                v-model="form.phone"
                placeholder="请输入手机号"
                pattern="[0-9]{11}"
                required
            >
          </div>


          <div class="form-actions">
            <button type="button" class="cancel-btn" @click="close">取消</button>
            <button type="submit" class="submit-btn">确认兑换</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'AddressModal',
  props: {
    visible: {
      type: Boolean,
      default: false
    },
    prize: {
      type: Object,
      default: null
    }
  },
  data() {
    return {
      form: {
        name: '',
        phone: '',
        address: '',
        postcode: ''
      }
    }
  },
  methods: {
    close() {
      this.$emit('close');
    },
    submitForm() {
      if (this.validateForm()) {
        this.$emit('submit', {
          ...this.form,
          prize: this.prize
        });
        this.resetForm();
      }
    },
    validateForm() {
      if (!this.form.name.trim()) {
        alert('请输入收货人姓名');
        return false;
      }
      if (!/^1[3-9]\d{9}$/.test(this.form.phone)) {
        alert('请输入正确的手机号码');
        return false;
      }

      return true;
    },
    resetForm() {
      this.form = {
        name: '',
        phone: '',
        address: '',
        postcode: ''
      }
    }
  }
}
</script>

<style scoped>
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.modal-container {
  background-color: white;
  border-radius: 10px;
  width: 90%;
  max-width: 500px;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
  animation: modal-fade-in 0.3s;
}

@keyframes modal-fade-in {
  from {
    opacity: 0;
    transform: translateY(-20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.modal-header {
  padding: 15px 20px;
  border-bottom: 1px solid #eee;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.modal-header h3 {
  margin: 0;
  color: #333;
}

.close-btn {
  background: none;
  border: none;
  font-size: 24px;
  cursor: pointer;
  color: #999;
  padding: 0 10px;
}

.close-btn:hover {
  color: #333;
}

.modal-content {
  padding: 20px;
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  margin-bottom: 8px;
  color: #555;
  font-weight: 500;
}

.form-group input,
.form-group textarea {
  width: 100%;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
  transition: border-color 0.3s;
}

.form-group input:focus,
.form-group textarea:focus {
  border-color: #4a90e2;
  outline: none;
}

.form-group textarea {
  resize: vertical;
}

.form-actions {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
  margin-top: 20px;
}

.cancel-btn {
  padding: 10px 20px;
  background-color: #f5f5f5;
  border: none;
  border-radius: 4px;
  color: #666;
  cursor: pointer;
  transition: background-color 0.3s;
}

.cancel-btn:hover {
  background-color: #e0e0e0;
}

.submit-btn {
  padding: 10px 20px;
  background: linear-gradient(135deg, #4a90e2, #6a5acd);
  border: none;
  border-radius: 4px;
  color: white;
  cursor: pointer;
  transition: opacity 0.3s;
}

.submit-btn:hover {
  opacity: 0.9;
}
</style>
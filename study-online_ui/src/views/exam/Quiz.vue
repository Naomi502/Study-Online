<template>
  <div class="quiz-page">
    <Header :ai="activeIndex = 2" />

    <!-- 添加页面过渡动画 -->
    <transition :name="transitionName" mode="out-in">
      <!-- 每日挑战入口 -->
      <div v-if="!showQuiz" key="stats" class="stats-container">
      <div class="daily-quiz-section">
        <div class="quiz-header">
          <h2>📚 每日十题</h2>
          <p class="quiz-intro">
            每日精选10道高质量编程题目，涵盖核心知识点，助你稳步提升开发能力。
            完成挑战可获得积分奖励，连续打卡解锁额外成就！
          </p>
        </div>

        <div class="stats-wrapper">
          <div class="user-stats">
            <h3>我的学习数据</h3>
            <div class="stats-grid">
              <div class="stat-item">
                <div class="stat-value">{{ userStats.points }}</div>
                <div class="stat-label">累计积分</div>
              </div>
              <div class="stat-item">
                <div class="stat-value">{{ userStats.accuracy }}%</div>
                <div class="stat-label">平均正确率</div>
              </div>
              <div class="stat-item">
                <div class="stat-value">{{ userStats.streakDays }}</div>
                <div class="stat-label">连续学习天数</div>
              </div>
            </div>
          </div>

          <div class="leaderboard">
            <h3>学霸排行榜</h3>
            <div class="rank-list">
              <div v-for="(user, index) in leaderboard" :key="user.id" class="rank-item">
                <span class="rank-number">#{{ index + 1 }}</span>
                <span class="rank-name">{{ user.name }}</span>
                <span class="rank-points">{{ user.points }} 积分</span>
              </div>
            </div>
          </div>
        </div>

        <button class="start-quiz-btn" @click="startQuiz">开始挑战</button>
      </div>
    </div>

      <!-- 答题主界面 -->
      <div v-else key="quiz" class="quiz-container">
      <div class="quiz-progress">
        <span>第 {{ currentQuestionIndex + 1 }} 题 / 共 {{ questions.length }} 题</span>
        <div class="progress-bar">
          <div
              class="progress"
              :style="{ width: `${(currentQuestionIndex + 1) / questions.length * 100}%` }"
          ></div>
        </div>
      </div>

      <div class="quiz-question">
        <h2>{{ currentQuestion.text }}</h2>
        <div v-if="currentQuestion.image" class="question-image">
          <img :src="currentQuestion.image" :alt="'题目图片'">
        </div>
      </div>

      <div class="quiz-options">
        <div
            v-for="(option, index) in currentQuestion.options"
            :key="index"
            class="option"
            :class="{
            'selected': selectedOption === index,
            'correct': showResult && index === currentQuestion.correctAnswer,
            'incorrect': showResult && selectedOption === index && index !== currentQuestion.correctAnswer
          }"
            @click="selectOption(index)"
        >
          <span class="option-letter">{{ String.fromCharCode(65 + index) }}.</span>
          <span class="option-text">{{ option }}</span>
        </div>
      </div>

      <div class="quiz-actions">
        <button
            v-if="currentQuestionIndex > 0"
            @click="prevQuestion"
            class="btn-prev"
        >
          上一题
        </button>

        <button
            v-if="!showResult && selectedOption !== null"
            @click="submitAnswer"
            class="btn-submit"
        >
          提交答案
        </button>

        <button
            v-if="showResult && currentQuestionIndex < questions.length - 1"
            @click="nextQuestion"
            class="btn-next"
        >
          下一题
        </button>

        <button
            v-if="showResult && currentQuestionIndex === questions.length - 1"
            @click="showFinalResult"
            class="btn-finish"
        >
          查看结果
        </button>
      </div>

      <div v-if="showResult" class="quiz-feedback">
        <div v-if="selectedOption === currentQuestion.correctAnswer" class="feedback-correct">
          <i class="icon-correct"></i>
          <span>回答正确！</span>
        </div>
        <div v-else class="feedback-incorrect">
          <i class="icon-incorrect"></i>
          <span>回答错误！正确答案是 {{ String.fromCharCode(65 + currentQuestion.correctAnswer) }}</span>
        </div>
        <div v-if="currentQuestion.explanation" class="explanation">
          <p>{{ currentQuestion.explanation }}</p>
        </div>
      </div>

      <div v-if="showFinalScore" class="result-modal">
        <div class="result-content">
          <h2>答题完成！</h2>
          <p>你的得分: {{ score }} / {{ questions.length }}</p>
          <p>正确率: {{ Math.round(score / questions.length * 100) }}%</p>
          <button @click="restartQuiz" class="btn-restart">重新答题</button>
        </div>
      </div>
    </div>
    </transition>

    <Footer v-show="footerShow" />
  </div>
</template>

<script>
import Header from '@/components/Header.vue';
import Footer from '@/components/Footer.vue';

export default {
  name: 'QuizPage',
  components: {
    Header,
    Footer
  },
  data() {
    return {
      transitionName: 'slide-fade', // 过渡效果名称
      showQuiz: false,
      userStats: {
        points: 1280,
        accuracy: 85,
        streakDays: 7
      },
      leaderboard: [
        { id: 1, name: '王立群', points: 3500 },
        { id: 2, name: '张峰', points: 2980 },
        { id: 3, name: '沈蓝翔', points: 2450 },
        { id: 4, name: '李慧珊', points: 1820 },
        { id: 5, name: '徐璐洁', points: 1560 }
      ],
      activeIndex: '3',
      footerShow: false,
      questions: [
        {
          text: 'Vue.js 是由谁创建的？',
          options: [
            'Evan You',
            'Dan Abramov',
            'Taylor Otwell',
            'Ryan Dahl'
          ],
          correctAnswer: 0,
          explanation: 'Vue.js 是由 Evan You 创建的，他之前在 Google 工作，使用 AngularJS 后决定创建一个更轻量级的框架。'
        },
        {
          text: '以下哪个指令用于条件渲染？',
          options: [
            'v-for',
            'v-if',
            'v-bind',
            'v-model'
          ],
          correctAnswer: 1,
          explanation: 'v-if 是 Vue 中用于条件渲染的指令，它会根据表达式的真假值来添加或移除 DOM 元素。'
        },
        {
          text: 'Vue 3 的 Composition API 主要解决了什么问题？',
          options: [
            '提高性能',
            '更好的 TypeScript 支持',
            '更好的代码组织和复用',
            '更小的打包体积'
          ],
          correctAnswer: 2,
          explanation: 'Composition API 主要解决了在复杂组件中逻辑关注点分散的问题，提供了更好的代码组织和复用能力。'
        },
        {
          text: 'React 的 Context API 主要用于解决什么问题？',
          options: [
            '简化组件之间的通信',
            '提高组件的渲染性能',
            '减少组件的嵌套层级',
            '增强组件的样式控制'
          ],
          correctAnswer: 3,
          explanation: 'Context API 主要用于解决组件之间的样式控制问题，它可以让组件在不使用 props 的情况下共享数据。'
        },
        {
          text: '以下哪个指令用于事件监听？',
          options: [
            'v-on',
            'v-bind',
            'v-model',
            'v-text'
          ],
          correctAnswer: 4,
          explanation: 'v-on 是 Vue 中用于事件监听的指令，它可以绑定 DOM 事件到组件的方法上。'
        },
        {
          text: 'Vue 3 的响应式系统是如何实现的？',
          options: [
            '基于 Proxy',
            '基于 Object.defineProperty',
            '基于发布-订阅模式',
            '基于观察者模式'
          ],
          correctAnswer:5,
          explanation: 'Vue 3 的响应式系统是基于 Proxy 实现的，它可以拦截对象的读写操作，实现数据的响应式更新。'
        },
        {
          text: '以下哪个指令用于双向绑定？',
          options: [
            'v-bind',
            'v-model',
            'v-on',
            'v-for'
          ],
          correctAnswer: 6,
          explanation: 'v-model 是 Vue 中用于双向绑定的指令，它可以将表单元素的值和组件的数据进行双向同步。'
        },
        {
          text: 'CSS 中 Flexbox 布局的主要优势是什么？',
          options: [
            '方便地实现弹性布局',
            '提高页面的加载速度',
            '增强页面的响应式设计',
            '减少 CSS 代码的编写量'
          ],
          correctAnswer: 7,
          explanation: 'Flexbox 布局的主要优势是方便地实现弹性布局，它可以根据容器的大小自动调整子元素的大小和位置。'
        },
        {
          text: '以下哪个指令用于条件渲染？',
          options: [
            'v-if',
            'v-else',
            'v-show',
            'v-for'
          ],
          correctAnswer: 8,
          explanation: 'v-if 是 Vue 中用于条件渲染的指令，它会根据表达式的真假值来添加或移除 DOM 元素。'
        },
        {
          text: 'Git 中分支的主要作用是什么？',
          options: [
            '并行开发不同的功能',
            '合并代码时减少冲突',
            '提高代码的提交速度',
            '管理代码的版本号'
          ],
          correctAnswer: 9,
          explanation: '分支的主要作用是并行开发不同的功能，它可以让开发者在不影响主线代码的情况下进行工作。'
        }
      ],
      currentQuestionIndex: 0,
      selectedOption: null,
      showResult: false,
      score: 0,
      showFinalScore: false,
      userAnswers: []
    }
  },
  computed: {
    currentQuestion() {
      return this.questions[this.currentQuestionIndex]
    }
  },
  mounted() {
    setTimeout(() => {
      this.footerShow = true;
    }, 150);
  },
  methods: {
    startQuiz() {
      this.transitionName = 'slide-fade-forward'
      this.showQuiz = true
      window.scrollTo({ top: 0, behavior: 'smooth' })
    },
    selectOption(index) {
      if (!this.showResult) {
        this.selectedOption = index
      }
    },
    submitAnswer() {
      this.showResult = true
      if (this.selectedOption === this.currentQuestion.correctAnswer) {
        this.score++
      }
      this.userAnswers[this.currentQuestionIndex] = this.selectedOption
    },
    nextQuestion() {
      if (this.currentQuestionIndex < this.questions.length - 1) {
        this.currentQuestionIndex++
        this.resetQuestionState()
      }
    },
    prevQuestion() {
      if (this.currentQuestionIndex > 0) {
        this.currentQuestionIndex--
        this.resetQuestionState()
        if (this.userAnswers[this.currentQuestionIndex] !== undefined) {
          this.selectedOption = this.userAnswers[this.currentQuestionIndex]
        }
      }
    },
    resetQuestionState() {
      this.selectedOption = null
      this.showResult = false
    },
    showFinalResult() {
      this.showFinalScore = true
    },
    restartQuiz() {
      this.transitionName = 'slide-fade-backward'
      this.showQuiz = false;
      this.currentQuestionIndex = 0
      this.selectedOption = null
      this.showResult = false
      this.score = 0
      this.showFinalScore = false
      this.userAnswers = []
    }
  }
}
</script>

<style scoped>
.quiz-page {
  width: 100%;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background: #ffffff;
}

/* 每日挑战样式 */
.daily-quiz-section {
  width: 100%;
  max-width: 1200px;
  margin: 130px auto 0;
  margin-bottom: 200px;
  padding: 40px 20px;
}

.quiz-header {
  text-align: center;
  margin-bottom: 40px;
}

.quiz-header h2 {
  font-size: 2.5rem;
  color: #2c3e50;
  margin-bottom: 20px;
}

.quiz-intro {
  color: #666;
  font-size: 1.1rem;
  line-height: 1.8;
  max-width: 800px;
  margin: 0 auto;
}

.stats-wrapper {
  display: flex;
  gap: 30px;
  margin: 40px 0;
}

.user-stats, .leaderboard {
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  padding: 24px;
  flex: 1;
}

.user-stats {
  flex: 0 0 400px;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
  margin-top: 20px;
}

.stat-item {
  text-align: center;
  padding: 15px;
  background: #f8f9fa;
  border-radius: 8px;
  transition: transform 0.2s;
}

.stat-item:hover {
  transform: translateY(-3px);
}

.stat-value {
  font-size: 24px;
  font-weight: bold;
  color: #42b983;
}

.stat-label {
  color: #666;
  font-size: 14px;
  margin-top: 8px;
}

.leaderboard h3, .user-stats h3 {
  color: #333;
  margin-bottom: 20px;
  font-size: 20px;
}

.rank-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.rank-item {
  display: flex;
  align-items: center;
  padding: 12px;
  background: #f8f9fa;
  border-radius: 6px;
  transition: transform 0.2s;
}

.rank-item:hover {
  transform: translateX(5px);
}

.rank-number {
  width: 40px;
  color: #666;
}

.rank-name {
  flex: 1;
  font-weight: 500;
}

.rank-points {
  color: #42b983;
  font-weight: bold;
}

.start-quiz-btn {
  display: block;
  margin: 40px auto 0;
  padding: 16px 48px;
  font-size: 1.2rem;
  background: linear-gradient(135deg, #42b983, #369f6b);
  color: white;
  border: none;
  border-radius: 30px;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.start-quiz-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 12px rgba(66, 185, 131, 0.3);
}

/* 答题界面样式 */
.quiz-container {
  width: 900px;
  margin: 140px auto 40px;
  padding: 30px;
  font-family: 'Arial', sans-serif;
  flex: 1;
  background: white;
  border-radius: 16px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.05);
}

.quiz-progress {
  margin-bottom: 30px;
}

.progress-bar {
  height: 8px;
  background-color: #f0f0f0;
  border-radius: 4px;
  margin-top: 8px;
}

.progress {
  height: 100%;
  background-color: #42b983;
  border-radius: 4px;
  transition: width 0.3s ease;
}

.quiz-question {
  margin-bottom: 30px;
}

.quiz-question h2 {
  font-size: 1.5rem;
  color: #333;
  margin-bottom: 15px;
  line-height: 1.4;
}

.question-image img {
  max-width: 100%;
  border-radius: 8px;
  margin-top: 10px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.quiz-options {
  margin-bottom: 30px;
}

.option {
  padding: 15px;
  margin-bottom: 10px;
  border: 1px solid #eee;
  border-radius: 8px;
  cursor: pointer;
  display: flex;
  align-items: center;
  transition: all 0.3s ease;
}

.option:hover {
  background-color: #f8fafc;
}

.option.selected {
  background-color: #e1f5fe;
  border-color: #4fc3f7;
}

.option.correct {
  background-color: #e8f5e9;
  border-color: #81c784;
}

.option.incorrect {
  background-color: #ffebee;
  border-color: #e57373;
}

.option-letter {
  font-weight: bold;
  margin-right: 10px;
  color: #555;
}

.quiz-actions {
  display: flex;
  justify-content: space-between;
  margin-bottom: 20px;
}

button {
  padding: 12px 24px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 1rem;
  transition: all 0.3s ease;
}

.btn-prev {
  background-color: #f0f0f0;
  color: #333;
}

.btn-prev:hover {
  background-color: #e0e0e0;
}

.btn-submit {
  background-color: #42b983;
  color: white;
}

.btn-submit:hover {
  background-color: #369f6b;
}

.btn-next, .btn-finish {
  background-color: #2196f3;
  color: white;
}

.btn-next:hover, .btn-finish:hover {
  background-color: #0d8bf2;
}

.btn-restart {
  background-color: #ff9800;
  color: white;
  margin-top: 20px;
}

.btn-restart:hover {
  background-color: #f57c00;
}

.quiz-feedback {
  padding: 15px;
  border-radius: 8px;
  margin-bottom: 20px;
}

.feedback-correct {
  color: #2e7d32;
  display: flex;
  align-items: center;
}

.feedback-incorrect {
  color: #c62828;
  display: flex;
  align-items: center;
}

.icon-correct, .icon-incorrect {
  display: inline-block;
  width: 20px;
  height: 20px;
  margin-right: 10px;
}

.icon-correct {
  background-color: #2e7d32;
  mask: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath d='M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41L9 16.17z'/%3E%3C/svg%3E");
}

.icon-incorrect {
  background-color: #c62828;
  mask: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath d='M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12 19 6.41z'/%3E%3C/svg%3E");
}

.explanation {
  margin-top: 15px;
  padding: 10px;
  background-color: #f5f5f5;
  border-radius: 4px;
  color: #555;
}

.result-modal {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 3000;
}

.result-content {
  background-color: white;
  padding: 30px;
  border-radius: 8px;
  text-align: center;
  max-width: 500px;
  width: 90%;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
}

.result-content h2 {
  color: #42b983;
  margin-bottom: 20px;
}

.result-content p {
  font-size: 1.2rem;
  margin: 10px 0;
}

@media (max-width: 768px) {
  .stats-wrapper {
    flex-direction: column;
  }

  .quiz-header h2 {
    font-size: 2rem;
  }

  .start-quiz-btn {
    width: 90%;
    max-width: 300px;

  }

  .quiz-container {
    width: 90%;
    padding: 20px;
    margin-top: 30px;
  }

  .quiz-question h2 {
    font-size: 1.3rem;
  }
}
</style>

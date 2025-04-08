<template>
  <div class="quiz-page">
    <Header :ai="activeIndex = 2" />

    <!-- 添加页面过渡动画 -->
    <transition :name="transitionName" mode="out-in">
      <!-- 每日挑战入口 -->
      <div v-if="currentStep === 'home'" key="stats" class="stats-container">
        <div class="daily-quiz-section">
          <div class="quiz-header">
            <h2>📚 专业测试</h2>
            <p class="quiz-intro">
              每日精选10道高质量题目，涵盖核心知识点，助你稳步提升开发能力。
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

          <button class="start-quiz-btn" @click="currentStep = 'courseSelect'">开始挑战</button>
        </div>
      </div>

      <!-- 课程选择界面 -->
      <div v-else-if="currentStep === 'courseSelect'" key="courseSelect" class="course-select-container">
        <div class="course-select-card">
          <h2>请选择测试课程</h2>
          <div class="course-list">
            <div
                v-for="course in courses"
                :key="course.id"
                class="course-item"
                :class="{ 'selected': selectedCourse === course.id }"
                @click="selectCourse(course.id)"
            >
              <div class="course-icon">
                <i :class="course.icon"></i>
              </div>
              <div class="course-info">
                <h3>{{ course.name }}</h3>
                <p>{{ course.description }}</p>
              </div>
            </div>
          </div>
          <div class="course-select-actions">
            <button class="btn-back" @click="currentStep = 'home'">返回</button>
            <button
                class="btn-start"
                :disabled="!selectedCourse"
                @click="startQuiz"
            >
              开始测试
            </button>
          </div>
        </div>
      </div>

      <!-- 答题主界面 -->
      <div v-else key="quiz" class="quiz-container">
        <div class="quiz-progress">
          <span>第 {{ currentQuestionIndex + 1 }} 题 / 共 {{ currentQuestions.length }} 题</span>
          <div class="progress-bar">
            <div
                class="progress"
                :style="{ width: `${(currentQuestionIndex + 1) / currentQuestions.length * 100}%` }"
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
              v-if="showResult && currentQuestionIndex < currentQuestions.length - 1"
              @click="nextQuestion"
              class="btn-next"
          >
            下一题
          </button>

          <button
              v-if="showResult && currentQuestionIndex === currentQuestions.length - 1"
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
            <p>你的得分: {{ score }} / {{ currentQuestions.length }}</p>
            <p>正确率: {{ Math.round(score / currentQuestions.length * 100) }}%</p>
            <div class="result-actions">
              <button @click="restartQuiz" class="btn-restart">重新答题</button>
              <button @click="backToCourseSelect" class="btn-back">选择其他课程</button>
            </div>
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

// 导入不同课程的题目

import reactQuestions from '@/data/reactQuestions';
import javascriptQuestions from '@/data/javascriptQuestions';
import cssQuestions from '@/data/cssQuestions';

import {safeQuestions,fillInTheBlanks} from "@/data/safetyQuestions";


export default {
  name: 'QuizPage',
  components: {
    Header,
    Footer
  },
  data() {
    return {
      transitionName: 'slide-fade', // 过渡效果名称
      currentStep: 'home', // 'home', 'courseSelect', 'quiz'
      selectedCourse: null,
      fillInQuestions: fillInTheBlanks,
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
      courses: [
        {
          id: 'safety',
          name: 'Safety',
          description: '清华大学实验室安全课程--M&E安全,快速了解安全知识, 提高安全意识',
          icon: 'icon-safety'
        },
        {
          id: 'react',
          name: 'React',
          description: '用于构建用户界面的JavaScript库',
          icon: 'icon-react'
        },
        {
          id: 'javascript',
          name: 'JavaScript',
          description: 'Web开发的核心编程语言',
          icon: 'icon-js'
        },
        {
          id: 'css',
          name: 'CSS',
          description: '样式表语言，用于描述HTML文档的呈现',
          icon: 'icon-css'
        }
      ],
      activeIndex: '3',
      footerShow: false,
      // 各课程题目将在created中初始化
      allQuestions: {},
      currentQuestions: [],
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
      return this.currentQuestions[this.currentQuestionIndex]
    }
  },
  created() {
    // 初始化各课程题目
    this.allQuestions = {
      safety: safeQuestions,
      react: reactQuestions,
      javascript: javascriptQuestions,
      css: cssQuestions
    };
  },
  mounted() {
    setTimeout(() => {
      this.footerShow = true;
    }, 150);
  },
  methods: {
    selectCourse(courseId) {
      this.selectedCourse = courseId;
    },
    startQuiz() {
      if (!this.selectedCourse) return;

      this.transitionName = 'slide-fade-forward';
      this.currentQuestions = this.allQuestions[this.selectedCourse];
      this.currentStep = 'quiz';
      window.scrollTo({ top: 0, behavior: 'smooth' });
    },
    selectOption(index) {
      if (!this.showResult) {
        this.selectedOption = index;
      }
    },
    submitAnswer() {
      this.showResult = true;
      if (this.selectedOption === this.currentQuestion.correctAnswer) {
        this.score++;
      }
      this.userAnswers[this.currentQuestionIndex] = this.selectedOption;
    },
    nextQuestion() {
      if (this.currentQuestionIndex < this.currentQuestions.length - 1) {
        this.currentQuestionIndex++;
        this.resetQuestionState();
      }
    },
    prevQuestion() {
      if (this.currentQuestionIndex > 0) {
        this.currentQuestionIndex--;
        this.resetQuestionState();
        if (this.userAnswers[this.currentQuestionIndex] !== undefined) {
          this.selectedOption = this.userAnswers[this.currentQuestionIndex];
        }
      }
    },
    resetQuestionState() {
      this.selectedOption = null;
      this.showResult = false;
    },
    showFinalResult() {
      this.showFinalScore = true;
    },
    restartQuiz() {
      this.transitionName = 'slide-fade-forward';
      this.currentQuestionIndex = 0;
      this.selectedOption = null;
      this.showResult = false;
      this.score = 0;
      this.showFinalScore = false;
      this.userAnswers = [];
      window.scrollTo({ top: 0, behavior: 'smooth' });
    },
    backToCourseSelect() {
      this.transitionName = 'slide-fade-backward';
      this.currentStep = 'courseSelect';
      this.currentQuestionIndex = 0;
      this.selectedOption = null;
      this.showResult = false;
      this.score = 0;
      this.showFinalScore = false;
      this.userAnswers = [];
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

/* 课程选择界面样式 */
.course-select-container {
  width: 100%;
  max-width: 1200px;
  margin: 130px auto 200px;
  padding: 0 20px;
}

.course-select-card {
  background: white;
  border-radius: 16px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.05);
  padding: 40px;
}

.course-select-card h2 {
  text-align: center;
  font-size: 2rem;
  color: #2c3e50;
  margin-bottom: 30px;
}

.course-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
  margin-bottom: 40px;
}

.course-item {
  display: flex;
  padding: 20px;
  border: 1px solid #eee;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.course-item:hover {
  transform: translateY(-3px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.course-item.selected {
  border-color: #42b983;
  background-color: #f0f9f5;
}

.course-icon {
  width: 50px;
  height: 50px;
  background-color: #f5f5f5;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 15px;
  font-size: 24px;
  color: #42b983;
}

.course-item.selected .course-icon {
  background-color: #e1f5eb;
}

.course-info h3 {
  font-size: 1.2rem;
  color: #333;
  margin-bottom: 5px;
}

.course-info p {
  font-size: 0.9rem;
  color: #666;
  line-height: 1.5;
}

.course-select-actions {
  display: flex;
  justify-content: center;
  gap: 20px;
}

.btn-back {
  padding: 12px 24px;
  background-color: #f0f0f0;
  color: #333;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.btn-back:hover {
  background-color: #e0e0e0;
}

.btn-start {
  padding: 12px 24px;
  background: linear-gradient(135deg, #42b983, #369f6b);
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.btn-start:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(66, 185, 131, 0.3);
}

.btn-start:disabled {
  background: #cccccc;
  cursor: not-allowed;
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

.result-actions {
  display: flex;
  justify-content: center;
  gap: 15px;
  margin-top: 20px;
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

  .course-select-card {
    padding: 20px;
  }

  .course-list {
    grid-template-columns: 1fr;
  }

  .quiz-container {
    width: 90%;
    padding: 20px;
    margin-top: 30px;
  }

  .quiz-question h2 {
    font-size: 1.3rem;
  }

  .result-actions {
    flex-direction: column;
    gap: 10px;
  }
}
</style>
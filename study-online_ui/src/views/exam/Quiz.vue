<template>

  <div class="quiz-page">
    <Header :ai="activeIndex = 2" />
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
                <div v-for="(item, index) in pointsRanking" :key="item.userId" class="rank-item">
                  <span class="rank-number">#{{ index + 1 }}</span>
                  <div class="user-info">
                    <img :src="item.user.img" alt="头像" class="user-avatar">
                    <span class="rank-name">{{ item.user.loginName }}</span>
                  </div>
                  <span class="rank-points">{{ item.score }} 积分</span>
                </div>
              </div>
            </div>
          </div>

          <button class="start-quiz-btn" @click="currentStep = 'courseSelect'">开始挑战</button>
        </div>
      </div>

      <!-- 课程选择界面 -->
    <!-- 修改课程选择容器部分 -->
    <div v-else-if="currentStep === 'courseSelect'" key="courseSelect" class="course-select-container">
      <transition name="fade">
        <div v-if="isLoading" class="loading-mask">
          <div class="loader">
            <div class="loader-spinner"></div>
            <div class="loader-text">正在加载题目中，请稍候...</div>
          </div>
        </div>
      </transition>
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
              <div class="course-img">
                <img :src="course.img" :alt="'课程图片'" style="width: 100%; height: 100%; border-radius: 5px;">
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
    <div v-else-if="currentStep === 'quiz'" key="quiz" class="quiz-container">
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
          <!-- 左边：始终显示的上一题按钮 -->
          <div class="btn-group">
          <button
              @click="prevQuestion"
              class="btn-prev"
              :disabled="currentQuestionIndex === 0"
          >
            上一题
          </button>
            <button
                class="btn-end"
                @click="endQuiz"
                :disabled="showFinalScore"
            >
              结束答题
            </button>
          </div>
          <div class="action-group">
            <template v-if="!showResult">
              <button
                  v-if="selectedOption !== null"
                  @click="submitAnswer"
                  class="btn-submit"
              >
                提交答案
              </button>
            </template>
            <template v-else>
              <button
                  v-if="currentQuestionIndex < currentQuestions.length - 1"
                  @click="nextQuestion"
                  class="btn-next"
              >
                下一题
              </button>
              <button
                  v-else
                  @click="showFinalResult"
                  class="btn-finish"
              >
                查看结果
              </button>
            </template>
          </div>

          <!-- 右边：始终可用的结束答题按钮 -->

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
      </div>
    <!-- 新增答题回顾页面 -->
    <div v-else-if="currentStep === 'review'" class="review-container">
      <div class="review-header">
        <h2>📝 答题回顾</h2>
        <div class="score-summary">
          <div class="score-item">
            <span class="score-label">总得分</span>
            <span class="score-value">{{ score }}/{{ currentQuestions.length }}</span>
          </div>
          <div class="score-item">
            <span class="score-label">正确率</span>
            <span class="score-value">{{ Math.round((score / currentQuestions.length) * 100) }}%</span>
          </div>
        </div>
      </div>
      <div class="review-actions">
        <button @click="backToCourseSelect" class="btn-back">
          ← 返回课程选择
        </button>
        <button @click="restartQuiz" class="btn-restart">
          🔄 重新挑战
        </button>
      </div>
      <div class="questions-list">
        <div
            v-for="(question, index) in currentQuestions"
            :key="index"
            class="question-item"
            :class="{'correct-answer': isCorrect(index), 'wrong-answer': !isCorrect(index)}"
        >
          <div class="question-header">
            <h3>第 {{ index + 1 }} 题</h3>
            <span class="answer-status">
              {{ isCorrect(index) ? '✅ 正确' : '❌ 错误' }}
            </span>
          </div>

          <div class="original-question">
            <p class="question-text">{{ question.text }}</p>
            <div v-if="question.image" class="question-image">
              <img :src="question.image" alt="题目图片">
            </div>
          </div>

          <div class="answer-analysis">
            <div class="user-answer">
              <span>你的答案：</span>
              <span class="user-option">
                {{ String.fromCharCode(65 + userAnswers[index]) }}
                <span v-if="!isCorrect(index)" class="wrong-mark">（错误）</span>
              </span>
            </div>
            <div class="correct-answer">
              <span>正确答案：</span>
              <span class="correct-option">
                {{ String.fromCharCode(65 + question.correctAnswer) }}
              </span>
            </div>
            <div v-if="question.explanation" class="explanation">
              <h4>答案解析：</h4>
              <p>{{ question.explanation }}</p>
            </div>
          </div>

          <div class="options-review">
            <div
                v-for="(option, optIndex) in question.options"
                :key="optIndex"
                class="option-item"
                :class="{
                'correct': optIndex === question.correctAnswer,
                'selected': optIndex === userAnswers[index],
                'wrong-selected': !isCorrect(index) && optIndex === userAnswers[index]
              }"
            >
              <span class="option-letter">{{ String.fromCharCode(65 + optIndex) }}.</span>
              <span class="option-text">{{ option }}</span>
            </div>
          </div>
        </div>
      </div>


    </div>

    <Footer v-show="footerShow" />
  </div>

</template>

<script>
import Header from '@/components/Header.vue';
import Footer from '@/components/Footer.vue';
import { getAllScore } from '@/api/score.js'
import {mksQuestions,fillInTheBlanks} from "@/data/mksQuestions";
import gfzQuestions from "@/data/gfzQuestions";
import pwfQuestions from "@/data/pwfQuestions";
import xdyhQuestions from "@/data/xdyhQuestions";

export default {
  name: 'QuizPage',
  components: {
    Header,
    Footer
  },
  data() {
    return {
      transitionName: 'slide-fade', // 过渡效果名称
      currentStep: 'home', // 新增 'loading' 状态
      loadingTimeout: null, // 新增 'loading' 状态超时计时器
      isLoading: false,  // 新增加载状态
      selectedCourse: null,
      fillInQuestions: fillInTheBlanks,
      userStats: {
        points: 169,
        accuracy: 85,
        streakDays: 4
      },
      pointsRanking: [], // 替换原来的leaderboard
      courses: [
        {
          id: 'gfz',
          name: '智慧医疗创新体验',
          description: '走进智慧医疗，解锁人工智能医疗技术的奥秘！',
          img: '/picture/h2.jpg'
        },
        {
          id: 'xdyh',
          name: '现代优化方法',
          description: '加深理解高分子合成材料领域的新理论、新技术和新方法',
          img: '/picture/y2.jpg'
        },
        {
          id: 'pwf',
          name: '偏微分方程',
          description: '数学学科的重要学科基础课程',
          img: '/picture/y3.jpg'
        },
        {
          id: 'mks',
          name: '马克思主义哲学专题研究',
          description: '“三大时期”“五大批判”经纬交织，纵横捭阖',
          img: '/picture/y4.jpg'
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
    this.fetchRankingData();
    this.allQuestions = {
      gfz: gfzQuestions,
      mks: mksQuestions,
      pwf: pwfQuestions,
      xdyh: xdyhQuestions
    };
  },
  mounted() {
    setTimeout(() => {
      this.footerShow = true;
    }, 150);
  },
  methods: {
    async fetchRankingData() {
      try {
        const { data } = await getAllScore();
        this.pointsRanking = data.slice(0, 5); // 取前五名
      } catch (error) {
        console.error('获取排行榜数据失败:', error);
      }
    },
    selectCourse(courseId) {
      this.selectedCourse = courseId;
    },
    beforeDestroy() {
      if (this.loadingTimeout) {
        clearTimeout(this.loadingTimeout);
      }
    },
    startQuiz() {
      if (!this.selectedCourse) return;
      this.isLoading = true;
      setTimeout(() => {
        this.currentQuestions = this.allQuestions[this.selectedCourse];
        this.currentStep = 'quiz';
        this.isLoading = false;
        window.scrollTo({ top: 0, behavior: 'smooth' });
      }, 2000);
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
    // 修改结果展示方法
    showFinalResult() {
      this.currentStep = 'review';
      window.scrollTo({ top: 0, behavior: 'smooth' });
    },

    // 添加辅助方法
    isCorrect(questionIndex) {
      return this.userAnswers[questionIndex] === this.currentQuestions[questionIndex].correctAnswer;
    },
    restartQuiz() {
      // 重置所有答题状态
      this.currentQuestionIndex = 0;
      this.selectedOption = null;
      this.showResult = false;
      this.score = 0;
      this.showFinalScore = false;
      this.userAnswers = [];

      // 关键步骤：重新加载题目（确保使用最新题目）
      this.currentQuestions = [...this.allQuestions[this.selectedCourse]];

      // 跳转到答题界面
      this.currentStep = 'quiz';

      // 滚动到顶部提升体验
      window.scrollTo({ top: 0, behavior: 'smooth' });
    },
    backToCourseSelect() {
      this.currentStep = 'courseSelect';
      this.currentQuestionIndex = 0;
      this.selectedOption = null;
      this.showResult = false;
      this.score = 0;
      this.showFinalScore = false;
      this.userAnswers = [];
      window.scrollTo({ top: 0, behavior: 'smooth' });
    },
    endQuiz() {
      if (confirm('确定要提前结束答题吗？已答题目将会保留进度。')) {
        this.showFinalScore = true;
        // 计算当前得分
        this.score = this.userAnswers.reduce((acc, ans, index) => {
          return acc + (ans === this.currentQuestions[index].correctAnswer ? 1 : 0)
        }, 0);
        // 新增：直接跳转到回顾页面
        this.currentStep = 'review';  // 添加这行关键代码
        window.scrollTo({ top: 0, behavior: 'smooth' });
      }
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
  height: 800px;
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
  color: #1976d2;
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
  margin-bottom: 8px;
  transition: all 0.3s ease;
}
.user-info {
  flex: 1;
  display: flex;
  align-items: center;
  margin-left: 15px;
}
.user-avatar {
  width: 30px;
  height: 30px;
  border-radius: 50%;
  margin-right: 10px;
}
.rank-number {
  width: 40px;
  color: #666;
  font-weight: bold;
}
.rank-name {
  font-weight: 500;
  color: #333;
}
.rank-points {
  color: #1976d2;
  font-weight: bold;
  margin-right: 10px;
}


.start-quiz-btn {
  display: block;
  margin: 40px auto 0;
  padding: 16px 48px;
  font-size: 1.2rem;
  background: linear-gradient(135deg,#1976d2, #548abc);
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
  max-width: 1400px;
  height: 800px;
  margin: 130px auto 0;
  margin-bottom: 200px;
  padding: 40px 20px;
}

.course-select-card {
  background: white;
  border-radius: 16px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.05);
  padding: 40px;
  margin-top: 70px;
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
  padding: 15px;
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
  border-color: #1976d2;
  background-color: #f0f9f5;
}

.course-img {
  width: 100%;
  height: 168px;
  background-color: #f5f5f5;
  border-radius: 8px;
  display: flex;
  margin-bottom: 7px;
  align-items: center;
  justify-content: center;
  margin-right: 15px;
  font-size: 24px;
  color: #42b983;
}

.course-item.selected .course-img {
  background-color: #e1f5eb;
}

.course-info h3 {
  margin-top: 15px;
  margin-left: 7px;
  margin-right: 7px;
  font-size: 1rem;
  font-weight: normal;
  color: #333;

}

.course-info p {
  margin-left: 7px;
  margin-right: 7px;
  font-size: 0.8rem;
  color: #666;
  line-height: 1.5;
  margin-top: 10px;
  margin-bottom: 15px;
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
  background: linear-gradient(135deg, #1976d2, #548abc);
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
  width: 100%;
  max-width: 1200px;
  height: 100px;
  margin: 130px auto 200px;
  padding: 40px 20px;
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
  background-color: #1976d2;
  border-radius: 4px;
  transition: width 2s ease;
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
  margin-bottom: 20px;
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
.btn-group {
  display: flex;
  gap: 15px;
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
  .quiz-actions {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 15px;
  }

  .action-group {
    display: flex;
    gap: 15px;
  }

  .btn-end {
    background-color: #ff4444;
    color: white;
    padding: 12px 24px;

    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.3s ease;
  }

  .btn-end:hover:not(:disabled) {
    background-color: #cc0000;
    transform: translateY(-2px);
  }

  .btn-end:disabled {
    background-color: #cccccc;
    cursor: not-allowed;
  }
}
/* 新增答题回顾样式 */
.review-container {
  width: 1200px;
  margin: 100px auto 200px;
  padding: 30px;
}

.review-header {
  text-align: center;
  margin-bottom: 40px;
  padding: 20px;
  background: #f8f9fa;
  border-radius: 10px;
}

.score-summary {
  display: flex;
  justify-content: center;
  gap: 40px;
  margin-top: 20px;
}

.score-item {
  text-align: center;
  padding: 15px 30px;
  border-radius: 8px;
  background: white;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.score-label {
  display: block;
  color: #666;
  font-size: 0.9em;
  margin-bottom: 5px;
}

.score-value {
  font-size: 1.8em;
  font-weight: bold;
  color: #1976d2;
}

.questions-list {
  margin-top: 30px;
}

.question-item {
  background: white;
  border-radius: 10px;
  padding: 25px;
  margin-bottom: 30px;
  box-shadow: 0 2px 6px rgba(0,0,0,0.05);
}

.question-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding-bottom: 15px;
  border-bottom: 1px solid #eee;
}

.answer-status {
  font-weight: bold;
  padding: 5px 10px;
  border-radius: 5px;
}

.correct-answer .answer-status {
  color: #2e7d32;
  background: #e8f5e9;
}

.wrong-answer .answer-status {
  color: #c62828;
  background: #ffebee;
}

.original-question {
  margin-bottom: 20px;
}

.question-text {
  font-size: 1.1em;
  line-height: 1.6;
  color: #333;
}

.answer-analysis {
  margin: 20px 0;
  padding: 15px;
  background: #f8f9fa;
  border-radius: 8px;
}

.user-answer, .correct-answer {
  align-items: center;
  margin: 10px 0;
}

.user-option {
  font-weight: bold;
  color: #1976d2;
}

.wrong-mark {
  color: #c62828;
  margin-left: 5px;
}

.correct-option {
  color: #2e7d32;
  font-weight: bold;
}

.explanation {
  margin-top: 15px;
  padding-top: 15px;
  border-top: 1px dashed #ddd;
}

.explanation h4 {
  color: #666;
  margin-bottom: 10px;
}

.options-review {
  display: grid;
  gap: 10px;
}

.option-item {
  padding: 12px;
  border: 1px solid #eee;
  border-radius: 6px;
  display: flex;
  align-items: center;
}

.option-item.correct {
  background: #e8f5e9;
  border-color: #81c784;
}

.option-item.selected {
  background: #e1f5fe;
  border-color: #4fc3f7;
}

.option-item.wrong-selected {
  background: #ffebee;
  border-color: #ef9a9a;
}

.review-actions {
  margin-top: 40px;
  display: flex;
  justify-content: center;
  gap: 20px;
}

.btn-restart {
  background: linear-gradient(135deg, #1976d2, #1565c0);
  color: white;
  padding: 12px 30px;
}

.btn-back {
  background: #f0f0f0;
  color: #666;
  padding: 12px 30px;
}

@media (max-width: 768px) {
  .review-container {
    padding: 20px;
    margin-top: 80px;
  }

  .score-summary {
    flex-direction: column;
    gap: 15px;
  }

  .question-item {
    padding: 15px;
  }
}


/* 新增淡入淡出动画 */
.fade-enter-active, .fade-leave-active {
  transition: opacity 0.3s ease;
}
.fade-enter, .fade-leave-to {
  opacity: 0;
}

/* 添加模糊效果 */
.blur-content {
  filter: blur(2px);
  transition: filter 0.3s ease;
}

/* 调整加载遮罩样式 */
.loading-mask {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(255, 255, 255, 0.95);
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 16px;
  z-index: 100;
}

/* 保持原有loader样式不变 */

.loader {
  text-align: center;
}

.loader-spinner {
  width: 50px;
  height: 50px;
  margin: 0 auto 20px;
  border: 4px solid #f3f3f3;
  border-top: 4px solid #1976d2;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  z-index: 1000;
}

.loader-text {
  color: #1976d2;
  font-size: 1.2rem;
  font-weight: 500;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

/* 调整课程选择容器定位 */
.course-select-container {
  position: relative;  /* 新增定位上下文 */
  width: 100%;
  max-width: 1400px;
  margin: 130px auto 200px;
  padding: 40px 20px;
}
</style>
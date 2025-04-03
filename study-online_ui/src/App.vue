<template>
    <div id="app">
        <vue-particles color="#409EFF" :particleOpacity="0.3" :particlesNumber="18" shapeType="circle" :particleSize="6"
            linesColor="#409EFF" :linesWidth="1" :lineLinked="true" :lineOpacity="0.4" :linesDistance="150" :moveSpeed="3"
            :hoverEffect="true" hoverMode="grab" :clickEffect="true" clickMode="push">
        </vue-particles>
        <transition name="fade" mode="out-in">
            <router-view v-if="isRouterAlive">
            </router-view>
        </transition>
    </div>
</template>

<script>
import { mapMutations, mapState } from 'vuex'
import { formSixDate } from '@/utils/common'

export default {
    name: 'app',
    provide() {
        return {
            reload: this.reload
        }
    },
    data() {
        return {
            isRouterAlive: true
        }
    },
    mounted() {
        console.log(this.isSign2);
        this.setTime()
    },
    computed: {
        ...mapState(['isSign2'])
    },
    methods: {
        ...mapMutations(['SETISSIGN']),
        reload() {
            this.isRouterAlive = false,
                this.$nextTick(function () {
                    this.isRouterAlive = true
                })
        },
        setTime() {
            setInterval(() => {
                //传入要设置的时分秒,如果相等执行初始化任务
                if (formSixDate(6, 0)) {
                    clearInterval(this.timer);
                    this.SETISSIGN(false)
                }
            }, 1000)
        }
    }
}
</script>

<style>
* {
    padding: 0;
    margin: 0;
}

#particles-js {
  width: 100%;
  height: 100%;
  position: fixed; /* 改为fixed定位 */
  top: 0;
  left: 0;
  z-index: 0; /* 设置最低层级 */
  pointer-events: none; /* 关键：禁止粒子接受点击事件 */
}

.fade-enter-active,
.fade-leave-active {
    transition: opacity 0.35s ease;
}

.fade-enter-from,
.fade-leave-to {
    opacity: 0;
}

/* ::-webkit-scrollbar {
  width: 0 !important;
}
::-webkit-scrollbar {
  width: 0 !important;height: 0;
} */
::-webkit-scrollbar {
    width: 6px;
    height: 10px;
}

::-webkit-scrollbar-thumb {
    background-color: rgba(144, 147, 153, .3);
    border-radius: 3px;
}
</style>

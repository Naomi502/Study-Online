<template>
    <div class="home">
        <Header />
        <div class="content">
            <HotClass />
        </div>
        <Footer v-show="footerShow"/>
    </div>
</template>

<script>
import Header from '@/components/Header.vue';
import Footer from '@/components/Footer.vue';
import HotClass from '@/views/HotClass.vue'
// @ is an alias to /src

export default {
    name: 'HomeView',
    data() {
        return {
            footerShow: true,
        };
    },
    components: {
        Header,
        Footer,
        HotClass
    },
    created() {
        this.footerShow = false
    },
    mounted() {
        setTimeout(() => {
            this.footerShow = true
            // console.log("1");
        }, 100);
    }
}
</script>

<style lang="less" scoped>

.home {
    width: 100%;


    .content {
        width: 93%;
        // height: 400px;
        margin: 100px auto;
        position: relative;
        z-index: 999;
        // background-color: white;
        // animation: load 0.4s linear;
        // transform: translateY(0px);
        // opacity: 1;

        // @keyframes load {
        //   0% {
        //     opacity: 0;
        //     transform: translateY(70px)
        //   }

        //   100% {
        //     opacity: 1;
        //     transform: translateY(0px)
        //   }
        // }

        // background-color: aqua;
    }
}

</style>

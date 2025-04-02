<template>
    <div class="footer">
        <div class="row" style="color: #a8a8a8;font-size: 14px;">
            <el-row class="row1">
                <span>中文 <i class="el-icon-arrow-down"></i> <span>|</span> </span>
                <span>课程入驻</span>
                <span>关于我们</span>
                <span>教科研平台</span>
                <span style="cursor: pointer;" @click="openNewLink">服务协议与隐私政策</span>
                <span>帮助与反馈</span>
                <span><a style="color: rgb(168, 168, 168);" target="_blank"
                        href="http://124.223.101.11:8050/#/login">管理平台</a></span>
            </el-row>
            <div class="row2">
                <span style="font-size: 24px;margin-bottom: 5px;">创新教育 改变世界</span>
                <span>New Education, New World</span>
            </div>
            <div class="row3">
                <el-row style="margin-bottom: 5px;">
                    <span>版权所有：扬州市职业大学（扬州开放大学）</span>
                    <span>苏ICP备13024625号-3 |
                    </span>
                    <span> <img width="18px" height="18px" style="margin-right: 4px;position: relative;top: 4px;"
                            src="https://static-cdn.xuetangx.com/xtassets/xtassets/copyright/copyright-icon.png"
                            alt="">京公网安备 11010802033054号</span>
                    <span>苏公网安备32100302010583号</span>
                </el-row>
                <span>地址：扬州市邗江区文昌西路458号</span>
            </div>
        </div>
        <!-- <div class="right">
        <img width="118px" height="118px" src="https://storagecdn.xuetangx.com/public_assets/xuetangx/xuetangX2018/76e93bdd5f6f357e58ab16c0a4433abb.qrcode.png" alt="">
        <span style="margin-top: 5px;">学堂微信客服</span>
    </div> -->
    </div>
</template>

<script>
export default {
    name: 'StudyOnlineFooter',

    data() {
        return {

        };
    },

    mounted() {

    },

    methods: {
        openNewLink() {
            let routeUrl = this.$router.resolve({
                path: "/protocol"
            })
            window.open(routeUrl.href, '_blank')
        }
    },
};
</script>

<style lang="less" scoped>
.footer {
    width: 100%;
    height: 280px;
    background-color: #282c2f;
    display: flex;
    min-width: 1100px;

    .row {
        width: 83%;
        height: 100%;
        margin: auto auto;
        display: flex;
        flex-direction: column;
        justify-content: space-evenly;

        .row1 {
            span {
                padding: 5px;
            }
        }

        .row2 {
            display: flex;
            flex-direction: column;
        }

        .row3 {
            font-size: 12px;
            display: flex;
            flex-direction: column;
        }
    }

    .right {
        color: #a8a8a8;
        font-size: 14px;
        text-align: center;
        margin-top: 75px;
        position: relative;
        right: 80px;
        display: flex;
        flex-direction: column;
    }
}</style>

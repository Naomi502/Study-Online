const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true,
  chainWebpack: config => {
    config
        .plugin('html')
        .tap(args => {
            args[0].title = '继续教育平台'
            return args;
        })
},
    devServer: {
        open: true,
        host: 'localhost',
        port: 8080,
        https: false,
    },
  lintOnSave: false
})

// module.exports = {
//   publicPath: './',         //配置本地引用目录文件,如不配置，默认为`/`
// }
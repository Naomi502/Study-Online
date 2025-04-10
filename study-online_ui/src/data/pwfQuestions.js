export default [
    {
        text: 'React 是由哪个公司开发的？',
        options: [
            'Google',
            'Facebook',
            'Microsoft',
            'Twitter'
        ],
        correctAnswer: 1,
        explanation: 'React 是由 Facebook 开发并开源的 JavaScript 库。'
    },
    {
        text: 'React 中的状态(state)和属性(props)有什么区别？',
        options: [
            'state 是组件内部管理的数据，props 是父组件传递的数据',
            'props 是组件内部管理的数据，state 是父组件传递的数据',
            '两者可以互换使用',
            'state 用于函数组件，props 用于类组件'
        ],
        correctAnswer: 0,
        explanation: 'state 是组件内部管理的数据，可以变化；props 是父组件传递的数据，组件内部不能直接修改。'
    },
    // 可以添加更多React题目...
];
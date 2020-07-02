---
title: 定时器
date: 2020-05-13T18:14:50+08:00
categories: ["notes"]
---



## 错题

1. 有关window对象的描述以下哪些是正确的？

   - 在全局作用域定义的变量、函数和对象都是window对象的属性和方法
   - window对象是BOM中最核心的对象
   - window可以用来代表用户的操作系统
   - window对象用来表示浏览器窗口

   > 我的选择：
   >
   > window对象用来表示浏览器窗口
   >
   > 在全局作用域定义的变量、函数和对象都是window对象的属性和方法
   >
   > 正确选项：
   >
   > window对象是BOM中最核心的对象
   >
   > window对象用来表示浏览器窗口
   >
   > 在全局作用域定义的变量、函数和对象都是window对象的属性和方法

   > 为什么选错？
   >
   > 记反了==！  认为BOM是window对象的。

2. 有关window对象的描述以下哪些是正确的？

   - window.innerWidth和window.innerHeight用来获取浏览器窗口的内部宽度和高度
   - 可以通过window对象获取一切我们想要的对象
   - window.outterWidth和window.outterHeight用来获取浏览器外部的宽度和高度
   - BOM中其他对象都是window对象的属性

   > 我的选择：
   >
   > BOM中其他对象都是window对象的属性
   >
   > window.innerWidth和window.innerHeight用来获取浏览器窗口的内部宽度和高度
   >
   > 正确答案：
   >
   > BOM中其他对象都是window对象的属性
   >
   > window.innerWidth和window.innerHeight用来获取浏览器窗口的内部宽度和高度
   >
   > window.outterWidth和window.outterHeight用来获取浏览器外部的宽度和高度

   > 为什么选错？
   >
   > 我认为`outterHeight`和`outterWidth`是获取整个浏览器窗口的宽度和高度。

### 定时器



定时器的具体方法由 Window对象提供，共有以下两种定时器

- 延迟执行：指的是指定程序代码在指定时间后被执行，而不是立即被执行
- 周期执行：指的是指定程序代码在指定时间为间隔，重复被执行。

目前，HTML页面中多数动态效果，以及动画效果等均由定时器内容完成。

### 延迟执行

语法：`var timeoutID=scope.setTimeout(function/code[,delay])`

- `function/code`

  受调用的函数或执行的代码

- `delay`

  延迟的毫秒数（1秒等于1000毫秒），函数的调用会在该延迟之后发生。如果省略该参数，delay取默认值0

- 返回值

  该方法的返回值`timeoutID`是一个正整数，表示定时器的编号。这个值可以传递给`clearTimeout()`来取消该定时器。

<div class="note warning icon"><p>基本语法测试</p></div>

```javascript
setTimeout(function () {
    console.log('默认立即制行')
})
setTimeout(function () {
    console.log('延迟3秒执行')
}, 3000)
console.log('测试是否被延迟制行影响')

// 清除定时 以下代码会导致 test 并不会输出
var t = setTimeout(function () {
    console.log('test')
}, 3000)
clearTimeout(t)
```



<p class="div-border yellow"">以上代码的测试如图所示，可以看到延迟制行会打乱代码执行的顺序。即*延迟10秒执行*语句并不会导致下边的语句不执行。</p>

![](https://cdn.jsdelivr.net/gh/blogimg/picbed@latest/2020/05/13/7f6f24419b2cd126d9c11402bc394cd2.png)

[https://antmoe.gitee.io/project/2020/05/13/01_延迟制行.html](https://antmoe.gitee.io/project/2020/05/13/01_延迟制行.html)

### 周期执行

语法：`var timeoutID =scope.setInterval(function/code[,delay]) `

- `function/code`

  受调用的函数或执行的代码

- `delay`

  延迟的毫秒数（1秒等于1000毫秒），函数的调用会在该延迟之后发生。如果省略该参数，delay取默认值0

- 返回值

  该方法的返回值`timeoutID`是一个正整数，表示定时器的编号。这个值可以传递给`clearInterval()`来取消该定时器。

<div class="note warning icon"><p>基本语法测试</p></div>

```javascript
setInterval(function () {
    console.log('默认立即制行')
})
setInterval(function () {
    console.log('延迟每3秒执行')
}, 3000)
console.log('测试是否被延迟制行影响')
// 清除定时
var t = setInterval(function () {
    console.log('test')
}, 3000)
clearInterval(t)
```

<p class="div-border yellow"">可以看到，几乎与延迟执行相同。执行顺序不会受到延迟的影响。清除定时器同样导致定时消失。</p>

![](https://cdn.jsdelivr.net/gh/blogimg/picbed@latest/2020/05/13/a10bc5ed2a33b513ea735b9a114ed74c.png)

<div class="note info icon"><p>将延迟执行改写为周期执行</p></div>

```javascript
// TAG 常规写法
function fun() {
    console.log('这是递归写法')
    setTimeout(fun, 1000)
}
fun()

// TAG 匿名函数写法
(function () {
    console.log('这是匿名函数写法')
    setTimeout(arguments.callee, 1000)
})()

// TAG 匿名函数写名字写法
(function fun1() {
    console.log('这是匿名写名字写法')
    setTimeout(fun1, 1000)
})()
```

[https://antmoe.gitee.io/project/2020/05/13/02_周期执行.html](https://antmoe.gitee.io/project/2020/05/13/02_周期执行.html)

### 动画方法requestAnimationFrame()

`window.requestAnimationFrame()` 告诉浏览器——你希望执行一个动画，并且要求浏览器在下次重绘之前调用指定的回调函数更新动画。该方法需要传入一个回调函数作为参数，该回调函数会在浏览器下一次重绘之前执行。

> 注意：若你想在浏览器下次重绘之前继续更新下一帧动画，那么回调函数自身必须再次调用`window.requestAnimationFrame()`

语法：`window.requestAnimationFrame(callback);`

- `callback`

  下一次重绘之前更新动画帧所调用的函数(即上面所说的回调函数)。该回调函数会被传入`DOMHighResTimeStamp`参数，该参数与`performance.now()`的返回值相同，它表示`requestAnimationFrame()` 开始去执行回调函数的时刻。

- 返回值

  一个 `long` 整数，请求 ID ，是回调列表中唯一的标识。是个非零值，没别的意义。你可以传这个值给 `window.cancelAnimationFrame()` 以取消回调函数。

<div class="note warning icon"><p>基本语法测试</p></div>

```javascript
console.log('this is a message ')
/*
        NOTE requestAnimationFrame(callback)
        NOTE 参数表示动画逻辑的回调函数
        NOTE 返回值表示当前执行动画的标识
*/
requestAnimationFrame(function () {
    console.log('this is animation...')
})

console.log('this is a message2 ')
```

![](https://cdn.jsdelivr.net/gh/blogimg/picbed@latest/2020/05/13/a8c6a01b2df34da1e528302532012d5c.png)

<p class="div-border yellow"">类似于延迟执行，执行一次就不会在执行了。</p>

<div class="note warning icon"><p>兼容性问题</p></div>

```javascript
var requestAnimationFrame = webkitRequestAnimationFrame || mozRequestAnimationFrame || requestAnimationFrame 
```

[https://antmoe.gitee.io/project/2020/05/13/03_HTML5的动画方法.html](https://antmoe.gitee.io/project/2020/05/13/03_HTML5的动画方法.html)

## 小案例

**以下两个案例需要注意的点就是周期函数的返回值需要在全局作用域声明。在时间内部进行赋值。**

### 动态时间显示

![](https://cdn.jsdelivr.net/gh/blogimg/picbed@latest/2020/05/13/c4c9019ee634867da087d76ba1583efd.png)

整体来说，这是一个非常简单的小案例。其基本逻辑用一个周期定时器包裹起来即可。

[https://antmoe.gitee.io/project/2020/05/13/04_动态时间显示.html](https://antmoe.gitee.io/project/2020/05/13/04_动态时间显示.html)

```html
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>动态显示时间</title>
    </head>

    <body>
        <button id="start">开始显示</button>
        <button id="stop">停止显示</button>
        <h2 id="showtime"></h2>
        <script>
            var startBtn = document.getElementById('start')
            var stopBtn = document.getElementById('stop')
            var showtime = document.getElementById('showtime')
            var t;
            startBtn.addEventListener('click', function () {
                // TAG 禁用按钮
                startBtn.setAttribute('disabled', 'disabled')
                t = setInterval(function () {
                    // TAG 1. 获取当前时间
                    var date = new Date()
                    var hour = date.getHours()
                    var minute = date.getMinutes()
                    var second = date.getSeconds()
                    // TAG 2. 格式化当前时间
                    var time = hour + ':' + minute + ':' + second
                    // TAG 3. 动态显示
                    showtime.textContent = time
                })
            })
            stopBtn.addEventListener('click', function () {
                startBtn.removeAttribute('disabled')
                clearInterval(t)
            })
        </script>
    </body>

</html>
```

### 方块移动

![](https://cdn.jsdelivr.net/gh/blogimg/picbed@latest/2020/05/13/5f1caa64c4dbb33a31f0ad26ad3635f2.png)

这个案例也很简单，同样是使用周期定时器。

[https://antmoe.gitee.io/project/2020/05/13/05_方块自动移动.html](https://antmoe.gitee.io/project/2020/05/13/05_方块自动移动.html)

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        body {
            margin: 0;
        }

        #box {
            width: 50px;
            height: 50px;
            background-color: coral;
            position: absolute;
            top: 200px;
            left: 100px;
        }
    </style>
</head>

<body>
    <div id="box"></div>
    <script>
        var box = document.getElementById('box')
        var t
        // NOTE 开关,false表示没有被点击过,应开始移动.
        var flag = false
        box.addEventListener('click', function () {
            if (!flag) {
                t = setInterval(function () {
                    // TAG 1. 获取当前方块的left
                    var style = window.getComputedStyle(box)
                    var left = parseFloat(style.left)
                    // TAG 2. 增加left样式属性值
                    left++
                    // TAG 3. 利用内联样式覆盖外联样式
                    box.style.left = left + 'px'
                }, 10)
                flag = true
            } else {
                clearInterval(t)
                flag = false
            }
        })


    </script>
</body>

</html>
```


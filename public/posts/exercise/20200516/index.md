# 三个动画练习




## 错题

1. `setInterval(function(){console.log('这是延迟执行.')}, 1000)`这段代码的含义描述正确的是？

   - 每隔一秒都会调用function函数
   - 每隔一秒都会执行console.log()语句
   - console.log()语句会在一秒之后执行
   - function函数只会被调用一次

   > 我的选择：
   >
   > console.log()语句会在一秒之后执行
   >
   > 每隔一秒都会执行console.log()语句
   >
   > 每隔一秒都会调用function函数 
   >
   > 正确答案：
   >
   > 每隔一秒都会执行console.log()语句
   >
   > 每隔一秒都会调用function函数

   > 为什么选错？
   >
   > ![](https://cdn.jsdelivr.net/gh/blogimg/picbed@latest/2020/05/16/d4adf5a01ef605414f00f1139dfdaa8a.png)
   >
   > 题目描述不严谨。但延迟一秒是因为周期函数每1秒执行一次。

## 小练习

今日学习内容为三个小练习，分别为小球自动向下移动、菜单自动隐藏、键盘控制方块。

### 小球自动向下移动



在线地址：[https://antmoe.gitee.io/project/2020/05/16/1_小球自动向下移动.html](https://antmoe.gitee.io/project/2020/05/16/1_小球自动向下移动.html)

1. 创建DIV
2. 通过不断改变其top属性，实现不断向下移动

![](https://cdn.jsdelivr.net/gh/blogimg/picbed@latest/2020/05/16/22aa8da1cdfc66e6faa186df3f46b8d8.png)

```HTML
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>小球自动向下移动</title>
    <style>
        body {
            margin: 0;
        }

        .box {
            width: 50px;
            height: 50px;
            background-color: coral;
            border-radius: 50%;
            position: relative;
            left: 400px;
            top: -50px;

        }
    </style>
</head>

<body>
    <!-- <div id="box"></div> -->
    <script>
        var body = document.body
        // 创建div id为box的标签,并加入到body元素种
        function createBox() {
            var WIDTH = window.innerWidth
            var div = document.createElement('div')
            div.setAttribute('class', 'box')
            var random = Math.random() * (WIDTH - 50);
            div.style.left = random + 'px'
            body.appendChild(div)
        }
        // 控制div向下移动
        function moveDown() {
            var boxs = document.getElementsByClassName('box')
            for (var i = 0; i < boxs.length; i++) {
                var box = boxs[i]
                var style = window.getComputedStyle(box)
                var boxTop = parseFloat(style.top)
                boxTop++
                box.style.top = boxTop + 'px'
            }
        }
        // 创建多个小球
        for (var i = 0; i < 10; i++) {
            createBox()
        }
        // 设置定时器,向下移动
        setInterval(function () {
            // 调用向下移动函数
            moveDown()
        }, 100)

    </script>
</body>

</html>
```

### 菜单自动隐藏

在线地址：[https://antmoe.gitee.io/project/2020/05/16/2_菜单自动隐藏.html](https://antmoe.gitee.io/project/2020/05/16/2_菜单自动隐藏.html)

与上一个类似，通过不断改变高度，实现不断变小。

![](https://cdn.jsdelivr.net/gh/blogimg/picbed@latest/2020/05/16/3e70fb5cc04e3fc66ee2885ec10b6c83.png)

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

        #menu {
            width: 100px;
            height: 300px;
            border: 1px solid black;
            position: absolute;
            left: 400px;
            top: 100px;
        }
    </style>
</head>

<body>
    <div id="menu"></div>
    <script>
        // 1. 获取指定元素
        var menu = document.getElementById('menu')
        var flag = false
        var t = setInterval(function () {
            // 2. 获取有效项式
            var style = window.getComputedStyle(menu)
            // 3. 获取指定元素的高度值
            var height = parseFloat(style.height)
            // 判断高度是否为零
            if (height <= 0) {
                // 将指定元素隐藏
                menu.style.display = 'none'
                clearInterval(t)
            } else {
                // 4. 减少元素的高度
                height--
                menu.style.height = height + 'px'
            }
        }, 100)

    </script>
</body>

</html>
```

### 键盘控制方块移动

在线地址：[https://antmoe.gitee.io/project/2020/05/16/3_键盘控制方块移动.html](https://antmoe.gitee.io/project/2020/05/16/3_键盘控制方块移动.html)

1. 常规的获取HTML元素

2. 常规的监听键盘事件（`keydown`）

3. 水平移动

   设置一个标志位，用于判断是向左还是向右。另外需要记录计时器的返回值。用于清除计时器。

4. 垂直移动

   与水平方向同理

5. 空格停止（清除移动）

   将记录的定时器编号清除即可。

![](https://cdn.jsdelivr.net/gh/blogimg/picbed@latest/2020/05/16/79d2481616943a81009cd5a7faba68ab.png)

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
        var html = document.documentElement
        var body = document.body
        var box = document.getElementById('box')
        var boxStyle = window.getComputedStyle(box)
        // 定义水平移动标志,垂直移动标志,垂直事件编号 水平事件编号
        var leavel_flag, vertical_flag, vertical, level

        document.addEventListener('keydown', function (e) {
            var boxTop = parseFloat(boxStyle.top)
            var boxLeft = parseFloat(boxStyle.left)
            // 获取按下的按键
            var key = e.code
            switch (key) {
                case 'ArrowUp':
                    vertical_flag = true
                    vertical = vertical_move()
                    break
                case 'ArrowDown':
                    vertical_flag = false
                    vertical = vertical_move()
                    break
                case 'ArrowLeft':
                    leavel_flag = false

                    level = level_move()
                    break
                case 'ArrowRight':
                    leavel_flag = true
                    level = level_move()
                    break
                case 'Space':
                    cancel()
                    break
            }
        })
        // 取消计时器
        function cancel() {
            if (vertical) {
                clearTimeout(vertical)
            }
            if (level) {
                clearTimeout(level)
            }
        }
        function level_move() {
            cancel()
            // TAG flag 为true时,+操作,即向右
            if (leavel_flag) {
                return setInterval(function () {
                    box.style.left = (++boxLeft) + 'px'
                }, 50)

            } else { //TAG 否则向左
                return setInterval(function () {
                    box.style.left = (--boxLeft) + 'px'
                }, 50)
            }
        }
        function vertical_move() {
            cancel()
            // TAG flag 为true时,-操作,即向上
            if (vertical_flag) {
                return setInterval(function () {
                    box.style.top = (--boxTop) + 'px'
                }, 50)
            } else { //TAG 否则向下
                return setInterval(function () {
                    box.style.top = (++boxTop) + 'px'
                }, 50)
            }
        }
    </script>
</body>

</html>
```



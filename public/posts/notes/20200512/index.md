# BOM编程艺术




# BOM编程艺术

## 日考错题

1. 以下哪些选项是可以用来获取select元素中所有的option元素？

   - selectElement.getElementsByTagName('option')
   - selectElement.options
   - selectElement.getElemnetsByName('option')
   - selectElement.length

   > 我的选择：
   >
   > selectElement.options
   >
   > selectElement.getElementsByTagName('option')
   >
   > selectElement.getElemnetsByName('option') 

   > 正确答案
   >
   > selectElement.options
   >
   > selectElement.length
   >
   > selectElement.getElementsByTagName('option')

   > 为什么做错？
   >
   > 对于`selectElement.getElemnetsByName('option') `选项看错了，以为是className。
   >
   > 没有选择`selectElement.length`是因为只认为他是取长度，审题不清。

2. 如何可以获取那个option元素被选中两列？

   - optionElement.selected属性值为value
   - optionElement.value属性值为非空字符串
   - selectElement.optionSelected
   - selectElement.selectedIndex

   > 我的选择：
   >
   > selectElement.selectedIndex
   >
   > selectElement.optionSelected

   > 正确答案：
   >
   > selectElement.selectedIndex
   >
   > optionElement.selected属性值为value

   > 为什么做错？
   >
   > `selectElement`对象根本就没有`optionSelected`属性。而是`selected`属性。

3. 如何获取option元素的值？

   - optionElement.value
   - optionElement.getAttribute('value')
   - optionElement.textValue
   - optionElment.text

   > 我的选择：
   >
   > optionElement.value
   >
   > optionElement.getAttribute('value')
   >
   > optionElment.text

   > 正确答案：
   >
   > optionElement.value
   >
   > optionElement.getAttribute('value')

   > 为什么做错？
   >
   > `optionElment.text`对于这个选项，值与文本内容可以不相等。

## 项目抽查

> 1. 一个表单
>
>    - 一个用户名输入框
>    - 两个密码输入（密码，确定密码）框
>    - 一个email输入框
>    - 一个下拉选择
>    - 复选框若干个
>
> 2. 逻辑内容①：实现对用户名输入不为空的验证
>
>    1. 获取用户名输入框对象
>
>    2. 为用户名输入框对象绑定事件（focus：获取焦点；**blur：失去焦点**）
>
>    3. 利用HTML5的API进行验证
>
>       ```javascript
>       if (username.validity.valueMissing) {
>           username.setCustomValidity('用户名不能为空')
>       } else {
>           username.setCustomValidity('')
>       }
>       ```
>
>    4. 虽然绑定的是blur（失去焦点）事件，但触发仍需要表单被提交才能触发。因此需要提交表单才可以。
>
> 3. 逻辑内容②：实现对两个密码框一致性的判断
>
>    1. 表单提交，提交的是表单。因此需要获取**表单对象**
>    2. 为表单对象绑定事件（submit）
>    3. 事件中，需要禁用默认事件。即`event.preventDefault()`
>    4. 接下来就是常规判断
>
>    ```javascript
>    // document.forms 返回结果为集合
>    var form = document.forms[0]
>    form.addEventListener('submit', function (event) {
>        event.preventDefault()
>        if (document.getElementById('pwd1').value != document.getElementById('pwd2').value) {
>            username.setCustomValidity('密码不一致')
>        } else {
>            username.setCustomValidity('')
>        }
>    })
>    ```

项目在线地址：[https://antmoe.gitee.io/project/2020/05/12/1.html](https://antmoe.gitee.io/project/2020/05/12/1.html)

```html
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
    </head>

    <body>
        <form action="">
            <input type="text" required id="username">
            <input type="password" id="pwd1">
            <input type="password" id="pwd2" >
            <input type="email">
            <select name="" id="">
                <option value="nan">男</option>
                <option value="nv">女</option>
            </select>
            <input type="checkbox" name="t" id="">test
            <input type="checkbox" name="t" id="">test
            <input type="checkbox" name="t" id="">test
            <input type="submit" value="66" id="sub">
        </form>
        <script>
            var form = document.forms[0]
            var username = document.getElementById('username')
            username.addEventListener('blur', function () {
                console.log(1)
                if (username.validity.valueMissing) {
                    username.setCustomValidity('用户名不能为空')
                } else {
                    username.setCustomValidity('')
                }
            })
            var sub = document.getElementById('sub')
            form.addEventListener('submit', function (event) {
                event.preventDefault()
                if (document.getElementById('pwd1').value != document.getElementById('pwd2').value) {
                    username.setCustomValidity('密码不一致')
                } else {
                    username.setCustomValidity('')
                }
            })
        </script>
    </body>

</html>
```



## 什么是BOM

BOM的全称为 Browser Object Model，被译为浏览器对象模型

BOM提供了独立于HTML页面内容，而与浏览器相关的一系列对象。主要被用于管理浏览器窗口及与测览器窗口之间通信等功能。

BOM由一系列对象构成，这些对象可以简单理解为是由各个览器所提供的，例如 Window对象等。

![](https://cdn.jsdelivr.net/gh/blogimg/picbed@latest/2020/05/12/a5739405c9abe805c30f207590c01f81.png)

## Window对象

window对象是BOM中最核心的对象

### 全局作用域

1. 在浏览器环境中运行`javascript`逻辑时，在全局作用域中定义的对象、变量和函数都是Window对象的属性和方法。

   ```javascript
   var test = 666
   console.log('test:', test)
   console.log('windows.test:', window.test)
   function t() {
       console.log('this is function')
   }
   t()
   window.t()
   delete window.test
   console.log('删除windwos.test后test的值:', test)
   console.log('删除windwos.test后windows.test的值:', window.test)
   
   delete test
   console.log('删除test后test的值:', test)
   console.log('删除test后windows.test的值:', window.test)
   ```

   ![](https://cdn.jsdelivr.net/gh/blogimg/picbed@latest/2020/05/12/fedb4decebf4344fd2aa96c28a3360de.png)

2. 根据以上测试结果，可以很清楚的发现：删除是不起作用的。

[https://antmoe.gitee.io/project/2020/05/12/01_window对象.html](https://antmoe.gitee.io/project/2020/05/12/01_window对象.html)

### 浏览器窗口的宽度和高度

- `innerWidth`和`innerHeight`属性

  只读属性，返回当前浏览器窗口的可视宽度和高度。如果存在滚动条，也包含滚动条。

- `outterWidth`和`outterHeight`属性

  只读属性，返回当前浏览器窗口的整个宽度和高度。

  ![](https://cdn.jsdelivr.net/gh/blogimg/picbed@latest/2020/05/12/6d47ca8ad57d938b38e9102eb243d5b5.png)

[https://antmoe.gitee.io/project/2020/05/12/02_图片跟随窗口变化.html](https://antmoe.gitee.io/project/2020/05/12/02_图片跟随窗口变化.html)

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
            padding: 0;
        }

        img {
            width: 100%;
        }
    </style>
</head>

<body>
    <img id="img" src="https://ae01.alicdn.com/kf/H1d2dc39c58a84dc0960d4173b1bbc4643.jpg" alt="">
    <script>
        var img = document.getElementById('img')
        // resize表示重新设置大小
        window.addEventListener('resize', function () {
            console.log(window.innerWidth, window.innerHeight)
            img.style.width = window.innerWidth + 'px'
            img.style.height = window.innerHeight + 'px'
        })
    </script>
</body>

</html>
```

<div class="note warning icon"><p>window.innerWidth等属性得值均为数字类型，作为宽度需加单位。例如window.innerWidth + 'px'</p></div>

### Windows对象与self属性

Window对象的self属性返回当前浏览器窗口的只读属性。换句话讲，Self属性返回的是 Window对象的引用。



```javascript
if (window.top != window.self) {
    console.log('这个窗口不是最顶层窗口')
} else {
    console.log('这个窗口是最顶层窗口')
}
```



### open和close



- `open[url]`

  参数参数打开地址。

- `close()`

  关闭当前页签

<div class="note warning icon"><p>以上两个方法均是操作页签</p></div>

[https://antmoe.gitee.io/project/2020/05/12/03_打开与关闭浏览器窗口.html](https://antmoe.gitee.io/project/2020/05/12/03_打开与关闭浏览器窗口.html)

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <button id="btn">按钮</button>
    <button id="close">关闭</button>
    <script>
        var btn = document.getElementById('btn')
        var closebtn = document.getElementById('close')

        btn.addEventListener('click', function () {
            window.open('https://baidu.com')
        })
        closebtn.addEventListener('click', function () {
            window.close()
        })
    </script>
</body>

</html>
```

### Navigator对象

Navigator对象包含了一些有美浏览器状态的信息。可以通过`window.navigator`属性得到 Navigator对象。

[https://antmoe.gitee.io/project/2020/05/12/04_navigator.html](https://antmoe.gitee.io/project/2020/05/12/04_navigator.html)

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <script>
        // 以下属性均为只读属性
        console.log('浏览器的代码名：', navigator.appCodeName)
        console.log('浏览器的名称：', navigator.appName)
        console.log('浏览器的平台和版本信息：', navigator.appVersion)
        console.log('运行浏览器的操作系统平台：', navigator.platform)
        console.log('运行浏览器的userAgent：', navigator.userAgent)
        // 判断用户使用的平台
        var ua = navigator.userAgent
        if (/windows/i.test(ua)) {
            console.log('当前是Windows系统')
        } else if (/mac/i.test(ua)) {
            console.log('当前是mac操作系统')
        } else if (/android/i.test(ua)) {
            console.log('当前是android操作系统')
        } else if (/iphone/i.test(ua)) {
            console.log('当前是iphone操作系统')
        }
    </script>
</body>

</html>
```

<div class="note warning icon"><p>使用switch语句判断用户浏览器信息</p></div>

```javascript
var ua = navigator.userAgent
var regex = /Chrome|Edge|Firefox/i
var info = ua.match(regex)
console.log(info)
switch (info[0]) {
    case 'Chrome':
        console.log('Chrome')
        break
    case 'Edge':
        console.log('Edge')
        break
    case 'Firefox':
        console.log('Firefox')
        break
    case 'msie':
        console.log('msie')
        break
    default:
        console.log('你的浏览器是自创的吧?')
}
```

<div class="note warning icon"><p>使用常规方式判断用户浏览器信息</p></div>

```javascript
var ua = navigator.userAgent
if (/Chrome/i.test(ua) && /Edg/i.test(ua)) {
    console.log('Edge')
} else if (/Firefox/i.test(i)) {
    console.log('Firefox')
} else if (/Chrome/i.test(ua)) {
    console.log('Chrome')
}
```

[https://antmoe.gitee.io/project/2020/05/13/1.html](https://antmoe.gitee.io/project/2020/05/13/1.html)

完整代码：

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <script>
        var ua = navigator.userAgent

        if (/Chrome/i.test(ua) && /Edg/i.test(ua)) {
            console.log('Edge')
        } else if (/Firefox/i.test(i)) {
            console.log('Firefox')
        } else if (/Chrome/i.test(ua)) {
            console.log('Chrome')
        }

        var regex = /Chrome|Edge|Firefox/i
        var info = ua.match(regex)
        switch (info[0]) {
            case 'Chrome':
                console.log('Chrome')
                break
            case 'Edge':
                console.log('Edge')
                break
            case 'Firefox':
                console.log('Firefox')
                break
            case 'msie':
                console.log('msie')
                break
            default:
                console.log('你的浏览器是自创的吧?')
        }
    </script>
</body>

</html>
```

![](https://cdn.jsdelivr.net/gh/blogimg/picbed@latest/2020/05/12/caced2bccf50eed9466f4425635c7a09.png)



### History对象

History对象包含用户在测览器中访问过的URL（网址）。

- `length`属性

  History对象的`length`属性可以获取用户在浏览器中访问网址的数量。

- 前进和后退功能

  |  方法名称   |                             描述                             |
  | :---------: | :----------------------------------------------------------: |
  | `forward()` |        实现跳转下一个页面，作用和浏览器的前进按钮一样        |
  |  `back()`   |       实现跳转到上一个页面，作用和浏览器的回退按钮一样       |
  |   `go()`    | 实现跳转到指定的页面。如果为负数表示后退，如果为正数表示前进 |

  

### Location对象

Location对象包含了浏览器的地址栏中的信息，该对象主要用于获取和设置地址。
Location对象很特别，因为该对象既是 Window对象的属性，又是 Document对象的属性。

![](https://cdn.jsdelivr.net/gh/blogimg/picbed@latest/2020/05/12/90837555b1f310080e40ef73f3e5f4d3.png)

| 属性/方法名称 |                             描述                             |
| :-----------: | :----------------------------------------------------------: |
|    `host`     |                    返回服务器名称和端口号                    |
|  `hostname`   |                        返回服务器名称                        |
|    `href`     |                  返回当前加载页面的完整URL                   |
|  `pathname`   |                 返回当前URL中的目录和文件名                  |
|    `port`     |                    返回当前URL中的端口号                     |
|  `protocol`   |                    返回页面使用的网络协议                    |
|  `assign()`   |        载入一个新的文档，作用和直接修改 Location相同         |
|  `reload()`   | 重新载入当前文档，作用和刷新按钮一样。参数为true时，则会强制清空缓存刷新页面 |
|  `replace()`  | 用新的文档替换当前文档（不会生成历史记录，不能使用回退按钮回退） |

1. 获取和设置地址

   [https://antmoe.gitee.io/project/2020/05/12/05_获取和设置地址.html](https://antmoe.gitee.io/project/2020/05/12/05_获取和设置地址.html)

   ```html
   <!DOCTYPE html>
   <html lang="en">
   
       <head>
           <meta charset="UTF-8">
           <meta name="viewport" content="width=device-width, initial-scale=1.0">
           <title>Document</title>
       </head>
   
       <body>
           <button id="btn">按钮</button>
           <script>
               var btn = document.getElementById('btn')
               btn.addEventListener('click', function () {
                   console.log('Location对象为：', window.location)
                   window.location = 'https://www.baidu.com'
               })
               // 也可以用下边的方式
               // btn.addEventListener('click', function () {
               //     console.log('Location对象的href属性为：', location.href)
               //     location.href = 'https://www.baidu.com'
               // })
           </script>
       </body>
   
   </html>
   ```

### 定时器

定时器的具体方法由 Window对象提供，共有以下两种定时器

- 延迟执行：指的是指定程序代码在指定时间后被执行，而不是立即被执行
- 周期执行：指的是指定程序代码在指定时间为间隔，重复被执行。

目前，HTML页面中多数动态效果，以及动画效果等均由定时器内容完成。

#### 延迟执行

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

#### 周期执行

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

#### 动画方法requestAnimationFrame()

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



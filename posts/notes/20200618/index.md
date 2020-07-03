# 七、jQuery狂拍大灰狼案例


在线案例显示：[狂拍灰太狼](https://antmoe.gitee.io/project/2020/06/18/%E7%8B%82%E6%8B%8D%E7%81%B0%E5%A4%AA%E7%8B%BC/)

## 首页布局

### 基本布局

![image-20200618100308459](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/18/ffd1fc4d292751a86bc6ffa5e7ae34ff.png)

完成首页的布局，背景使用了一张图片。其余元素，图中已经标出。

```html
<div class="container">
    <h1>0</h1>
    <div class="progress"></div>
    <button class="start">开始游戏</button>
    <div class="rules">游戏规则</div>
</div>
```

```css
* {
    margin: 0;
    height: 0;
}

.container {
    width: 320px;
    height: 480px;
    background: url("https://tva1.sinaimg.cn/large/005B3XPgly1gfw7dh267lj308w0dc759.jpg") no-repeat 0 0;
    margin: 50px auto;
    position: relative;
}

.container>h1 {
    color: white;
    margin-left: 60px;
}

.container>.progress {
    width: 180px;
    height: 16px;
    background: url('https://tva1.sinaimg.cn/large/005B3XPgly1gfw7dh7tu4j305000gt8j.jpg') no-repeat 0 0;
    position: absolute;
    top: 66px;
    left: 63px;
}

.container>.start {
    width: 150px;
    height: 35px;
    /* line-height: 35px; */
    text-align: center;
    color: white;
    background: linear-gradient(#e55c3D, #c50000);
    border-radius: 20px;
    border: none;
    font-size: 20px;
    position: absolute;
    top: 320px;
    left: 50%;
    margin-left: -75px;
    outline: none;
    cursor: pointer;
}

.container>.rules {
    width: 100%;
    height: 20px;
    background-color: #ccc;
    position: absolute;
    left: 0;
    bottom: 0;
    text-align: center;
}
```

### 其他布局

1. 游戏规则页面

   这个页面很简单，一个蒙版即可。

   ![image-20200618102204541](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/18/c77ec88542ce691af3fc23e5a312c0e5.png)

   ```css
   .container>.rule {
       width: 100%;
       height: 100%;
       background: rgba(0, 0, 0, 0.5);
       position: absolute;
       left: 0;
       top: 0;
       padding-top: 100px;
       box-sizing: border-box;
       text-align: center;
       /* display: none; */
   }
   
   .container>.rule>p {
       line-height: 50px;
       color: white;a
   }
   
   .container>.rule>a {
       color: red;
   }
   ```

   ```html
   <div class="rule">
       <p>游戏规则：</p>
       <p>1. 游戏时间60S</p>
       <p>2. 拼手速：殴打灰太狼+10分</p>
       <p>3. 殴打小灰灰-10分</p>
       <a href="#">【关闭】</a>
   </div>
   ```

2. 游戏结束页面

   ![image-20200618102518062](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/18/931052e02372c8c5c3e5114c4d8c1823.png)

   ```css
   .container>.mask {
       width: 100%;
       height: 100%;
       background: rgba(0, 0, 0, 0.5);
       position: absolute;
       left: 0;
       top: 0;
       padding-top: 200px;
       box-sizing: border-box;
       text-align: center;
       /* display: none; */
   }
   
   .container>.mask>h1 {
       color: #ff4500;
       text-shadow: 3px 3px 0 #fff;
   }
   
   .container>.mask>button {
       width: 150px;
       height: 35px;
       /* line-height: 35px; */
       text-align: center;
       color: white;
       background: linear-gradient(#74accf, #007ddc);
       border-radius: 20px;
       border: none;
       font-size: 20px;
       position: absolute;
       top: 320px;
       left: 50%;
       margin-left: -75px;
       outline: none;
       cursor: pointer;
   }
   ```

   ```html
   <div class="mask">
       <h1>GAME OVER</h1>
       <button>重新开始</button>
   </div>
   ```

### 完整代码

至此已经完成了静态页面的布局。

```html
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <style>
            * {
                margin: 0;
                padding: 0;
            }

            .container {
                width: 320px;
                height: 480px;
                background: url("https://tva1.sinaimg.cn/large/005B3XPgly1gfw7dh267lj308w0dc759.jpg") no-repeat 0 0;
                margin: 50px auto;
                position: relative;
            }

            .container>h1 {
                color: white;
                margin-left: 60px;
            }

            .container>.progress {
                width: 180px;
                height: 16px;
                background: url('https://tva1.sinaimg.cn/large/005B3XPgly1gfw7dh7tu4j305000gt8j.jpg') no-repeat 0 0;
                position: absolute;
                top: 66px;
                left: 63px;
            }

            .container>.start {
                width: 150px;
                height: 35px;
                /* line-height: 35px; */
                text-align: center;
                color: white;
                background: linear-gradient(#e55c3D, #c50000);
                border-radius: 20px;
                border: none;
                font-size: 20px;
                position: absolute;
                top: 320px;
                left: 50%;
                margin-left: -75px;
                outline: none;
                cursor: pointer;
            }

            .container>.rules {
                width: 100%;
                height: 20px;
                background-color: #ccc;
                position: absolute;
                left: 0;
                bottom: 0;
                text-align: center;
            }

            /* 游戏规则 */
            .container>.rule {
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                position: absolute;
                left: 0;
                top: 0;
                padding-top: 100px;
                box-sizing: border-box;
                text-align: center;
                display: none;
            }

            .container>.rule>p {
                line-height: 50px;
                color: white;
            }

            .container>.rule>a {
                color: red;
            }

            /* 游戏结束 */
            .container>.mask {
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                position: absolute;
                left: 0;
                top: 0;
                padding-top: 200px;
                box-sizing: border-box;
                text-align: center;
                /* display: none; */
            }

            .container>.mask>h1 {
                color: #ff4500;
                text-shadow: 3px 3px 0 #fff;
            }

            .container>.mask>button {
                width: 150px;
                height: 35px;
                /* line-height: 35px; */
                text-align: center;
                color: white;
                background: linear-gradient(#74accf, #007ddc);
                border-radius: 20px;
                border: none;
                font-size: 20px;
                position: absolute;
                top: 320px;
                left: 50%;
                margin-left: -75px;
                outline: none;
                cursor: pointer;
            }
        </style>
        <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.12.4/jquery.js"></script>
        <script>
            $(function () {

            })
        </script>
    </head>

    <body>
        <div class="container">
            <h1>0</h1>
            <div class="progress"></div>
            <button class="start">开始游戏</button>
            <div class="rules">游戏规则</div>
            <div class="rule">
                <p>游戏规则：</p>
                <p>1. 游戏时间60S</p>
                <p>2. 拼手速：殴打灰太狼+10分</p>
                <p>3. 殴打小灰灰-10分</p>
                <a href="#">【关闭】</a>
            </div>
            <div class="mask">
                <h1>GAME OVER</h1>
                <button>重新开始</button>
            </div>
        </div>
    </body>

</html>
```

## 基本页面的显示隐藏

### 游戏规则的显示与隐藏

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/18/bb5dfdb5f35d50c8aa536502fc1f2629.png)

利用jQuery（`fadeIn`与`fadeOut`方法）很容易就能实现。

1. 找到被点击的按钮，并绑定事件
2. 将需要被显示/隐藏的元素进行`fadeIn`或`fadeOut`方法即可。

```javascript
// 1. 游戏规则的点击
$('.rules').click(function () {
    $('.rule').stop().fadeIn(100)
})
// 2. 关闭按钮的点击
$('.close').click(function () {
    $('.rule').stop().fadeOut(100)
})
```

### 开始与重新开始

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/18/e893142aaa2a211148c574c3212149a8.png)

游戏开始涉及到的内容分别是：

1. 按钮消失

   同样的调用`fadeOut`方法即可

2. 进度条开始逐渐减少

   使用计数器，将宽度逐渐减少即可。

   ```javascript
   // 3. 游戏开始按钮点击
   $('.start').click(function () {
       $(this).stop().fadeOut(100)
       // 调用处理进度条的方法
       progressHandle()
   })
   ```

   <div class="snote idea yellow"><p>由于重新开始按钮的事件与开始事件几乎一致，因此同会调用处理进度条的事件。但重新开始时需要将进度条的进度重新赋值为100%。因此，在进入函数时，先将进度条置为100%即可实现复用。</p></div>

   ```javascript
   // 定义处理进度条的方法
   function progressHandle() {
       // 重新设置进度条的宽度
       $('.progress').css({
           width: 180
       })
       // 使用定时器处理进度条
       var timer = setInterval(function () {
           // 拿到进度条当前的宽度
           var progressWidth = $('.progress').width()
           // 减少当前宽度
           progressWidth -= 10
           // 重新赋值宽度
           $('.progress').css({
               width: progressWidth
           })
           // 监听进度条是否走完
           if (progressWidth <= 0) {
               // 关闭定时器
               clearInterval(timer)
               $('.mask').stop().fadeIn(100)
           }
       }, 100)
       }
   ```

### 重新开始

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/18/d50fa98205031f3a0fe9a9c44bf13185.png)

完成了处理进度条事件后，重新开始只需要调用此事件即可。

```javascript
// 4. 重新开始按钮
$('.reStart').click(function () {
    $('.mask').stop().fadeOut(100)
    progressHandle()
})
```

## 随机位置和图片

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/18/1afe7073a693fe9dff1a8e92d0ae907e.png)

<div class="snote msg cyan"><p>前期准备</p></div>

1. 一个函数，专门用户灰太狼动画的显示

   ```javascript
   function startWolfAnimation() {}
   ```

2. 一个数组用于存储灰太狼的图片

   ```javascript
   var wolf_1 = [
       "https://ae04.alicdn.com/kf/U6d7418e287294bb88d0461d6c27bfcd82.jpg",
       "https://ae02.alicdn.com/kf/Ud511a9efcffa4fe6b2a100aa7513f3e8H.jpg",
       "https://ae01.alicdn.com/kf/U8de07ee534de40b092bb37895a58074bW.jpg",
       "https://ae01.alicdn.com/kf/U65e24e9eea4c4823884a994a4943f5f3H.jpg",
       "https://ae04.alicdn.com/kf/U059507c66fb6466eb8ca6381c794e213I.jpg",
       "https://ae03.alicdn.com/kf/U83f4455be089478b8beaec3153cc1073C.jpg",
       "https://ae02.alicdn.com/kf/U7104f8f282b54523bb782f09a371454bI.jpg",
       "https://ae02.alicdn.com/kf/U9a8f28c4af7846b99166155c31a9f5d6H.jpg",
       "https://ae02.alicdn.com/kf/U788c378b55a046d7a69e460ea7723f43l.jpg",
       "https://ae02.alicdn.com/kf/U707e83428bfd4fcca7f3e1ef732f642dF.jpg",
   ]
   ```

   

3. 一个数组用于存储小灰灰的图片

   ```javascript
       var wolf_2 = [
                           'https://ae01.alicdn.com/kf/U00654478fdbc42bcb157dc88ca49d535v.jpg',
                           'https://ae03.alicdn.com/kf/Ufffbe0e563f2422f8468dfe07e6944cbj.jpg',
                           'https://ae01.alicdn.com/kf/Ua6fc5df7037c4bb4aa9c4140851fa6bfo.jpg',
                           'https://ae01.alicdn.com/kf/U52169e31a945465c946c00cd3a23f96dF.jpg',
                           'https://ae01.alicdn.com/kf/Ub2f779675ad04432a2bed6153f59a4c6B.jpg',
                           'https://ae02.alicdn.com/kf/U8a0ef3b264f946fbacfb905d96bbc60em.jpg',
                           'https://ae02.alicdn.com/kf/U2c445d659e324b9c97593f47f11a5785V.jpg',
                           'https://ae03.alicdn.com/kf/U60c99e7d8f3844b18f33f1b3bee649c8M.jpg',
                           'https://ae02.alicdn.com/kf/U184d2a419e824317aac79ee85762479f9.jpg',
                           'https://ae02.alicdn.com/kf/Ufce9406da7ed4515a8e71c9c4d161697r.jpg',
                       ]
   ```

4. 一个数组用于存储位置

   由于位置包含左与右，因此我们在数组中存储的是对象。

   ```js
   var arrPos = [
       { left: "100px", top: '115px' },
       { left: "20px", top: '160px' },
       { left: "190px", top: '142px' },
       { left: "105px", top: '193px' },
       { left: "19px", top: '221px' },
       { left: "202px", top: '212px' },
       { left: "120px", top: '275px' },
       { left: "30px", top: '295px' },
       { left: "209px", top: '297px' },
   ]
   ```

   

### 设置随机位置与随机图片

1. 随机位置

   因为已经有了一个所有位置的数组，因此只要随机取其中一个即可。

   `Math.round(Math.random() * 8)`

2. 随机图片

   与随机位置同理，`Math.round(Math.random())`

能够获取到随机位置与图片后，那么接下来要做的就是：

1. 创建一个图片元素

   ```javascript
   var $wolfImage = $('<img src="">')
   ```

2. 设置图片的位置

   ```javascript
   // 获取随机图片的位置
   var posIndex = Math.round(Math.random() * 8)
   // 4. 设置图片显示的位置
   $wolfImage.css({
       position: 'absolute',
       left: arrPos[posIndex].left,
       top: arrPos[posIndex].top
   })
   ```

3. 设置图片的内容

   ```javascript
   // 随机获取数组类型
   var wolf_type = Math.round(Math.random()) == 0 ? wolf_1 : wolf_2
   // 5. 设置图片内容
   $wolfImage.attr('src', wolf_type[5])
   
   ```

4. 将图片添加到页面

   ```javascript
   // 6. 将图片添加到页面上
   $('.container').append($wolfImage)
   ```

   

## 实现动画

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/18/489a8dfce9c85d44b711e76d2d812f29.png)

1. 点击开始按钮后

   执行动画，并且需要判断图片显示（不能显示被打的图片）。当图片显示完成后，删除图片。因此，在设置图片内容时可以为其开启定时器。

   ```javascript
   // 5. 设置图片内容
   var wolfIndex = 0
   wolfTimer = setInterval(function () {
       if (wolfIndex > 5) {
           $wolfImage.remove()
           clearInterval(wolfTimer)
           startWolfAnimation()
       }
       $wolfImage.attr('src', wolf_type[wolfIndex])
       wolfIndex++;
   }, 300)
   function startWolfAnimation() {
       // 灰太狼图片
       var wolf_1 = [
           "https://ae04.alicdn.com/kf/U6d7418e287294bb88d0461d6c27bfcd82.jpg",
           "https://ae02.alicdn.com/kf/Ud511a9efcffa4fe6b2a100aa7513f3e8H.jpg",
           "https://ae01.alicdn.com/kf/U8de07ee534de40b092bb37895a58074bW.jpg",
           "https://ae01.alicdn.com/kf/U65e24e9eea4c4823884a994a4943f5f3H.jpg",
           "https://ae04.alicdn.com/kf/U059507c66fb6466eb8ca6381c794e213I.jpg",
           "https://ae03.alicdn.com/kf/U83f4455be089478b8beaec3153cc1073C.jpg",
           "https://ae02.alicdn.com/kf/U7104f8f282b54523bb782f09a371454bI.jpg",
           "https://ae02.alicdn.com/kf/U9a8f28c4af7846b99166155c31a9f5d6H.jpg",
           "https://ae02.alicdn.com/kf/U788c378b55a046d7a69e460ea7723f43l.jpg",
           "https://ae02.alicdn.com/kf/U707e83428bfd4fcca7f3e1ef732f642dF.jpg",
       ]
       // 小灰灰图片
       var wolf_2 = [
           'https://ae01.alicdn.com/kf/U00654478fdbc42bcb157dc88ca49d535v.jpg',
           'https://ae03.alicdn.com/kf/Ufffbe0e563f2422f8468dfe07e6944cbj.jpg',
           'https://ae01.alicdn.com/kf/Ua6fc5df7037c4bb4aa9c4140851fa6bfo.jpg',
           'https://ae01.alicdn.com/kf/U52169e31a945465c946c00cd3a23f96dF.jpg',
           'https://ae01.alicdn.com/kf/Ub2f779675ad04432a2bed6153f59a4c6B.jpg',
           'https://ae02.alicdn.com/kf/U8a0ef3b264f946fbacfb905d96bbc60em.jpg',
           'https://ae02.alicdn.com/kf/U2c445d659e324b9c97593f47f11a5785V.jpg',
           'https://ae03.alicdn.com/kf/U60c99e7d8f3844b18f33f1b3bee649c8M.jpg',
           'https://ae02.alicdn.com/kf/U184d2a419e824317aac79ee85762479f9.jpg',
           'https://ae02.alicdn.com/kf/Ufce9406da7ed4515a8e71c9c4d161697r.jpg',
       ]
       // 随机位置
       var arrPos = [
           { left: "100px", top: '115px' },
           { left: "20px", top: '160px' },
           { left: "190px", top: '142px' },
           { left: "105px", top: '193px' },
           { left: "19px", top: '221px' },
           { left: "202px", top: '212px' },
           { left: "120px", top: '275px' },
           { left: "30px", top: '295px' },
           { left: "209px", top: '297px' },
       ]
       // 3. 创建一个图片
       var $wolfImage = $('<img src="" class="wolfImage">')
       // 获取随机图片的位置
       var posIndex = Math.round(Math.random() * 8)
       // 4. 设置图片显示的位置
       $wolfImage.css({
           position: 'absolute',
           left: arrPos[posIndex].left,
           top: arrPos[posIndex].top
       })
       // 随机获取数组类型
       var wolf_type = Math.round(Math.random()) == 0 ? wolf_1 : wolf_2
       // 5. 设置图片内容
       var wolfIndex = 0
       wolfTimer = setInterval(function () {
           if (wolfIndex > 5) {
               $wolfImage.remove()
               clearInterval(wolfTimer)
               startWolfAnimation()
           }
           $wolfImage.attr('src', wolf_type[wolfIndex])
           wolfIndex++;
       }, 300)
       // 6. 将图片添加到页面上
       $('.container').append($wolfImage)
   }
   ```

   > 定时器需要在全局声明，因为游戏结束后需要清楚这个定时器，否则当游戏结束时，还是会出现动画。

2. 游戏结束

   游戏结束后，应当停止动画，并且清除已存在的灰太狼图片。

   ```javascript
   // 监听进度条是否走完
   if (progressWidth <= 0) {
       // 关闭开始动画的定时器
       clearInterval(timer)
       $('.mask').stop().fadeIn(100)
       // 停止灰太狼动画
       stopWolfAnimation()
   }
   }, 100)
   
   // 停止灰太狼动画函数
   function stopWolfAnimation() {
       $('.wolfImage').remove()
       clearInterval(wolfTimer)
   }
   ```

3. 重新开始

   重新开始按钮执行逻辑其实就是在执行一遍开始动画。

   ```javascript
   // 4. 重新开始按钮
   $('.reStart').click(function () {
       $('.mask').stop().fadeOut(100)
       progressHandle()
       // 处理灰太狼动画的方法
       startWolfAnimation()
   })
   ```

   

## 游戏规则的实现

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/18/06a7f8b9b6888e36e7e68a1ea88ab341.png)

1. 游戏规则的触发应该是图片被点击时，因此在开始动画的函数中新增一个游戏规则的方法。并传入图片作为参数。

   ```javascript
   // 7. 调用处理游戏规则的方法
   gameRules($wolfImage);
   ```

2. 为了判断被点击的图片是加分数还是减分数，将图片地址添加一个参数。

   ```javascript
                       // 灰太狼图片
                       var wolf_1 = [
                           "https://ae04.alicdn.com/kf/U6d7418e287294bb88d0461d6c27bfcd82.jpg?add",
                           "https://ae02.alicdn.com/kf/Ud511a9efcffa4fe6b2a100aa7513f3e8H.jpg?add",
                           "https://ae01.alicdn.com/kf/U8de07ee534de40b092bb37895a58074bW.jpg?add",
                           "https://ae01.alicdn.com/kf/U65e24e9eea4c4823884a994a4943f5f3H.jpg?add",
                           "https://ae04.alicdn.com/kf/U059507c66fb6466eb8ca6381c794e213I.jpg?add",
                           "https://ae03.alicdn.com/kf/U83f4455be089478b8beaec3153cc1073C.jpg?add",
                           "https://ae02.alicdn.com/kf/U7104f8f282b54523bb782f09a371454bI.jpg?add",
                           "https://ae02.alicdn.com/kf/U9a8f28c4af7846b99166155c31a9f5d6H.jpg?add",
                           "https://ae02.alicdn.com/kf/U788c378b55a046d7a69e460ea7723f43l.jpg?add",
                           "https://ae02.alicdn.com/kf/U707e83428bfd4fcca7f3e1ef732f642dF.jpg?add",
                       ]
                       // 小灰灰图片
                       var wolf_2 = [
                           'https://ae01.alicdn.com/kf/U00654478fdbc42bcb157dc88ca49d535v.jpg?min',
                           'https://ae03.alicdn.com/kf/Ufffbe0e563f2422f8468dfe07e6944cbj.jpg?min',
                           'https://ae01.alicdn.com/kf/Ua6fc5df7037c4bb4aa9c4140851fa6bfo.jpg?min',
                           'https://ae01.alicdn.com/kf/U52169e31a945465c946c00cd3a23f96dF.jpg?min',
                           'https://ae01.alicdn.com/kf/Ub2f779675ad04432a2bed6153f59a4c6B.jpg?min',
                           'https://ae02.alicdn.com/kf/U8a0ef3b264f946fbacfb905d96bbc60em.jpg?min',
                           'https://ae02.alicdn.com/kf/U2c445d659e324b9c97593f47f11a5785V.jpg?min',
                           'https://ae03.alicdn.com/kf/U60c99e7d8f3844b18f33f1b3bee649c8M.jpg?min',
                           'https://ae02.alicdn.com/kf/U184d2a419e824317aac79ee85762479f9.jpg?min',
                           'https://ae02.alicdn.com/kf/Ufce9406da7ed4515a8e71c9c4d161697r.jpg?min',
                       ]
   ```

   > 使用本地链接无需添加，修改图片名即可。

3. 替换当前动画

   当被点击后，应该显示后五张图片。因此将第五步的设置图片内容所需要判断的索引修改为变量，并添加到全局变量。这样方便修改当前图片显示的索引。

   ```javascript
   // 5. 设置图片内容
   window.wolfIndex = 0
   window.wolfIndexEnd = 5
   wolfTimer = setInterval(function () {
       if (wolfIndex > wolfIndexEnd) {
           // ...
       }
   ```

4. 判断加/减分数

   拿到当前被点击图片，然后判断src属性是否包含`add`即可。如果包含说明是加分，否则就是减分。

   ```javascript
   // 拿到当前点击图片的地址
   var $src = $(this).attr('src')
   var flag = $src.indexOf('add') >= 0
   // 根据图片类型增减分数
   if (flag) {
       $('.score').text(parseInt($('.score').text()) + 10)
   } else {
       $('.score').text(parseInt($('.score').text()) - 10)
   }
   ```



## 完整代码

```html
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Document</title>
        <style>
            * {
                margin: 0;
                padding: 0;
            }

            .container {
                width: 320px;
                height: 480px;
                background: url("https://tva1.sinaimg.cn/large/005B3XPgly1gfw7dh267lj308w0dc759.jpg")
                    no-repeat 0 0;
                margin: 50px auto;
                position: relative;
            }

            .container > h1 {
                color: white;
                margin-left: 60px;
            }

            .container > .progress {
                width: 180px;
                height: 16px;
                background: url("https://tva1.sinaimg.cn/large/005B3XPgly1gfw7dh7tu4j305000gt8j.jpg")
                    no-repeat 0 0;
                position: absolute;
                top: 66px;
                left: 63px;
            }

            .container > .start {
                width: 150px;
                height: 35px;
                /* line-height: 35px; */
                text-align: center;
                color: white;
                background: linear-gradient(#e55c3d, #c50000);
                border-radius: 20px;
                border: none;
                font-size: 20px;
                position: absolute;
                top: 320px;
                left: 50%;
                margin-left: -75px;
                outline: none;
                cursor: pointer;
            }

            .container > .rules {
                width: 100%;
                height: 20px;
                background-color: #ccc;
                position: absolute;
                left: 0;
                bottom: 0;
                text-align: center;
            }

            /* 游戏规则 */
            .container > .rule {
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                position: absolute;
                left: 0;
                top: 0;
                padding-top: 100px;
                box-sizing: border-box;
                text-align: center;
                display: none;
            }

            .container > .rule > p {
                line-height: 50px;
                color: white;
            }

            .container > .rule > a {
                color: red;
            }

            /* 游戏结束 */
            .container > .mask {
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                position: absolute;
                left: 0;
                top: 0;
                padding-top: 200px;
                box-sizing: border-box;
                text-align: center;
                display: none;
            }

            .container > .mask > h1 {
                color: #ff4500;
                text-shadow: 3px 3px 0 #fff;
            }

            .container > .mask > button {
                width: 150px;
                height: 35px;
                /* line-height: 35px; */
                text-align: center;
                color: white;
                background: linear-gradient(#74accf, #007ddc);
                border-radius: 20px;
                border: none;
                font-size: 20px;
                position: absolute;
                top: 320px;
                left: 50%;
                margin-left: -75px;
                outline: none;
                cursor: pointer;
            }
        </style>
        <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.12.4/jquery.js"></script>
        <script>
            $(function () {
                var wolfTimer;
                // 1. 游戏规则的点击
                $(".rules").click(function () {
                    $(".rule").stop().fadeIn(100);
                });
                // 2. 关闭按钮的点击
                $(".close").click(function () {
                    $(".rule").stop().fadeOut(100);
                });
                // 3. 游戏开始按钮点击
                $(".start").click(function () {
                    $(this).stop().fadeOut(100);
                    // 调用处理进度条的方法
                    progressHandle();
                    // 调用处理灰太狼动画的方法
                    startWolfAnimation();
                });
                // 4. 重新开始按钮
                $(".reStart").click(function () {
                    $(".mask").stop().fadeOut(100);
                    progressHandle();
                    // 处理灰太狼动画的方法
                    startWolfAnimation();
                });
                // 定义处理进度条的方法
                function progressHandle() {
                    // 重新设置进度条的宽度
                    $(".progress").css({
                        width: 180,
                    });
                    // 使用定时器处理进度条
                    var timer = setInterval(function () {
                        // 拿到进度条当前的宽度
                        var progressWidth = $(".progress").width();
                        // 减少当前宽度
                        progressWidth -= 1;
                        // 重新赋值宽度
                        $(".progress").css({
                            width: progressWidth,
                        });
                        // 监听进度条是否走完
                        if (progressWidth <= 0) {
                            // 关闭定时器
                            clearInterval(timer);
                            $(".mask").stop().fadeIn(100);
                            // 停止灰太狼动画
                            stopWolfAnimation();
                        }
                    }, 100);
                }

                // 定义处理灰太狼的动画的方法
                function startWolfAnimation() {
                    // 灰太狼图片
                    var wolf_1 = [
                        "https://ae04.alicdn.com/kf/U6d7418e287294bb88d0461d6c27bfcd82.jpg?add",
                        "https://ae02.alicdn.com/kf/Ud511a9efcffa4fe6b2a100aa7513f3e8H.jpg?add",
                        "https://ae01.alicdn.com/kf/U8de07ee534de40b092bb37895a58074bW.jpg?add",
                        "https://ae01.alicdn.com/kf/U65e24e9eea4c4823884a994a4943f5f3H.jpg?add",
                        "https://ae04.alicdn.com/kf/U059507c66fb6466eb8ca6381c794e213I.jpg?add",
                        "https://ae03.alicdn.com/kf/U83f4455be089478b8beaec3153cc1073C.jpg?add",
                        "https://ae02.alicdn.com/kf/U7104f8f282b54523bb782f09a371454bI.jpg?add",
                        "https://ae02.alicdn.com/kf/U9a8f28c4af7846b99166155c31a9f5d6H.jpg?add",
                        "https://ae02.alicdn.com/kf/U788c378b55a046d7a69e460ea7723f43l.jpg?add",
                        "https://ae02.alicdn.com/kf/U707e83428bfd4fcca7f3e1ef732f642dF.jpg?add",
                    ];
                    // 小灰灰图片
                    var wolf_2 = [
                        "https://ae01.alicdn.com/kf/U00654478fdbc42bcb157dc88ca49d535v.jpg?min",
                        "https://ae03.alicdn.com/kf/Ufffbe0e563f2422f8468dfe07e6944cbj.jpg?min",
                        "https://ae01.alicdn.com/kf/Ua6fc5df7037c4bb4aa9c4140851fa6bfo.jpg?min",
                        "https://ae01.alicdn.com/kf/U52169e31a945465c946c00cd3a23f96dF.jpg?min",
                        "https://ae01.alicdn.com/kf/Ub2f779675ad04432a2bed6153f59a4c6B.jpg?min",
                        "https://ae02.alicdn.com/kf/U8a0ef3b264f946fbacfb905d96bbc60em.jpg?min",
                        "https://ae02.alicdn.com/kf/U2c445d659e324b9c97593f47f11a5785V.jpg?min",
                        "https://ae03.alicdn.com/kf/U60c99e7d8f3844b18f33f1b3bee649c8M.jpg?min",
                        "https://ae02.alicdn.com/kf/U184d2a419e824317aac79ee85762479f9.jpg?min",
                        "https://ae02.alicdn.com/kf/Ufce9406da7ed4515a8e71c9c4d161697r.jpg?min",
                    ];
                    // 随机位置
                    var arrPos = [
                        { left: "100px", top: "115px" },
                        { left: "20px", top: "160px" },
                        { left: "190px", top: "142px" },
                        { left: "105px", top: "193px" },
                        { left: "19px", top: "221px" },
                        { left: "202px", top: "212px" },
                        { left: "120px", top: "275px" },
                        { left: "30px", top: "295px" },
                        { left: "209px", top: "297px" },
                    ];
                    // 3. 创建一个图片
                    var $wolfImage = $('<img src="" class="wolfImage">');
                    // 获取随机图片的位置
                    var posIndex = Math.round(Math.random() * 8);
                    // 4. 设置图片显示的位置
                    $wolfImage.css({
                        position: "absolute",
                        left: arrPos[posIndex].left,
                        top: arrPos[posIndex].top,
                    });
                    // 随机获取数组类型
                    var wolf_type = Math.round(Math.random()) == 0 ? wolf_1 : wolf_2;
                    // 5. 设置图片内容
                    window.wolfIndex = 0;
                    window.wolfIndexEnd = 5;
                    wolfTimer = setInterval(function () {
                        if (wolfIndex > wolfIndexEnd) {
                            $wolfImage.remove();
                            clearInterval(wolfTimer);
                            startWolfAnimation();
                        }
                        $wolfImage.attr("src", wolf_type[wolfIndex]);
                        wolfIndex++;
                    }, 300);
                    // 6. 将图片添加到页面上
                    $(".container").append($wolfImage);

                    // 7. 调用处理游戏规则的方法
                    gameRules($wolfImage);
                }
                function gameRules($wolfImage) {
                    $wolfImage.one("click", function () {
                        // 修改索引
                        window.wolfIndex = 5;
                        window.wolfIndexEnd = 9;
                        // 拿到当前点击图片的地址
                        var $src = $(this).attr("src");
                        var flag = $src.indexOf("add") >= 0;
                        // 根据图片类型增减分数
                        if (flag) {
                            $(".score").text(parseInt($(".score").text()) + 10);
                        } else {
                            $(".score").text(parseInt($(".score").text()) - 10);
                        }
                    });
                }
                // 停止灰太狼动画
                function stopWolfAnimation() {
                    $(".wolfImage").remove();
                    clearInterval(wolfTimer);
                }
            });
        </script>
    </head>

    <body>
        <div class="container">
            <h1 class="score">0</h1>
            <div class="progress"></div>
            <button class="start">开始游戏</button>
            <div class="rules">游戏规则</div>
            <div class="rule">
                <p>游戏规则：</p>
                <p>1. 游戏时间60S</p>
                <p>2. 拼手速：殴打灰太狼+10分</p>
                <p>3. 殴打小灰灰-10分</p>
                <a href="#" class="close">【关闭】</a>
            </div>
            <div class="mask">
                <h1>GAME OVER</h1>
                <button class="reStart">重新开始</button>
            </div>
        </div>
    </body>
</html>

```

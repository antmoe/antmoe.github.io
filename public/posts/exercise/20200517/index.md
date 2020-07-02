# 左右滑动式轮播图


## 描述

[https://antmoe.gitee.io/project/2020/05/17/1_轮播图切换动画.html](https://antmoe.gitee.io/project/2020/05/17/1_轮播图切换动画.html)

实现静态效果不难，只需要控制其left效果即可。

如果加入动画效果，只能利用定时器.

左右按钮的切换大致相同,只以右按钮为例:

1. 记录当前图片的索引(全局变量保存)
2. 判断尺寸
   - 几张图片
   - 每张图片的宽度
3. 利用定时器完成累加/减

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>小米首页轮播图</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
        }

        .container {
            width: 1226px;
            height: 460px;
            background-color: lightcyan;
            overflow: hidden;
            margin: 100px auto;

            position: relative;
        }

        .container .imgList {
            width: 6130px;
            position: absolute;
        }

        .container .imgList img {
            display: block;
            width: 1226px;
            height: auto;
            float: left;
        }

        .container .slide-controls {
            width: 100%;
            height: 100%;
            position: absolute;
            left: 0;
            top: 0;
            right: 0;
            bottom: 0;
        }

        .container .slide-controls .slide-left,
        .container .slide-controls .slide-right {
            width: 41px;
            height: 69px;

            position: absolute;
            top: 50%;
            transform: translateY(-50%);

            background-image: url(https://i1.mifile.cn/f/i/2014/cn/icon/icon-slides.png);
            cursor: pointer;

            z-index: 2;
        }

        .container .slide-controls .slide-left {
            left: 0;
            background-position: -84px 0;
        }

        .container .slide-controls .slide-left:hover {
            background-position: 0 0;
        }

        .container .slide-controls .slide-right {
            right: 0;
            background-position: -124px 0;
        }

        .container .slide-controls .slide-right:hover {
            background-position: -42px 0;
        }

        .container .nav {
            width: 100px;
            height: 20px;

            position: absolute;
            left: 50%;
            right: 0;
            bottom: 8px;

            transform: translateX(-50%);

            z-index: 2;
        }

        .container .nav .slide-nav {
            width: 12px;
            height: 12px;
            border: 2px solid #fff;
            border-color: hsla(0, 0%, 100%, .3);
            border-radius: 10px;
            background: rgba(0, 0, 0, .4);
            cursor: pointer;
            margin: 0 4px;
            float: left;
            z-index: 3;
        }

        .container .nav .slide-nav:hover {
            background: hsla(0, 0%, 100%, .4);
            border-color: rgba(0, 0, 0, .4);
        }
    </style>
    <script type="text/javascript" nonce="e9b48b8ca3e64a6a85e757b4795"
        src="//local.adguard.org?ts=1589675716165&amp;type=content-script&amp;dmn=gethtml.cn&amp;css=1&amp;js=1&amp;gcss=1&amp;rel=1&amp;rji=1&amp;stealth=1&amp;uag="></script>
    <script type="text/javascript" nonce="e9b48b8ca3e64a6a85e757b4795"
        src="//local.adguard.org?ts=1589675716165&amp;name=AdGuard%20Popup%20Blocker&amp;name=AdGuard%20Assistant&amp;name=AdGuard%20Extra&amp;type=user-script"></script>
</head>

<body>
    <!-- 视觉容器 -->
    <div class="container">
        <!-- 图片列表 -->
        <div class="imgList">
            <img src="https://ae01.alicdn.com/kf/U1a6b653720d845c682f97d2fcf75c22f6.png" />
            <img src="https://cdn.cnbj1.fds.api.mi-img.com/mi-mall/755aca9487082e7698e16f17cfb70839.jpg" />
            <img src="https://cdn.cnbj1.fds.api.mi-img.com/mi-mall/e5b37cdb85b3b93b5938cc508a10c906.jpg" />
            <img src="https://cdn.cnbj1.fds.api.mi-img.com/mi-mall/e909ef0e50960f61a730380013bc960a.jpg" />
            <img src="https://cdn.cnbj1.fds.api.mi-img.com/mi-mall/6bd4174b8c5aad67a64864a5716ad152.jpg" />
        </div>
        <!-- 左右切换菜单 -->
        <div class="slide-controls">
            <div class="slide-left"></div>
            <div class="slide-right"></div>
        </div>
        <!-- 轮播图的导航 -->
        <div class="nav">
            <div class="slide-nav"></div>
            <div class="slide-nav"></div>
            <div class="slide-nav"></div>
            <div class="slide-nav"></div>
            <div class="slide-nav"></div>
        </div>
    </div>
    <script>
        // NOTE 获取元素对象
        var container = document.getElementsByClassName('container')[0]
        var imgList = container.getElementsByClassName('imgList')[0]
        var rightBtn = document.getElementsByClassName('slide-right')[0]
        var leftBtn = document.getElementsByClassName('slide-left')[0]
        var nav = container.getElementsByClassName('nav')[0]
        var slide_nav = container.getElementsByClassName('slide-nav')
        var indexStart
        var auto_num
        // NOTE 定义全局变量

        // TAG 定义单图片的宽度（每次滚动的大小）
        var img_width = 1226
        // TAG 图片的总个数
        var img_num = imgList.childElementCount
        // TAG 图片当前的索引 默认为0
        var img_index = 0
        // TAG 记录上一个nav按钮
        var pre_nav_num = 0
        // NOTE 定义函数
        // TAG 按钮点击时，对应图片获得对应样式
        function showNav(num) {
            // 显示当前被点击的nav
            slide_nav[num].style.background = 'hsla(0, 0%, 100%, .4)'
            slide_nav[num].style.borderColor = 'rgba(0, 0, 0, .4)'
            // 取消上一次的nav
            slide_nav[pre_nav_num].style.borderColor = 'hsla(0, 0%, 100%, .4)'
            slide_nav[pre_nav_num].style.background = 'rgba(0, 0, 0, .4)'
        }
        auto()

        // TAG 右按钮 绑定事件
        rightBtn.addEventListener('click', function () {
            if (img_index < img_num - 1) {
                pre_nav_num = img_index
                indexStart = -(img_index * img_width)
                img_index++
                // indexEnd = -(img_index * img_width)
            } else {
                img_index = 0
                indexStart = 1226
                // indexEnd = 0
                pre_nav_num = 4
            }
            clearInterval(auto_num)
            moveLeft()
            // FIXED 延迟10秒似乎不起作用
            setTimeout(auto, 5000)
            showNav(img_index)
        })
        // TAG 左按钮 绑定事件
        leftBtn.addEventListener('click', function () {
            if (img_index == 0) {
                img_index = 4
                indexStart = -6130
                pre_nav_num = 0
            } else {
                pre_nav_num = img_index
                indexStart = -(img_index * img_width)
                img_index--
            }
            // imgList.style.left = -(img_index * img_width) + 'px'

            moveRight()
            showNav(img_index)
        })
        // TAG nav绑定事件
        nav.addEventListener('click', function (e) {
            // TAG 定义一个数组，用于存储nav列表
            var nav_list = []
            for (var i = 0; i < nav.childElementCount; i++) {
                nav_list.push(slide_nav[i])
                slide_nav[i].style.borderColor = 'hsla(0, 0%, 100%, .4)'
                slide_nav[i].style.background = 'rgba(0, 0, 0, .4)'
            }
            var target = e.target
            if (target.className === 'slide-nav') {
                img_index = nav_list.indexOf(target)
                slide_nav[img_index].style.borderColor = 'hsla(0, 0%, 100%, .4)'
                slide_nav[img_index].style.background = 'rgba(255, 255, 255, 0.4)'
                imgList.style.left = -(img_index * img_width) + 'px'
            }
        })
        // BUG 边界切换不完美
        function moveLeft() {
            if (indexStart <= -(img_index * img_width)) {
                clearInterval(t)
            } else {
                indexStart -= 10
                imgList.style.left = indexStart + 'px'
                var t = setTimeout(moveLeft, 1)
            }
        }
        function moveRight() {
            if (indexStart >= -(img_index * img_width)) {
                clearInterval(t)
            } else {
                indexStart += 10
                imgList.style.left = indexStart + 'px'
                var t = setTimeout(moveRight, 1)
            }
        }
        function auto() {
            auto_num = setInterval(function () {
                if (img_index < img_num - 1) {
                    pre_nav_num = img_index
                    indexStart = -(img_index * img_width)
                    img_index++
                    // indexEnd = -(img_index * img_width)
                } else {
                    img_index = 0
                    indexStart = 1226
                    // indexEnd = 0
                    pre_nav_num = 4
                }
                // imgList.style.left = -(img_index * img_width) + 'px'
                moveLeft()
                showNav(img_index);
            }, 5000)
        }

    </script>
</body>

</html>
```



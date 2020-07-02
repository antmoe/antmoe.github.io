---
title: 五、jQuery动效
date: 2020-06-16T18:39:51+08:00
categories: ["notes"]
tags: ["jQuery"]
---

## 显示隐藏动画

显示`show()`动画，隐藏动画`hide()`，切换动画`toggle()`

这三个方法都可以传入参数：

- 一个参数

  代表动画完成的时间

- 两个参数

  第一个表示动画完成的时间，第二个参数表示动画完成后执行的回调函数

```javascript
$(function () {
    $('button').eq(0).click(function () {
        $('div').show(1000, function () {
            alert('显示动画执行完毕')
        })
    })
    $('button').eq(1).click(function () {
        $('div').hide(1000, function () {
            alert('隐藏动画执行完毕')
        })
    })
    $('button').eq(2).click(function () {
        $('div').toggle(1000, function () {
            alert('切换动画执行完毕')
        })
    })

})
```

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/e0d96af89c33513e1ada7db205bc7184.png)



<div class='tip' ><p>对联广告案例<p></div>

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/4cd771fe592f737a592c6bf24a2ba968.png)

1. 监听网页滚动

2. 当滚动到一定量时，展示图片否则隐藏图片

   ```javascript
   $(function () {
       // 1. 监听网页的滚动
       $(window).scroll(function () {
           // 1.1 获取网页滚动的偏移位
           var offset = $('html,body').scrollTop()
           // 1.2 判断网页是否滚动到了指定的位置
           if (offset >= 500) {
               // 1.3 显示广告
               $('img').show(1000)
           } else {
               $('img').hide(1000)
           }
       })
   })
   ```

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

            .left {
                float: left;
                position: fixed;
                left: 0;
                top: 200px;
            }

            .right {
                float: right;
                position: fixed;
                right: 0;
                top: 200px;
            }

            img {
                display: none;
            }
        </style>
        <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.12.4/jquery.js"></script>
        <script>
            $(function () {
                // 1. 监听网页的滚动
                $(window).scroll(function () {
                    // 1.1 获取网页滚动的偏移位
                    var offset = $('html,body').scrollTop()
                    // 1.2 判断网页是否滚动到了指定的位置
                    if (offset >= 500) {
                        // 1.3 显示广告
                        $('img').show(1000)
                    } else {
                        $('img').hide(1000)
                    }
                })
            })
        </script>
    </head>

    <body>
        <img src="https://ae03.alicdn.com/kf/Ub8d7c62873d74ebda173addf2b82d741T.jpg" class="left">
        <img src="https://ae03.alicdn.com/kf/Ub8d7c62873d74ebda173addf2b82d741T.jpg"
             class="right"><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
    </body>

</html>
```



## 展开收起动画

显示`slideDown()`动画，隐藏动画`slideUp()`，切换动画`slideToggle()`

这三个方法都可以传入参数：

- 一个参数

  代表动画完成的时间

- 两个参数

  第一个表示动画完成的时间，第二个参数表示动画完成后执行的回调函数

```javascript
$('button').eq(0).click(function () {
    $('div').slideDown(1000, function () {
        alert('展开完毕')
    })
})
$('button').eq(1).click(function () {
    $('div').slideUp(1000, function () {
        alert('收起完毕')
    })
})
$('button').eq(1).click(function () {
    $('div').slideToggle(1000, function () {
        alert('切换完毕')
    })
})
```

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/893c798118bdae353d5d381bf3dfbaad.png)

<div class='tip' ><p>折叠菜单案例<p></div>

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/f7de3b765fed84c6bb7e836c12148b61.png)

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

        .nav {
            list-style: none;
            width: 300px;
            margin: 100px auto;
        }

        .nav>li {
            border: 1px solid #000;
            line-height: 35px;
            border-bottom: none;
            text-indent: 2em;
            position: relative;
        }

        .nav>li:last-child {
            border-bottom: 1px solid #000;
            border-bottom-left-radius: 5px;
            border-bottom-right-radius: 5px;
        }

        .nav>li:first-child {
            border-top-left-radius: 5px;
            border-top-right-radius: 5px;
        }

        .nav>li>span {
            background: url("https://ae02.alicdn.com/kf/U7eebc02d0d5e4be287d88baf368f0019S.jpg") no-repeat center;
            display: inline-block;
            width: 32px;
            height: 32px;
            position: absolute;
            right: 10px;
            top: 5px;
        }

        .sub {
            display: none;
        }

        .sub>li {
            list-style: none;
            background-color: mediumorchid;
            border: 1px solid white;
        }

        .sub>li:hover {
            background-color: red;
        }

        .nav>.current>span {
            transform: rotate(90deg)
        }
    </style>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.12.4/jquery.js"></script>
    <script>
        $(function () {
            // 1. 监听一级菜单的点击事件
            $('.nav>li').click(function () {
                // 1.1 拿到二级菜单
                var $sub = $(this).children('.sub')
                // 1.2 让二级菜单显示
                $sub.slideDown(1000)
                // 1.3 拿到所有非当前二级菜单
                var otherSub = $(this).siblings().children('.sub')
                console.log(otherSub)
                // 1.4 让所有非当前二级菜单收起
                otherSub.slideUp(1000)
                // 1.5让被点击的一级菜单箭头旋转
                $(this).addClass('current')
                // 1.6 让所有非一级菜单箭头还原
                $(this).siblings().removeClass('current')
            })
        })

    </script>
</head>

<body>
    <ul class="nav">
        <li>一级菜单<span></span>
            <ul class="sub">
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
            </ul>
        </li>
        <li>一级菜单<span></span>
            <ul class="sub">
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
            </ul>
        </li>
        <li>一级菜单<span></span>
            <ul class="sub">
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
            </ul>
        </li>
        <li>一级菜单<span></span>
            <ul class="sub">
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
            </ul>
        </li>
        <li>一级菜单<span></span>
            <ul class="sub">
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
            </ul>
        </li>
        <li>一级菜单<span></span>
            <ul class="sub">
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
            </ul>
        </li>
        <li>一级菜单<span></span>
            <ul class="sub">
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
            </ul>
        </li>
        <li>一级菜单<span></span>
            <ul class="sub">
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
            </ul>
        </li>
    </ul>
</body>

</html>
```

<div class='tip'><p>下拉菜单案例<p></div>

在jQuery中，如果需要执行动画，建议在执行动画之前先调用stop方法，然后在执行动画。

当使用stop时：

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/300d014dbbfb5adfdd4952a511cd61f6.png)

不适用stop时：

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/e8e717315aa8fda98e81b5a57b9514cf.png)



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

        .nav {
            list-style: none;
            width: 300px;
            height: 50px;
            background: red;
            margin: 100px auto;
        }

        .nav>li {
            width: 100px;
            height: 50px;
            line-height: 50px;
            text-align: center;
            float: left;
        }

        .sub {
            list-style: none;
            background-color: royalblue;
            display: none
        }
    </style>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.12.4/jquery.js"></script>
    <script>
        $(function () {
            // 1. 监听一级菜单的移入事件
            $('.nav>li').mouseenter(function () {
                // 1.1 拿到二级菜单
                var $sub = $(this).children('.sub')
                // 1.2 停止当前正在运动的动画
                $sub.stop()
                // 1.3 让二级菜单展开
                $sub.slideDown(1000)
            })
            // 2. 监听一级菜单的移出事件
            $('.nav>li').mouseleave(function () {
                // 1.1 拿到二级菜单
                var $sub = $(this).children('.sub')
                // 1.2 停止当前正在运动的动画
                $sub.stop()
                // 1.3 让二级菜单收起
                $sub.slideUp(1000)
            })
        })

    </script>
</head>

<body>
    <ul class="nav">
        <li>一级菜单
            <ul class="sub">
                <li>二级菜单</li>
                <li>二级菜单</li>
                <li>二级菜单</li>
            </ul>
        </li>
        <li>一级菜单</li>
        <li>一级菜单</li>
    </ul>
</body>

</html>
```

## 淡入淡出动画

- `fadeIn`淡入
- `fadeOut`淡出
- `fadeToggle`切换

以上三个方法均可传入两个参数：

- 时间
- 回调函数

与上述几种方法相似

- `fadeTo`淡入到···

  三个参数分别为：时间，淡入到（程度），回调函数

  ```javascript
  $('buton').eq(3).click(function () {
      $('div').fadeTo(1000, 0.5, function () {
          alert('淡入到完毕')
      })
  })
  ```

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/d6c8ec1ade608f3a72cc7e4fe740163a.png)



<div class='tip' ><p>弹窗广告案例<p></div>

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/c995922d18dbb1eee4571e6fbf96aefd.png)

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

            .ad {
                position: fixed;
                right: 0;
                bottom: 0;
                display: none;
            }

            .ad>span {
                display: inline-block;
                width: 30px;
                height: 30px;
                position: absolute;
                top: 0;
                right: 0;
            }
        </style>
        <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.12.4/jquery.js"></script>
        <script>
            $(function () {
                // 1. 监听span的点击事件
                $('span').click(function () {
                    $('.ad').remove()
                })
                // 2. 执行广告动画
                $('.ad').stop().slideDown(1000).fadeOut(1000).fadeIn(1000)
            })

        </script>
    </head>

    <body>
        <div class="ad">
            <img src="https://ae03.alicdn.com/kf/U2f875afd3ec347f38fc58fc5a091f97dd.jpg" alt="">
            <span></span>
        </div>
    </body>

</html>
```

## 自定义动画

自定义动画的方法为`animate`，可接收三个或四个参数：

- 三个参数

  三个参数分别为动画代码，时长，回调函数

  ```javascript
  $('button').eq(0).click(function () {
      $('.one').animate({
          width: 500
      }, 1000, function () {
          alert('自定义动画执行完毕')
      })
  })
  ```

  ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/e057ae2e86d449b0b814225c34d1ca6c.png)

- 四个参数

  四个参数分别表示：

  - 第一个参数

    接收一个对象，可在对象中修改属性

  - 第二个参数

    指定动画时长

  - 第三个参数

    指定动画节奏，默认是swing

  - 第四个参数

    动画执行完毕之后的回调函数

  ```javascript
  $('button').eq(0).click(function () {
      $('.one').animate({
          marginLeft: 500
      }, 5000, function () {
          // alert('自定义动画执行完毕')
      })
  })
  $('button').eq(0).click(function () {
      $('.two').animate({
          marginLeft: 500
      }, 5000, 'linear', function () {
          // alert('自定义动画执行完毕')
      })
  })
  ```

  ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/788d410d615fce4f917e98c41dfd183c.png)



<span class="inline-tag green">累加属性</span>

累加属性就是在原来基础上再次增加。在第一个参数值得位置填写字符传表达式即可。

```javascript
$('button').eq(1).click(function () {
    $('.two').animate({
        width: "+=100"
    }, 1000, function () {
        alert('自定义动画执行完毕')
    })
})
```

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/ab1aa373d8177b5847a13768c1e8c5d0.png)

<span class="inline-tag green">关键字</span>

关键字属性即传值时传入关键字，例如 `hide`,`toggle`

```javascript
$('button').eq(2).click(function () {
    $('.two').animate({
        // width: 'hide'
        width: 'toggle'
    }, 1000, function () {
        alert('自定义动画执行完毕')
    })
})
```

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/46a6df054ad072c7d2978ab455546f6f.png)

## stop方法和delay方法

`delay(time)`用于延迟动画。例如：

```javascript
$('.one').animate({
    width: 500,
}, 1000).delay(2000).animate({
    height: 500
}, 1000)
```

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/eb08fe515de1a856960c10d3a743a848.png)

`stop(bool)`方法表示停止动画，但其可以传入参数：

```javascript
$('.one').animate({
    width: 500,
}, 2000).animate({
    height: 500
}, 2000).animate({
    height: 100
}, 2000).animate({
    width: 100
}, 2000)
```

例如如上代码，完整的效果为：

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/9a091422cae58b26a09876ad8c70bfe7.png)

- `stop(true)`与`stop(true,false)`

  立即停止当前所有动画，包括后续动画

  ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/d0b7b24a5cb88bd8bfb3fcecaa800773.png)

- `stop()`、`stop(false)`、`stop(false,false)`

  立即停止当前所有动画，继续执行后续的动画

  ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/f0dc419d9bf86ac76a98a2019c74181c.png)

- `stop(false,true)`

  立即完成当前动画，继续执行后续动画

  ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/59fd8272b8b3164f0febc73dd4bf56d7.png)

- `stop(true true)`

  立即完成当前的，并且停止后续所有

  ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/77f160d79dae7f18574e9bc58a50e417.png)

## 图标特效

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/0e001340ef130eda357e877c3cc2f7bc.png)

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

        ul {
            list-style: none;
            width: 400px;
            height: 250px;
            border: 1px solid #000;
            margin: 100px auto;
        }

        ul>li {
            width: 100px;
            height: 50px;
            margin-top: 50px;
            text-align: center;
            float: left;
            overflow: hidden;
        }

        ul>li>span {
            display: inline-block;
            width: 24px;
            height: 24px;
            background: url('https://ae02.alicdn.com/kf/U8f6d143a1f9d4323976a7df7486f7e2cT.jpg') no-repeat 0 0;
            position: relative;

        }
    </style>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.12.4/jquery.js"></script>
    <script>
        $(function () {
            // 1. 遍历所有li
            $('li').each(function (index, ele) {
                var $url = "url('https://ae02.alicdn.com/kf/U8f6d143a1f9d4323976a7df7486f7e2cT.jpg') no-repeat 0 " + index * -24 + "px"
                // 1.2 设置新的图片位置
                $(this).children('span').css('background', $url)
            })
            // 2 监听li移入事件
            $('li').mouseenter(function () {
                // 2.1 将图片上移
                $(this).children('span').animate({
                    top: -50
                }, 1000, function () {
                    // 2.2 将图标定位到下方
                    $(this).css('top', '50px')
                    // 2.3 将图标复位
                    $(this).animate({
                        top: 0
                    }, 1000)
                })
            })
        })

    </script>
</head>

<body>
    <ul>
        <li><span></span>
            <p>百度</p>
        </li>
        <li><span></span>
            <p>百度</p>
        </li>
        <li><span></span>
            <p>百度</p>
        </li>
        <li><span></span>
            <p>百度</p>
        </li>
        <li><span></span>
            <p>百度</p>
        </li>
        <li><span></span>
            <p>百度</p>
        </li>
        <li><span></span>
            <p>百度</p>
        </li>
        <li><span></span>
            <p>百度</p>
        </li>
    </ul>
</body>

</html>
```

## 无限循环滚动

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/91b5cf89136dfb7105c1e5a8b9c556d7.png)

1. 为了让图片无缝衔接，需要在末尾添加与开头两个一模一样的元素。即html元素就变成了

   ```html
           <div>
               <ul>
                   <li><img src="https://ae01.alicdn.com/kf/U1a8fa2929bca4fddb8b38411e9751104b.jpg"></li>
                   <li><img src="https://ae04.alicdn.com/kf/Ue87bb1c5ad4c4c8c9c3a664f3619b126h.jpg"></li>
                   <li><img src="https://ae01.alicdn.com/kf/U3f740877f20040bd8f37c94440f26b569.jpg"></li>
                   <li><img src="https://ae03.alicdn.com/kf/Ua2b193cb94224ed796104020743af8aes.jpg"></li>
                   <li><img src="https://ae01.alicdn.com/kf/U1a8fa2929bca4fddb8b38411e9751104b.jpg"></li>
                   <li><img src="https://ae04.alicdn.com/kf/Ue87bb1c5ad4c4c8c9c3a664f3619b126h.jpg"></li>
               </ul>
           </div>
   ```

2. 鼠标移入事件

   鼠标移入时，应停止当前动画并且为所有非当前选中的元素添加模板。

   ```javascript
   // 停止动画
   clearInterval(timer)
   // 给非当前选中添加模板
   $(this).siblings().fadeTo(100, 0.5)
   ```

3. 鼠标移出时

   让图片继续滚动，并且去除所有蒙版

   ```javascript
   // 继续滚动
   autoPlay()
   // 去除所有的蒙版
   $('li').fadeTo(100, 1)
   ```

   

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

        div {
            width: 600px;
            height: 161px;
            border: 1px solid #000;
            margin: 100px auto;
            overflow: hidden;
        }

        ul {
            width: 1800px;
            list-style: none;
            height: 161px;
            background: #000;
        }

        ul>li {
            float: left;
        }
    </style>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.12.4/jquery.js"></script>
    <script>
        $(function () {
            // 0 定义遍历保存偏移位
            var offset = 0
            // 1. 让图片滚动起来
            var timer;
            function autoPlay() {
                timer = setInterval(function () {
                    offset += -10
                    if (offset <= -1200) {
                        offset = 0
                    }
                    $('ul').css('marginLeft', offset)
                }, 50)
            }
            autoPlay()
            // 2. 监听li的移入和移出事件
            $('li').hover(function () {
                // 停止动画
                clearInterval(timer)
                // 给非当前选中添加模板
                $(this).siblings().fadeTo(100, 0.5)
            }, function () {
                // 继续滚动
                autoPlay()
                // 去除所有的蒙版
                $('li').fadeTo(100, 1)
            })
        })
    </script>
</head>

<body>
    <div>
        <ul>
            <li><img src="https://ae01.alicdn.com/kf/U1a8fa2929bca4fddb8b38411e9751104b.jpg"></li>
            <li><img src="https://ae04.alicdn.com/kf/Ue87bb1c5ad4c4c8c9c3a664f3619b126h.jpg"></li>
            <li><img src="https://ae01.alicdn.com/kf/U3f740877f20040bd8f37c94440f26b569.jpg"></li>
            <li><img src="https://ae03.alicdn.com/kf/Ua2b193cb94224ed796104020743af8aes.jpg"></li>
            <li><img src="https://ae01.alicdn.com/kf/U1a8fa2929bca4fddb8b38411e9751104b.jpg"></li>
            <li><img src="https://ae04.alicdn.com/kf/Ue87bb1c5ad4c4c8c9c3a664f3619b126h.jpg"></li>
        </ul>
    </div>
</body>

</html>
```


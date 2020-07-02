---
title: 四、jQuery事件相关
date: 2020-06-16T13:30:50+08:00
categories: ["notes"]
tags: ["jQuery"]
---

## 事件绑定

绑定方式有两种：

1. 直接通过`.eventName(fn)`方式绑定。

   ```javascript
   $('button').click(function () {
       alert('hello tzk')
   })
   ```

   - 编码效率高
   - 部分事件jQuery没有实现

2. 通过`on(eventName,function)`方式绑定

   ```javascript
   $('button').on('click', function () {
       alert('hello tzk')
   })
   ```

   - 编码效率略低
   - 所有JavaScript事件都可以添加

<div class="note warning icon"><p>注意：以上两种绑定方式均不会被覆盖，并且可以添加多个事件。</p></div>

```javascript
$('button').click(function () {
    alert('hello tzk')
})
$('button').click(function () {
    alert(123)
})
$('button').mouseleave(function () {
    alert(mouseleave)
})
```

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/7fd3b6fd229295a551e819254718644f.png)

## 事件解绑

事件解绑只有一个方法`off()`，只需要用需要解绑的元素调用此方法即可。

```javascript
function test1() {
    alert('hello tzk')
}
function test2() {
    alert('hello 123')
}

$('button').click(test1)
$('button').click(test2)
$('button').mouseleave(function () {
    alert('mouseleave')
})
$('button').mouseenter(function () {
    alert('mouseenter')
})
```

对于以上事件绑定：

- 不传入参数

  会移除button元素的**所有**绑定事件。

  ```javascript
  $('button').off()
  ```

- 传入一个参数

  会移除所有指定类型的事件。

  ```javascript
  $('button').off('click')
  ```

  ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/2a59202a72fca1da6d00b5a29e7bfa3a.png)

- 传入两个参数

  会移除指定类型的指定事件

  ```javascript
  $('button').off('click', test1)
  ```

  ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/6311344cbbed392c43f814aa751c898d.png)

## jQuery事件冒泡和默认行为

1. 什么是事件冒泡

   当父子级关系时，如果为父级与子级同时绑定事件。当触发子级事件时，也会触发父级事件。

   例如：

   ```javascript
   <div class="father">
       <div class="son"></div>
   </div>
   
   <script>
           $(function () {
           $('.son').click(function () {
               alert('son')
           })
           $('.father').click(function () {
               alert('father')
           })
       })
   </script>
   ```

   ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/e94cf02cd1514248ca2c74857ff177dd.png)

2. 如何阻止事件冒泡

   在子级事件中添加`return false`或者`event.stopPropagation()`

   ```javascript
   $('.son').click(function (event) {
       alert('son')
       // return false
       event.stopPropagation()
   })
   ```

   > 阻止事件冒泡一定要在子级添加。

3. 什么是默认行为

   默认行为指一些标签默认的行为，例如a标签默认跳转网页。

4. 如何阻止默认行为

   两种方式。

   ```javascript
   $('a').click(function (event) {
       alert('弹出注册框')
       // return false
       event.preventDefault()
   })
   ```

## 事件自动触发

事件自动触发有两个方法，参数传入为字符串形式的事件名称。

1. `trigger`

   - 会触发事件冒泡

     ```javascript
     $('.son').click(function (event) {
         alert('son')
     })
     $('.father').click(function () {
         alert('father')
     })
     $('.son').trigger('click')
     ```

     ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/d351511bae1996c8e4b1b092ccd11e4f.png)

   - 不会阻止默认行为

     ```javascript
     $('input[type="submit"]').click(function () {
         alert('被点击了！')
     })
     $('input[type="submit"]').trigger('click')
     ```

     ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/2b5f812db82e65909cf684a437de89cf.png)

2. `triggerHandler`

   - 不会触发事件冒泡

     ```javascript
     $('.son').click(function (event) {
         alert('son')
     })
     $('.father').click(function () {
         alert('father')
     })
     $('.son').triggerHandler("click")
     ```

     ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/8ae9de6b5500914db6c46ace4df2f3d9.png)

   - 会阻止默认行为

     ```javascript
     $('input[type="submit"]').click(function () {
         alert('被点击了！')
     })
     $('input[type="submit"]').triggerHandler('click')
     ```

     ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/0d012ead137f2edd721403bd627b71c9.png)

<div class="snote idea yellow"><p>a标签的默认行为</p></div>

对a标签设置自动事件时，无法触发其默认行为。

```javascript
$('a').click(function () {
    alert('a')
})
$('a').trigger('click')
```

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/4a6a7430ebfad38e9929f9b9dc4a37d2.png)

如果想要触发其默认行为则需要如下更改：

```html
<a href="http://baidu.com" target="_blank"><span>注册</span></a>
```

```javascript
$('span').click(function () {
    alert('a')
})
$('span').trigger('click')
```

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/a6991f7e66c1eb670fa97f91050a0941.png)

## 自定义事件

自定义事件需要满足的条件：

1. 只能通过`on`绑定事件

   ```javascript
   $('.son').on('myClick', function () {
       alert('son')
   })
   ```

2. 事件必须通过`trigger`触发

   ```javascript
   $('.son').trigger('myclick')
   ```

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/afe5f8576d11a198b45c224bb5ab9777.png)

## 事件命名空间

想要使事件的命名空间有效，必须满足两个条件

1. 事件是通过`on`来绑定的

   用`.Name`的方式区分是谁添加的。

   ```javascript
   $('.son').on('myClick.zs', function () {
       alert('son')
   })
   $('.son').on('myClick.ls', function () {
       alert('son')
   })
   ```

2. 通过`trigger()`触发事件

   - 触发两个事件

     ```javascript
     $('.son').trigger('myClick')
     ```

   - 只触发某一个

     ```javascript
     // 将事件名称填写完整即可
     $('.son').trigger('myClick.ls')
     ```

     

<div class="snote idea yellow"><p>面试题（细节）</p></div>

1. 利用`trigger`触发子元素带命名空间的事件，那么父元素带相同命名空间的事件也会被触发，而父元素没有命名空间的事件不会被触发

   ```javascript
   $('.father').on('myClick.ls', function () {
       alert('father click1')
   })
   $('.father').on('myClick', function () {
       alert('father click2')
   })
   $('.son').on('myClick.ls', function () {
       alert('son click1')
   })
   $('.son').trigger('myClick.ls')
   ```

   ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/bd2e7685f75ad832b2c0e042ba3654be.png)

2. 利用`trigger`触发子元素不带命名空间的事件，那么子元素所有相同类型的事件和父元素所有相同类型的事件都会被触发

   ```javascript
   $('.father').on('myClick.ls', function () {
       alert('father click1')
   })
   $('.father').on('myClick', function () {
       alert('father click2')
   })
   $('.son').on('myClick.ls', function () {
       alert('son click1')
   })
   $('.son').trigger('myClick')
   ```

   ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/eb593b93a1a5d3cbafb9dc4a76079a2a.png)



## 事件委托

1. 什么是事件委托

   请别人帮忙做事情，然后将昨晚的结果反馈给我们

将`li`的点击事件委托给`ul`元素监听。

```javascript
$('ul').delegate('li', 'click', function () {
    console.log($(this).html())
})
```

<div class="snote msg cyan"><p>利用事件委托完成弹出框</p></div>

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/07bfdaffed6d985bc66755ed14dae711.png)

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

            html,
            body {
                width: 100%;
                height: 100%;
            }

            .mask {
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, .5);
                position: fixed;
                left: 0;
                top: 0;
            }

            .login {
                width: 570px;
                /* height: 290px; */
                margin: 100px auto;
                position: relative;
            }

            .login>span {
                width: 50px;
                height: 50px;
                position: absolute;
                top: 0;
                right: 0;
            }
        </style>
        <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.12.4/jquery.js"></script>
        <script>
            $(function () {
                $('a').click(function () {
                    var $mask = $('<div class="mask"><div class= "login" ><img src="https://ae01.alicdn.com/kf/U0acca6abe69449398ddbe1f56f032ecaw.jpg" alt=""><span></span></div>')
                    $('body').append($mask)
                    $('body').delegate('.login>span', 'click', function () {
                        $mask.remove()
                    })
                    return false
                })
            })
        </script>
    </head>

    <body>
        <!-- <div class="mask">
<div class="login">
<img src="https://ae01.alicdn.com/kf/U0acca6abe69449398ddbe1f56f032ecaw.jpg" alt="">
<span></span>
</div>
</div> -->
        <a href="https://www.baidu.com">注册</a>
        <div>
            我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落
            我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落
            我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落
            我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落
            我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落
            我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落
            我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落
            我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落
            我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落
            我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落
            我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落我是段落
        </div>
    </body>

</html>
```

## 移入移出事件

移入事件`mouseover`移出事件`mouseout`。这种方法 子元素被移入移出也会触发父元素的事件。

```javascript
$(function () {
    $('.father').mouseover(function () {
        console.log('鼠标移入了')
    })
    $('.father').mouseout(function () {
        console.log('鼠标移出了')
    })
})
```

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/c066274855eeb99e2f6aa5b555ab7c69.png)

为了解决以上问题，jQuery提供了另外两个方法：鼠标移入`mouseenter`和鼠标移出`mouseleave`。



<div class="snote idea yellow"><p>同时监听移入与移出</p></div>

使用的方法为`hover`，这个方法可以接收一个或两个参数，并且不会子元素被移入移出也会触发父元素的事件。

- 一个参数

  ```javascript
  $('.father').hover(function () {
      console.log('移入/移除 执行的函数')
  })
  ```

  一个参数代表移入移出都执行此函数。

  ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/b7d337f6646f84724206efdec75f0721.png)

- 两个参数

  ```javascript
  $('.father').hover(function () {
      console.log('移入执行的函数')
  }, function () {
      console.log('移出执行的函数')
  })
  ```

  第一个参数代表移入时执行的函数，第二个参数代表移出时执行的函数。

  ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/bfc3ad3f3e645299682732002f02ac52.png)



## 电影排行榜案例

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/68a5f2a1ecf51f7a433448c63a98752b.png)

<div class='tip success'><p>实现思路<p></div>

1. 将内容DIV设置为隐藏
2. 当鼠标移入后将隐藏的div显示出来
3. 当鼠标移出后将显示的div隐藏起来

<span class="inline-tag blue">直译方式</span>

```javascript
$('li').mouseenter(function () {
    $(this).addClass('current')
})
$('li').mouseleave(function () {
    $(this).removeClass('current')
})
```

<span class="inline-tag blue">简化方式1</span>

```javascript
$('li').hover(function () {
    $(this).addClass('current')
}, function () {
    $(this).removeClass('current')
})
```

<span class="inline-tag blue">简化方式2</span>

```javascript
$('li').hover(function () {
    $(this).toggleClass('current')
})
```

<div class="snote success"><p>完整代码</p></div>

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

        .box {
            width: 300px;
            height: 450px;
            margin: 50px auto;
            border: 1px solid #000;

        }

        .box>h1 {
            font-size: 20px;
            line-height: 35px;
            color: deeppink;
            padding-left: 10px;
            border-bottom: 1px dashed #ccc;
        }

        ul>li {
            list-style: none;
            padding: 5px 10px;
            border: 1px dashed #ccc;
        }

        ul>li:nth-child(-n+3) span {
            background-color: deeppink;
        }

        ul>li>span {
            display: inline-block;
            height: 20px;
            width: 20px;
            background: #ccc;
            text-align: center;
            line-height: 20px;
            margin-right: 10px;
        }

        .content {
            overflow: hidden;
            margin-top: 5px;
            display: none;
        }

        .content>img {
            width: 80px;
            height: 120px;
            float: left;
        }

        .content>p {
            width: 180px;
            height: 120px;
            float: right;
            font-size: 12px;
            line-height: 20px;
        }

        .current .content {
            display: block;
        }
    </style>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.12.4/jquery.js"></script>
    <script>
        $(function () {
            $('li').hover(function () {
                $(this).toggleClass('current')
            })
            // $('li').mouseenter(function () {
            //     $(this).addClass('current')
            // })
            // $('li').mouseleave(function () {
            //     $(this).removeClass('current')
            // })
            // $('li').hover(function () {
            //     $(this).addClass('current')
            // }, function () {
            //     $(this).removeClass('current')
            // })
        })
    </script>
</head>

<body>
    <div class="box">
        <h1>电影排行榜</h1>
        <ul>
            <li><span>1</span>电影名称
                <div class="content">
                    <img
                        src="https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/d0efe1580ab93f0e6b1a04bb07a8259f.png">
                    <p>测试文字哈哈哈</p>
                </div>
            </li>
            <li><span>2</span>电影名称<div class="content">
                    <img
                        src="https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/d0efe1580ab93f0e6b1a04bb07a8259f.png">
                    <p>测试文字哈哈哈</p>
                </div>
            </li>
            <li><span>3</span>电影名称<div class="content">
                    <img
                        src="https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/d0efe1580ab93f0e6b1a04bb07a8259f.png">
                    <p>测试文字哈哈哈</p>
                </div>
            </li>
            <li><span>4</span>电影名称<div class="content">
                    <img
                        src="https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/d0efe1580ab93f0e6b1a04bb07a8259f.png">
                    <p>测试文字哈哈哈</p>
                </div>
            </li>
            <li><span>5</span>电影名称<div class="content">
                    <img
                        src="https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/d0efe1580ab93f0e6b1a04bb07a8259f.png">
                    <p>测试文字哈哈哈</p>
                </div>
            </li>
        </ul>
    </div>
</body>

</html>
```

## Tab选项卡

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/16/16cd6e47005402ae5b80172cde71ce59.png)

<span class="inline-tag blue">实现思路</span>

1. HTML结构

   ```html
   <div class="box">
       <ul class="nav">
           <li class="current">123</li>
           <li>123</li>
           <li>123</li>
           <li>123</li>
       </ul>
       <ul class="content">
           <li class="show">
               <img src="https://ae02.alicdn.com/kf/U5303870feaa24803b2a9debcfb260c79T.jpg">
           </li>
           <li>
               <img src="https://ae02.alicdn.com/kf/U3e7e3e14488d431b9b1178ddddc1fdd4T.jpg">
           </li>
           <li>
               <img src="https://ae01.alicdn.com/kf/U0b5025b6d75b45c1a2590c1fdc6d5bcbq.jpg">
           </li>
           <li>
               <img src="https://ae01.alicdn.com/kf/U7015657127cf4f8dbd19d9f03fd38636F.jpg">
           </li>
       </ul>
   </div>
   ```

2. 基本思路

   - 监听鼠标移入事件

     1. 修改被移入选项卡的背景颜色
     2. 获取当前移入选项卡的索引
     3. 根据索引找到对应的图片
     4. 显示找到的图片

     ```javascript
     $('.nav>li').mouseenter(function () {
         // 1.1 修改被移入选项卡的背景颜色
         $(this).addClass('current')
         // 1.2 获取当前移入选项卡的索引
         var index = $(this).index()
         console.log(index)
         // 1.3 根据索引找到对应的图片
         var $li = $('.content>li').eq(index)
         // 1.4 显示找到的图片
         $li.addClass('show')
     })
     ```

   - 监听鼠标移出事件

     1. 还原被移入选项卡的背景颜色
     2. 获取当前移出选项卡的索引
     3. 根据索引找到对应图片
     4. 隐藏图片

     ```javascript
     $('.nav>li').mouseleave(function () {
         // 1.1 还原被移入选项卡的背景颜色
         $(this).removeClass('current')
         // 1.2 获取当前移出选项卡的索引
         var index = $(this).index()
     
         // 1.3 根据索引找到对应图片
         var $li = $('.content>li').eq(index)
         // 1.4 隐藏图片
         $li.removeClass('show')
     })
     ```

3. 对于实现tab选项卡的简单思路

   主要用到`siblings()`方法，该方法取得一个包含匹配的元素集合中每一个元素的所有唯一同辈元素的元素集合。

   ```javascript
   $('.nav>li').mouseenter(function () {
       // 1.1 修改被移入选项卡的背景颜色
       $(this).addClass('current')
       // 1.2 还原其他兄弟选项卡的颜色
       $(this).siblings().removeClass('current')
       // 1.3 获取当前移入选项卡的索引
       var index = $(this).index()
       // 1.4 根据索引找到对应的图片
       var $li = $('.content>li').eq(index)
       // 1.5 隐藏兄弟图片
       $li.siblings().removeClass('show')
       // 1.6 显示找到的图片
       $li.addClass('show')
   })
   ```

<div class="snote success"><p>完整代码</p></div>

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

            .box {
                width: 440px;
                height: 298px;
                margin: 50px auto;
                border: 1px solid #000;
            }

            .nav>li {
                list-style: none;
                width: 110px;
                height: 50px;
                background: orange;
                text-align: center;
                float: left;
                line-height: 50px;
            }

            .nav>.current {
                background: #ccc;
            }

            .content>li {
                list-style: none;
                display: none;
                text-align: center;
            }

            .content>.show {
                display: block;
            }

            .content>li>img {
                width: 240px;
            }
        </style>
        <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.12.4/jquery.js"></script>
        <script>
            $(function () {
                /*
            // 1. 监听选项卡的移入事件
            $('.nav>li').mouseenter(function () {
                // 1.1 修改被移入选项卡的背景颜色
                $(this).addClass('current')
                // 1.2 获取当前移入选项卡的索引
                var index = $(this).index()
                console.log(index)
                // 1.3 根据索引找到对应的图片
                var $li = $('.content>li').eq(index)
                // 1.4 显示找到的图片
                $li.addClass('show')
            })
            // 1. 监听选项卡的移出事件
            $('.nav>li').mouseleave(function () {
                // 1.1 还原被移入选项卡的背景颜色
                $(this).removeClass('current')
                // 1.2 获取当前移出选项卡的索引
                var index = $(this).index()

                // 1.3 根据索引找到对应图片
                var $li = $('.content>li').eq(index)
                // 1.4 隐藏图片
                $li.removeClass('show')
            })
            */
                // 1. 监听选项卡的移入事件
                $('.nav>li').mouseenter(function () {
                    // 1.1 修改被移入选项卡的背景颜色
                    $(this).addClass('current')
                    // 1.2 还原其他兄弟选项卡的颜色
                    $(this).siblings().removeClass('current')
                    // 1.3 获取当前移入选项卡的索引
                    var index = $(this).index()
                    // 1.4 根据索引找到对应的图片
                    var $li = $('.content>li').eq(index)
                    // 1.5 隐藏兄弟图片
                    $li.siblings().removeClass('show')
                    // 1.6 显示找到的图片
                    $li.addClass('show')
                })
            })
        </script>
    </head>

    <body>
        <div class="box">
            <ul class="nav">
                <li class="current">123</li>
                <li>123</li>
                <li>123</li>
                <li>123</li>
            </ul>
            <ul class="content">
                <li class="show">
                    <img src="https://ae02.alicdn.com/kf/U5303870feaa24803b2a9debcfb260c79T.jpg">
                </li>
                <li>
                    <img src="https://ae02.alicdn.com/kf/U3e7e3e14488d431b9b1178ddddc1fdd4T.jpg">
                </li>
                <li>
                    <img src="https://ae01.alicdn.com/kf/U0b5025b6d75b45c1a2590c1fdc6d5bcbq.jpg">
                </li>
                <li>
                    <img src="https://ae01.alicdn.com/kf/U7015657127cf4f8dbd19d9f03fd38636F.jpg">
                </li>
            </ul>
        </div>
    </body>

</html>
```
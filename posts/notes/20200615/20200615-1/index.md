# 一、初识jQuery


## 版本选择

[1.x](https://code.jquery.com/)：兼容ie678，但相对其它版本文件较大，官方只做BUG维护，功能不再新增，最终版本：1.12.4 (2016年5月20日).

[2.x](https://code.jquery.com/)：不兼容ie678，相对1.x文件较小，官方只做BUG维护，功能不再新增，最终版本：2.2.4 (2016年5月20日)

[3.x](https://code.jquery.com/)：不兼容ie678，只支持最新的浏览器，很多老的jQuery插件不支持这个版本，相对1.x文件较小，提供不包含Ajax/动画API版本。

## jQuery的使用

1. 下载jQuery或者使用cdn
2. 引入jQuery的文件
3. 编写代码

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.12.4/jquery.js"></script>
    <script>
        $(document).ready(function () {
            alert('hello tzk')
        })
    </script>
</head>

<body>

</body>

</html>
```

## jQuery和JS的加载模式

1. 通过原生JS和jQuery都可以拿到DOM元素，及图片的宽高

   ```javascript
   window.onload = function () {
       // 1. 通过原生的js入口函数可以拿到DOM元素
       var img = document.getElementsByTagName('img')[0]
       console.log(img)
       // 2. 通过原生的JS入口函数可以拿到DOM元素的宽高
       var width = window.getComputedStyle(img).width
       console.log('onload: ', width)
   }
   $(document).ready(function () {
       // 1. 通过JQuery入口函数可以拿到DOM元素
       var $img = $('img')
       console.log($img)
       // 2. 通过JQuery入口函数可以拿到DOM元素的宽高
       var $width = $img.width()
       console.log('ready: ', $width)
   })
   ```

   ![image-20200613204348555](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/13/8e61ae4e2e3d2d012ae906e655d7b30e.png)

2. 原生的JS如果编写了多个入口函数，后面编写的会覆盖原来的。而jQuery不会覆盖

   ```javascript
   window.onload = function () {
       alert('hello tzk1')
   }
   window.onload = function () {
       alert('hello tzk2')
   }
   ```

   只会弹出hello tzk2

   ```javascript
   $(document).ready(function () {
       alert('hello tzk1')
   });
   $(document).ready(function () {
       alert('hello tzk2')
   });
   ```

   hello tzk1与hello tzk2都会弹出。

## jQuery入口函数的其他写法

```javascript
// 1. 第一种写法
$(document).ready(function () {
    alert('hello tzk')
});
// 第二种写法
jQuery(document).ready(function () {
    alert('hello tzk')
});
// 第三种写法(推荐)
$(function () {
    alert('hello tzk')
})
// 第四种写法
jQuery(function () {
    alert('hello tzk')
})
```

jQuery的四种写法中，推荐使用第三种写法。

## jQuery的冲突问题

1. 释放`$`符号

   ```javascript
   jQuery.noConflict()
   jQuery(function () {
       alert('hello tzk')
   })
   ```

   - 释放操作必须在编写其他`JQuery`代码之前编写

   - 释放之后就不能在使用`$`,改为使用`jQuery`

2. 自定义访问符号

   ```javascript
   var nj = jQuery.noConflict()
   nj(function () {
       alert('hello tzk')
   })
   ```

   

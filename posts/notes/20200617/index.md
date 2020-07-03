# 六、jQuery节点操作


## 添加节点相关方法

### 内部插入

1. 插入到节点最前面

   ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/17/6e15481e5a0fb6403ad6321a090db446.png)

   ```javascript
   // 方法1
   $li.prependTo('ul')
   // 方法2（常用）
   $('ul').prepend($li)
   ```

2. 添加到节点最后边

   ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/17/407e913e46aee4dcf0c0d110691eadd2.png)

   ```javascript
   // 方法1
   $li.appendTo('ul')
   // 方法2（常用）
   $('ul').append($li)
   ```

### 外部插入

1. 将元素添加到指定元素外部的后面

   ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/17/b60af2cba4c5f037be5489ea0b9a2754.png)

   ```javascript
   // 方法1
   $li.insertAfter('ul')
   // 方法2（常用）
   $('ul').after($li)
   ```

2. 会将元素添加到指定元素外部的前面

   ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/17/bbe6fb7cabe233aa01a3b9d78e343aff.png)

   ```javascript
   // 方法1
   $li.insertBefore('ul')
   // 方法2（常用）
   $('ul').before($li)
   ```

   

## 删除节点相关方法

1. `remove()`或`detach()`

   删除指定元素，可传入参数。例如`$('li').detach('.item')`表示删除li下的`.item`元素

   ```javascript
   $('div').remove()
   $('li').detach('.item')
   ```

   两个方法一样，都可以接收参数。

   ![不传入参数](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/17/06b804de4f9e43e1d529607f4dae34f0.png)

2. `empty()`

   删除指定元素的内容和子元素,指定元素自身不会被删除

   ```javascript
   $('div').empty()
   ```

   ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/17/ecb26bdd21fd7cb595ee5301ee40c8c0.png)

## 替换节点相关方法

`replaceWith()`与`replaceAll()`都会替换所有匹配的元素为指定元素。

```javascript
// 1. 新建元素
var $h6 = $('<h6>我是标题6</h6>')
// 2. 替换所有匹配的元素为指定元素
$('h1').replaceWith($h6)
// 或者如下写法
// $h6.replaceAll('h1')
```

## 复制节点相关方法

复制节点使用`clone()`方法，传入一个布尔值。`true`表示深复制，`false`表示浅复制。

1. 浅复制

   ```javascript
   $('button').eq(0).click(function () {
       // 1. 浅复制一个元素
       var $li = $('li:first').clone(false)
       // 将复制的元素加入的ul中
       $('ul').append($li)
   })
   ```

2. 深复制

   ```javascript
   $('button').eq(1).click(function () {
       // 1. 深复制一个元素
       var $li = $('li:first').clone(true)
       // 将复制的元素加入的ul中
       $('ul').append($li)
   })
   ```

<div class="snote idea yellow"><p>深复制、浅复制的区别</p></div>

浅复制只会复制元素本身，无法复制原元素绑定的事件。而深复制则会连同绑定事件一同复制。

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/17/7f207c472a7c4fa057bcf242ee212a83.png)

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.12.4/jquery.js"></script>
    <script>
        $(function () {
            $('button').eq(0).click(function () {
                // 1. 浅复制一个元素
                var $li = $('li:first').clone(false)
                // 将复制的元素假如的ul中
                $('ul').append($li)
            })
            $('button').eq(1).click(function () {
                // 1. 深复制一个元素
                var $li = $('li:first').clone(true)
                // 将复制的元素假如的ul中
                $('ul').append($li)
            })
            $('li').click(function () {
                alert(1)
            })
        })
    </script>
</head>

<body>
    <button>浅复制节点</button>
    <button>深复制节点</button>
    <ul>
        <li>我是第1个li</li>
        <li>我是第2个li</li>
        <li>我是第3个li</li>
        <li>我是第4个li</li>
        <li>我是第5个li</li>
    </ul>
</body>

</html>
```

## 新浪微博案例

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/17/09929db91693d76c78aabc5068b70d73.png)

> jQuery部分逻辑思路

1. 监听发送按钮

   - 有内容

     生成DIV，并添加

   - 无内容

     按钮禁止点击

2. 生成div

   - 获取用户输入内容，将内容作为DIV的内容进行生成

3. 插入DIV

   获取插入容器，在其顶部插入

4. 顶/踩/删除

   - 顶/踩

     获取标签内容并转化为整型然后加1

   - 删除

     利用`parents()`方法，在其传入需要获取的父元素选择器（`parents('.info')`），即可获取相应的父元素。

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

        html {
            width: 100%;
            height: 100%;
        }

        body {
            background: url('https://ae04.alicdn.com/kf/Ud1fa6cf847c446e5a65e91f43081d503V.jpg') no-repeat center 0;
        }

        .nav {
            width: 100%;
            height: 48px;

        }

        .mav>img {
            width: 100%;
        }

        .content {
            width: 1000px;
            overflow: hidden;
            background: #ebdbd4;
            margin: 200px auto 0 auto;
        }

        .content>.left {
            float: left;
            width: 150px;
        }

        .content>.right {
            float: right;
            width: 240px;
        }

        .content>.center {
            float: left;
            width: 600px;
            height: 168px;
            background: url(https://ae03.alicdn.com/kf/U7ed12369ffd74c2a9ca1d46907ce3eb9G.jpg)no-repeat 0 0;
            background-size: 600px 168px;
        }

        .center>.comment {
            width: 570px;
            height: 73px;
            margin-left: 15px;
            margin-top: 45px;
            resize: none;
            outline: none;
            border: none;
        }

        .center>.send {
            width: 82px;
            height: 30px;
            margin-top: 4px;
            margin-left: 506px;
            border: none;
            background: #fd8040;
            cursor: pointer;
            outline: none;
            color: white;
        }

        .content>.messageList {
            width: 600px;
            /* height: 600px; */
            background: white;
            float: left;
        }

        .messageList>.info {
            padding: 10px 20px;
            border-bottom: 2px solid #ccc;
        }

        .info>.infoText {
            line-height: 25px;
            margin-bottom: 10px;
        }

        .info>.infoOperation {
            width: 100%;
            overflow: hidden;
        }

        .infoOperation>.infoTime {
            float: left;
            font-size: 13px;
            color: #ccc;
        }

        .infoOperation>.infoHandle {
            float: right;
            font-size: 13px;
        }

        .infoHandle>a {
            text-decoration: none;
            color: #ccc;
            background: url(https://ae04.alicdn.com/kf/Uf79214b661074c6ca3416eccddeb4e61D.jpg)no-repeat 0 0;
            padding-left: 25px;
            margin-left: 10px;
        }

        .infoHandle>a:nth-child(2) {
            background-position: 0 -17px;
        }

        .infoHandle>a:nth-child(3) {
            background-position: 0 -33px;
        }

        .page {
            width: 1000px;
            height: 40px;
            margin: 0 auto;
            text-align: right;
            background-color: #9f5024;
            padding: 10px;
            box-sizing: border-box;
        }

        .page>a {
            text-decoration: none;
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 1px solid #ccc;
            line-height: 20px;
            color: #2b2b2b;
        }
    </style>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.12.4/jquery.js"></script>
    <script>
        $(function () {
            // 0。 监听内容的实时输入
            $('body').delegate('.comment', 'propertychange input', function () {
                // 判断是否输入了内容
                if ($(this).val().length > 0) {
                    $('.send').prop('disabled', false)
                } else {
                    $('.send').prop('disabled', true)
                }
            })
            // 1. 监听发布按钮的点击
            $('.send').click(function () {
                // 拿到用户输入的内容
                var $text = $('.comment').val()
                // 根据内容创建节点
                var $weibo = createEle($text)
                // 插入微博
                $('.messageList').prepend($weibo)
            })
            // 2. 监听顶点击
            $('body').delegate('.infoUp', 'click', function () {
                $(this).text(parseInt($(this).text()) + 1)
            })
            // 3. 监听踩点击
            $('body').delegate('.infoDown', 'click', function () {
                $(this).text(parseInt($(this).text()) + 1)
            })
            // 4. 监听删除点击
            $('body').delegate('.infoDel', 'click', function () {
                $(this).parents('.info').remove()
            })
            function createEle(text) {

                var $weibo = $('<div class="info"><p class= "infoText" > ' + text + '</p ><p class="infoOperation"><span class="infoTime">' + formatDate() + '</span><span class="infoHandle"><a href="javasript:;" class="infoUp">0</a><a href="javasript: ;" class="infoDown">0</a><a href="javasript: ;" class="infoDel">删除</a></span></p></div > ')
                return $weibo
            }
            // 生成时间
            function formatDate() {
                var date = new Date()
                var arr = [
                    date.getUTCFullYear() + '-',
                    date.getMonth() + 1 + '-',
                    date.getDate() + ' ',
                    date.getHours() + ':',
                    date.getMinutes() + ':',
                    date.getSeconds()
                ]
                return arr.join("")
            }
        })
    </script>
</head>

<body>
    <div class="nav">
        <img src="https://ae02.alicdn.com/kf/U8c9c77c71a30441aa2e439c2552c6fe6q.jpg" alt="">
    </div>
    <div class="content">
        <img src="https://ae02.alicdn.com/kf/Ua155fa993f7641a89d83d88af96a6df2Z.jpg" alt="" class="left">
        <div class="center">
            <textarea class="comment"></textarea>
            <input type="button" value="发布" class="send" disabled>
        </div>
        <img src="https://ae02.alicdn.com/kf/U0cf31717da7d412da7029b72551d9a94K.jpg" alt="" class="right">
        <div class="messageList">

        </div>
    </div>
    <div class="page">
        <a href="javascript:;">1</a>
        <a href="javascript:;">2</a>
        <a href="javascript:;">3</a>
    </div>
</body>

</html>
```



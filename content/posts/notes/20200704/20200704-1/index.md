---
title: 六、中间件与跨域
date: 2020-07-04T11:01:50+08:00
categories: ["notes"]
tags: ["Node"]
---

## 什么是中间件

在路由相应之前就会执行中间件的内容，例如在中间件中进行赋值，这种就可以在路由执行时使用这个值。

所以中间件就是服务器开启之后和路由响应之前执行的一个函数。这个函数可以操作req与res。使用`next()`向下传递到下一个中间件，最后传到路由。

例如开启三个中间件的写法：

```javascript
app.use((req, res, next) => {
  console.log("中间件1");
  req.requestTime = Date.now();
  next();
});
app.use((req, res, next) => {
  console.log("中间件2");
  next();
});

app.get("/", (req, res) => {
  console.log(Date.now() - req.requestTime);
  res.send("Hello World!");
});
```

## 什么是跨域

1. 浏览器使用`ajax`时，如果请求的**接口地址**和**当前打开的页面地址不同源**称之为跨域。

   协议和地址、端口都一样成为同源。有一个不同则为不同源。

2. 同源与不同源的意义

   浏览器安全策略。



## 设置响应头允许跨域

只需要在响应头处设置`Access-Control-Allow-Origin`为`*`即可。

```javascript
app.post("/login", (req, res) => {
  // 设置响应头，允许资源被访问、共享
  res.setHeader("Access-Control-Allow-Origin", "*");
  // 接收用户传递过来的用户名和密码
  let { username, password } = req.body;
  if (username == "admin" && password == "123") {
    res.send({
      code: 200,
      msg: "登陆成功",
    });
  } else {
    res.send({
      code: 400,
      msg: "登陆失败",
    });
  }
});
```

## 在中间件设置允许跨域

<div class="snote idea yellow"><p>自己写中间件</p></div>

因为中间件会在执行路由之前会被调用，因此可以将设置响应头在中间件中设置。

```javascript
app.use((req, res, next) => {
    // 设置响应头，允许资源被访问、共享
    res.setHeader("Access-Control-Allow-Origin", "*");
    next();
});
```

<div class="snote idea yellow"><p>使用第三方模块</p></div>

安装`cors`模块（`npm i cors`）。接下来使用即可。

```javascript
const cors = require("cors");
app.use(cors());
```

## jsonp

<span class="inline-tag green">原理</span>

通过动态创建`script`标签，通过`script`标签的`src`请求没有域限制来获取资源

例如在html页面中，将`script`标签地址改为后端接口。

```javascript
app.get("/all", (req, res) => {
  console.log(Date.now() - req.requestTime);
  res.send("console.log('hah')");
});
```

```html
<script src="http://127.0.0.1:3000/all"></script>
```

那么当服务器开启时，我们就会看到返回来的内容会当作`JavaScript`代码执行。

![image-20200704144323306](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/04/f212657e0a108838b602da174f5c35ed.png)

因此此方式需要与前端进行配合才可使用。例如前端通过get参数方式将函数名传递给后端。

```html
<script>
    function fn() {
        console.log('这是事先准备好的函数！')
    }
    function fn1(backData) {
            console.log(backData)
        }
</script>
<script src="http://127.0.0.1:3000/all?callback=fn"></script>
```

```javascript
app.get("/all", (req, res) => {
  let fn = req.query.callback;
  res.send(`fn()`);
});
app.get("/all", (req, res) => {
  let fn = req.query.callback;
  res.send(`${fn}({'name':'haha','price':100})`);
});
```

![image-20200704145208850](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/04/ac6ca8bf770470e2762c1e135e45d1ef.png)

![image-20200704145820494](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/04/9fd8dc6816b25a65f55ba055fe2988a6.png)

<span class="inline-tag green">动态获取数据的示例</span>

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <button id="btn">点我获取</button>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        function sb(backData) {
            // 接收后端的数据
            console.log(backData);
        }
        $('#btn').on('click', function () {
            // 1. 动态创建script标签
            var script1 = document.createElement('script')
            $(script1).attr('src', 'http://127.0.0.1:3000/all?callback=sb')
            // 2. 把script添加到body中使用
            $('body').append(script1)
        })
    </script>
</body>

</html>
```

```javascript
app.get("/all", (req, res) => {
  let fn = req.query.callback;
  res.send(`${fn}({'name':'haha','price':100})`);
});
```

![5808cd66-8e73-4575-8415-9d3bb9ab91ef](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/04/e175a08f8fca37c28f700cf8de858c6f.png)

## ajax请求使用jsonp

```javascript
$.ajax({
    url: 'http://127.0.0.1:3000/all',
    dataType: 'jsonp',
    success: function (backData) {
        console.log(backData)
    }
})
```

如果访问的接口支持jsonp，那么jQuery会自动创建script标签

## 请求一言接口示例

```html
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
    </head>

    <body>
        <button id="btn">点我获取</button>
        <div></div>
        <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script>
            function sb(backData) {
                // 接收后端的数据
                console.log(backData);
            }
            $('#btn').on('click', function () {
                $.ajax({
                    url: 'https://v1.hitokoto.cn?encode=json',
                    dataType: 'jsonp',
                    success: function (backData) {
                        let data = JSON.parse(backData)

                        $('div').html(data['hitokoto'] + '---' + data['from'])

                    }
                })
            })
        </script>
    </body>


    </html>
```


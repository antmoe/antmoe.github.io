---
title: 一、Ajax的基本用法
date: 2020-08-21T10:43:00+08:00
categories: ["notes"]
---

## 同步交互与异步交互

### 同步交互

指发送一个请求，需要等待返回，然后才能够发送下ー个请求。同步交互相当于排队，轮到下一个的情况会因为前一个而有所不同。

![image-20200821104552568](https://files.alexhchu.com/2020/08/21/1d99c46d24c65.png)

> 与排队类似。*例如学生在食堂买饭，只有等前边同学买完才能轮到自己。*
>
> 客户端向服务器端发送请求，必须等待结果返回，才能向服务端再次发送请求。

### 异步交互

所谓异步交互，就是指指发送一个请求，不需要等待返回，随时可以再发送下一个请求。同步交互与异步交互的区别在于同步交互需要等待结果，而异步交互不需要等待。

![image-20200821105600663](https://files.alexhchu.com/2020/08/21/d923d87d1e5c7.png)

异步交互相比同步交互的优势主要具有以下几点

1. 用户操作无须像同步交互必须等待结果。
2. 异步交互只需与服务器端交換必要的数据内容，而不是将所有数据全部更新。
3. 异步交互对带宽造成的压力相比同步交互更小。
4. 通过Aja实现异步交互不需要任何第三方插件，只要浏览器支持Javascript语言即可实现。

异步交互相比同步交互井不是优势，它也存在一些问题

1. 异步交互破坏了浏览器原有的前进和后退机制。
2. 如果后面逻辑的行依靠前面逻辑行的结果的话，异步交互可能会造成问题。
3. Aja×实现异步交互对搜索引擎支持较弱。
4. Ajax实现异步交互会引起一些Web安全问题，例如如SQL注人攻击、跨站点脚本攻击等问题。

## Ajax概念

### Ajax是什么

Asynchronous JavaScript + XML（异步JavaScript和XML）, 其本身不是一种新技术，而是一个在 2005年被Jesse James Garrett提出的新术语，用来描述一种使用现有技术集合的‘新’方法。

当使用结合了这些技术的AJAX模型以后， 网页应用能够快速地将增量更新呈现在用户界面上，而不需要重载（刷新）整个页面。这使得程序能够更快地回应用户的操作。



### Ajax涉及的技术

Ajax只是为实现异步交互的手段，不是一种技术，而是多种技术的整合。其中包括以下几种技术

- HTML页面

- CSS

- JavaScript

- DOM

- XML

- XMLHttpRequest对象

  实现Ajax异步交互的核心

### Ajax的核心对象

实现Ajax异步交互的核心就是XMLHttpRequest对象，该对象为客户端提供了在客户端和服务器之传输数据的功能。

Xmlhttprequestx对象最初由微软设计，随后被Mozilla、Apple和Google采纳。如今，该对象已经被W3C组织标准化。通过该对象，可以很容易地得到一个URL上的资源数据。尽管名字里有XML，但XMLHttpRequest对象可以得到所有类型的数据资源，井不局限于XML格式的数据。

## 实现Ajax异步交互

### 实现Ajax的执行步骤

1. 创建核心对象XMLHttpRequest
2. 通过XMLHttpRequest对象的open方法与服务器建立连接
3. 构建请求所需的数据内容，并通过XMLHttpRequest对象的send方法发送出去
4. 通过XMLHttpRequest对象提供的onreadystatechange事件监听服务器端的通信状态
5. 接收并处理服务器端向客户端响应的数据结果
6. 将处理的结构更新到HTML页面中

### 创建Ajax的核心对象

1. 函数式定义

   ```javascript
   function createXMLHttpRequest() {
       var httpRequest;
       if (window.XMLHttpRequest) {
           // 适用于非IE浏览器
           httpRequest = new XMLHttpRequest();
       } else if (window.ActiveXObject) {
           //   适用于IE浏览器
           try {
               // IE 7+
               httpRequest = new ActiveXObject("Msxml2.XMLHTTP");
           } catch (e) {
               try {
                   //   IE 6-
                   httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
               } catch (e) {}
           }
       }
       return httpRequest;
   }
   ```

2. 为window原型定义方法

   ```javascript
   Object.defineProperty(window, "createXMLHttpRequest", function () {
       var httpRequest;
       if (window.XMLHttpRequest) {
           // 适用于非IE浏览器
           httpRequest = new XMLHttpRequest();
       } else if (window.ActiveXObject) {
           //   适用于IE浏览器
           try {
               // IE 7+
               httpRequest = new ActiveXObject("Msxml2.XMLHTTP");
           } catch (e) {
               try {
                   //   IE 6-
                   httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
               } catch (e) {}
           }
       }
       return httpRequest;
   });
   
   ```

3. 匿名函数

   ```javascript
   (function () {
     function createXMLHttpRequest() {
       var httpRequest;
       if (window.XMLHttpRequest) {
         // 适用于非IE浏览器
         httpRequest = new XMLHttpRequest();
       } else if (window.ActiveXObject) {
         //   适用于IE浏览器
         try {
           // IE 7+
           httpRequest = new ActiveXObject("Msxml2.XMLHTTP");
         } catch (e) {
           try {
             //   IE 6-
             httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
           } catch (e) {}
         }
       }
       return httpRequest;
     }
     window.createXMLHttpRequest = createXMLHttpRequest;
   })();
   ```

   

任选一种方式即可创建一个Ajax的核心对象。

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <script src="1. createXMLHttpRequest.js"></script>
    <script>
        var xhr = createXMLHttpRequest()
        console.log(xhr);
    </script>
</body>

</html>
```

![image-20200821114254352](https://files.alexhchu.com/2020/08/21/711a8ff808acf.png)

### 实现Ajax的步骤

关于核心对象的方法参考：[MDN](https://developer.mozilla.org/zh-CN/docs/Web/API/XMLHttpRequest)

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

    </body>
    <script src="1. createXMLHttpRequest.js"></script>
    <script>
        var btn = document.getElementById('btn')
        btn.addEventListener('click', function () {
            // 实现Ajax异步交互
            // 1. 创建核心对象
            var xhr = createXMLHttpRequest()
            // 2. 调用核心对象的open方法
            // 作用 - 与服务器建立连接
            // 参数参考 https://developer.mozilla.org/zh-CN/docs/Web/API/XMLHttpRequest/open
            xhr.open('get', 'https://v1.hitokoto.cn')
            // 3. 调用核心对象的send方法
            // 作用 - 将客户端页面的数据发送给服务器端
            // 参数参考 https://developer.mozilla.org/zh-CN/docs/Web/API/XMLHttpRequest/send
            xhr.send(null)
            // 4. 利用核心对象的onreadystatechange事件监听服务器端的通信状态
            // 当接收到服务器端处理完毕的信号
            // 参考连接 https://developer.mozilla.org/zh-CN/docs/Web/API/XMLHttpRequest/readyState
            xhr.onreadystatechange = function () {
                // 通过核心对象的属性readyState监听通信状态
                //readyState=4：响应的内容解析完毕，可以在客户端使用了--完成
                if (xhr.readyState === 4) {
                    // 接收服务器端返回的处理结果（responseText）
                    console.log(xhr.responseText);
                }
            }
            // 5. 将接收到的结果更新到HTML页面中
        })
    </script>

</html>
```

![fc1431ad-f6f1-44b4-9d6c-cff3d603cb2a](https://files.alexhchu.com/2020/08/21/50623f4215687.gif)

## 通过Ajax异步交互

### 响应状态码

通过`status`属性判断返回响应的状态码。

```javascript
xhr.onreadystatechange = function () {
    // 通过核心对象的属性readyState监听通信状态
    //readyState=4：响应的内容解析完毕，可以在客户端使用了--完成
    if (xhr.readyState === 4 && xhr.status === 200) {
        // 接收服务器端返回的处理结果（responseText）
        console.log(xhr.responseText);
        console.log(xhr.status);
    }
}
```

![image-20200821150106643](https://files.alexhchu.com/2020/08/21/a29178d4658e4.png)

### open方法

请求方法分为可以是POST与GET

### send方法

当不发送数据时需要传递`null`而不是不传参。

如果请求方式为`GET`，那么参数只能是`null`，将参数添加到请求地址中。

```javascript
xhr.open('get', 'https://v1.hitokoto.cn?c=a&c=c')
```

如果请求方式为`POST`，那么参数传入请求的参数,并且设置请求头即可。

```javascript
xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
xhr.send("c=a&c=c")
```



## Node.js搭建基础服务

```javascript
const http = require("http");

const hostname = "127.0.0.1";
const port = 3000;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader("Content-Type", "text/plain");
  res.end("Hello, World!\n");
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});

```


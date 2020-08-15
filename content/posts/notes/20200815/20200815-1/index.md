---
title: HTTP各种特性总览
date: 2020-08-15T10:29:50+08:00
categories: ["notes"]
tags: ["Node"]
---

更多HTTP头特性可参考：https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Headers

## CORS跨域请求的限制与解决

在返回数据时设置头信息即可，例如：

```javascript
const http = require("http");
http.createServer(function (req, res) {
    res.writeHead(200,{
    	"Access-Control-Allow-Origin":'*'
    })
}).listen(8888);
```

> 跨域是由浏览器限制的，浏览器允许`img`、`script`、`link`等标签访问不同域的内容。

将其中的`*`设置为某个域名，那么则标识只允许某个域名可以访问。但是只能一个域名，如果需要多个域名需要增加服务器逻辑进行判断。



## CORS跨域限制以及与请求验证

 当请求头中包含一些自定义的头信息，那么默认情况下同样会收到跨域限制，因此需要设置允许的头：

```javascript
const http = require("http");
http.createServer(function (req, res) {
    res.writeHead(200,{
    	"Access-Control-Allow-Origin":'*',
        //设置允许的请求头
        "Access-Control-Allow-Headers":'X-Test-Cors',
        //设置允许的请求方法
        "Access-Control-Allow-Methods":'POST,PUT,Delete',
        //设置最长时间，即1000S内无需再次发送预请求
        "Access-Control-Max-Age":'1000',
    })
}).listen(8888);
```



## 缓存头Cache-Control的含义和使用

- `public`

  任何代理服务器都可以对数据进行缓存

- `private`

  只有发起请求的浏览器可以缓存

- `no-cache`

  任何一个节点都不可以缓存

### 设置缓存

```javascript
const http = require("http");
http.createServer(function (req, res) {
    res.writeHead(200,{
    	"Cache-Control":'max-age=20',
    })
}).listen(8888);
```

> 关于刷新缓存：可以文件名后加入根据内容生成的哈希码。

### 重新验证

- `must-revalidate`

  如果缓存已经过期，需要向源服务端重新获取数据，不能直接使用

- `proxy-revalidate`

  缓存服务器必须在过期时在源服务器重新请求

### 其他

- `no-store`

  本地和代理不可以缓存

- `no-transform`

  不可以随便改动返回的内容

## 缓存验证Last-Modified和Etag的使用

![image-20200812201958071](https://files.alexhchu.com/2020/08/12/72e551db527c3.png)

### 验证头

- `Last-Modified`

  上次修改时间，配合`If-Modified-Since`或者`If-unModified-Since`使用

- `Etag`

  数据签名，配合`If-Match`或者`If-Non-Match`使用，对比资源的签名判断是否使用缓存。

## Cookie和Seesion

Cookie包含的属性

- `max-age`和`expires`设置过期时间
- `Secure`只在https的时候发送
- `HttpOnly`无法通过document.cookie访问

```javascript
const http = require("http");
http.createServer(function (req, res) {
    res.writeHead(200,{
    	"Cache-Control":'max-age=20',
        // 设置过期时间2s的cookie
        "Set-Cookie":'id=123;max-age=2',
        "Set-Cookie":'abc=456',
    })
}).listen(8888);
```

> Cookie存在过期时间，如果不设置过期时间，那么过期时效为浏览器关闭时。
>
> 为主域设置Cookie后所有子域都可以使用Cookie。
>
> Session通常的使用方法时，通过cookie设置session。

## HTTP长连接

> HTTP1.1中有6个并发的链接。而HTTP2在一个TCP链接可以并发的发送多个请求，因此只需要一个链接即可！

创建长连接

```javascript
const http = require("http");
http.createServer(function (req, res) {
    res.writeHead(200,{
    	"Connection":"keep-alive"
    })
}).listen(8888);
```

`Connection`为`close`时，表示不适用http长链接。

## 数据协商

服务端根据请求段携带的数据而确定返回何种数据。

- 客户端：

  1. `Accept`

     明确想要接收数据的类型

  2. `Accept-Encoding`

     明确编码方式，限制服务端压缩方式

  3. `Accept-Language`

     明确返回信息是中文还是英文

  4. `User-Agent`

     判断浏览器信息

- 服务器端

  1. `Content-Type`

     作为真正返回的数据格式进行返回

  2. `Content-Encoding`

     对应`Accept-Encoding`

  3. `Content-Language`

     对应`Accept-Language`

![image-20200814145604713](https://files.alexhchu.com/2020/08/14/eff47432fecbb.png)

## Redirect

也就是重定向，必须将头设置为`301`或`302`

```javascript
const http = require("http");
const fs = require("fs");

http
  .createServer(function (req, res) {
    console.log("request come", req.url);
    if (req.url === "/") {
      res.writeHead(302, {
        Location: "/new",
      });
      res.end("");
    } else {
      res.writeHead(200, {
        "Content-Type": "text/html",
      });
      res.end("<div>this is content</div>");
    }
  })
  .listen(8888);

console.log("server listening on 8888");

```

> 浏览器会默认长期缓存301。因此使用301时要谨慎。

## CSP

- 限制资源获取
- 报告资源获取越权

限制方式

- default-src限制全局
- 指定资源类型
  - `img-src`
  - `style-src`
  - `script-src`
  - 。。。

```javascript
const http = require("http");
const fs = require("fs");

http
  .createServer(function (req, res) {
    console.log("request come", req.url);
    const html = fs.readFileSync("index.html", "utf-8");
    res.writeHead(200, {
      "Content-Type": "text/html",
      // 只允许http或者https方式加载，而不允许执行内联的script脚本
      "Content-Security-Policy": "default-src http: https:",
    });
    res.end(html);
  })
  .listen(8888);

console.log("server listening on 8888");
```

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
        console.log(1)
    </script>
</body>

</html>
```



![image-20200814154111064](https://files.alexhchu.com/2020/08/14/f527428657ab7.png)

1. 限制只能加载本服务器的内容

   ```javascript
   createServer(function (req, res) {
       console.log("request come", req.url);
       const html = fs.readFileSync("index.html", "utf-8");
       res.writeHead(200, {
           "Content-Type": "text/html",
           // 限制只能加载本服务器的内容
           "Content-Security-Policy": "default-src \'self\'",
       });
       res.end(html);
   })
   ```

2. 限制只能加载某个网站的内容

   ```javascript
   createServer(function (req, res) {
       console.log("request come", req.url);
       const html = fs.readFileSync("index.html", "utf-8");
       res.writeHead(200, {
           "Content-Type": "text/html",
           // 限制只能加载某个网站的内容
           "Content-Security-Policy": "default-src https://cdn.jsdelivr.com/",
       });
       res.end(html);
   })
   ```

3. 限制表单

   ```javascript
   createServer(function (req, res) {
       console.log("request come", req.url);
       const html = fs.readFileSync("index.html", "utf-8");
       res.writeHead(200, {
           "Content-Type": "text/html",
           // 限制只能加载某个网站的内容
           "Content-Security-Policy": "default-src https://cdn.jsdelivr.com/; form-action \'self\'",
       });
       res.end(html);
   })
   ```
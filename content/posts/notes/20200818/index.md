---
title: HTTP协议原理与实践
date: 2020-08-18T10:32:00+08:00
categories: ["notes"]
---

# HTTP协议原理与实践

## 三次握手

### 简单比喻

> TCP 三次握手就好比A与B在街上隔着50米看见了对方，但是因为某些原因不能100%确认，所以要通过招手的方式相互确定对方是否认识自己。 

1. A首先向B招手(**syn**)，B看到A向自己招手后，向对方点了点头挤出了一个微笑(**ack**)。A看到B微笑后确认了B成功辨认出了自己(进入**estalished**状态)。
2. 但是B还有点怀疑，向四周看了一看，有没有可能A是在认错了呢？，B也需要确认一下。所以B也向A招了招手(**syn**)，A看到B向自己招手后知道对方是在寻求自己的确认，于是也点了点头发出微笑(**ack**)，B看到对方的微笑后确认了A就是在向自己打招呼(进入**established**状态)。
3. 于是两人加快步伐，走到了一起，相互拥抱。

## 为什么是三次

 过程：A招手--B点头微笑--B招手--A点头微笑 。其中B连续进行了2个动作，先是点头微笑(回复对方)，然后再次招手(寻求确认)，实际上可以将这两个动作合一，招手的同时点头和微笑(**syn+ack**)。于是四个动作就简化成了三个动作，A招手--B点头微笑并招手--A点头微笑。这就是三次握手的本质，中间的一次动作是两个动作的合并。

### HTTP三次握手过程

三次握手得作用是**明确双方的接收和发送能力都是正常的。**

|  次数  |           做的事情           |                       服务端得到的结论                       |                       客户端得到的结论                       |
| :----: | :--------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| 第一次 | 客户端发送网络包，服务器接收 |        客户端的发送能力正常<br />服务端的接收能力正常        |                                                              |
| 第二次 | 服务器发送网络包，客户端接收 |                                                              | 服务端发送能力、接收能力正常<br />客户端接收能力、发送能力正常 |
| 第三次 | 客户端发送网络包，服务端接收 | 服务端发送能力、接收能力正常<br />客户端接收能力、发送能力正常 |                                                              |

![](https://tva1.sinaimg.cn/large/832afe33ly1g8u7gnm82cg20k00p0wsm.gif)

## URI、URL、URN

### URI

Uniform Resource Identifier ：统一资源标识符

用来唯一标识互联网上的信息资源，包括 URL 和 URN

### URL

Uniform Resource Locator：统一资源定位器

`http://user:pass@host.com:80/path?query=string#hash`，此类格式的都叫 URL，比如 ftp 协议

### URN

永久统一资源定位符，资源移动之后还能被找到。但目前还没有非常成熟的使用方案

## 报文格式

![](https://files.alexhchu.com/2020/08/12/fc3e3d7e65487.png)

### HTTP 方法

用来定义对于资源的操作，常用的操作有 GET、POST 等。

### HTTP CODE

定义服务器对请求的处理结果，各个区间的 CODE 有各自的语义。好的 HTTP 服务可以通过 CODE 判断结果。

## 使用 nodejs 实现一个最简单的服务器

```javascript
const http = require("http");
http
  .createServer(function (req, res) {
    console.log("request come", req.url);
    res.end("123");
  })
  .listen(8888);
```

![](https://files.alexhchu.com/2020/08/12/ad90a807a46d3.png)

## CORS 跨域请求的限制与解决

在返回数据时设置头信息即可，例如：

```javascript
const http = require("http");
http.createServer(function (req, res) {
    res.writeHead(200,{
    	"Access-Control-Allow-Origin":'*'
    })
}).listen(8888);
```

> 跨域是由浏览器限制的，浏览器允许 `img`、`script`、`link` 等标签访问不同域的内容。

将其中的 `*` 设置为某个域名，那么则标识只允许某个域名可以访问。但是只能一个域名，如果需要多个域名需要增加服务器逻辑进行判断。

## CORS 跨域限制以及与请求验证

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

## 缓存头 Cache-Control 的含义和使用

缓存性

| 可缓存性 |                             说明                             |
| :------: | :----------------------------------------------------------: |
|  public  |              任何代理服务器都可以对数据进行缓存              |
| private  |                 只有发起请求的浏览器可以缓存                 |
| no-cache | 可以在本地缓存，可以在代理服务器缓存，但是这个缓存要服务器验证才可以使用 |

1. 无缓存时

   服务器代码

   ```javascript
   const http = require("http");
   const fs = require("fs");
   
   http
     .createServer((req, res) => {
       console.log("req come", req.url);
       if (req.url === "/") {
         const html = fs.readFileSync("1.html", "utf-8");
         res.writeHead(200, {
           "Content-Type": "text/html",
         });
         res.end(html);
       }
       if (req.url === "/script.js") {
         res.writeHead(200, {
           "Content-Type": "text/javascript",
         });
         res.end('console.log("script loaded")');
       }
     })
     .listen(8888);
   
   console.log("server listening on http://127.0.0.1:8888");
   ```

   静态网页代码

   ```html
   <!DOCTYPE html>
   <html lang="en">
   
   <head>
       <meta charset="UTF-8">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>Document</title>
   </head>
   
   <body>
       <h2>哈哈哈哈</h2>
       <script src="/script.js"></script>
   </body>
   
   </html>
   ```

   ![image-20200818115850134](https://files.alexhchu.com/2020/08/18/2414b0a37c34c.png)

   每次发起请求都会重新到服务器去请求资源。

2. 设置缓存时间20

   ```javascript
   const http = require("http");
   const fs = require("fs");
   
   http
     .createServer((req, res) => {
       console.log("req come", req.url);
       if (req.url === "/") {
         const html = fs.readFileSync("1.html", "utf-8");
         res.writeHead(200, {
           "Content-Type": "text/html",
         });
         res.end(html);
       }
       if (req.url === "/script.js") {
         res.writeHead(200, {
           "Content-Type": "text/javascript",
           "Cache-Control": "max-age=20",
         });
         res.end('console.log("script loaded")');
       }
     })
     .listen(8888);
   
   console.log("server listening on http://127.0.0.1:8888");
   
   ```

   ![image-20200818120032712](https://files.alexhchu.com/2020/08/18/c6363505b9db0.png)

   可以看到第二次请求（20S内）就是在内存加载了。此时即便服务器更新了内容，如果客户端存在缓存，那么也不会看到。



到期

|         到期         |                     说明                     |
| :------------------: | :------------------------------------------: |
| `max-age=<seconds>`  |             代表seconds秒后过期              |
| `s-maxage=<seconds>` |         对代理服务器设置缓存过期时间         |
|     `max-stale`      | 即便缓存过期，在这个时间内还可以使用过期缓存 |

重新验证

|        验证        |                            说明                            |
| :----------------: | :--------------------------------------------------------: |
| `must-revalidate`  | 如果缓存已经过期，需要向源服务端重新获取数据，不能直接使用 |
| `proxy-revalidate` |          缓存服务器必须在过期时在源服务器重新请求          |

其他

|     其他     |                说明                |
| :----------: | :--------------------------------: |
|   no-store   |     本地和代理都不可以存储缓存     |
| no-transform | 不可以随便改动返回的内容（压缩等） |



## 验证缓存

![](https://files.alexhchu.com/2020/08/12/72e551db527c3.png)

### 验证头

- `Last-Modified`

  上次修改时间，配合 `If-Modified-Since` 或者 `If-UnModified-Since` 使用。如果没有被更新，那么可以直接使用。

- `Etag`

  数据签名，配合 `If-Match` 或者 `If-Non-Match` 使用，对比资源的签名判断是否使用缓存。



验证etag验证缓存

```javascript
const http = require("http");
const fs = require("fs");

http
  .createServer((req, res) => {
    console.log("req come", req.url);
    if (req.url === "/") {
      const html = fs.readFileSync("1.html", "utf-8");
      res.writeHead(200, {
        "Content-Type": "text/html",
      });
      res.end(html);
    }
    if (req.url === "/script.js") {
      res.writeHead(200, {
        "Content-Type": "text/javascript",
        "Cache-Control": "max-age=200000000,no-cache",
        "Last-Modified": "123",
        Etag: "777",
      });
      const etag = req.headers["if-non-match"];
      if (etag === "777") {
        res.writeHead(304, {
          "Content-Type": "text/javascript",
          "Cache-Control": "max-age=200000000,no-cache",
          "Last-Modified": "123",
          Etag: "777",
        });
        res.end("");
      } else {
        res.writeHead(200, {
          "Content-Type": "text/javascript",
          "Cache-Control": "max-age=200000000,no-cache",
          "Last-Modified": "123",
          Etag: "777",
        });
        res.end('console.log("script loaded")');
      }
    }
  })
  .listen(8888);

console.log("server listening on http://127.0.0.1:8888");

```

![image-20200818150703058](https://files.alexhchu.com/2020/08/18/ea66dbe6b92b4.png)

设置后当客户端第一次请求后，在之后的请求会带上这个请求头，服务器拿到这个请求头后验证是否可以直接读取缓存

## Cookie和Session

Cookie 包含的属性

- `max-age` 和 `expires` 设置过期时间
- `Secure` 只在 https 的时候发送
- `HttpOnly` 无法通过 document.cookie 访问

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

> Cookie 存在过期时间，如果不设置过期时间，那么过期时效为浏览器关闭时。
>
> 为主域设置 Cookie 后所有子域都可以使用 Cookie。
>
> Session 通常的使用方法时，通过 cookie 设置 session。



## HTTP长连接

> HTTP1.1 中有 6 个并发的链接。而 HTTP2 在一个 TCP 链接可以并发的发送多个请求，因此只需要一个链接即可！

```javascript
const http = require("http");
http.createServer(function (req, res) {
    res.writeHead(200,{
    	"Connection":"keep-alive"
    })
}).listen(8888);
```

`Connection` 为 `close` 时，表示不使用 http 长链接。



![image-20200818155328334](https://files.alexhchu.com/2020/08/18/f812e9b08da37.png)

![image-20200818155507518](https://files.alexhchu.com/2020/08/18/4dc86ca78baa4.png)



## 数据协商

服务端根据请求段携带的数据而确定返回何种数据。

|      客户端       |     服务端对应     |               说明               |
| :---------------: | :----------------: | :------------------------------: |
|     `Accept`      |                    |      明确想要接收数据的类型      |
| `Accept-Encoding` | `Content-Encoding` | 明确编码方式，限制服务端压缩方式 |
| `Accept-Language` | `Content-Language` |    明确返回信息是中文还是英文    |
|   `User-Agent`    |                    |          判断浏览器信息          |

|     服务端     |              说明              |
| :------------: | :----------------------------: |
| `Content-Type` | 作为真正返回的数据格式进行返回 |

![](https://files.alexhchu.com/2020/08/14/eff47432fecbb.png)

## Redirect

也就是重定向，必须将头设置为 `301` 或 `302`

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

> 浏览器会默认长期缓存 301。因此使用 301 时要谨慎。

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

## windows下使用nginx

通过[官网](http://nginx.org/en/download.html)下载Nginx，将其解压。在命令行内输入`./nginx.exe`即可启动。

![image-20200814195306631](https://files.alexhchu.com/2020/08/14/44f9441c0b6da.png)

![image-20200814195331140](https://files.alexhchu.com/2020/08/14/c953b9bb64db9.png)

## 基础代理配置

> 如果启动的nginx进程过多，可能会导致代理不生效！
>
> 通过`taskkill /IM  nginx.exe  /F`命令可以清除所有nginx进程。

1. 通过`include server/*.conf`实现为单独一个站点设置配置文件

   ```nginx
   http{
       include server/*.conf
   }
   ```

   ![image-20200814195736125](https://files.alexhchu.com/2020/08/14/3d10fe62d535a.png)

   此配置代表将server文件下的所有conf文件导入。

2. 最简单的代理

   ```nginx
   server{
       listen 80;
       server_name test.com;
       location /{
           proxy_pass http://127.0.0.1:8888;
           # 修改代理头为请求的地址
           proxy_set_header Host $host;
       }
   }
   ```

   以上配置表示 当访问test.com时会映射到本地8888端口。`$host`表示请求的地址。

## 代理缓存

```nginx
proxy_cache_path cache levels=1:2 keys_zone=my_cache:10m;
server{
    listen        80;
    server_name test.com;
    location / {
        proxy_pass http://127.0.0.1:8888;
        # 修改代理头为请求的地址
        proxy_set_header Host $host;
        # 设置缓存(名字与上方对应)
        proxy_cache my_cache;
    }
}
```

可以使用[Vary](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Headers/Vary)对不同请求头设置缓存。

## HTTPS

![image-20200815083641945](https://files.alexhchu.com/2020/08/15/a70172b9c6a51.png)

证书生成命令：

```bash
openssl req -x509 -newkey rsa:2048 -nodes -sha256 -keyout localhost-privkey.pem -out localhost-cert.pem
```

- 通过nginx部署https服务

```nginx
server{
    listen        ssl;
    server_name test.com;

    ssl on;
    ssl_certificate_key ../certs/localhost-privkey.pem;
    ssl_certificate ../certs/localhost-cert.pem;

    location / {
        proxy_pass http://127.0.0.1:8888;
        # 修改代理头为请求的地址
        proxy_set_header Host $host;
    }
}
```

其中将证书放到了根目录下`certs`文件夹下。

- 访问自动跳转https

  ```nginx
  server{
      listen 80 default_server;
      listen [::]:80 default_server;
      server_name test.com;
      return 302 https://$server_name$request_url;
  }
  ```



## HTTP2的优势

- 信道复用

- 分帧传输

- Server Push

  HTTP1.1中

  ![image-20200815090204244](https://files.alexhchu.com/2020/08/15/1ae04786cca4d.png)

  HTTP2中

  ![image-20200815090355014](https://files.alexhchu.com/2020/08/15/da5054bacc036.png)

## 通过nginx设置HTTP2

```nginx
server{
    listen        ssl http2;
    http2_push_preload on;
}
```

http2必须在https的基础上开启。
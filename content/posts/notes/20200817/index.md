---
title: 图解HTTP网络协议
date: 2020-08-17T11:05:00+08:00
categories: ["notes"]
---

# 图解HTTP网络协议

## 基于HTTP的组件系统

- 代理

  请求通过一个实体被发出，实体也就是用户代理。大多数情况下，这个用户代理都是指**浏览器**。

- 响应

  每一个发送到服务器的请求，都会被服务器处理井返回一个消息，也就是响应。

在这个请求与回应之间，还有许许多多的被称为 Proxies 的实体，他们的作用与表现各不同。

### 客户端

user-agent 就是任何能够为用户发起行为的工具。这个角色通常都是由浏览器来扮演。一些例外情况，比如是工程师使用的程序，以及 Web 开发人员调试应用程序。

测览器总是作为发起一个请求的实体（近几年已经出现一些机制能够模拟由服务器起的请求消息，例姒如 Node.js)

浏览器首先发送一个请求来获取页面的 HTML 文档，再解析文档中的资源信息发送其他请求，获取可执行脚本或 CSS 样式来进行页面布局這染，以及一些其它页面资源（如图片和视频等）。然后，浏览器将这些资源整合到一起，展现出一个完整的文档，也就是网页。

> 大多数情况下即可将客户端理解为浏览器。

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/08/07/d253ad0ba74f7ec11c7c142812144714.png)

### WEB服务器

在 HTTP 协议通信过程的另一端，是由 Web 服务器来服务并提供客户端所请求的文档。服务器只是虚拟意义上代表一个机器：它可以是共享负载（负载均衡）的一组服务器组成的计算机群，也可以是种复杂的软件，通过向其他计算机（如缓存，数据库服务器，电子商务服务器等）发起请求来获取部分或全部资源。

> Web 服务不一定是一台机器，但一个机器上可以装载的众多 Web 服务。

### 代理（Proxies）

在浏览器和服务器之间，有许多计算机和其他设备转发了 HTTP 消息。由于 Web 栈层次结构的原因它们大多都出现在传输层、网络层和物理层上，对于 HTTP 应用层而言就是透明的，虽然它们可能会对应用层性能有重要影响。还有一部分是表现在应用层上的，被称为代理（ Proxies）。代理（ Proxies）既可以表现得透明，又可以不透明（“改变请求” 会通过它们）。代理主要有如下几种作用：

- 缓存（可以是公开的也可以是私有的，像浏览器的缓存）
- 过滤（像反病毒扫描，家长控制）
- 负载均衡（让多个服务器服务不同的请求）
- 认证（对不同资源进行权限管理）
- 日志记录（允许存储历史信息）

## HTTP消息的基本结构

|      名称      |                             描述                             |
| :------------: | :----------------------------------------------------------: |
|  `start line`  | 一行起始行用于描述要执行的请求，或者是对应的状态，成功或失败。这个起始行总是单行的。 |
| `HTTP headers` |        一个可选的 HTTP 头集合指明请求或描述消息正文。        |
|  `empty line`  |        一个空行指示所有美于请求的元数据已经发送完毕。        |
|     `body`     | 一个可选的包含请求相美数据的正文（比如 HTML 表单内容）或者响应相美的文档。正文的大小有起始行的 HTTP 头来指定。 |

起始行和 HTTP 消息中的 HTTP 头统称为 “请求头”，而其有效负载被称为 “消息正文”。

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/08/08/c822d217ff8a440cd6eb32eec6771120.png)

## 请求消息

### 起始行

起始行包括三个元素：请求方法、请求地址、HTTP版本。

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/08/08/0746ac48667a2d7d224d6d556239a57c.png)

### 请求方法

| 请求方法 |                             描述                             |
| :------: | :----------------------------------------------------------: |
|   GET    | GET 方法请求一个指定资源的表示形式。使用 GET 的请求应该只被用于获取数据 |
|   HEAD   |  HEAD 方法请求一个与 GET 请求的响应相同的响应，但没有响应体  |
|   POST   | POST 方法用于将实体提交到指定的资原，通常导致状态或服务器上的副作用的更改 |
|   PUT    |       PUT 方法用请求有效载荷替换目标资源的所有当前表示       |
|  DELETE  |                  DELETE 方法删除指定的资源                   |
| CONNECT  |      ONNECT 方法建立一个到由目标资源标识的服务器的隧道       |
| OPTIONS  |            OPTIONS 方法用于描述目标资源的通信选项            |
|  TRACE   |      TRACE 方法沿着到目标资源的路径执行一个消息环回测试      |
|  PATCH   |               PATCH 方法用于对资源应用部分修改               |

### 请求头

请求头允许客户端向服务器端传递附加信息。请求头由名称（不区分大小写）后跟一个冒号 “：”，冒号后跟具体的值（不带换行符）组成。

1. 通用头：同时适用于请求和响应消息，但与最终消息主体中传输的数据无关的消息头
2. 请求头：包含更多有关要获取的资源或客户端本身信息的消息头。
3. 实体头：包含有关实体主体的更多信息，比如加主体长 Content- Length）度或其 MIME 类型。

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/08/08/854c9f2ffbea665bf70d5e1d1974d785.png)

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/08/08/fc68e55fa9b3ebe70108ee8d8a214ec5.png)

### 请求主体

请求消息的最后一部分是请求主体。

- 不是所有的请求都需要请求主体：例如获取资源的请求 GET、HEAD、 DELETE 和 OPTIONS 通常它们不需要请求主体。
- 有些请求将数据发送到服务器以便更新数据：常见的的情况是 POST 请求（包含 HTML 表单数据）。

请求主体大致可分为两类

1. 单一资源主体：由一个单文件组成。该类型请求主体由两个 header 定义： Content-Type 和 Content-length
2. 多资源主体：由多部分请求主体组成，每一部分包含不同的信息位。通常是和 HTML 表单连系在一起

## 响应消息

### 状态行

HTTP 响应消息的起始行被称作状态行（statusline), 包含：

1. 协议版本：通常为 HTTP/1.1
2. 状态码：表明请求是成功或失败。常见的状态码是 200,404, 或 302.
3. 状态文本：一个简短的，纯粹的信息，通过状态码的文本描述，帮助人们理解该 HTTP 消息

### 响应头

响应头允许服务器端向客户端传递附加信息。响应头由名称（不区分大小写）后跟一个冒号 “：”，冒号后跟具体的值（不带换行符）组成

根据不同上下文，可将响应头分为

1. 通用头：同时适用于请求和响应消息，但与最终消息主体中传输的数据无关的消息头。
2. 响应头：包含有关响应的补充信息，如其位置或服务器本身（名称和版本等）的消息头。
3. 实体头：包含有关实体主体的更多信息，比如主体长（ Content- Length）度或其 MIME 类型。

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/08/08/a9ca7a8fa048f81bece1ed9624cd7cc7.png)

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/08/08/49ba6db38e10edfc889433122cb0d08e.png)

### 响应主体

响应消息的最后一部分是响应主体。不是所有的响应都需要响应主体：例如具有状态码（如 201 或 204) 的响应，通常不会有响应主体。响应主体大致可分为两类

1. 单一资源主体：由已知长度的单个文件组成。该类型响应主体由两个 header 定义： Content Type 和 Content-length
2. 单一资原主仲：由未知长度的单个文件组成，通过将 Transfer- Encoding 设置为 chunked 来使用 chunks 编码
3. 多资源主体：由多部分响应主体组成，每部分包含不同的信息段。但这是比较少见的。

## HTTP1.x的缺点

- 消息头不能被压缩，会对带宽稻城压力
- 两个报文之间的 header 通常非常相似，但它们仍然在连接中重复传输。
- 无法复用。当在同一个服务器打开几个连接时，TCP 热连接比冷连接更加有效。

## 缓存类型

1. 私有缓存

   私有缓存只能用于单独用户。

   ```
   Cache-Control:private
   ```

2. 共享缓存

   共享缓存可以被多个用户使用。

   ```
   Cache-Control:public
   ```

## 缓存控制



### Cache-Control 头

HTTP/1.1 定义的 Cache-Control 头用来区分对缓存机制的支持情况，请求头和响应头都支持这个属性。通过它提供的不同的值来定义存策略。

1. 禁止进行缓存

   ```
   Cache-Control: no-store
   Cache-Control: no-cache, no-store, must-revalidate
   ```

2. 强制确认缓存

   ```
   Cache-Control: no-cache
   ```

3. 缓存过期机制

   ```
   Cache-Control: max-age=31536000
   ```

4. 缓存验证确认

   ```
   Cache-Control: must-revalidate
   ```

### Pragma 头

Pragma 头是 HTTP/1.0 标准中定义的一个 header 属性，请求中包含 Pragma 的效果跟在头信息中定义 “Cache-Control:no-cache” 相同。但是 HTTP 的响应头不支持这个属性，所以它不能拿来完全替代 HTTP/1.1 中定义的 Cache-Control 头。通常定义 Pragma 以向后兼容基于 HTTP/1.0 的客户。

```
Pragma: no-cache
```

### Expires 头

Expires 响应头包含日期 / 肘间，即在此时候之后，响应过期。

- 无效的日期，比如 0 代表着过去的日期，即该资源已经过期。
- 如果在 Cache-Control 响应头设置了 “max-age” 或者 “s-max-age” 指令，那么 Expires 头会被忽略

```
Expires : Wed,21 Oct 2015 07:28:00 GMT
```

## 访问与更新Cookie

### 创建Cookie

Cookie存储可以是多个内容，其格式为键值对`name=value`。多个内容中间用`;`隔开。

```javascript
document.cookie = 'name=zhuangwuji'
```



### 读取Cookie

`allCookies`被赋值为一个字符串，该字符串包含所有的Cookie，每条cookie以分号分隔（即key= value键值对）。

```javascript
var allCookies = document.cookie
console.log(allCookies);
var arr = allCookies.split(';')
for (var i = 0; i < arr.length; i++) {
    var cookie = arr[i]
    var cookiePair = cookie.split('=')
    console.log(cookiePair[0] + '=' + cookiePair[1]);
}
```



### 修改Cookie

与创建类似。

```javascript
document.cookie = 'name=zhuangwuji'
```



### 删除Cookie

删除Cookie只需要将键对应的值设置为空，并且把Expires标识为以前的时间即可。

```javascript
document.cookie = 'name=;expires=Thu,01 jan 1970 00:00:00 GMT'
```



## HTTP中的Cookie

### Set-Cookie响应头

服务器使用Set-Cookie响应头部向用户代理（一般是浏览器）发送cookie信息。一个简单的Cookie可能像这样

```header
Set-Cookie: <cookie名>=<cookie值>
```

服务器通过该头部告知客户端保存Cookie信息。

```header
HTTP/1.0 200 ok
Content-type: text/html
Set-Cookie: yummy_cookie=choco
Set-Cookie: tasty_cookie=strawberry
```

### Cookie请求头

对服务器发起的每一次新请求，浏览器都会将之前保存的Cookie信息通过Cookie请求头部再发送给服务器。

```header
GET /sample_page.html HTTP/1.1
Host: www.example.org
Cookie: yummy_cookie=choco;tasty_cookie=strawberry
```

## 简单请求

1. 请求方法为：GET、HEAD、POST 其中一个
2. 不得人为设置下列集合之外的其他首部字段：`Accept`、`Accept-Language`、`Content-Language`、`Content-Type`
3. `Content-Type`的值仅限以下三者之一
   - `text/plain`
   - `multipart/form-data`
   - `application/x-www-form-urlencoded`

值得注意的是，这些跨域请求与浏览器发出的其他跨域请求并无二致。如果服务器未返回正确的响应首部，则请求方不会收到任何数据。因此，那些不允许跨域请求的网站无需为这一新的 HTTP 访问控制特性担心。

## 预检请求

1. 请求方法为：PUT、DELETE、CONNECT、OPTIONS、TRACE、PATH
2. 不得人为设置下列集合之外的其他首部字段：`Accept`、`Accept-Language`、`Content-Language`、`Content-Type`
3. `Content-Type`的值仅限以下三者之一
   - `text/plain`
   - `multipart/form-data`
   - `application/x-www-form-urlencoded`

预检请求要求必须首先使用 OPTONS 方法发起一个预检请求到服务器，以获取服务器是否允许该实际请求。

**预检请求可以避免跨域请求对服务器的用户数据产生未预期的影响。**

## 认证请求

XMLHttpRequest 与 CORS 的一个有趣的特性是，可以基于 HTTP cookies 和 HTTP 认证信息发送身份凭证。一般而言，对于跨域 XMLHttpRequest 请求，浏览器**不会**发送身份凭证信息。如果要发送凭证信息，需要设置 `XMLHttpRequest` 的某个特殊标志位。

```
xmlHttpRequest.withCredentials = true
```

`withCredentials` 标志设置为 `true`，从而向服务器发送 Cookies。因为这是一个简单 GET 请求，所以浏览器不会对其发起 “预检请求”。但是，如果服务器端的响应中未携带 `Access-Control-Allow-Credentials: true` ，浏览器将不会把响应内容返回给请求的发送者。


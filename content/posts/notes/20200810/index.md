---
title: HTTP缓存机制与Cookie
date: 2020-08-10T23:03:00+08:00
categories: ["notes"]
---

## HTTP的缓存机制

### 缓存是什么

缓存是一种保存资源副本并在下次请求时直接使用该副本的技术。当Web缓存发现请求的资源已经被存储，它会拦截请求，返回该资源的拷贝，而不会去源服务器重新下载。

缓存需要合理配置，因为并不是所有资源都是永久不変的。重要的是对一个资源的缓存应截止到其下次发生改变（即不能缓存过期的资源）。

![image-20200810213242542](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@06d51b9d75d9ae9560d5d09c65c7649f7a91a59c/2020/08/10/b80cbde1d12d69b94f708a992a518e5a.png)

![image-20200810214608480](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@801fbf05692ac99e49300ce0991786a6f474c2a0/2020/08/10/68027e413487a346a000bdbbda4c63d6.png)

缓存服务器端的数据的优点

1. 缓解服务器端的资源消耗和运行压力，提升服务器端的整体性能。
2. 减少服务器端资源加载的延迟，进而成少显示某个资源所用的时间
3. 减少对带宽造成的压力，避免网络阻塞问题的出现
4. Web站点变得更具有响应性

常见的HTTP缓存只能存储GET响应，对于其他类型的响应则无能为力。

- 检索请求的成功响应：响应状态码为200,则表示为成功。包含例如HTML文档，图片，或者文件的响应。
- 不变的重定向：响应状态码为301
- 错误响应：响应状态码为404的一个页面。
- 不完全的响应：响应状态码为206,只返回局部的信息。
- 除了GET请求外，如果匹配到作为ー个已被定义的cache键名的响应。

  

## 缓存类型

### 私有缓存

私有缓存只能用于单独用户。洳览器缓存拥有用户通过HTTP下载的所有文档。这些缓存为浏览过的文档提供向后/向前导航、保存网页、查看源码等功能，可以避免再次向服务器发起多余的请求。它同样可以提供缓存內容的离线览。

```header
Cache-Control:private
```

### 共享缓存

共享缓存可以被多个用户使用。例如，ISP或所在的公司可能会架设一个web代理来作为本地网络基础的一部分提供给用户。这样热门的资源就会被重复使用，减少网络拥堵与延迟

```header
Cache-Control:public
```

## 缓存控制

### Cache-control头

HTTP/1.1定义的Cache-Control头用来区分对缓存机制的支持情况，请求头和响应头都支持这个属性。通过它提供的不同的值来定义存策略。

1. 禁止进行缓存

   ```header
   Cache-Control: no-store
   Cache-Control: no-cache, no-store, must-revalidate
   ```

2. 强制确认缓存

   ```header
   Cache-Control: no-cache
   ```

3. 缓存过期机制

   ```header
   Cache-Control: max-age=31536000
   ```

4. 缓存验证确认

   ```header
   Cache-Control: must-revalidate
   ```

### Pragma头

Pragma头是HTTP/1.0标准中定义的一个header属性，请求中包含Pragma的效果跟在头信息中定义“Cache-Control:no-cache”相同。但是HTTP的响应头不支持这个属性，所以它不能拿来完全替代HTTP/1.1中定义的Cache-Control头。通常定义Pragma以向后兼容基于HTTP/1.0的客户。

```header
Pragma: no-cache
```

### Expires头

Expires响应头包含日期/肘间，即在此时候之后，响应过期。

- 无效的日期，比如0代表着过去的日期，即该资源已经过期。
- 如果在Cache-Control响应头设置了“max-age”或者“s-max-age”指令，那么 Expires头会被忽略

```header
Expores: Wed,21 Oct 2015 07:28:00 GMT
```



## Cookie

### Cookie是什么

Cookie是服务器发送到用户浏览器并保存在本地的一小块数据，会在浏览器下次向同一服务器再发起请求时被携带并发送到服务器上。

![image-20200810222245206](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@ab642c1677b0990fca8e5b3651826f9683cc707e/2020/08/10/b088b483a2755493b77d51a06acb82fb.png)

通常，Cookie用于告知服务端两个请求是否来自同一浏览器，如保持用户的登录状态。 cookie使基于无状态的HTTP协议记录稳定的状态信息成为了可能。Cookie技术产生源于HTTP协议在互联网上的急速发展。

Cookie曾一度用于客户端数据的存储，因当时并没有其它合适的存储办法而作为唯一的存储手段。但现在随着现代洳览器开始支持各种各杵的存储方式， Cookie渐渐被淘汰。由于服务器指定Cookie后，浏览器的每次请求都会携带Cookie数据，会带来额外的性能开销。

### Cookie的存储

Cookie保存在客户端某个特定的目录下的一个扩展名为“.txt”文本文件中，井且不同站点的 Cookie数据保存不同的文件中。

Cookie数据一般都是加密后保存的。

### Cookie的作用域

Domain和Path标识定义了Cookie的作用域，即Cookie应该发送给哪些URL.

- Domain标识指定了哪些主机可以接受Cookie
  - 如果不指定，默认为当前文档的主机（不包含子域名）。
  - 如果指定了 Domain，则一般包含子域名。例如，如果设置Domain=`wolongxueyuan.com`,则（Cookie也包含在子域名中（如`developer.wolongxueyuan.com`).
- Path标识指定了主机下的哪些路径可以接受Cookie（该URL路径必须存在于请求URL中）。以字符%x2F(“/”）作为路径分隔符，子路径也会被匹配。

### Cookie的有效期

Max-Age和 Expires/标识定义了 Cookie的有效期，即 Cookie的生命周期。

- 会话期Cookie

  会话期Cookie是最简单的Cookie。浏览器关之后Cookie会被自动删除，也就是说cookie仅在会话期内有效。会话期 Cookie不需要指定过期时间（Expires）或者有效期（MaxーAge)

- 持久性Cookie

  持久性 Cookie可以指定一个特定的过期时间（ Expires）或有效期（Max-Age)

### Cookie的应用

Cookie主要用于以下三个方面

- 会话状态管理（如用户登录状态、购物车、游戏分数或其它需要记录的信息）
- 个性化设置（如用户自定义设置、主题等）
- 浏览器行为跟踪（如跟踪分析用户行为等）



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


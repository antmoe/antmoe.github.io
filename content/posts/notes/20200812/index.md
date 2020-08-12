---
title: HTTP协议基础及发展历史
date: 2020-08-12T21:13:00+08:00
categories: ["notes"]
---

## 经典五层模型介绍

![image-20200812102304972](https://files.alexhchu.com/2020/08/12/af83366c73f48.png)

### 第三层

1. 物理层

   定义物理设备如何传输数据

2. 数据链路层

   在通信的实体间建立数据链路连接

3. 网络层

   数据在节点之间传输创建逻辑链路

### 传输层

向用户提供可靠的端到端（End-to-End）服务

传输层向高层屏蔽了下层数据通信的细节

### 应用层

为应用软件提供了很多服务，构建与TCP协议之上。屏蔽了网络传输相关细节

## HTTP协议的发展历史

### HTTP/0.9

- 只有一个命令GET
- 没有HEADER等描述数据的信息
- 服务器发送完毕，就关闭TCP连接

### HTTP/1.0

- 增加了很多命令
- 增加status code和header
- 多字符集支持、多部分发送、权限、缓存等

### HTTP/1.1

- 持久连接
- pipeline
- 增加了host和其他一些命令

### HTTP2

- 所有数据以二进制传输
- 同一个连接里面发送多个请求不在需要按照顺序来
- 头信息压缩以及推送提高效率的功能

## 三次握手

过程：张三招手--李四点头微笑--李四招手--张三点头微笑 。其中李四连续进行了2个动作，先是点头微笑(回复对方)，然后再次招手(寻求确认)，实际上可以将这两个动作合一，招手的同时点头和微笑(**syn+ack**)。于是四个动作就简化成了三个动作，张三招手--李四点头微笑并招手--张三点头微笑。这就是三次握手的本质，中间的一次动作是两个动作的合并。

![](https://tva1.sinaimg.cn/large/832afe33ly1g8u7gnm82cg20k00p0wsm.gif)

> 图的解释：
>
> 1. `client`端发送`syn`字段，请求连接
> 2. `server`端回复`ack`、`syn`字段字段确定与之连接
> 3. `client`接到确认后进入`established`已建立状态，并发送`ack`字段确认对方的连接

## URI、URL、URN

### URI

Uniform Resource Identifier ：统一资源标识符

用来唯一标识互联网上的信息资源，包括URL和URN

### URL

Uniform Resource Locator：统一资源定位器

`http://user:pass@host.com:80/path?query=string#hash`，此类格式的都叫URL，比如ftp协议

### URN

永久统一资源定位符，资源移动之后还能被找到。但目前还没有非常成熟的使用方案

## HTTP报文格式

![image-20200812113153236](https://files.alexhchu.com/2020/08/12/fc3e3d7e65487.png)

### HTTP方法

用来定义对于资源的操作，常用的操作有GET、POST等。

### HTTP CODE

定义服务器对请求的处理结果，各个区间的CODE有各自的语义。好的HTTP服务可以通过CODE判断结果。

## 使用nodejs实现一个最简单的服务器

```javascript
const http = require("http");
http
  .createServer(function (req, res) {
    console.log("request come", req.url);
    res.end("123");
  })
  .listen(8888);
```

![image-20200812114753588](https://files.alexhchu.com/2020/08/12/ad90a807a46d3.png)
---
title: 跨域资源共享
date: 2020-08-11T20:51:00+08:00
categories: ["notes"]
---

## 跨域资源共享是什么

CORS全称为Cross-Origin Resource Sharing，被译为跨域资源共享，新増了一组HTTP首部字段，允许服务器声明哪些源站有权限访问哪些资源。

跨域资源共享标规范要求，对那些可能对服务器数据产生副作用的HTTP请求方法（特别是GET以外的HTTP请求，或者搭配某些MIME类型的POST请求），浏览器必须首先使用OPTIONS方法发起一个预检请求，从而获知服务端是否允许该跨域请求。服务器确认允许之后，才发起实际的HTTP请求。在预检请求的返回中，服务器端也可以通知客户端，是否需要携带身份凭证。

跨域资源共享机制的工作原理主要应用于三个场景

1. 简单请求
2. 预检请求
3. 认证请求



## 简单请求

1. 请求方法为：GET、HEAD、POST其中一个
2. 不得人为设置下列集合之外的其他首部字段：`Accept`、`Accept-Language`、`Content-Language`、`Content-Type`
3. `Content-Type`的值仅限以下三者之一
   - `text/plain`
   - `multipart/form-data`
   - `application/x-www-form-urlencoded`

值得注意的是，这些跨域请求与浏览器发出的其他跨域请求并无二致。如果服务器未返回正确的响应首部，则请求方不会收到任何数据。因此，那些不允许跨域请求的网站无需为这一新的HTTP访问控制特性担心。

## 预检请求

### 预检请求是什么

1. 请求方法为：PUT、DELETE、CONNECT、OPTIONS、TRACE、PATH
2. 不得人为设置下列集合之外的其他首部字段：`Accept`、`Accept-Language`、`Content-Language`、`Content-Type`
3. `Content-Type`的值仅限以下三者之一
   - `text/plain`
   - `multipart/form-data`
   - `application/x-www-form-urlencoded`

预检请求要求必须首先使用OPTONS方法发起一个预检请求到服务器，以获取服务器是否允许该实际请求。

预检请求可以避免跨域请求对服务器的用户数据产生未预期的影响。

## 认证请求

XMLHttpRequest与 CORS 的一个有趣的特性是，可以基于HTTP cookies和 HTTP 认证信息发送身份凭证。一般而言，对于跨域 XMLHttpRequest 请求，浏览器**不会**发送身份凭证信息。如果要发送凭证信息，需要设置 `XMLHttpRequest `的某个特殊标志位。

```javascript
xmlHttpRequest.withCredentials = true
```

 `withCredentials` 标志设置为 `true`，从而向服务器发送 Cookies。因为这是一个简单 GET 请求，所以浏览器不会对其发起“预检请求”。但是，如果服务器端的响应中未携带 `Access-Control-Allow-Credentials: true` ，浏览器将不会把响应内容返回给请求的发送者。
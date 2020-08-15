---
title: Nginx代理以及面向未来的HTTP
date: 2020-08-15T10:29:50+08:00
categories: ["notes"]
tags: ["Node"]
---

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


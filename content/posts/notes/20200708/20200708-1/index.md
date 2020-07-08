---
title: 一、Django连接与建立数据库
date: 2020-07-08T11:01:50+08:00
categories: ["notes"]
tags: ["Node"]
---

## Windows系统

由于二进制包安装了半个小时，还是卡在进度条不动。因此决定使用压缩包进行安装。

1. 下载安装包

   [下载地址](https://www.mongodb.com/try/download/community)

   ![image-20200708121142544](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/418101af076a337a0683ea5cf22d72b9.png)

2. 下载完成后将其解压，例如我解压到了`F:\MongoDB`文件下。

3. 接下来进入该文件创建`data`与`logs`文件

   ![image-20200708121317156](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/ff8268f963d4bd36837036bf5f08e122.png)

4. 以管理员身份启动终端，然后输入如下命令

   ```bash
    mongod --install --dbpath F:\MongoDB\data --logpath F:\MongoDB\logs\mongo.log
   ```

5. 开启数据库服务

   ```bash
   net start mongodb
   ```

6. 链接数据库

   ```bash
   mongo
   ```

   ![image-20200708121521710](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/c14dcc1658e812c35f575bfacf551ffa.png)



其他命令 

1. 删除服务

   ```bash
   mongod --remove
   ```

2. 关闭服务

   ```bash
   net stop mongodb
   ```

   

## Linux系统
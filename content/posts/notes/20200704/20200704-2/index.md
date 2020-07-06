---
title: 七、NodeJs数据库管理
date: 2020-07-04T15:56:50+08:00
categories: ["notes"]
tags: ["Node"]
---

title: 七、NodeJs数据库管理
categories:

  - 大前端
  - NodeJs
    tags:
  - 大前端
  - NodeJs
  - mysql
  - 笔记
    date: 2020-07-04 15:56:58

## 建表

MySQL程序可以使用PHP study集成工具。链接、操作数据库可以使用phpstudy自带的工具也可以使用navicat工具。

## SQL语句-增删改查

1. 插入数据

   ```sql
   insert into 表名(字段名1，字段名2) values(值1，值2);
   ```

   <span class="inline-tag blue">例如：</span>

   ```sql
   insert into user(name,description) values('陈浩南','铜锣湾扛把子');
   ```

   ![image-20200704162719944](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/04/d8453bff20575322c9f35151ab212395.png)

2. 删除数据

   ```sql
   delete from 表名 where 条件;
   ```

   条件一定要写，如果不写则会**删除该表中所有的数据删除。**

   <span class="inline-tag blue">例如：</span>

   ```sql
   delete from user where id>3;
   ```

3. 修改数据

   ```sql
   update 表名 set 字段名1=新值1,字段名2=新值2 where 条件;
   ```

   条件一定要写，如果不写则会**修改数据表中的全部数据**

   <span class="inline-tag blue">例如：</span>

   ```sql
   update user set name='子风兄',description='比波波还骚' where id=3;
   ```

4. 查询数据

   ```sql
   select * from 表名 [where 条件];
   ```

   ![image-20200704164131234](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/04/a3ceacbaeaa9ae7a1ea01d53689f4b1e.png)

## NodeJs操作数据库

NodeJs链接数据库需要使用模块`mysql`。基本结构如下：

```javascript
var mysql = require("mysql");
// 创建一个链接数据库的链接
var connection = mysql.createConnection({
    // 数据库地址
    host: "localhost",
    // 数据库账号
    user: "root",
    // 数据库密码
    password: "root",
    // 数据库名（非表名）
    database: "study",
});
// 打开链接
connection.connect();

// 具体语句
// .....

connection.end();

```

连接与关闭链接可以不写。

### 查

```javascript
connection.query("select * from user", (error, result, fields) => {
  // 如果查询遇到错误，则error代表错误。没有错误则为null
  console.log(error);
  // 执行sql语句得到的结果。如果查询遇到错误，则为undefined
  console.log(result);
  // 字段信息
  console.log(fields);
});
```

<span class="inline-tag yellow">result</span>

![image-20200704170616466](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/04/34d759db0e1d33f9bb9943fdb5e400ea.png)

<span class="inline-tag yellow">fields</span>

![image-20200704170635370](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/04/e18098d70f800365cb4acef534872c2c.png)

### 其他查询方法

1. 以什么开头

   ```sql
   select * from hero where heroName like "马%";
   ```

   ![image-20200706192609590](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/06/dc7db35db5e1a3bc220fe8c9f7dd2543.png)

2. 以什么结尾

   ```sql
   select * from hero where heroName like "%韦";
   ```

   ![image-20200706192724093](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/06/7d602da456d1bfc3ca64d1425c3a4a6d.png)

3. 包含什么内容

   ```sql
   select * from hero where heroName like "%魔%";
   ```

   ![image-20200706192800250](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/06/24e9f208bb0c675aa799ff53e4fd8741.png)

4. 并且条件

   ```sql
   select * from hero where heroName like "%魔%" and isDelete='false';
   ```

   可用`and`链接多个条件。

   ![image-20200706193125673](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/06/d2d5d94d61fff9c08a67bef1d35535e7.png)

5. 或条件

   ```sql
   select * from hero where heroName like "%魔%" or heroName like "%信%";
   ```

   ![image-20200706193321722](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/06/8ca36b9567f43057c428bb026fab0bc3.png)

6. 排序

   - 降序

     ```sql
     select * from hero where heroName like "%魔%" or heroName like "%信%" order by id desc;
     ```

     ![image-20200706193441568](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/06/5d2e0fe766376a39b4192203d29e9634.png)

   - 升序

     默认为升序

     ```sql
     select * from hero where heroName like "%魔%" or heroName like "%信%" order by id asc;
     ```

     ![image-20200706193535578](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/06/7d51fd678197bc5c259488b7f582273e.png)

   - 分页

     倒序情况下拿到前20条数据

     ```javascript
     select * from hero  order by id desc limit 0,20;
     ```

     ![image-20200706193830578](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/06/1250da7213b0e113211d08705e414ead.png)

   - 连表查询

     ```sql
     select 字段 from 表1 inner join 表2 on 对应关系
     ```

     ```sql
     select * from horder inner join customer on horder.cid = custom.id;
     ```

     可对两个表设置别名，但是后边也要设置别名。

     ```sql
     select * from horder h inner join customer c on h.cid = c.id;
     ```

     也可以只查询某个字段。

     ```sql
     select h.id,h.oname,c.price,c.id,c.cname,c.age from horder h inner join customer c on h.cid = c.id;
     ```

     

### 增

```javascript
let name = "伦哥";
let description = "这是个描述";
connection.query(
    `insert into user(name,description) values('${name}','${description}')`,
    (error, result, fields) => {
        // 如果查询遇到错误，则error代表错误。没有错误则为null
        console.log(error);
        // 执行sql语句得到的结果。如果查询遇到错误，则为undefined
        console.log(result);
        // 字段信息
        console.log(fields);
    }
);
```

其中`result`会返回一个对象，`fields`返回`undefined`。其中`affectedRows`表示受影响的行数，如果大于0则表示新增成功。

![image-20200704171121849](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/04/6e5f0d8cbe1472dd92f587bd8a2f6892.png)

### 删

```javascript
let id = 3;
connection.query(`delete from user where id=${id}`, (error, result, fields) => {
    if (error == null) {
        console.log(result);
    }
});
```

![image-20200704172128720](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/04/71e92a3c3aac2610826ab7b971615049.png)

### 改

改与新增类似。

```javascript
let name = "伦哥";
let description = "这是个描述";
let id = 3;
connection.query(
    `update user set name='${name}',description='${description}' where id=${id}`,
    (error, result, fields) => {
        if (error == null) {
            console.log(result);
        }
    }
);
```

![image-20200704171859547](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/04/a37f6461eb8a1346ded5dff6ba963fe7.png)

## 英雄管理系统-添加接口

```javascript
app.post("/hero/add", upload.single("heroIcon"), (req, res) => {
  // 1.1 接收前端传递过来的参数
  console.log(req.file);
  console.log(req.body);
  let heroIcon = req.file.filename;
  let { heroName, heroSkill } = req.body;
  // 执行sql语句代码
  connection.query(
    `insert into hero(heroName,heroSkill,heroIcon) values('${heroName}','${heroSkill}','${heroIcon}');`,
    (error, result, fields) => {
      if (error == null) {
        res.send({
          code: 200,
          msg: "新增成功",
          list: { heroName: heroName, heroSkill: heroSkill },
        });
      } else {
        res.send({
          code: 400,
          msg: "新增失败",
          list: { heroName: heroName, heroSkill: heroSkill },
        });
      }
    }
  );
});
```



## 英雄管理系统-获取接口

```javascript
app.get("/hero/all", (req, res) => {
    connection.query(
        `select id,heroName,heroSkill,heroIcon from hero where isDelete = 0`,
        (error, result, fields) => {
            if (error == null) {
                console.log(result);

                res.send({
                    code: 200,
                    msg: "查询成功",
                    list: result,
                });
            } else {
                res.send({
                    code: 400,
                    msg: "查询失败",
                    list: null,
                });
            }
        }
    );
});
```

## 完整代码

```javascript
const express = require("express");
const multer = require("multer");
const mysql = require("mysql");

var connection = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "root",
    database: "study",
});

const app = express();
var upload = multer({ dest: "uploads/" });
app.use(express.static("uploads"));
// 路由
// 参数:heroName heroSkill,heroIcon(文件),
app.post("/hero/add", upload.single("heroIcon"), (req, res) => {
    // 1.1 接收前端传递过来的参数
    console.log(req.file);
    console.log(req.body);
    let heroIcon = req.file.filename;
    let { heroName, heroSkill } = req.body;
    // 执行sql语句代码
    connection.query(
        `insert into hero(heroName,heroSkill,heroIcon) values('${heroName}','${heroSkill}','${heroIcon}');`,
        (error, result, fields) => {
            if (error == null) {
                res.send({
                    code: 200,
                    msg: "新增成功",
                    list: { heroName: heroName, heroSkill: heroSkill },
                });
            } else {
                res.send({
                    code: 400,
                    msg: "新增失败",
                    list: { heroName: heroName, heroSkill: heroSkill },
                });
            }
        }
    );
});

app.get("/hero/all", (req, res) => {
    connection.query(
        `select id,heroName,heroSkill,heroIcon from hero where isDelete = 0`,
        (error, result, fields) => {
            if (error == null) {
                console.log(result);

                res.send({
                    code: 200,
                    msg: "查询成功",
                    list: result,
                });
            } else {
                res.send({
                    code: 400,
                    msg: "查询失败",
                    list: null,
                });
            }
        }
    );
});

// 开启服务器
app.listen(3000, () => {
    console.log("开启成功");
});

```


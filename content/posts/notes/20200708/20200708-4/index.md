---
title: 四、mongoose的使用
date: 2020-07-08T11:01:50+08:00
categories: ["notes"]
tags: ["Node"]
---

## mongoose

核心概念

- schema 

  约束字段/列数据

- model模型 

  对应 集合 后期用它来实现数据增删改查

### 简介

1. 安装

   ```bash
   npm i mongoose
   ```

2. schema

   英文网： [http://mongoosejs.com](http://mongoosejs.com)

   中文网： [http://mongoosejs.net/](http://mongoosejs.net/)

   作用：用来约束MongoDB文档数据（哪些字段必须，哪些字段可选的）

3. model

   一个模型对应一个集合。后面通过模型管理集合中的数据。

### 使用

基本模型

```javascript
// 一、导入模块
const mongoose = require("mongoose");
// 二、连接数据库
const db = mongoose.createConnection(
  "mongodb://shop2:shop2@localhost:27017/shop",
  { useNewUrlParser: true, useUnifiedTopology: true },
  (err) => {
    if (err) {
      console.log("---------------------------------------");
      console.log("数据库连接失败：", err);
      console.log("---------------------------------------");
      return;
    }
    console.log("数据库连接成功");
  }
);

// 三、设置数据模型（声明是哪个集合，限制字段个数和字段类型）
const model = db.model("api", {
  uname: { type: String, default: "神龙教主" },
  pwd: String,
  age: { type: Number },
  sex: { type: String },
});
```



1. 插入一条数据

   ```javascript
   const insertObj = new model({
       uname: "张三",
       pwd: "123",
       age: 18,
       sex: "man",
   });
   
   insertObj
       .save()
       .then((res) => {
       return res;
   })
       .catch((err) => {
       console.log("插入失败" + err);
       return false;
   });
   
   ```

2. 查询数据

   ```javascript
   model
       .find({ uname: "张三" })
       .then((res) => {
       console.log(res);
   
       return res;
   })
       .catch((err) => {
       console.log(err);
       return false;
   });
   ```

3. 分页查询

   ```javascript
   model
       .find({ uname: "张三" })
       .skip(1)
       .limit(1)
       .then((res) => {
       console.log(res);
   
       return res;
   })
       .catch((err) => {
       console.log(err);
       return false;
   });
   
   ```

   

## 教学管理系统接口开发

### 基本框架(express)

```javascript
const express = require("express");
const app = express();
const port = 3000;

app.get("/", (req, res) => res.send("Hello World!"));
app.listen(port, () =>
  console.log(`Server running at  http://127.0.0.1:${port}`)
);

```

### 学生添加接口

1. 导入`body-parser`模块接收前端传来的数据

2. 定义路由

   分模块开发，将路由的方法写在`/constroller/stu.js`文件中。

   ```javascript
   const stuController = require(process.cwd() + "/constroller/stu");
   app.post("/stu", stuController.create);
   ```

   在`/constroller/stu.js`文件中，导入模型，调用模型中的方法完成逻辑的编写，最后导出。

   ```javascript
   // 导入模型
   const { createModle } = require(process.cwd() + "/models/stu");
   const create = async (req, res) => {
       //   res.send("this is stu create");
       let postData = req.body;
       let rs = await createModle(postData);
       if (rs) {
           res.send({
               meta: {
                   state: 200,
                   msg: "添加成功",
               },
               data: null,
           });
       } else {
           res.send({
               meta: {
                   state: 500,
                   msg: "添加失败",
               },
               data: null,
           });
       }
   };
   
   // 导出成员
   module.exports = { create };
   ```

   在`/models/stu.js`模型文件中，定义与数据库相关的操作。

   ```javascript
   // 一、导入模块
   const mongoose = require("mongoose");
   // 二、连接数据库
   const db = mongoose.createConnection(
     "mongodb://shop2:shop2@localhost:27017/shop",
     { useNewUrlParser: true, useUnifiedTopology: true },
     (err) => {
       if (err) {
         console.log("---------------------------------------");
         console.log("数据库连接失败：", err);
         console.log("---------------------------------------");
         return;
       }
       console.log("数据库连接成功");
     }
   );
   
   // 三、设置数据模型（声明是哪个集合，限制字段个数和字段类型）
   const model = db.model("stu", {
     uname: { type: String, default: "神龙教主" },
     pwd: String,
     age: { type: Number },
     sex: { type: String },
   });
   
   const createModle = (postData) => {
     insertObj = new model(postData);
     return insertObj
       .save()
       .then((res) => {
         return res;
       })
       .catch((err) => {
         console.log(err);
         return false;
       });
   };
   
   // 四、方法
   
   module.exports = { createModle };
   
   ```

### 学生列表接口

1. 定义路由`/stu` get请求

   ```javascript
   app.get("/stu", stuController.create);
   ```

2. 为控制器新增方法

   ```javascript
   const index = (req, res) => {
       listModle().then((rs) => {
           if (rs) {
               res.send({
                   meta: {
                       state: 200,
                       msg: "查询成功",
                   },
                   data: rs,
               });
           } else {
               res.send({
                   meta: {
                       state: 500,
                       msg: "查询失败",
                   },
                   data: null,
               });
           }
       });
   };
   ```

3. 修改stu模型，增加查询方法

   ```javascript
   const listModle = () => {
     return model
       .find()
       .then((res) => {
         console.log(res);
         return res;
       })
       .catch((err) => {
         console.log(err);
         return null;
       });
   };
   ```

### 学生列表接口分页

1. 添加路由

   ```javascript
   app.get("/stu", stuController.index);
   ```

2. 修改控制器

   ```javascript
   const index = (req, res) => {
     let getData = req.query;
     let pagesize = parseInt(getData.pagesize);
     let skip = (parseInt(getData.pageno) - 1) * pagesize;
     listModle(skip, pagesize).then((rs) => {
       if (rs) {
         res.send({
           meta: {
             state: 200,
             msg: "查询成功",
           },
           data: rs,
         });
       } else {
         res.send({
           meta: {
             state: 500,
             msg: "查询失败",
           },
           data: null,
         });
       }
     });
   };
   ```

3. 修改模型

   ```javascript
   const listModle = (skip, limit) => {
     return model
       .find()
       .skip(skip)
       .limit(limit)
       .then((res) => {
         console.log(res);
         return res;
       })
       .catch((err) => {
         console.log(err);
         return null;
       });
   };
   ```

## apiDoc的使用

1. 安装模块（仅一次）

   ```bash
   npm install apidoc -g
   ```

2. 在项目根目录创建`apidoc.json`文件（仅一次）

   ```json
   {
   "name": "example",
   "version": "0.1.0",
   "description": "apiDoc basic example",
   "title": "Custom apiDoc browser title",
   "url" : "https://api.github.com/v1"
   }
   ```

   例如：

   ```json
   {
    "name": "教学管理系统接口文档",
    "version": "1.0.0",
    "description": "一个非常NB的接口文档",
    "title": "Custom apiDoc browser title",
    "url" : "http://localhost:3000"
   }
   ```

3. 写接口注释（N次）

   ```javascript
   /**
    * @api {get} /user/:id Request User information
    * @apiName GetUser
    * @apiGroup User
    *
    * @apiParam {Number} id Users unique ID.
    *
    * @apiSuccess {String} firstname Firstname of the User.
    * @apiSuccess {String} lastname  Lastname of the User.
    */
   ```

   例如：

   ```javascript
   /**
    * @api {get} /stu 学生模块列表
    * @apiName Add
    * @apiGroup Stu
    *
    * @apiParam {Number} pageno   当前页
    * @apiParam {Number} pagesize 每页显示条数
    *
    * @apiSuccess {String}  meta  状态码&提示信息
    * @apiSuccess {String}  data  数据
    */
   ```

4. 生成接口文档（N次）

   ```bash
   apidoc -i ./接口注释目录 -o ./接口文档存放目录
   ```

   


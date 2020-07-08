---
title: NodeJs博客系统开发
date: 2020-07-07T19:52:50+08:00
categories: ["project"]
---

## 开发前的准备

1. 安装插件

   - body-parser
   - cookies
   - express
   - markdown
   - mongoose
   - swig

   ```bash
   npm i body-parser cookies markdown mongoose swig
   ```

2. 基本的目录结构

   ```
   blog
    ├── app.js  应用（启动）入口文件
    ├── db   数据库存储目录
    ├── models   数据库模型文件目录
    ├── node_modules   node第三方模块目录
    ├── package-lock.json  
    ├── package.json   
    ├── public   公共文件目录（css、js、image...）
    ├── routers  路由文件目录
    ├── schemas  数据库结构文件（schema）目录
    └── views    模板试图文件目录
   ```

3. 导入并定义当前使用的模板引擎

   以下内容均写入入口文件。

   ```javascript
   var swig = require("swig");
   /**
    * 定义当前应用使用的模板引擎
    * @date 2020-07-07
    * @param {any} "html" 模板引擎的名称，同时也是模板文件的后缀
    * @param {any} swig.renderFile 用于解析处理模板内容的方法
    */
   app.engine("html", swig.renderFile);
   ```

4. 设置模板引擎存放目录

   ```javascript
   /**
    * 设置模板引擎存放目录
    * @date 2020-07-07
    * @param {any} "views" 固定 必须是views
    * @param {any} "./views" 表示目录
    */
   app.set("views", "./views");
   ```

5. 注册所使用的模板引擎

   ```javascript
   /**
    * 注册所使用的模板引擎
    * @date 2020-07-07
    * @param {any} "view engine" 第一个参数固定
    * @param {any} "html" 第二个参数与app.engine方法中第一个参数相同
    * @returns {any}
    */
   app.set("view engine", "html");
   ```

6. 为了防止内存影响修改模板，因此需要禁用内存

   ```javascript
   // 开发过程中取消缓存
   swig.setDefaults({ cache: false });
   ```

7. 添加一个模板文件，并在路由中将其返回

   ```javascript
   app.get("/", (req, res) => {
     /**
      * 返回文件
      * @date 2020-07-07
      * @param {any} "index" 表示views文件中所使用的文件
      * @param {any} 表示传递给模板的数据
      */
     res.render("index.html");
   });
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
       <h1>欢迎光临我的博客!!!</h1>
   </body>
   
   </html>
   ```

   ![image-20200707200844156](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/07/63fdbf7ce80a288e1ece0731d4fefd9b.png)
   
8. 静态文件托管

   ```javascript
   app.use("/public", express.static("public")); //设置托管静态资源文件
   ```

   那么在HTML页面只需要`/public/js/jquery.min.js`即可引入`public`文件中的文件。

   第一个参数默认为`/`

9. 划分模块

   ```javascript
   // TAG 根据不同功能划分模块
   app.use("/admin", require("./routers/admin"));
   app.use("/api", require("./routers/api"));
   app.use("/", require("./routers/main"));
   ```

   在`app.js`中划分好模块后，接下来就是在路由文件里新建`admin.js`、`api.js`、`main.js`三个文件。并在三个文件中写入基本内容后，即可通过地址查看。

   ```javascript
   var express = require("express");
   
   var router = express.Router();
   
   router.get("/user", (req, res, next) => {
     res.send("API - User");
   });
   module.exports = router;
   ```

   ![image-20200708101735061](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/8b7df02c18fb650830209920a91d60d5.png)

10. 定义数据库结构

    1. 安装MongoDB
    
    2. 链接数据库
    
       ```javascript
       mongoose.connect("mongodb://localhost:27018/blog", function (err) {
         if (err) {
           console.log("链接失败");
         } else {
           console.log("链接成功");
           app.listen(port, () =>
             console.log(`Server running at  http://127.0.0.1:${port}`)
           );
         }
       });
       ```
    
    3. 定义Schema
    
       ```javascript
       var mongoose = require("mongoose");
       // 用户的表结构
       
       module.exports = new mongoose.Schema({
         // 用户名
         username: String,
         // 密码
         password: String,
       });
       
       ```
    
    4. 定义module
    
       ```javascript
       var mongoose = require("mongoose");
       // 用户的表结构
       
       var userSchema = require("../schemas/user");
       
       module.exports = mongoose.model("User", userSchema);
       ```
    
       




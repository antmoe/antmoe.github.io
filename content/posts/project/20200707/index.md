---
title: NodeJs博客系统开发
date: 2020-07-07T19:52:50+08:00
categories: ["project"]
---

<div class="btns rounded grid5"><a href="https://gitee.com/antmoe/project/tree/master/2020/07/blog" title="下载源码"><i class="fa fa-download"></i> 下载源码</a></div>

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
    
       

## 注册接口

1. 用户注册时请求注册接口
   - 判断账号密码是否合法
   - 判断用户是否存在
2. 根据判断做出相应的相应

```javascript
router.post("/user/register", (req, res, next) => {
    let { username, password } = req.body;
    console.log(username, password);
    if (username != "" && password != "") {
        console.log(respondseData);
        // 验证用户是否被注册
        User.findOne({ username: username })
            .then((userinfo) => {
            if (userinfo) {
                // 数据库中有此数据
                respondseData.code = 4;
                respondseData.message = "用户已被注册";
                console.log(respondseData);
            } else {
                // 数据库中无此数据
                var user = new User({
                    username: username,
                    password: password,
                });
                respondseData.code = 200;
                respondseData.message = "注册成功";
                return user.save();
            }
        })
            .then((newUserInfo) => {
            res.send(respondseData);
            console.log(newUserInfo);
        });
    } else {
        respondseData.message = "你输入的内容似乎不对哦！";
        res.send(respondseData);
    }
});
```

## 登陆接口及Cookie保存

1. 判断用户名及密码是否符合规范
2. 判断数据库是否存在这个用户以及密码是否一致
3. 登陆后，保存Cookie

主程序`app.js`

```javascript
app.use(function (req, res, next) {
  req.cookies = new Cookies(req, res);
  if (req.cookies.get("userInfo")) {
    req.userinfo = JSON.parse(req.cookies.get("userInfo"));
    try {
      // 获取当前登陆用户的类型，是否是管理员
      User.findById(req.userinfo._id).then(function (userInfo) {
        req.userinfo.isAdmin = userInfo.isAdmin;
        next();
      });
    } catch (e) {
      req.userinfo = {};
      next();
    }
  } else {
    next();
  }
});
```

用户表结构`schema`

```javascript
var mongoose = require("mongoose");
// 用户的表结构

module.exports = new mongoose.Schema({
  // 用户名
  username: String,
  // 密码
  password: String,
  // 管理员权限
  isAdmin: { type: Boolean, default: false },
});

```

登陆接口的实现

```javascript
router.post("/user/login", (req, res) => {
  let { username, password } = req.body;
  if (username != "" && password != "") {
    // 判断数据库是否存在此用户
    User.findOne({
      username: username,
      password: password,
    }).then((userInfo) => {
      if (!userInfo) {
        // 没有合适的用户
        respondseData.message = "用户名或密码错误";
      } else {
        // 有合适的用户
        respondseData.code = 200;
        respondseData.message = "登陆成功";
        req.cookies.set(
          "userInfo",
          JSON.stringify({
            _id: userInfo._id,
            username: userInfo.username,
          })
        );
      }
      res.send(respondseData);
    });
  } else {
    respondseData.message = "你输入的好像不合法哦！";
    res.send(respondseData);
  }
});
```



## 后台开发

### 基本框架

首先我们定义一个公用模板，用于每个模块（首页等）的调用。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <title>后台管理</title>
</head>
<body>
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">后台管理</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li ><a href="/admin/user">用户管理</a></li>
                <!--<li ><a href="/admin/category">分类管理</a></li>-->
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">分类管理 <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="/admin/category">分类首页</a></li>
                        <li><a href="/admin/category/add">添加分类</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">内容管理 <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="/admin/content">内容管理首页</a></li>
                        <li><a href="/admin/content/add">添加内容</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">文章管理 <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">Action</a></li>
                        <li><a href="#">Another action</a></li>
                        <li><a href="#">Something else here</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="#">Separated link</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="#">One more separated link</a></li>
                    </ul>
                </li>
                <li><a href="#">评论</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <!--<li><a href="#">Link</a></li>-->
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">{{userinfo.username}} <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">退出</a></li>
                    </ul>
                </li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>
<div class="container-fluid">
    <!--模板中的此部分可能不同，使用block占位-->
   {% block main%} {endblock}
</div>

</body>
</html>
```

其中，`{% block main%} {endblock}`表示占位。在其他模板页面中只需要重写这个区块即可。

例如`index.html`页面。

```html
<!--layout.html是公用的模板，可以使用继承-->
{% extends 'layout.html' %}

{% block main %}
<div class="jumbotron">
    <h1>Hello, {{userinfo.username}}</h1>
    <p>欢迎进入破梨博客后台管理</p>
    <!--<p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a></p>-->
</div>
{% endblock%}
```

### 注册用户列表展示

![image-20200709184322951](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/09/e194a55c8d4f293a3dfdd68bc008844f.png)

<span class="inline-tag green">路由规则</span>

```javascript
router.get("/user", (req, res, next) => {
  var page = Number(req.query.page || 1);
  var limit = 10;
  var pages = 0;
  User.count().then((count) => {
    pages = Math.ceil(count / limit);
    page = Math.min(page, pages);
    page = Math.max(page, 1);
    console.log(page);
    var skip = (page - 1) * limit;
    User.find()
      .skip(skip)
      .limit(limit)
      .then((result) => {
        res.render("admin/user_index", {
          users: result,
          page: page,
          pages: pages,
        });
      });
  });
});
```

<span class="inline-tag green">HTML模板</span>

```html
<!--layout.html是公用的模板，可以使用继承-->
{% extends 'layout.html' %}

{% block main %}
<ol class="breadcrumb">
    <li><a href="/admin">管理首页</a></li>
    <li><a href="#">用户列表</a></li>
    <!--<li class="active">Data</li>-->
</ol>
<h3>用户列表</h3>
<table class="table table-hover table-bordered table-striped">
    <tr>
        <th>ID</th>
        <th>用户名</th>
        <th>密码</th>
        <th>管理员</th>
    </tr>

    {% for item in users%}
    <tr>
        <td>{{item._id.toString()}}</td>
        <td>{{item.username}}</td>
        <td>{{item.password}}</td>
        {% if item.isAdmin%}
        <td style="color: green;">是</td>
        {% else %}
        <td style="color: red;">否</td>
        {% endif %}
    </tr>
    {% endfor %}
</table>
<!--分页功能在page.html中，因为很多地方都会用到，所以封装成模板，调用即可-->
{% include 'page.html' %}
{% endblock%}
```

分页模板

```html
<nav aria-label="Page navigation">
    <ul class="pager">
        <li class="previous"><a href="/admin/user?page={{page-1}}"><span aria-hidden="true">&larr;</span> 上一页</a></li>
        <!--<li>一共{{pages}}页,当前第{{page}}页</li>-->
        <li class="next"><a href="/admin/user?page={{page+1}}">下一页 <span aria-hidden="true">&rarr;</span></a></li>
        <li>一共{{pages}}页,当前第{{page}}页</li>
    </ul>
</nav>
```

### 分类

1. 首页

   用于展示所有分类，为每个分类设置删除与修改的功能。以及将最新添加的分类按照索引降序将其排列。

   ```javascript
   router.get("/category", (req, res, next) => {
     var page = Number(req.query.page || 1);
     var limit = 10;
     var pages = 0;
     Categories.count().then((count) => {
       pages = Math.ceil(count / limit);
       page = Math.min(page, pages);
       page = Math.max(page, 1);
       console.log(page);
       var skip = (page - 1) * limit;
       Categories.find()
         .sort({ _id: -1 })
         .skip(skip)
         .limit(limit)
         .then((result) => {
           res.render("admin/category_index", {
             categories: result,
             page: page,
             pages: pages,
           });
         });
     });
   });
   ```

   

2. 修改分类

   须判断修改的分类是否存在。

   ```javascript
   // 添加分类页面
   router.get("/category/add", (req, res, next) => {
       res.render("admin/category_add", {
           userinfo: req.userinfo,
       });
   });
   // 分类保存
   router.post("/category/add", (req, res, next) => {
       let { name } = req.body || null;
       if (name == "") {
           console.log("分类名称必须填写");
           res.render("admin/error", {
               userinfo: req.userinfo,
               message: "分类名称必须填写",
           });
       } else {
           Categories.findOne({
               name: name,
           })
               .then(function (rs) {
               if (rs) {
                   res.render("admin/error", {
                       userinfo: req.userinfo,
                       message: "分类已经存在",
                   });
                   return Promise.reject();
               } else {
                   return new Categories({
                       name: name,
                   }).save();
               }
           })
               .then(function (newCategory) {
               res.render("admin/success", {
                   userinfo: req.userinfo,
                   message: "分类保存成功",
                   url: "/admin/category",
               });
           });
       }
   });
   // 分类修改页面
   router.get("/category/edit", function (req, res) {
       var id = req.query.id || "";
       Categories.findOne({ _id: id }).then(function (category) {
           console.log(category);
           if (!category) {
               res.render("admin/error", {
                   userinfo: req.userinfo,
                   message: "此分类不存在",
               });
           } else {
               res.render("admin/category_edit", {
                   userinfo: req.userinfo,
                   message: category.name,
               });
           }
       });
   });
   router.post("/category/edit", function (req, res) {
       var id = req.query.id || "";
       var name = req.body.name || "";
       Categories.findOne({ _id: id })
           .then(function (category) {
           if (!category) {
               res.render("admin/error", {
                   userinfo: req.userinfo,
                   message: "此分类不存在",
               });
               return Promise.reject();
           } else {
               // 是否存在此数据
               if (name == category.name) {
                   res.render("admin/success", {
                       userinfo: req.userinfo,
                       message: "修改成功",
                       url: "/admin/category",
                   });
                   return Promise.reject();
               } else {
                   return Categories.findOne({
                       _id: { $ne: id },
                       name: name,
                   });
               }
           }
       })
           .then(function (sameCategory) {
           if (sameCategory) {
               res.render("admin/error", {
                   userinfo: req.userinfo,
                   message: "分类已存在！",
               });
               return Promise.reject();
           } else {
               return Categories.update(
                   {
                       _id: id,
                   },
                   { name: name }
               );
           }
       })
           .then(function () {
           res.render("admin/success", {
               userinfo: req.userinfo,
               message: "修改成功",
               url: "/admin/category",
           });
       });
   });
   ```

   

3. 删除分类 

   直接删除即可

   ```javascript
   // 分类删除
   router.get("/category/delete", function (req, res) {
     var id = req.query.id || "";
     Categories.remove({
       _id: id,
     }).then(function () {
       res.render("admin/success", {
         userinfo: req.userinfo,
         message: "删除成功",
         url: "/admin/category",
       });
     });
   });
   ```

   

### 文章

1. 文章模型的创建

   - 模型

     ```javascript
     var mongoose = require("mongoose");
     // 用户的表结构
     
     var contentSchema = require("../schemas/content");
     
     module.exports = mongoose.model("Content", contentSchema);
     ```

   - schema

     ```javascript
     var mongoose = require("mongoose");
     // 用户的表结构
     
     module.exports = new mongoose.Schema({
       // 关联字段
       category: {
         // 类型
         type: mongoose.Schema.Types.ObjectId,
         // 引用另一张表的模型
         ref: "categories",
       },
       // 关联字段
       user: {
         // 类型
         type: mongoose.Schema.Types.ObjectId,
         // 引用另一张表的模型
         ref: "User",
       },
       // 添加时间
       addTime: {
         type: Date,
         default: new Date(),
       },
       // 阅读数量
       views: {
         type: Number,
         default: 0,
       },
       // 用户名
       title: String,
       // 简介
       description: {
         type: String,
         default: "",
       },
       content: {
         type: String,
         default: "",
       },
     });
     
     ```

2. 添加文章

   ```javascript
   router.post("/content/add", function (req, res) {
     if (req.body.category == "") {
       res.render("admin/error", {
         userinfo: req.userinfo,
         message: "分类不能为空",
       });
       return;
     }
     // 保存到数据库
     console.log(req.userinfo);
     new Content({
       category: req.body.category,
       title: req.body.title,
       description: req.body.description,
       content: req.body.content,
       user: req.userinfo._id,
     })
       .save()
       .then(function () {
         res.render("admin/success", {
           userinfo: req.userinfo,
           message: "内容保存成功",
         });
       });
   });
   
   ```

3. 显示文章

   ```javascript
   router.get("/content", function (req, res) {
     var page = Number(req.query.page || 1);
     var limit = 10;
     var pages = 0;
     Content.count().then((count) => {
       pages = Math.ceil(count / limit);
       page = Math.min(page, pages);
       page = Math.max(page, 1);
       console.log(page);
       var skip = (page - 1) * limit;
       Content.find()
         .sort({ _id: -1 })
         .skip(skip)
         .limit(limit)
         .populate(["category", "user"])
         .then((result) => {
           res.render("admin/content_index", {
             userinfo: req.userinfo,
             page: page,
             pages: pages,
             contents: result,
             user: req.userinfo,
           });
         });
     });
   });
   ```

   

### 首页

```javascript
router.get("/", (req, res, next) => {
  var data = {
    page: Number(req.query.page || 1),
    limit: 10,
    pages: 1,
    userinfo: req.userinfo,
    navinfo: [],
    count: 0,
  };
  console.log(req.userinfo);
  Categories.find()
    .then(function (result) {
      data.navinfo = result;
      return Content.count();
    })
    .then(function (count) {
      data.count = count;
      pages = Math.ceil(data.count / data.limit);
      page = Math.min(data.page, data.pages);
      page = Math.max(data.page, 1);
      var skip = (data.page - 1) * data.limit;
      return Content.find()
        .limit(data.limit)
        .skip(skip)
        .populate(["category", "user"])
        .sort({ _id: -1 });
    })

    .then(function (contents) {
      data.contents = contents;
      console.log(data);
      navinfo = data.navinfo;
      res.render("main/index", data);
    });
});
```

### 评论

```javascript
// 评论提交
router.post("/comment", function (req, res) {
  // 评论的ID
  var contentid = req.body.contentid || "";
  var postData = {
    username: req.userinfo.username,
    postTime: new Date(),
    content: req.body.content,
  };
  Content.findOne({
    _id: contentid,
  })
    .then(function (content) {
      console.log(content);
      content.comments.push(postData);
      return content.save();
    })
    .then(function (newContent) {
      respondseData.data = newContent;
      res.send(respondseData);
    });
});
router.get("/comment", function (req, res) {
  // 评论的ID
  var contentid = req.query.contentid || "";
  Content.findOne({
    _id: contentid,
  }).then(function (newContent) {
    respondseData.data = newContent;
    res.send(respondseData);
  });
});
```


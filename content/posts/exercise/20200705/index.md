---
title: 九、英雄管理系统
date: 2020-07-05T22:16:50+08:00
categories: ["exercise"]
---

## 准备

### mysql-ithm的使用

- 安装`npm i mysql-ithm`

- 使用

  参照文档即可。

- 简单示例

  ```javascript
  // 导入模块
  const hm = require("mysql-ithm");
  
  //2.连接数据库
  //如果数据库存在则连接，不存在则会自动创建数据库
  hm.connect({
    host: "localhost", //数据库地址
    port: "3306",
    user: "root", //用户名，没有可不填
    password: "root", //密码，没有可不填
    database: "cqmanager502", //数据库名称
  });
  
  //3.创建Model(表格模型：负责增删改查)
  //如果table表格存在则连接，不存在则自动创建
  let herotModel = hm.model("hero", {
    heroName: String,
    heroSkill: String,
  });
  
  //4.调用API：添加数据
  // herotModel.insert(
  //   { heroName: "张三10", heroSkill: "吃吃吃" },
  //   (err, results) => {
  //     console.log(err);
  //     console.log(results);
  //     if (!err) console.log("增加成功");
  //   }
  // );
  
  // 批量增加
  var arr = [
    { heroName: "张三10", heroSkill: "吃吃吃" },
    { heroName: "张三11", heroSkill: "吃吃吃" },
    { heroName: "张三12", heroSkill: "吃吃吃" },
  ];
  
  herotModel.insert(arr, (err, results) => {
    console.log(err);
    console.log(results);
    if (!err) console.log("增加成功");
  });
  
  ```

### 抓包入口

1. 发起两个请求

   只需要实例化第二个请求，在第一个请求中使用`crawler.queue`方法即可。

   ```javascript
   var c = new Crawler({
       maxConnections: 10,
       callback: function (error, res, done) {
           if (error) {
               console.log(error);
           } else {
               var $ = res.$;
               JSON.parse(res.body).forEach((v) => {
                   xq.queue(`https://pvp.qq.com/web201605/herodetail/${v.ename}.shtml`);
               });
           }
           done();
       },
   });
   c.queue("https://pvp.qq.com/web201605/js/herolist.json");
   
   // 创建一个详情实例
   var xq = new Crawler({
       maxConnections: 10,
       callback: function (error, res, done) {
           if (error) {
               console.log(error);
           } else {
               var $ = res.$;
               //   console.log($(".cover-name").text(), $(".skill-name>b").first().text());
               //   console.log("https:" + $(".ico-play").prev("img").attr("src"));
               heroes.push({
                   heroName: $(".cover-name").text(),
                   heroSkill: $(".skill-name>b").first().text(),
                   heroIcon: "https:" + $(".ico-play").prev("img").attr("src"),
                   isDelete: false,
               });
           }
           done();
       },
   });
   ```

2. 入库

   应等待所有请求完成后在进行入库操作。

   ```javascript
   xq.on("drain", function () {
       heroModel.insert(heroes, (err, results) => {
           if (!err) console.log("增加成功");
       });
   });
   ```

3. 完整代码

   ```javascript
   var Crawler = require("crawler");
   var hm = require("mysql-ithm");
   
   // 创建一个获取全部英雄的实例
   var c = new Crawler({
       maxConnections: 10,
       callback: function (error, res, done) {
           if (error) {
               console.log(error);
           } else {
               var $ = res.$;
               JSON.parse(res.body).forEach((v) => {
                   xq.queue(`https://pvp.qq.com/web201605/herodetail/${v.ename}.shtml`);
               });
           }
           done();
       },
   });
   c.queue("https://pvp.qq.com/web201605/js/herolist.json");
   
   // 声明一个数组 用于存放所有英雄
   var heroes = [];
   // 创建一个详情实例
   var xq = new Crawler({
       maxConnections: 10,
       callback: function (error, res, done) {
           if (error) {
               console.log(error);
           } else {
               var $ = res.$;
               //   console.log($(".cover-name").text(), $(".skill-name>b").first().text());
               //   console.log("https:" + $(".ico-play").prev("img").attr("src"));
               heroes.push({
                   heroName: $(".cover-name").text(),
                   heroSkill: $(".skill-name>b").first().text(),
                   heroIcon: "https:" + $(".ico-play").prev("img").attr("src"),
                   isDelete: false,
               });
           }
           done();
       },
   });
   // 等待所有请求全部做完之后，入库
   xq.on("drain", function () {
       heroModel.insert(heroes, (err, results) => {
           console.log(err);
           console.log(results);
           if (!err) console.log("增加成功");
       });
   });
   
   hm.connect({
       host: "localhost", //数据库地址
       port: "3306",
       user: "root", //用户名，没有可不填
       password: "root", //密码，没有可不填
       database: "cqmanager", //数据库名称
   });
   
   //3.创建Model(表格模型：负责增删改查)
   //如果table表格存在则连接，不存在则自动创建
   let heroModel = hm.model("hero", {
       heroName: String,
       heroSkill: String,
       heroIcon: String,
       isDelete: String,
   });
   
   ```

   ![image-20200704214218195](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/04/a1a0f9242a003b4339858c1938a2881e.png)

## 项目服务端

### API接口

|   接口名称   |       URL        | 请求方式 |            请求参数             |        返回值        |
| :----------: | :--------------: | :------: | :-----------------------------: | :------------------: |
| 查询英雄列表 |   `/hero/list`   |   GET    | {search:英雄名称}。不传返回所有 |  [heros:{英雄列表}]  |
| 查询英雄详情 |   `/hero/info`   |   GET    |           {id:英雄id}           |   {data:英雄详情}    |
|   编辑英雄   |  `/hero/update`  |   POST   |      {name,skill,icon,id}       |      {code:200}      |
|   删除英雄   |  `/hero/delete`  |   POST   |              {id}               |      {code:200}      |
|   新增英雄   |   `/hero/add`    |   POST   |        {name,skill,icon}        |      {code:200}      |
|    验证码    |    `/captcha`    |   GET    |               无                |      验证码图片      |
|   用户注册   | `/user/register` |   POST   | {username,password,code:验证码} | {code:200\|401\|402} |
|   用户登录   |  `/user/login`   |   POST   |       {username,password}       | {code:200\|401\|402} |
|   退出登录   |    `/logout`     |   GET    |               无                |          无          |

### 后端基本架构

```javascript
// 1. 导包
const express = require("express");

// 2. 创建服务器
const app = express();
// 3. 托管静态资源
app.use(express.static("www"));
// 4. 配置中间件

// 5. 写接口
// 5.1 查询英雄列表（没有删除的）
app.get("/hero/list", (req, res) => {
  res.send("sb");
});
// 5.2 查询英雄的详情（编辑的第一步：根据ID查询，显示到编辑页）
app.get("/hero/info", (req, res) => {
  res.send("sb");
});
// 5.3 编辑英雄（）
app.post("/hero/update", (res, req) => {
  res.send("sb");
});
// 5.4 删除英雄（软删除，实际上修改的是当前id的英雄isDelete为true）
app.post("/hero/delete", (res, req) => {
  res.send("sb");
});
// 5.5 新增英雄
app.post("/hero/add", (res, req) => {
  res.send("sb");
});
// 5.6 验证码
app.get("/captcha", (req, res) => {
  res.send("sb");
});
// 5.7 用户注册
app.post("/user/register", (res, req) => {
  res.send("sb");
});
// 5.8 用户登录
app.post("/user/login", (res, req) => {
  res.send("sb");
});
// 5.9 退出登录
app.get("/logout", (req, res) => {
  res.send("sb");
});
// 6. 开启服务器
const port = 3000;
app.listen(port, () =>
  console.log(`Server running at  http://127.0.0.1:${port}`)
);
```

### 查询英雄列表

<div class="snote idea yellow"><p>简单分析</p></div>

1. 考虑是否传入了参数

   - 传入参数

     模糊查询参数内容

   - 没有传入参数

     查询全部数据

<span class="inline-tag green">此接口代码</span>

```javascript
// 5.1 查询英雄列表（没有删除的）
app.get("/hero/list", (req, res) => {
    let { search } = req.query;
    console.log(search);
    if (!search) {
        // 没有查询参数 -- 查询所有的英雄
        heroModel.find('isDelete="false"', (err, results) => {
            if (err) {
                res.send({
                    code: 500,
                    msg: "服务器错误" + err,
                });
            } else {
                res.send({
                    code: 200,
                    heros: results,
                });
            }
        });
    } else {
        // 用户参数了参数 -- 查询包含search的英雄
        // 模糊查询
        heroModel.find(
            `heroName like "%${search}%" and isDelete="false"`,
            (err, results) => {
                if (err) {
                    res.send({
                        code: 500,
                        msg: "服务器错误" + err,
                    });
                } else {
                    res.send({
                        code: 200,
                        heros: results,
                    });
                }
            }
        );
    }
});
```

### 新增英雄

<div class="snote idea yellow"><p>简单分析</p></div>

1. 由于英雄是有头像的，因此接收参数需要用到`multer`模块

   其余参数可使用`req.body`接收。

2. 将其插入到数据库

   需要对`isDelete`设置默认值。

<span class="inline-tag green">此接口代码</span>

```javascript
app.post("/hero/add", upload.single("heroIcon"), (req, res) => {
    let { heroName, heroSkill, isDelete = "false" } = req.body;
    let heroIcon = req.file.filename;
    heroModel.insert(
        { heroName, heroSkill, heroIcon, isDelete },
        (err, results) => {
            if (err) {
                res.send({
                    code: 500,
                    msg: "服务器内部错误" + err,
                });
            } else {
                res.send({
                    code: 200,
                    msg: "新增成功",
                });
            }
        }
    );
});
```

## 项目客户端

### 首页

<div class="snote idea yellow"><p>简单分析</p></div>

1. 进入页面

   - 首先发送Ajax请求全部数据，然后渲染到页面

2. 点击查询按钮

   查询数据框内的内容

<span class="inline-tag blue">效果展示</span>

![image-20200705210722274](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/05/28ce41a41c07343cecf8580d7143717d.png)

<span class="inline-tag green">核心代码</span>

```html
<!-- 创建模板 -->
<script id="cq" type="text/html">
  {{ each heros v }}
  <tr>
      <td>{{ v.heroName }}</td>
      <td>{{ v.heroSkill }}</td>
      <td><img src="{{ v.heroIcon }}" alt="" /></td>
      <td>
        <button class="btn btn-success btn-edit" onclick='location.href="./update.html?id={{v.id}}"'>编辑🍞</button>
        <button class="btn btn-danger btn-delete" data-id='{{v.id}}'>删除👍</button>
      </td>
    </tr>
    {{ /each }}

</script>

<script>
  $.ajax({
    type: 'get',
    url: '/hero/list',
    success: function (backData) {
      if (backData.code == 200) {
        var resHtml = template('cq', backData)
        $('tbody').html(resHtml)
      }
    }
  });
  // 二、英雄名包含关键词的英雄
  $('#searchBtn').on('click', function (e) {
    e.preventDefault()
    let search = $('#search').val().trim()
    $.ajax({
      type: 'get',
      url: '/hero/list',
      data: {
        search
      },
      success: function (backData) {
        if (backData.heros.length == 0) {
          $('tbody').html('没有数据')
          return
        }
        if (backData.code == 200) {
          var resHtml = template('cq', backData)
          $('tbody').html(resHtml)
        }
      }
    });
  })
</script>
```

### 新增页面

<div class="snote idea yellow"><p>简单分析</p></div>

1. 点击新增按钮，跳转新增页面
2. 输入英雄昵称、技能与头像后点击提交
3. 将输入内容新增，并且跳回首页

<span class="inline-tag blue">效果展示</span>

![image-20200705220105972](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/05/d9f5e47d7f68a43cd0407eb682f32378.png)

<span class="inline-tag green">核心代码</span>

```html
<script>
    $(function () {
        // 1. 图片预览
        $('#heroIcon').on('change', function () {
            // 1. 获取用户选择的图片
            var file = this.files[0]
            // 2. 创建一个url
            var url = URL.createObjectURL(file)
            // 3. 把url赋值给与滥用的img的src属性
            $('.preview').attr('src', url)
        })
        // 2. 完成新增
        $('.btn-add').on('click', function (e) {
            e.preventDefault()
            var fd = new FormData(document.querySelector('form'))
            $.ajax({
                type: 'post',
                url: '/hero/add',
                data: fd,
                contentType: false,
                processData: false,
                success: function (backData) {
                    if (backData.code == 200) {
                        alert('新增成功')
                        window.location.href = '/'
                    }
                }
            })
        })
    })
</script>
```


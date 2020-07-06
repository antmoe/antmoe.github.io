---
title: 九、英雄管理系统
date: 2020-07-05T22:16:50+08:00
categories: ["exercise"]
---

<a href="https://gitee.com/antmoe/project/tree/master/2020/07/cqmanager" title="查看源代码"><i class="fa fa-book"></i> 查看源代码</a>

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
app.post("/hero/update", (req, res) => {
  res.send("sb");
});
// 5.4 删除英雄（软删除，实际上修改的是当前id的英雄isDelete为true）
app.post("/hero/delete", (req, res) => {
  res.send("sb");
});
// 5.5 新增英雄
app.post("/hero/add", (req, res) => {
  res.send("sb");
});
// 5.6 验证码
app.get("/captcha", (req, res) => {
  res.send("sb");
});
// 5.7 用户注册
app.post("/user/register", (req, res) => {
  res.send("sb");
});
// 5.8 用户登录
app.post("/user/login", (req, res) => {
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

### 根据ID查询英雄

<div class="snote idea yellow"><p>简单分析</p></div>

1. 接收到传来的id，然后根据此ID进行查询

2. 为了防止恶意查询，应设置所查询的ID字段没有被删除

   - 没有错误，且有数据

     返回该数据

   - 有错误

     返回错误信息

   - 无错误，但没有英雄

     返回提示

<span class="inline-tag green">此接口代码</span>

```javascript
app.get("/hero/info", (req, res) => {
    // a. 接收传递过来的英雄ID
    let { id } = req.query;
    // b.根据id查询英雄的详细信息
    heroModel.find(`id=${id} and isDelete="false"`, (err, results) => {
        if (err == null && results.length != 0) {
            res.send({
                code: 200,
                data: results[0],
            });
        } else if (err) {
            res.send({
                code: 500,
                mgs: "服务器内部错误" + err,
            });
        } else {
            res.send({
                code: 201,
                mgs: "没有此英雄，或已被删除！",
            });
        }
    });
});
```

### 编辑英雄

<div class="snote idea yellow"><p>简单分析</p></div>

1. 根据前端传来的参数，判断是否传入了图片
2. 根据ID进行对应的修改

<span class="inline-tag green">此接口代码</span>

```javascript
app.post("/hero/update", upload.single("heroIcon"), (req, res) => {
    let { id, heroName, heroSkill } = req.body;
    let obj = {
        heroName,
        heroSkill,
    };
    if (req.file != undefined) {
        // 传递了文件参数
        obj.heroIcon = req.file.filename;
    }
    heroModel.update(`id=${id}`, obj, (err, results) => {
        if (err) {
            res.send({
                code: 500,
                msg: "服务器内部错误" + err,
            });
        } else {
            res.send({
                code: 200,
                msg: "修改成功",
            });
        }
    });
});
```

### 英雄删除

<div class="snote idea yellow"><p>简单分析</p></div>

1. 接收传来的ID
2. 软删除，而不是真的删除

<span class="inline-tag green">此接口代码</span>

```javascript
app.post("/hero/delete", (req, res) => {
    let = { id } = req.body;
    hm.update(`id=${id}`, { isDelete: "true" }, function (err, results) {
        if (err) {
            res.send({
                code: 500,
                msg: "服务器内部错误" + err,
            });
        } else {
            res.send({
                code: 200,
                msg: "删除成功",
            });
        }
    });
});
```

### 生成验证码

<div class="snote idea yellow"><p>简单分析</p></div>

1. 安装插件`svg-captcha`
2. 验证码实际返回的是一个svg的图片
3. ![image-20200706144000041](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/06/d65f49902e0dea8b7a9a98d2ffb94daa.png)

<span class="inline-tag green">此接口代码</span>

```javascript
const svgCaptcha = require("svg-captcha"); //验证码插件
app.get("/captcha", (req, res) => {
  // 创建一个验证码
  var captcha = svgCaptcha.create();
  // 返回验证码
  res.type("svg");
  res.status(200).send(captcha.data);
});
```

### 注册用户

<div class="snote idea yellow"><p>简单分析</p></div>

1. 建立一个表格，用于存放用户信息

2. 进入路由逻辑后，首先判断验证码是否正确

   可以通过一个变量接收验证码的值

3. 当验证码正确时，应首先验证数据库无此用户，然后在进行逻辑处理

```javascript
app.post("/user/register", (req, res) => {
    let { username, password, code } = req.body;
    console.log(username, password, code);
    if (code.toLocaleLowerCase() != captchaCode.toLocaleLowerCase()) {
        res.send({
            code: 402,
            msg: "验证码错误",
        });
    } else {
        userModel.find(`username="${username}"`, (err, results) => {
            if (err) {
                res.send({
                    code: 500,
                    msg: "服务器内部错误",
                });
            } else {
                if (results.length > 0) {
                    // 用户名是否存在
                    res.send({
                        code: 401,
                        msg: "用户已存在",
                    });
                } else {
                    userModel.insert(
                        {
                            username,
                            password,
                        },
                        (err, results) => {
                            // 注册时的错误判断
                            if (err) {
                                res.send({
                                    code: 500,
                                    msg: "服务器内部错误",
                                });
                            } else {
                                res.send({
                                    code: 200,
                                    msg: "注册成功",
                                });
                            }
                        }
                    );
                }
            }
        });
    }
});
```

### 用户登录

<div class="snote idea yellow"><p>简单分析</p></div>

1. 只需要查询用户名与密码匹配的数据即可

<span class="inline-tag green">核心代码</span>

```javascript
app.post("/user/login", (req, res) => {
    let { username, password } = req.body;
    userModel.find(
        `username="${username}" and password="${password}"`,
        (err, results) => {
            if (err) {
                res.send({
                    code: 500,
                    msg: "服务器内部错误" + err,
                });
            } else {
                if (results.length > 0) {
                    res.send({
                        code: 200,
                        msg: "登录成功",
                    });
                } else {
                    res.send({
                        code: 401,
                        msg: "账号或密码错误",
                    });
                }
            }
        }
    );
});
```



### 加入Cookie登录验证

cookie使用`cookie-session`可以使用模块。

```javascript
const cookieSession = require("cookie-session");
app.use(
  cookieSession({
    name: "session",
    keys: ["123", "456", "xiaokang"],
    maxAge: 24 * 69 * 60 * 1000, // 过期事件 24小时过期
  })
);
```

由于多个页面都是需要判断用户是否登陆，因此需要单独写一个接口，用于判断用户有没有登陆。

```javascript
app.get("/isLogin", (req, res) => {
  // 如果没有登录，
  res.send(req.session.user);
});
```

当用户登陆后会返回一个设定的值，否则返回空字符串。

### 退出登陆

<div class="snote idea yellow"><p>简单分析</p></div>

1. 退出登陆即删除cookie

<span class="inline-tag green">核心代码</span>

```javascript
app.get("/logout", (req, res) => {
  req.session = null;
  res.writeHead(302, {
    Location: "login.html",
  });
  res.end();
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

### 根据ID查询英雄（编辑第一步）

<div class="snote idea yellow"><p>简单分析</p></div>

1. 根据id查询英雄是放在编辑页面展示，也就是说进入编辑页首先发送Ajax请求，获取英雄的信息

<span class="inline-tag blue">效果展示</span>

![image-20200706095041953](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/06/558a7467e2c557978508de811ebf6007.png)

<span class="inline-tag green">核心代码</span>

```html
<script>
    $(function () {
        //  一、根据ID发送Ajax请求，获取详细信息 并显示在页面标签上 
        var id = window.location.search.split('=')[1]
        $.ajax({
            url: '/hero/info',
            type: 'get',
            data: { id },
            success: function (backData) {
                if (backData.code == 200) {
                    $('#id').val(id)
                    $('#name').val(backData.data.heroName)
                    $('#skill').val(backData.data.heroSkill)
                    $('#iconImg').attr('src', backData.data.heroIcon)
                }
            }
        })

    })
</script>
```

### 编辑英雄

<div class="snote idea yellow"><p>简单分析</p></div>

1. 与新增英雄较为类似，获取formData数据后提交即可

<span class="inline-tag green">核心代码</span>

```javascript
// 图片预览
$('#heroIcon').on('change', function () {
    var file = this.files[0]
    var url = URL.createObjectURL(file)
    $('#iconImg').attr('src', url)
})
// 保存按钮事件
$('.btn-save').on('click', function (e) {
    e.preventDefault()
    var fd = new FormData(document.querySelector('form'))
    $.ajax({
        type: 'post',
        url: '/hero/update',
        contentType: false,
        processData: false,
        data: fd,
        success: function (backData) {
            if (backData.code == 200) {
                alert('编辑成功')
                window.location.href = '/'
            }
        }
    })
})
```

### 删除英雄

<div class="snote idea yellow"><p>简单分析</p></div>

1. 点击按钮后，发送POST请求即可

<span class="inline-tag green">核心代码</span>

```javascript
app.post("/hero/delete", (req, res) => {
  let = { id } = req.body;
  heroModel.update(`id=${id}`, { isDelete: "true" }, function (err, results) {
    if (err) {
      res.send({
        code: 500,
        msg: "服务器内部错误" + err,
      });
    } else {
      res.send({
        code: 200,
        msg: "删除成功",
      });
    }
  });
});
```

### 显示验证码

<div class="snote idea yellow"><p>简单分析</p></div>

1. 只需要将图片的路径设置为验证码接口即可
2. 但需要注意的是`img`标签有缓存，如果路径相同则不发送请求。
3. 因此解决这个问题只需要在请求时加入一个随机参数即可，而参数值使用随机数即可

<span class="inline-tag blue">效果展示</span>

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/06/0f6f36fecaa303a5099592b2e69990af.png)

<span class="inline-tag green">核心代码</span>

```html
<script>
    $(function () {
        $('.vCode').on('click', function () {
            $(this).attr('src', '/captcha?xc=' + Math.random())
        })
    })
</script>
```

### 注册用户

<div class="snote idea yellow"><p>简单分析</p></div>

1. 获取输入框的内容，发送Ajax请求即可。
2. 但是发送的密码是明文，因此需要进行加密处理（MD5）

<span class="inline-tag blue">效果展示</span>

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/06/287d5080872565cac4f7016f391d7293.png)

<span class="inline-tag green">核心代码</span>

```javascript
$('.register').on('click', function (e) {
    e.preventDefault()
    let username = $('#username').val().trim()
    $('#password').val(md5($('#password').val().trim(), 'yingyingguaiguai'))
    let password = $('#password').val().trim()
    let code = $('#code').val().trim()
    $.ajax({
        type: 'post',
        url: '/user/register',
        data: { username, password, code },
        success: function (backData) {
            if (backData.code == 200) {
                alert(backData.msg);
                window.location.href = '/'
            } else {
                alert(backData.msg)
            }
        }
    })
})
```

### 用户登录

<div class="snote idea yellow"><p>简单分析</p></div>

1. 获取输入框的内容，发送Ajax请求即可。
2. 但是发送的密码是明文，因此需要进行加密处理（MD5）

<span class="inline-tag blue">效果展示</span>

<span class="inline-tag green">核心代码</span>

```javascript
$(function () {
    $('.login').on('click', function (e) {
        e.preventDefault()
        let username = $('#username').val().trim()
        $('#password').val(md5($('#password').val().trim(), 'yingyingguaiguai'))
        let password = $('#password').val().trim()
        $.ajax({
            type: "post",
            url: '/user/login',
            data: { username, password },
            success: function (backData) {
                if (backData.code == 200) {
                    window.location.href = '/'
                } else {
                    alert(backData.msg)
                }
            }
        })
    })
})
```

### 判断是否登陆

<div class="snote idea yellow"><p>简单分析</p></div>

1. 因为已经存在了一个接口用于判断是否登陆，因此在页面加载后**自动发送**请求判断是否登陆即可。

<span class="inline-tag green">核心代码</span>

```html
<script>
    (function () {
        $.ajax({
            type: 'get',
            url: '/isLogin',
            success: function (backData) {
                if (backData == '') {
                    alert('没有登陆')
                    window.location.href = '/login.html'
                }
            }
        })
    })()
</script>
```

## 涉及概念

### COOKIE工作流程

![image-20200706170117094](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/06/71af4a34e6b0d56635fa0dd13c91da9a.png)

<span class="inline-tag green">一个简单的演示</span>

```javascript
const express = require("express");

const app = express();

app.get("/login", (req, res) => {
  res.writeHead(200, {
    "Content-Type": "text/plain;charset=utf-8",
    "Set-Cookie": "userid=123456",
  });
  res.end();
});

// 查询接口

app.get("/list", (req, res) => {
  // 接收cookie
  console.log(req.headers);
  res.send("sb");
});
app.listen(8086, () => {
  console.log("服务器已开启");
});

```

![image-20200706171922538](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/06/971adc1c7504e65f8d14154da7d3892a.png)


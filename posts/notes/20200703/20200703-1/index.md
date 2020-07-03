# 四、node服务器搭建


## 什么是端口

一台电脑可以部署多个服务器，根据端口不同找到不同的服务器。

默认的`http`端口为80端口。

## web服务器读取网页并返回

1. 使用`http`模块开启一个服务器
2. 在服务器内部读取文件，将读取到的字符串内容作为服务器的响应返回

```javascript
const http = require("http");
const fs = require("fs");
const path = require("path");
const server = http.createServer((req, res) => {
  // 拼接路径
  const filePath = path.join(__dirname, "index.html");
  fs.readFile(filePath, "utf-8", (err, data) => {
    if (err == null) {
      // 返回页面
      res.end(data);
    } else {
      res.end(err);
    }
  });
});
server.listen(8080, () => {
  console.log("成功开启");
});

```

![image-20200702165449844](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/02/214ec8ef92eb390dc0bb515f897249de.png)

## 静态服务器的实现

<span class="inline-tag green">静态服务器的流程</span>

1. 浏览器向服务器发起请求

2. 服务器查询受否存在这个文件

   - 存在

     返回

   - 不存在

     返回默认404页面

<span class="inline-tag green">静态服务器的实现</span>

静态服务器实现与读取网页返回几乎一致，通过`request.url`可以获取用户访问的路径。

```javascript
const http = require("http");
const fs = require("fs");
const path = require("path");
const server = http.createServer((req, res) => {
  // 得到用户请求的是哪一个页面
  console.log(req.url); // /pica.jpg
  var filePath = path.join(__dirname, "static", req.url);
  // 服务器存在嗅探功能，根据请求资源名字，能够得知请求类型。因此编码参数可以省略
  fs.readFile(filePath, (err, data) => {
    if (err == null) {
      res.end(data);
    } else {
      res.end(path.join(__dirname, "static", "404.html"));
    }
  });
});

server.listen(8080, () => {
  console.log("成功开启:http://127.0.0.1:8080");
});

```

![image-20200702174739374](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/02/89c40aaacb09a8adf0eafa16cec4c9b5.png)



## 接收前端传来的get参数

get参数是与url拼接在一起的，因此可以使用`url.parse`方法解析字符串。

```javascript
const http = require("http");
// 处理url
const url = require("url");

const server = http.createServer((req, res) => {
  //   res.end(req.url);
  /**
   * url.parse 解析通过get传来的参数
   * @param {string} req.url 待解析的url
   * @param {boolean} true 如果为true则返回一个对象
   * @returns {Object}
   */
  let urlObj = url.parse(req.url, true);
  console.log(urlObj.query);
  res.end(JSON.stringify(urlObj.query));
});
server.listen(8080, () => {
  console.log("成功开启");
});

```

![image-20200702210042663](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/02/d1aa88347140f7b71e49a0ca30e9b739.png)

## 接收前端传来的post参数

接收post数据需要为请求体注册`data`事件与`end`事件。前者表示接收数据，回调函数内参数传入数据，函数体处理数据；后者表示接收完数据后调用的回调函数。

处理接收的数据使用`querystring.parse`可以将接收的数据转换为对象形式。

```javascript
const http = require("http");
const querystring = require("querystring");
const server = http.createServer((req, res) => {
  let postData = "";
  // 时间处理程序，参数是传递过来的数据
  req.on("data", (chunk) => {
    postData += chunk;
  });
  req.on("end", () => {
    console.log(postData); //name=123&passwd=haha
    // 解析传来的参数数据
    let postObj = querystring.parse(postData); //{ name: '123', passwd: 'haha' }
    console.log(postObj);
  });
  res.end("sb");
});
server.listen(8080, () => {
  console.log("成功开启");
});

```

## GET与POST的区别

|          |        GET         |          POST           |
| :------: | :----------------: | :---------------------: |
|   传值   |    通过url传值     | 通过请求体(querystring) |
| 数据大小 |      相对较少      |        将对较大         |
|  安全性  |      相对较低      |        相对较高         |
| 一般用途 | 请求数据、获取数据 |        提交数据         |



## 爬虫示例

> 使用第三方模块的步骤：
>
> 1. 新建一个文件夹（非中文且不能与模块名相同）
>
> 2. `npm init -y` 进行初始化
>
> 3. 下载模块
>
>    可以到npm官网搜索
>
> 4. 使用模块
>
>    参照模块说明文档 

1. 爬取丁香园的body数据

   ```javascript
   const fs = require("fs");
   var Crawler = require("crawler");
   
   var c = new Crawler({
     maxConnections: 10,
     callback: function (err, res, done) {
       if (err) {
         console.log(err);
       } else {
         var $ = res.$;
         fs.writeFile("./temp/1.txt", $("body").text(), (err) => {
           if (err == null) {
             console.log("成功");
           }
         });
       }
       done();
     },
   });
   
   c.queue("https://ncov.dxy.cn/ncovh5/view/pneumonia");
   
   ```

2. 爬取一张图片

   ```javascript
   var Crawler = require("crawler");
   var fs = require("fs");
   
   var c = new Crawler({
     encoding: null,
     jQuery: false, // set false to suppress warning message.
     callback: function (err, res, done) {
       if (err) {
         console.error(err.stack);
       } else {
         fs.createWriteStream(res.options.filename).write(res.body);
       }
   
       done();
     },
   });
   
   c.queue({
     uri: "https://ae01.alicdn.com/kf/H21b5f6b8496141a1979a33666e1074d9x.jpg",
     filename: "./temp/test.jpg",
   });
   
   ```

   

## npm命令的使用

1. 安装当前目录下的项目所需要的所有依赖包`npm install`

2. 如果下载过程中卡住，可以使用`npm cache clean -f`清除缓存

3. 使用淘宝镜像

   参考地址：[https://developer.aliyun.com/mirror/NPM?from=tnpm](https://developer.aliyun.com/mirror/NPM?from=tnpm)

### pakeage与pakeage-lock的区别

1. 使用npm5之前的版本，是不会生成`package-lock.json`这个文件的。
2. npm5以后，包括npm5这个版本，才会生成`package-lock.json`文件
3. 当使用npm安装包的时候，npm都会生成或書更新`package-lock.json`文件

   - npm5以后的版本，在安装包的时候，不需要加`--save(s)`参数，也会自动在`package.json`中保存依项
   - 当安装包的时候，会自动创建或更新`package-jock.json`文件
   - `package-lock.json`文件内保存了`node_modules`：中所有包的信息，包含这些包的名称、版本号、下地址。带来好处是，如果重新`npm install`的时候，就无逐个分析包的依赖项，因比会大大加快安装速度
   - 从`package-lock.json`文件名来看，Iock代表的是"锁定"的意思。它用来物定当前开发使用的版本号，防止`npm install`的时侯自动更新到了更新版本。因为新版本有可能会更新老的API,导数之前的代码出错
   - 原来的`package.json`文件只能定大版本，也就是版本号的第一位，并不能定后面的小版本，你每次`npm install`都是拉取的该大版本下的最新的版本，为了稳定性考虑我们几手是不敢随意升级依包的，这将导数多出来很多工作量，测试/适配等，所以`package-lock.json`文件出来了，当你每次安装一个依赖的候就定在你安装的这个版本。

## 使用express模块

GET与POST传参：

- GET传参--接收参数

  只需要在请求体内直接通过`request.query`即可取到传参对象

- POST参数--接收参数

  需要导入`body-parser`模块，首先对url进行转码，然后在请求体内可以通过`request.body`获取传参对象

### 创建一个简单的服务器

```javascript
const express = require("express");
// 创建服务器
const app = express();

// 创建路由
app.get("/", (req, res) => {
  // 注意 使用express模块创建服务器，使用send作为相应
  res.send("Hello World!你好啊");
});
// 监听接口
app.listen(3000, () => {
  console.log(`Server running at  http://127.0.0.1:3000`);
});

```

### 创建一个静态资源服务器

创建静态资源可以设置静态目录`app.use(express.static("PATH"));`

```javascript
const express = require("express");
// 创建服务器
const app = express();
// 设置静态目录
app.use(express.static("static"));
// 创建路由
app.get("/", (req, res) => {
  // 注意 使用express模块创建服务器，使用send作为相应
  res.send("Hello World!你好啊");
});
// 监听接口
app.listen(3000, () => {
  console.log(`Server running at  http://127.0.0.1:3000`);
});

```

## 实现一个简单的get接口

```javascript
const express = require("express");

const app = express();

/**
 * 得到随机笑话
 * @date 2020-07-03
 * @param {string} "/joke" 请求地址
 * @param {function} (req,res) 请求与相应
 */
app.get("/joke", (req, res) => {
  let arr = ["第一个笑话", "第二个笑话", "第三个笑话"];
  let index = Math.floor(Math.random() * 3);
  res.send(arr[index]);
});

app.listen(3000);

```

## 返回JSON

返回json直接返回一个对象即可。

```javascript
const express = require("express");

const app = express();

app.get("/food", (req, res) => {
  let arr = ["第一个笑话", "第二个笑话", "第三个笑话"];
  let index = Math.floor(Math.random() * 3);
  res.send({
    foodName: arr[index],
    price: 100,
    desc: "这是一个描述",
  });
});

app.listen(3000);

```

## 实现一个带有参数的GET接口

通过`req.query`可以获取传输的参数对象，然后取到具体的内容。

```javascript
const express = require("express");

const app = express();

app.get("/getNickName", (req, res) => {
  // 接收参数
  let heroName = req.query.heroName;
  console.log(heroName);
  let heroNickName = "";
  let hero = {
    提莫: "迅捷斥候",
    李青: "盲僧",
    盖伦: "德玛西亚之力",
    亚索: "疾风剑豪",
  };
  if (hero[heroName] != undefined) {
    heroNickName = hero[heroName];
  } else {
    heroNickName = "暂无这个英雄的资料";
  }
  res.send(heroNickName);
});

app.listen(3000);

```

## 实现简单的POST接口

```javascript
const express = require("express");

const app = express();
// 只需要将方式改为post即可
app.post("/sb", (req, res) => {
  res.send("sb");
});

app.listen(3000);

```

## 带参数的POST接口

在post请求中，无法使用`req.query`拿到请求的数据。所以拿到数据需要使用第三方模块`body-parser`模块。

1. 将请求体解析

   `app.use(bodyParser.urlencoded({ exrtended: false }));`

2. 通过`req.body`拿到请求的数据

   ![image-20200703115616895](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/03/9eef160ae826c6731f06a0a6ebc34b3d.png)

```javascript
const express = require("express");
const bodyParser = require("body-parser");

const app = express();
// 将请求体的数据解析
app.use(bodyParser.urlencoded({ exrtended: false }));
app.post("/login", (req, res) => {
  console.log(req.body);
  if (req.body.name == "123" && req.body.passwd == "123") {
    res.send("登录成功");
  } else {
    res.send("登录失败");
  }
});

app.listen(3000);

```

## 返回是json格式字符串的接口

使用`express`模块返回字符串默认为`text/html`格式，设置响应头后即可返回json格式的字符串。

```javascript
const express = require("express");

const app = express();

app.get("/getFood", (req, res) => {
  res.setHeader("Content-Type", "text/json");
  res.send(
    `foodName:"红烧肉",
        price:100`
  );
});
app.listen(3000, () => {
  console.log("服务器已开启");
});

```

![image-20200703142458941](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/03/34d5ea9ba2520823a3bb712f3c8a6fa1.png)

## POST传文件参数

post接收文件参数需要使用`multer`模块，然后将传过来的文件放在此模块创建的文件夹下。

请求第二个可选参数为接收文件的键值。通过`req.file`获取文件信息，通过`req.body`获取一同传输的文本信息。

```javascript
const express = require("express");
const multer = require("multer");

const app = express();
// 创建一个uploads文件夹
var upload = multer({ dest: "uploads/" });
app.post("/register", upload.single("usericon"), (req, res) => {
  // 传过来的文件，参数名用usericon
  // 一起传过来的文本信息保存在req.body中
  console.log(req.file);
  console.log(req.body);
  res.send("sb");
});

app.listen(3000);

```

![image-20200703145224424](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/03/881cf8064a4f7f838f7233ebbfc96b05.png)

![image-20200703145231408](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/03/58fcddebca5dade3ffd41cdf7e0fece4.png)

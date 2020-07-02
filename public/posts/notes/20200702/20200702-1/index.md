# 三、NodeJs模块化


## 内置模块的基本使用(删除文件)

```javascript
const fs = require("fs");

/**
 * 删除文件
 * @param {string} "./temp/test.txt" 被删除文件的路径
 * @param {function} (err) 回调函数，将错误信息传入其中
 */
fs.unlink("./temp/test.txt", (err) => {
  if (err) throw err;
  console.log("已成功删除 test");
});

```

## fs模块读文件

```javascript
const fs = require("fs");

/**
 * 读取文件信息
 * @date 2020-07-01
 * @param {sting} "./temp/t.txt" 文件路径
 * @param {sting} "utf-8" 指定字符编码
 * @param {function} (err,data) 回调函数传入错误信息与读到的数据
 */
fs.readFile("./temp/t.txt", "utf-8", (err, data) => {
  if (err) throw err;
  console.log(data);
});

```

## fs模块写文件

如果没有文件夹那么会抛出错误，但是没有文件则会自动创建文件。如果已经存在，则会覆盖。

```javascript
const fs = require("fs");

const data1 = `
这是一个测试
`;

/**
 * 写文件
 * @param {any} "./temp/1.txt" 待写入文件的路径
 * @param {any} data 待写入的数据
 * @param {function} err 回调函数传入错误类型
 */
fs.writeFile("./temp/1.txt", data1, (err) => {
  if (err) throw err;
  console.log("文件已保存");
});

```

## 同步异步

- 同步

  所谓同步也就是按顺序执行

- 异步

  同时执行，谁先做完谁输出。不会造成阻塞。

![image-20200701195212126](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/0c4f04a1fd8566424151175391463743.png)

1. 面试题-1

   ```javascript
   var t = true;
   windows.setTimeout(function () {
     t = false;
   }, 1000);
   while (t) {}
   console.log("end");
   ```

   以上代码会无限循环，因为定时器是异步执行。则先进入循环，一旦进入，那么就会发生无限循环。

2. 面试题-2

   ```javascript
   var t = true;
   while (t) {
     windows.setTimeout(function () {
       t = false;
     }, 1000);
   }
   console.log("end");
   ```

   以上代码还是会死循环。计时器虽然已经声明了，但计时器的回调函数无法被执行。

## 相对路径的问题

### 路径问题

NodeJs中的相对路径是相对于执行js文件的终端工具路径而言。

```javascript
const fs = require("fs");

fs.readFile("./temp/1.txt", "utf-8", (err, data) => {
  if (err == null) {
    console.log(data);
  } else {
    console.log(err);
  }
});
```

![image-20200702082329200](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/02/fb9014d72d0c3783fb0cd661fd22a8d6.png)

### 和路径相关的变量

- 获取当前文件所在目录

  `__dirname`

- 获取当前文件的绝对路径

  `__filename`

以上两个变量不需要定义即可使用。

```javascript
console.log(__dirname);
// d:\coder\studyCode\project\2020\07\02
console.log(__filename);
// d:\coder\studyCode\project\2020\07\02\06-路径相关的变量.js
```

![image-20200702082907423](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/02/b5cb1151e53e9ad1dafc74cac59be08b.png)

因此要读取的文件可以使用此变量进行拼接。

```javascript
const fs = require("fs");
console.log(__dirname);
console.log(__filename);
fs.readFile(__dirname + "/temp/1.txt", "utf-8", (err, data) => {
  if (err == null) {
    console.log(data);
  } else {
    console.log(err);
  }
});
```

## path模块

为了避免出现少写斜杠（`\`）的错误出现。

1. `join`路径拼接方法

   `path.join()`方法使用平台特定的分隔符作为定界符将所有给定的 `path` 片段连接在一起，然后规范化生成的路径。

   ```javascript
   const path = require("path");
   const fs = require("fs");
   
   const fullPath = path.join(__dirname, "temp", "1.txt");
   
   console.log(fullPath);
   fs.readFile(fullPath, "utf-8", (err, data) => {
     if (err == null) {
       console.log(data);
     } else {
       console.log(err);
     }
   });
   ```

   ![image-20200702084332456](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/02/07321281d1f1bdf30b6d19f565d7b578.png)

## http模块

<span class="inline-tag green">创建一个简单的本地服务器</span>

```javascript
const http = require("http");

// 创建服务器
// 返回值代表服务器
const server = http.createServer((request, response) => {
  response.end("Hello World");
});

// 开启服务器
server.listen(8080, () => {
  console.log("服务器已经开启：8080");
});
```

![image-20200702085231673](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/02/4a4c12cbbf6d597e84e6ae114b9b53a2.png)

<span class="inline-tag green">中文乱码问题</span>

解决中文乱码须在响应头设置`Content-Type`

```javascript
const http = require("http");

// 创建服务器
// 返回值代表服务器
const server = http.createServer((request, response) => {
    // 设置响应头，防止中文乱码
    response.setHeader("Content-Type", "text/html;charset=utf-8");
    response.end("你好，世界");
});

// 开启服务器
server.listen(8080, () => {
    console.log("服务器已经开启：8080");
});
```

## nodemon工具

此工具作用为自动监视文件的修改，自动重新运行。

- 安装

  `npm install nodemon -g`

- 使用

  `nodemon 文件名`

![115c2d23-7812-4cf5-94c1-d763c77f2b5c](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/02/8c54f6893621507696490eab7ab903b8.png)



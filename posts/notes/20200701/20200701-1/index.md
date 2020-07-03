# 一、Node.js入门


## 什么是NodeJs

NodeJs是一个基于谷歌V8引擎的运行环境。(服务器上的v8引擎就是node.js)

其作用是让js拥有开发服务端的功能

## 环境安装

官方地址：https://nodejs.org/zh-cn/

安装完成后，添加环境变量。命令行终端输入`node -v`即可输出版本号。

![image-20200701111152975](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/afee4dfef4d6a54dc0ee5e8f4c5edf43.png)

同样的，安装完NodeJs之后会自动安装`npm`（node package manager）。输入`npm -v`也会出现版本号。

![image-20200701111435443](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/c6f4ac7aa04d2f6110a675f9425a5fd2.png)

> npm可以到[NPM](https://npmjs.com)去寻找包，类似GitHub。





## 运行NodeJs

1. VSCode中使用RunCoder插件

   ![image-20200701112340004](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/65d0458b70f4ef3872a8b4905ec3c748.png)

2. 终端

   ![image-20200701112451290](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/5a45fb80c77a9f7a626cda7c27934100.png)

   注意路径问题，执行命令为`node 文件名`

   > VSCode中的终端同理。

3. 双击node.exe，在其内编写代码

   ![image-20200701112716027](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/08e37e87d2615b89f9244b5748b09334.png)

   

## 服务器端与浏览器端

服务端的JavaScript只有ECMAScript，也就意味着在NodeJs

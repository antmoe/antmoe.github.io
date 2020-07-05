# 八、NPM包管理


## 如何写NodeJs模块

1. 遵守`commentjs`规范。
   - 导入模块
   - 暴露出去（导出）

一个简单的示例：

```javascript
// 定义一个对象
let db = {
    baseUrl: "http://127.0.0.1:3000/",
    insert: function () {
        console.log("插入方法");
    },
    delete: function () {
        console.log("删除方法");
    },
};
// 将其暴露出去
module.exports = db;

```

在我们的模块中定义一个对象，并将其暴露出去。接下来在我们自己的js文件中去使用这个对象。

```javascript
const myMoudle = require("./01-自己写的模块.js");
myMoudle.insert();
```

![image-20200704183311332](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/04/de8a6bdc4269e1ce19b64d7ece3abe1b.png)

## 写一个自己的模块

## NPM发布包

1. 进入待发布的目录，然后初始化目录`npm init`。并依次填入**包名**、**版本**、**描述**等信息。如果没有可以跳过（回车）。

   ![image-20200704190840715](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/04/01bcf2340ef6ec6fe11f55c924418d22.png)

2. 注册NPM账号

   - 官方网址注册（推荐）
   - 使用`npm adduser`命令注册

3. 登录账号`npm login`

   ![image-20200704192929433](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/04/5639ebeb64cdbdf9ae9146e15fb45a12.png)

   - 如果使用了淘宝镜像须切换回官方源`npm config set registry https://registry.npmjs.org/`

4. 发布包`npm publish `

   ![image-20200704192323418](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/04/275bc71b9abafecfa2134fe776b957d9.png)

   ![image-20200704193040051](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/04/0a4b8a9c78bfd5e8a82a85f4facf5b10.png)

   - 包名不能重复
   - 需要注意配置文件的`main`字段指定的为主文件。
   - 如果使用了淘宝镜像须切换回官方源`npm config set registry https://registry.npmjs.org/`

5. 更新包

   - 修改版本

   - 重新发布

     ![image-20200704193537648](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/04/a88a21c91730fa74b2bc821ab9ba77ce.png)

6. 教程参考

   - https://blog.csdn.net/taoerchun/article/details/82531549







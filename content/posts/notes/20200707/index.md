---
title: 十、Promise的使用
date: 2020-07-07T16:17:50+08:00
categories: ["notes"]
tags: ["Node"]
---

## Promise用来做什么

用来解决回调地狱。回调地狱也就是回调函数中嵌套了回调函数，代码阅读性低。

例如如下代码：

```javascript
const fs = require("fs");

// 读A文件
fs.readFile(`${__dirname}/etc/a.txt`, "utf-8", (err, data) => {
  if (err) {
    console.log(err);
  } else {
    console.log(data);
    // 读B文件
    fs.readFile(`${__dirname}/etc/b.txt`, "utf-8", (err, data) => {
      if (err) {
        console.log(err);
      } else {
        console.log(data);
        // 读C文件
        fs.readFile(`${__dirname}/etc/c.txt`, "utf-8", (err, data) => {
          if (err) {
            console.log(err);
          } else {
            console.log(data);
          }
        });
      }
    });
  }
});

```

在读完A文件后读取B文件在读取C文件。

![image-20200707090321049](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/07/19608e387583ca9eb926fc4792c34ef3.png)

## Promise工作流程

`Promise`对象是一个构造函数，用来生成`Promise`实例。`Promise`构造函数接收一个函数作为参数。这个参数的函数又有两个参数，这两个参数分别是`resolve`和`reject`。这两个参数也是函数，由JavaScript引擎提供。

- 异步操作成功后调用`resolve()`方法，他内部调用了`then()`里面的第一个参数函数。
- 异步操作失败后调用`reject()`方法，他内部调用了`then()`里面的第二个参数函数。

```javascript
const fs = require("fs");

let p = new Promise((resolve, reject) => {
  // 读文件
  fs.readFile(`${__dirname}/etc/a.txt`, "utf-8", (err, data) => {
    if (!err) {
      // 读取成功
      resolve(data); // 调用此方法
    } else {
      // 读取失败
      reject(err); // 调用此方法
    }
  });
});
p.then(
  (data) => {
    console.log(data);
  },
  (err) => {
    console.log(err);
  }
);

```

![image-20200707094503084](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/07/871481f2f06bcafdfa186469f83a737e.png)

## Promise原理

`Promise`对象代表一个异步操作，有三种状态：`pending`（进行中）、`fulfilled`（已成功）和`rejected`（已失败）。

只有异步操作的结果，可以决定当前是哪一种状态，任何其他操作都无法改变这个状态。

`Promise`对象的状态改变，只有两种可能：

- 异步操作成功

  从`pending`变为`fulfilled`

- 异步操作失败

  从`pending`变为`rejected`

## Promise对象的特点以及封装

1. 特点

   创建`Promise`对象后立即执行。

   ```javascript
   const fs = require("fs");
   
   let p = new Promise((resolve, reject) => {
     console.log("promise - test");
   
     // 读文件
     fs.readFile(`${__dirname}/etc/a.txt`, "utf-8", (err, data) => {
       if (!err) {
         // 读取成功
         resolve(data); // 调用此方法
       } else {
         // 读取失败
         reject(err); // 调用此方法
       }
     });
   });
   p.then(
     (data) => {
       console.log(data);
     },
     (err) => {
       console.log(err);
     }
   );
   console.log("promise end- test");
   
   ```

   ![image-20200707100938748](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/07/e8e352869b656d65eb2ed76cdeea226b.png)

   **因此不要在Promise里面写其他的代码，只写异步操作即可。**

2. 封装

   ```javascript
   const fs = require("fs");
   
   function getPromise(fileName) {
     return new Promise((resolve, reject) => {
       // 读文件
       fs.readFile(`${__dirname}/etc/${fileName}.txt`, "utf-8", (err, data) => {
         if (!err) {
           // 读取成功
           resolve(data); // 调用此方法
         } else {
           // 读取失败
           reject(err); // 调用此方法
         }
       });
     });
   }
   
   getPromise("a").then(
     (data) => {
       console.log(data);
     },
     (err) => {
       console.log(err);
     }
   );
   
   ```

## 解决回调地狱

让异步操作的本质实际上就是在异步操作成功后的回调函数里返回另外的`Promise`，在执行另一个`then`方法。

```javascript
const fs = require("fs");

function getPromise(fileName) {
  return new Promise((resolve, reject) => {
    // 读文件
    fs.readFile(`${__dirname}/etc/${fileName}.txt`, "utf-8", (err, data) => {
      if (!err) {
        // 读取成功
        resolve(data); // 调用此方法
      } else {
        // 读取失败
        reject(err); // 调用此方法
      }
    });
  });
}

getPromise("a")
  .then((data) => {
    console.log(data);
    return getPromise("b");
  })
  .then((data) => {
    console.log(data);
    return getPromise("c");
  })
  .then((data) => {
    console.log(data);
  });

```

![image-20200707105821182](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/07/273640b33de907b43652c418a4c174c3.png)

## Ajax也会返回Promise对象

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://cdn.jsdelivr.net/npm/jquery@latest/dist/jquery.min.js"></script>
</head>

<body>
    <button id="btn">点我看笑话</button>
    <script>
        $('#btn').on('click', function () {
            $.ajax({
                type: 'get',
                url: 'https://v1.hitokoto.cn/?a=g&encode=json',
            }).then((backData) => {
                console.log(backData.hitokoto);
            }, (err) => {
                console.log(err);
            })
        })
    </script>
</body>

</html>
```

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/07/2008d589fa61fc9acb78857992bde1e8.png)

## catch()方法

此方法能够抓取错误，在最后一个`then()`方法后边在加一个`catch`方法。无论哪一个出错都会抓取到错误。

```javascript
getPromise("a")
    .then((data) => {
    console.log(data);
    return getPromise("b");
})
    .then((data) => {
    console.log(data);
    return getPromise("c1");
})
    .then((data) => {
    console.log(data);
})
    .catch((err) => {
    console.log(err);
});
```

![image-20200707111755743](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/07/7a6c96194960b5690874f4d850a06ad1.png)

## all()方法

`Promise.all()`方法用于将多个 Promise 实例，包装成一个新的 Promise 实例。



```javascript
let p1 = getPromise("a");
let p2 = getPromise("b");
let p3 = getPromise("c");

let pAll = Promise.all([p1, p2, p3]);

pAll.then((data) => {
  console.log(data);
});

```

![image-20200707112639684](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/07/e986c10648de9ef592a2384e3b9d3562.png)



> 此方法要求每一个小的`Promise`都要成功，只要有一个失败都会导致整个的`Promise`错误。
>
> ![image-20200707112725643](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/07/dfca850be646ecedb82f7fd84dbe428f.png)

## race()方法

`Promise.race()`方法同样是将多个 Promise 实例，包装成一个新的 Promise 实例。

此方法与`all`方法的区别是只要有一个成功即成功。

```javascript
let p1 = getPromise("a");
let p2 = getPromise("b");
let p3 = getPromise("c");

let pRace = Promise.race([p1, p2, p3]);

pRace.then((data) => {
  console.log(data);
});

```

![image-20200707113048187](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/07/ac27defdb887beca959123f6adf38445.png)

## Module的语法

使用模块的好处

1. 避免变量污染，命名冲突
2. 提供代码的复用率、维护性
3. 依赖关系管理

- `export`命令：用于规定模块对外的接口
  1. 外部能够读取模块内部的某个变量、函数、类
  2. 使用as关键字重命名
  3. 该命令可以出现在模块的任何位置，只要用于模块顶层即可。除了块作用域内
- `import`命令：用于输入其他模块提供的功能
  1. 变量、函数
  2. 使用as关键字
  3. 输入的变量都是只读的
  4. import命令具有提升效果

> 注意：module是静态导入，因此不能使用表达式和变量那些运行时才能知道的结果的变量。

<span class="inline-tag blue">通过`export`导出</span>

1. 导出变量

   - 逐个导出

     ```javascript
     export let name = "张三";
     export let age = 12;
     ```

   - 批量导出

     ```javascript
     let name = "张三";
     let age = 23;
     export { name, age };
     ```

2. 导出函数

   - 逐个导出

     ```javascript
     export function addFn(a, b) {
       console.log(a + b);
     }
     ```

   - 批量导出

     ```javascript
     function addFn1(a, b) {
       console.log(a + b);
     }
     function addFn2(a, b) {
       console.log(a + b);
     }
     export { addFn1, addFn2 };
     ```

<span class="inline-tag blue">通过`import`导入</span>

导入的变量只能读不能修改。

1. 导入变量

   - 直接导入

     ```javascript
     import { name, age } from "./09-export.js";
     ```

   - 设置别名导入

     ```javascript
     import { name as myName, age } from "./09-export.js";
     ```

2. 导入对象

   对象中的属性可以修改。

   ```javascript
   import { obj } from "./09-export.js";
   console.log(obj);
   obj.age = 78;
   console.log(obj);
   ```

   ![image-20200707152151224](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/07/3595e2568a3c24e90ac9ba6700d9be1a.png)



<span class="inline-tag blue">`HTML`引入模块</span>

在HTML引入

```html
<script type="module" src="./10-import.js"></script>
```

浏览器加载 ES6 模块，也使用`<script>`标签，但是要加入`type="module"`属性。

### 其他用法

1. 整体加载

   ```javascript
   import * as obj from "./export.js";
   console.log("fn1", obj.fn1(5));
   console.log("fn1", obj.fn2(5));
   ```

2. 默认导入

   正常输出导入时，要加`{}`。默认输出，导入时不要加`{}`

   一个模块中只能由一个`export default`

   ```javascript
   export default function () {
     console.log("temp");
   }
   ```

   ```javascript
   import myfn from "./export.js";
   ```

### 复合写法

![image-20200707155326059](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/07/34d26352f5e3e77668b308ff512b7fc2.png)

在上面的三个文件中，`import.js`需要使用`export.hs`中的变量，而`export.js`又需要使用`public.js`中的变量。此时可以使用复合写法。

<span class="inline-tag red">public.js</span>

```javascript
export let number1 = 10;
```

<span class="inline-tag red">export.js</span>

```javascript
// 导入public.js的number1变量
// 继续导出给 import.js 使用
// 复合写法
export { number1 } from "./public.js";
```

<span class="inline-tag red">import.js</span>

```javascript
import { number1 } from "./export.js";

console.log(number1);
```


# 严格模式（一）


## 概述

### 严格模式是什么

严格模式是Javascript中的一种限制性更强的変种方式。严格模式不是一个子集：它在语义上与正常代码有着明显的差异。

不支持严格模式的刘览器与支持严格模式的浏览器行为上也不一样，所以不要在未经严格模式特性测试情况下使用严格模式。

严格模式可以与非严格模式共存，所以脚本可以逐渐的选择性加入严格模式。

### 严格模式的目的

首先，严格模式会将Javascript陷阱直接变成明显的错误。

其次，严格模式修正了一些引擎难以优化的错误：同样的代码有些时候严格模式会比非严格模式下更快

第三，严格模式禁用了一些有可能在未来版本中定义的语法。

## 开启严格模式

### 全局开启严格模式

只需要在全局写以下字符串即可。作用于全局作用域

```javascript
"use strict";
a = 100;
console.log(a);
```



### 函数开启严格模式

在函数内写以下字符串即可。只作用于函数作用域。例如：

```javascript
function fn() {
  "use strict";
  v = 200;
  console.log(v);
}
```



## 变量

### 禁止意外创建变量

1. 非严格模式

   在函数作用域中定义变量，不适用var关键字那么自动将其提升为全局变量。例如：

   ```javascript
   function fn() {
     w = 200;
     console.log(w); //200
   }
   fn();
   console.log(w); //200
   ```

2. 严格模式下

   在严格模式下则会抛出异常

   ```javascript
   "use strict";
   function fn() {
     // 在函数作用域中定义变量 - 不适用var关键字-> 自动将其提升为全局变量
     w = 200;
     console.log(w); 
   }
   fn();
   console.log(w); 
   // v = 100;
   //   ^
   
   ```

   

### 静默失败转为异常

所谓静默失败就是既不报错也没有任何效果，例如改变常量的值。在严格模式下，静默失败会转换成抛出异常。

例如：

```javascript
// 定义一个常量
const v = 3.14;

// 重新赋值
v = 1.14;
console.log(v);

```

以上代码在稍微老一点的浏览器可能并不会报错（新版报错），但开启严格模式后，一定会报错。

### 禁止delete关键字

在严格模式下不能对变量使用`delete`运算符。

例如：

```javascript
var v = 100;

console.log(v); //100

delete v;
console.log(v); //100

```

1. 严格模式下会抛出一个错误
2. 非严格模式下会输出两个100

<div class="snote idea yellow"><p>严格模式下禁用delete只针对删除变量，而不是数组元素和对象属性。</p></div>

```javascript
"use strict";
var arr = [0, 1, 2, 3, 4];
delete arr[0];
console.log(arr); //[ <1 empty item>, 1, 2, 3, 4 ]

var obj = {
  name: "张无忌",
};
delete obj.name;
console.log(obj.name); // undefined
```



### 对变量名的限制

在严格模式下，JavaScript对变量名也有限制。特别不能使用如下内容作为变量名：

- `implements`
- `interface`
- `let`
- `package`
- `private`
- `protected`
- `public`
- `static`
- `yield`

上述关键词表示在ECMAScript的下一个版本中可能会用到他们，在严格模式下使用以上字符作为变量名会导致语法错误。

## 对象

### 不可删除的属性

```javascript
"use strict";
delete Object.prototype;
console.log(Object.prototype);
// 报错
```

非严格模式下不会报错，但也不会删除成功。但在严格模式下会直接抛出错误。

但严格模式并不会限制所有对象，例如：

```javascript
"use strict";
delete Math.random;
console.log(Math.random); //undefined
Math.random();

```

即使在严格模式下，还是可以删除`Math.random`方法。

### 属性名必须唯一

在严格模式下，一个对象内的所有属性名在对象内必须唯一。

```javascript
"use strict";
var obj = {
  name: "张无忌",
  name: "周芷若",
};
console.log(obj.name); // 周芷若

```

开启严格模式后，如果对象具有相同属性，那么并不会报错，而是覆盖。

![image-20200605175526975](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/05/63e0bfa2e1b452eb6ef3e5579089dc60.png)

### 只读属性的赋值

```javascript
"use strict";
var obj = {};
Object.defineProperty(obj, "age", {
  value: 18,
});
// 针对只读属性进行修改操作

obj.age = 80;
console.log(obj.age);

delete obj.age;
console.log(obj.age);

```

对于不可修改的属性，无论是修改还是删除都会发生报错。

### 不可扩展的对象

在严格模式下，不能为不可扩展的对象添加新属性。

```javascript
"use strict";
var obj = {};
// 设置对象obj是一个不可扩展的对象
Object.preventExtensions(obj);

// 为对象obj新增属性或方法

obj.name = "张无忌";
console.log(obj);

```

以上代码在严格模式下会报错，非严格模式下不会报错。

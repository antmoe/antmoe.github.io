---
title: Object对象的属性描述符的存取器
date: 2020-05-26T09:14:50+08:00
categories: ["notes"]
---

## 属性描述符的存取器

1. get

   `get`当获取或访问当前属性时，会调用此方法。

   > 类似数据描述符中的value
   >
   > - get方法在被调用时，不能传递任何参数
   >
   > - get方法在被调用时，允许传递this关键字
   >   - this - 表示当前的目标对象

   ```javascript
   var obj = {
     name: "张无忌",
   };
   Object.defineProperty(obj, "name", {
     // 获取指定的属性
     get: function () {
       // 当获取或访问当前属性时，会调用此方法
       /**
        * 类似数据描述符中的value
        * get方法在被调用时，不能传递任何参数
        * get方法在被调用时，允许传递this关键字
        *   this - 表示当前的目标对象
        */
       // return this;
       return "周芷若";
     },
   });
   console.log(obj.name); // 周芷若
   // 同样的如果只设置get，那么也是不能修改的。
   obj.name = "赵敏";
   console.log(obj.name); // 周芷若
   
   ```

2. set

   set方法用于定义当前目标函数的修改功能

   > - 该方法接收唯一的一个参数
   >
   >   作为当前目标属性的新的值
   >
   > - 通过属性修改操作指定新的值
   >
   >   作为形参对应的实参

   此方法修改值需借助一个变量，例如：

   ```javascript
   var obj = {
     name: "张无忌",
   };
   var value; //全局变量
   Object.defineProperty(obj, "name", {
     /**
      * set方法用于定义当前目标函数的修改功能
      * 该方法接收唯一的一个参数 -> 作为当前目标属性的新的值
      * 通过属性修改操作指定新的值 -> 作为形参对应的实参
      *
      */
     set: function (newvalue) {
       console.log("this is set function ");
       value = newvalue;
     },
   });
   obj.name = "赵敏";
   console.log(obj.name); //赵敏
   ```

   <div class="note warning icon"><p>需要注意的是：如果变量没有初始化获取值，那么值是undefined。</p></div>

   ```javascript
   var obj = {
     name: "张无忌",
   };
   var value; //全局变量
   Object.defineProperty(obj, "name", {
     set: function (newvalue) {
       console.log("this is set function ");
       value = newvalue;
     },
   });
   console.log(obj.name); //undefined
   ```

<div class="note success icon"><p>关于get与set的另一种常见写法</p></div>

```javascript
var obj = {
  // 存取描述符中的get
  get attr() {
    return "张三";
  },
  set attr(value) {
    console.log("setter:" + value);
  },
};
console.log(obj.attr); //张三
obj.attr = 100; //setter:100
```

这种写法中，赋值与上方一致，也是定义一个新的变量，然后赋值。此写法结果与用法与上边一致，只是写法不同。

## 防篡改对象

定义的对象默认在任何时候、任何位置，无论有意义的还是无意义的都可以修改对象的属性或方法。而这些篡改可能会影响对象的内置属性或方法，从而导致对象的正常功能可能无法使用。
Javascript在ES5版本中新増了放置纂改对象的属性或方法的机制，共提供了以下三级保护方式

- 禁止扩展

  禁止为对象扩展新的属性或方法

- 密封对象

  禁止扩展新的属性或方法，禁止配置现有的属性或方法的描述符，仅允许读写属性的值

- 冻结对象

  禁止对对象执行任何修改操作。

### 禁止扩展

禁止扩展只需要调用`Object.preventExtensions(obj)`方法即可，参数就是需要禁止的对象.

一旦设置禁止扩展,那么该对象不可新增属性或方法.

- 使用`obj.name`方法新增不会报错但无效
- 使用`Object.defineProperty`方法新增会报错.

判断对象是否可扩展使用方法`Object.isExtensible(obj)`,参数同样是需要判断的对象.

返回一个布尔值,`true`表示可被扩展,`false`表示不可被扩展.

```javascript
var obj = {};
// 将对象设置禁止扩展
Object.preventExtensions(obj);
// 新增属性或方法无效 -> 语法没有报错
obj.name = "张无忌";
// 此方法新增或修改或报错
// Cannot define property name, object is not extensible
Object.defineProperty(obj, "name", {
  value: "周芷若",
});
console.log(obj);
// 返回布尔值 true表示可扩展 false表示不可扩展
var result = Object.isExtensible(obj);
console.log(result);
```

### 密封对象

将对象进行密封调用`Object.seal(obj)`即可,参数为需要密封的对象.

一旦将对象进行了密封,那么需要注意如下:

- 不能为该对象**新增**属性或方法
- 不能修改该对象的以下属性或方法的描述符
  - `configurable`
  - `enumerable`

判断是否是密封对象`Object.isSealed(obj)`,参数同样是需要判断的对象.

返回一个布尔值,`true`表示被密封了,`false`表示没有被密封

```javascript
var obj = {
  name: "张无忌", //可修改
};

// 将该对象进行密封
Object.seal(obj);
/**
 * 将对象进行密封
 * 1. 不能为该对象新增属性或方法
 * 2. 不能修改该对象的属性或方法的描述符（configurable、enumerable）
 */
// // 新增属性
obj.age = 18;
console.log(obj); // { name: '张无忌' }
// // 修改属性
obj.name = "周芷若";
console.log(obj); //{ name: '周芷若' }

// 报错
// Object.defineProperty(obj, "age", {
//   value: 18,
// });
// 修改值
Object.defineProperty(obj, "name", {
  value: "赵敏",
  writable: false,
  //   configurable: true, //不可修改
  //   enumerable: true, //不可修改
});
console.log(obj); //{ name: '周芷若' }
obj.name = "赵敏";
console.log(obj); //{ name: '赵敏' }

```

### 冻结对象

将对象进行密封调用`Object.freeze(obj)`即可,参数为需要冻结的对象.

一旦将对象进行了冻结,那么该对象只能使用,不能做任何修改,包括删除

判断是否是密封对象`Object.isFrozen(obj)`,参数同样是需要判断的对象.

返回一个布尔值,`true`表示被冻结了,`false`表示没有被冻结

```javascript
var obj = {
  name: "张无忌",
};
// 冻结对象
Object.freeze(obj);

// 新增
obj.age = 18;
console.log(obj); //{ name: '张无忌' }
// 修改
obj.name = "周芷若";
console.log(obj); //{ name: '张无忌' }
// 删除
delete obj.name;
console.log(obj); //{ name: '张无忌' }

// 以下方法报错
// Object.defineProperty(obj, "age", {
//   value: 18,
// });
console.log(Object.isFrozen(obj));
```


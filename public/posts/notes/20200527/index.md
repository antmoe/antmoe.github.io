# Function类型（一）


# Function类型

## Function类型与函数

函数是这样的一段 Javascript代码，它只定义一次，但可能被执行或调用多次。

Function类型是 JavaScript提供的引用类型之一，通过 Function类型创建 Function对象。

在Javascript中，函数也是以对象的形式存在的。每个函数都是一个 Function对象。

函数名，本质就是一个変量名，是指向某个Function对象的引用。

**每一个函数都是一个Function类型的函数**、

```javascript
function fn() {
  console.log("this is fn function");
}
var f = function () {
  console.log("this is f function");
};

// 函数是一个对象
console.log(fn instanceof Object); //true
console.log(f instanceof Object); //true
// 函数是Function类型的对象
console.log(fn instanceof Function); //true
console.log(f instanceof Function); //true
```

![image-20200526231149385](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/05/26/d72757f809cc4a100c8f6fc83d5e5d83.png)

<div class="note default icon"><p>通过Function创建函数</p></div>

语法：`var 函数名 = new Function(args,statement);`

- `args`

  字符串类型，表示当前创建函数的形参。如果是多个形参用逗号分隔

- `statement`

  表示当前创建函数的函数体（字符串类型）。

```javascript
var fun = new Function("a,b", 'console.log("this is function "+a+" "+b)');
fun(100, 200);
```

![image-20200526231256933](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/05/26/f3d636b6c9d346e539d4bda55f749939.png)

## Function与Object

Function即是自身类型也是Object类型。Object同理。

```javascript
/**
 * Function类型时JavaScript中的引用类型之一
 * 引用类型都可以当作一个构造函数
 * 构造函数也是函数的一种
 * 构造函数是一个Function类型的对象
 * JavaScript中所有对象都是Object类型
 */
console.log(Function instanceof Function); //true
/**
 * Function类型时JavaScript中的引用类型之一
 * 引用类型都可以当作一个构造函数
 * 构造函数也是函数的一种
 * 构造函数是一个Function类型的对象
 * JavaScript中所有对象都是Object类型
 */
console.log(Function instanceof Object); //true

/**
 * Object类型是JavaScript中的引用类型之一
 * 引用类型都可以当作一个构造函数
 * 构造函数也是函数的一种
 * 构造函数是一个Function类型的对象
 */
console.log(Object instanceof Function); //true
/**
 * Object类型是JavaScript中的引用类型之一
 * 引用类型都可以当作一个构造函数
 * 构造函数也是函数的一种
 * 构造函数是一个Function类型的对象
 * JavaScript中所有对象都是Object类型
 */
console.log(Object instanceof Object); //true

```

## 自定义构造函数

构造函数又称对象模板或构造器，它的作用是<span style='color:rgb(233, 30, 100)'>创建JavaScript对象</span>。构造函数有两种，分别如下：

- JavaScript提供的构造函数 - 引用类型
- 自定义构造函数

<span class="inline-tag blue">自定义构造函数声明方式</span>

1. 函数声明方式

   ```javascript
   function Hero() {
     // 定义属性
     this.name = "张无忌";
     //  定义方法
     this.sayMe = function () {
       console.log("this is function ");
     };
   }
   ```

2. 字面量声明方式

   ```javascript
   var Hero = function (name) {
     // 定义属性
     this.name = name;
     //  定义方法
     this.sayMe = function () {
       console.log("this is function ");
     };
   };
   ```

<span class="inline-tag blue">利用构造函数创建对象</span>

创建对象的类型为声明时的函数。例如使用Hero构造函数创建对象，那么对象就是Hero类型的。

```javascript
var hero = new Hero("张无忌");
console.log(hero);
```

![image-20200527095808114](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/05/27/8b0433edeef2b18c885d6d1957295154.png)

<span class="inline-tag blue">构造函数与函数的异同点</span>

1. 相同点

   - 语法结构相同

2. 不同点

   - 函数

     函数包括函数体，而函数体里包括局部变量和函数

   - 构造函数

     构造函数包括属性和方法

## Constructor属性

![image-20200527113922102](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/05/27/c5e9c36140ec3752d20338d7ad6a0aed.png)

JavaScript中所有对象都包含一个`constructor`属性，这个属性来源于Object对象。

```javascript
// 定义一个构造函数
function Hero() {
  this.name = "张无忌";
  this.sayMe = function () {
    console.log("this is function ");
  };
}
// 使用构造函数创建对象
var hero = new Hero();
// 对象具有与构造函数相同的属性和方法
console.log(hero.name);
hero.sayMe();
// js中所有对象都是Object类型
console.log(hero.constructor);
```

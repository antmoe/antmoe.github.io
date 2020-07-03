# this关键字（一）


## 概述

### this是什么

this文键字是Javascript中最复杂的机制之ー。它是一个很特别的关键字，被自动定义在所有函数的作用域中。但是即使是非常有经验的 Javascript开发者也很难说清它到底指向什么。

实际上， Javascript中this的机制井没有那么先进，但是开发者往往会把理解过程复杂化。亳不夸张地说，不理解它的含义，大部分开发任务都无法完成。

this都有一个共同点，它总是返回一个对象。简单说，this就是属性或方法“当前”所在的对象。

### 为什么使用this

this提供了一种更优雅的方式来隐式“传递”一个对象引用，因此可以将API设计得更加简洁井且易于复用。

随着使用模式越来越复杂，显式传递上下文对象会让代码变得越来越混乱，使用this则不会这样。

### 调用位置

想要了解this的绑定过程，首先要理解调用位置：调用位置就是函数在代码中被调用的位置（而不是声明的位置）

通常来说，寻找调用位置就是寻找“函数被调用的位置”。最重要的是要分析调用栈（就是为了到达当前执行位置所调用的所有函数



1. 函数调用

   ```javascript
   var v = 100;
   // this 经常被定义在函数的作用域中
   
   function fn() {
     // this总是要返回一个对象
     console.log(this.v); //this指向哪个对象，不取决于定义的位置
   }
   // this 指向哪个对象，取决于调用的位置
   fn(); // 函数的调用  结果为：100（浏览器环境）
   
   ```

   ![this的基本用法](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/04/d7271ea03cc5144bb702a120e0b8b844.png)

2. 对象调用

   ```javascript
   var v = 100;
   // this 经常被定义在函数的作用域中
   
   function fn() {
     // this总是要返回一个对象
     console.log(this.v); //this指向哪个对象，不取决于定义的位置
   }
   
   // 定义一个对象，将fn函数作为obj对象的方法
   var obj = {
     v: 200,
     f: fn,
   };
   obj.f(); //200
   
   ```

   ![this的基本用法](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/04/3cd4fe8c69aff08e73034b1b96be3797.png)

3. 直接调用

   ```javascript
   var v = 100;
   // this 指向哪个对象，取决于调用的位置
   console.log(this.v); // 100 （浏览器环境）
   ```

   

## 绑定规则

### 默认绑定

在一个函数体中使用this，当该函数被独立调用。可以把这条规则看作是无法应用其他规则时的默认规则。

```javascript
function fn() {
  console.log(this.v); 
}
var v = 100;
fn(); //100
```

声明在全局作用域中的变量（比如`var v=100`)就是全局对象的一个同名属性。当调用`fn()`函数时，`this.v`被解析成了全局变量`v`。

函数调用时应用了this的默认绑定，因此this指向全局对象。

### 隐式绑定

隐式绑定的规则需要考虑的是调用位置是否有上下文对象，或者说是否被某个对象拥有或者包含。当然，这种说法井不准确。

```javascript
function fn() {
    console.log(this.v); 
}
var obj = {
    v: 200,
    f: fn,
};
obj.f(); //200

```

调用位置会使用obj上下文来引用函数，因此你可以说函数被调用时obj对象“拥有”或者“包含”它。

<div class='tip warning'><p>隐式丢失<p></div>

隐式丢失是最常见的this绑定问题，指的就是被隐式绑定的函数会丢失绑定对象，也就是说它会应用默认绑定，从而把this绑定到全局对象。

```javascript
// 定义一个全局变量
var v = 100;
// 定义一个函数
function fn() {
  console.log(this.v);
}
// 定义一个对象
var obj = {
  v: 200,
  f: fn, //对象的f()方法指向fn()函数
};
// 定义一个全局变量,并被赋值为对象obj的f()方法
var fun = obj.f;
// 将fun作为一个函数进行调用
fun(); //nodejs环境下为undefined；浏览器环境下是100
```

![image-20200604160728833](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/04/5414a6c123513f0d34970b8020f88ef5.png)

### 显式绑定

显式绑定就是明确在调用时，this所绑定的对象。 Javascript中提供了`apply()`方法和`call()`方法实现，这两个方法的第一个参数接收是一个对象，会把这个对象绑定到this，接着在调用函数时指定这个this。

```javascript
// 定义一个全局变量
var v = 100;
// 定义一个函数
function fn() {
  console.log(this.v);
}
// 定义一个对象
var obj = {
  v: 200,
  f: fn, //对象的f()方法指向fn()函数
};
// 定义一个全局变量,并被赋值为对象obj的f()方法
var fun = obj.f;
// 将fun作为一个函数进行调用
fun.apply(obj);

```



## 继承链

|     类别     | 备注                               |      `constructor`       |            `prototype`            |            `__poroto__`            |
| :----------: | ---------------------------------- | :----------------------: | :-------------------------------: | :--------------------------------: |
| （构造）函数 | 函数即对象                         |       指向Function       | 指向一个constructor为自身的空对象 |                                    |
|     对象     |                                    | 指向创建该对象的构造函数 |                                   | 源于创建该对象的构造函数的显式原型 |
|   Function   | 是所有构造器的源头                 |         指向自身         |     对象的constructor指向自身     |                                    |
|    Object    | `Object.prototype`是所有原型的源头 |       指向Function       | 是一个constructor指向自身的空对象 |                                    |

参考于：


![10-11](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/09/e1718f233f681dfecf4c8c1ae29a5ebd.png)

![lALPGp4a6oGudk_NA6TNA8s_971_932.png_720x720q90g](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/09/9bccd4cd9ddebeb734c21264535caef6.png)



## 面向对象的继承

1. 基于对象的原型实现

   ```
   object.__proto__ = obj
   ```

   指向一个对象

2. 基于构造函数的原型实现

   ```
   Object.prototype
   ```

   指向一个空对象

### 继承常见的几种方式

- 原型链继承: 原型与对象继承; 只继承于原型
  问题: 
  1. 实际上并不是真正的继承, 其实是多个构造函数之间共享一个对象(属性和方法)
  2. 创建子类的对象时, 不能向父级的构造函数传递任何参数。
- 原型式继承
- 借助构造函数: apply() 或 call() 方法
  问题: this 的传递
- 组合方式继承: 原型链 + 构造函数

## 面向对象

### 对象

<div class='tip' ><p>创建对象的方式<p></div>

1. 构造函数方式

   ```javascript
   var obj = new Object()
   ```

2. 直接量方式

   ```javascript
   var obj = {
     name: "lilei",
     sayMe: function () {
       console.log("this is lilei");
     }
   }
   ```

<div class='tip' ><p>构造器(constructor)<p></div>

对象的构造器都是指向创建该对象的构造函数。例如以下示例代码:

```javascript
function Foo() {}
var foo = new Foo()
```

上述示例代码中的 foo 对象的构造器就是 Foo。

<div class='tip' ><p>隐式原型(__proto__)<p></div>

对象的隐式原型与创建该对象的构造函数的显式原型是指向同一个对象。

```javascript
function Foo() {}
var foo = new Foo()

console.log(foo.__proto__ === Foo.prototype)
```

### 函数

<div class='tip' ><p>函数创建方式<p></div>

1. 直接量方式

   ```javascript
   var fun = function(){}
   ```

   与 JavaScript 中的变量是存在关系，例如以下示例代码:

   ```javascript
   var fun = function(){}
   var fun = 'this is text'
   
   console.log(fun) // 'this is text'
   ```

   上述示例代码存在覆盖问题。

2. 初始化器方式

   ```javascript
   function fun(){}
   ```

3. 构造函数方式

   ```javascript
   var fun = new Function()
   ```

   上述示例代码说明函数是一个 Function 类型的对象。

<div class='tip' ><p>函数的特性<p></div>

1. 函数可能与变量之间存在关系(直接量方式定义函数时)
2. 函数与构造函数允许同时存在的
3. 函数是一个 Function 类型的对象

<div class='tip' ><p>显式原型(prototype)<p></div>

构造函数的显式原型与利用该构造函数所创建对象的隐式原型是指向同一个对象。

<div class='tip' ><p>构造器(constructor)<p></div>

函数的构造器就是 Function。

```javascript
function fun(){}

console.log(fun.constructor === Function)
```

<div class='tip' ><p>隐式原型(__proto__)<p></div>

函数的隐式原型与 Function 的显式原型是指向同一个对象。

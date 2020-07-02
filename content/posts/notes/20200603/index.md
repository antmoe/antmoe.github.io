---
title: 原型（二）
date: 2020-06-03T09:14:50+08:00
categories: ["notes"]
---


### 自有属性与原型属性的优先级

自有属性的优先级**高**于原型属性，也就是说当原型属性与自有属性同时存在时，那么优先打印出的是自有属性。但自有属性不会覆盖原型属性，当删除自有属性时，再次访问该属性，那么会输出原型属性。

```javascript
// 定义构造函数
function Hero() {
  this.name = "张无忌";
}
// 构造函数的原型
Hero.prototype.name = "周芷若";
// 构造函数创建对象
var hero = new Hero();
// 自有属性与原型同名时，默认访问的是自有属性
// 自有属性的优先级别高于原型属性
console.log(hero.name); //张无忌
// 删除对象的属性
delete hero.name;
console.log(hero.name); //周芷若
```

### 检测自有属性与原型属性

检测自有属性有两种方式，分别为`object.hasOwnProperty(prop)`与`in`关键字。但这两种方式是有区别的。

- `object.hasOwnProperty(prop)`方式

  - 参数

    示指定属性的名称，字符串类型

  - 返回值

    - `true`

      表示**存在**指定属性是自有属性

    - `false`

      表示不存在指定的自有属性

  - 示例

    ```javascript
    function Hero() {
      this.name = "张无忌"; // 自有属性
    }
    Hero.prototype.age = 18;
    var hero = new Hero();
    /**
     * object.hasOwnProperty()
     * 作用 - 判断当前属性是否为自有属性
     *  参数
     *    prop - 表示指定属性的名称
     * 返回值
     *   true - 表示存在指定属性是自有属性
     *   false - 表示不存在指定的自有属性
     */
    console.log(hero.hasOwnProperty("name")); //true
    console.log(hero.hasOwnProperty("age")); // false
    console.log(hero.hasOwnProperty("sex")); // false
    
    
    ```

- `in`关键字

  - 返回值

    - `true`

      表示存在指定属性

    - `false`

      表示不存在指定属性

  - 示例

    ```javascript
    function Hero() {
      this.name = "张无忌"; // 自有属性
    }
    Hero.prototype.age = 18;
    var hero = new Hero();
    /**
     * 使用in关键字检测对象的属性
     * 作用 - 判断对象中是否存在指定属性（自有属性或原型属性）
     *  * 返回值
     *   true - 表示存在指定属性
     *   false - 表示不存在指定属性
     */
    console.log("name" in hero); //true
    console.log("age" in hero); //true
    console.log("sex" in hero); // false
    
    ```



### 扩展属性和方法

1. 利用*对象.属性*或方法的方式新增属性或方法

   ```javascript
   function Hero() {}
   // 1. 利用对象.属性或方法的方式新增属性或方法
   Hero.prototype.name = "张无忌";
   Hero.prototype.sayMe = function () {
       console.log("this is function");
   };
   var hero = new Hero();
   console.log(hero.name); // 张无忌
   hero.sayMe(); // this is function
   ```

2. 直接将原型重新赋值为一个新对象

   ```javascript
   function Hero() {}
   // 2. 直接将原型重新赋值为一个新对象
   Hero.prototype = {
       name: "张无忌",
       sayMe: function () {
           console.log("this is function");
       },
   };
   var hero = new Hero();
   console.log(hero.name); // 张无忌
   hero.sayMe(); // this is function
   ```

3. 二者区别

   第一种是相当于在原有的基础上扩充，而第二种会直接将内存指向改为一个新对象，如果原来新增过属性或方法，则全会丢失。

   ![image-20200601163042862](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/01/591df29494eccb9f8a3075581f5d44b6.png)

### 隐式原型与显式原型

将函数的原型称为**显式原型**

将对象的原型成为**隐式原型**

<div class="note icon font5 far fa-lightbulb" style="background: #fdf8ea;border-left-color: #f0ad4e;"><p>所有对象都具有原型，但对象的原型(__proto__)并非是函数的原型(prototype)。对象的原型不能用于真实开发工作，仅用于逻辑测试</p></div>

```javascript
// 定义构造函数
function Hero() {
  this.name = "张无忌";
}
// 通过构造函数的原型新增属性或方法
Hero.prototype.age = 18;
// 通过构造函数创建对象
var hero = new Hero();
console.log(hero.name);
console.log(hero.age);

/**
 * 所有的对象其实也具有原型
 * * 注意 - 对象的原型(__proto__)并非是函数的原型(prototype)
 * 区分
    将函数的原型称为 显式原型
    将对象的原型成为 隐式原型
* 对象的原型：不能用于真实开发工作，仅用于逻辑测试
 */

console.log(hero.prototype); // undefined 表示对象中不存在该属性
console.log(hero.__proto__); // Hero { age: 18 }

```

### isPrototypeOf()方法

isPrototypeOf() 判断指定对象是否是另一个对象的原型。

```javascript
// 通过初始化器定义对象
obj = {
  name: "张无忌",
};
// 定义构造函数
function Hero() {}
// 将对象obj赋值给构造函数Hero的原型
Hero.prototype = obj;
// 通过构造函数创建对象
var hero = new Hero();
// isPrototypeOf() 判断指定对象是否是另一个对象的原型
console.log(obj.isPrototypeOf(hero)); // true
console.log(hero.isPrototypeOf(obj)); // fasle
```

## 扩展内建对象

1. 直接通过Object原型新增

   ```javascript
   Object.prototype.sayMe = function () {
     console.log("this is function");
   };
   // 通过Object构造函数创建对象
   
   var obj = new Object();
   
   obj.sayMe();
   
   ```

2. 通过`defineProperty`方法新增

   ```javascript
   Object.defineProperty(Object.prototype, "sayMe", {
     value: function () {
       console.log("this is sayMe");
     },
   });
   var obj = new Object();
   obj.sayMe();
   ```

   
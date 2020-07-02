---
title: 继承（二）
date: 2020-06-07T09:14:50+08:00
categories: ["notes"]
---

## 继承

### 原型式继承

所谓原型式继承，就是定义一个函数，该函数中创建一个临时性的构造函数，将作为参数传入的对象作为这个构造函数的原型，最后返回这个构造函数的实例对象。

```javascript
// 定义一个函数
function fn(obj) {
  // 定义一个临时的构造函数
  function Fun() {}
  //   将函数的参数作为构造函数的原型
  Fun.prototype = obj;
  // 将构造函数创建的对象进行返回
  return new Fun();
}
var obj = {
  name: "张无忌",
};
// 调用函数
var result = fn(obj);
console.log(result);

```

但是以上方式并不能很自由的为对象添加自有属性，因此可以对其函数内的构造函数进行修改（调整）。

```javascript
/**
 * 定义一个函数 - 用于实现对象之间的继承
 * 参数
 *   obj - 表示继承关系中的父级对象
 *   prop - 对象格式，表示继承关系中的子集对象的属性
 * */

function fn(obj, prop) {
  // 定义一个临时的构造函数
  function Fun() {
    //   遍历对象的属性和方法
    for (var attrName in prop) {
      var attrValue = prop[attrName];
      this[attrName] = attrValue;
    }
  }
  //   将函数的参数作为构造函数的原型
  Fun.prototype = obj;
  // 将构造函数创建的对象进行返回
  return new Fun();
}
var obj = {
  name: "张无忌",
};
// 调用函数
var result = fn(obj, {
  age: 18,
  sayMe: function () {
    return "this is sayMe";
  },
});
console.log(result.sayMe());

```

<div class="snote msg cyan"><p>其主要区别为为函数多添加一个参数，用于接收自有变量。当进行创建对象时，传入自有变量即可。</p></div>

<div class="snote undo"><p>JavaScript中实现以上函数的功能可以使用Object.create()方法实现。但其传入自有属性时需注意。具体可参照如下代码：</p></div>

```javascript
var obj = {
  name: "张无忌",
};
var newObj = Object.create(obj, {
  age: {
    value: 18,
    enumerable: true,
  },
  sayMe: {
    value: function () {
      return "this is function";
    },
  },
});
console.log(newObj.name); // 张无忌
console.log(newObj); // { age: 18 }
console.log(newObj.sayMe()); // this is function

```

### 借助构造函数

无论是原型链还是原型式继承，都具有相同的问题。想要解決这样的问题的话，可以借助构造函数（也可以叫做伪造对象或经典继承）。

这种方式实现非常简单，就是在子对象的构造函数中调用父对象的构造函数。具体可以通过调用apply()和 call()方法实现。

apply()和call()方法都允许传递指定某个对象的this。对于继承来讲，可以实现在子对象的构造函数中调用父对象的构造函数时，将子对象的this和父对象的this绑定在一起。

```javascript
// 定义父级对象的构造函数
function Parent() {
  this.parent = "parent";
}

// 定义子级对象的构造函数
function Child() {
  // 调用父级对象的构造函数 -> 使用apply()或call()方法
  Parent.apply(this);
  this.child = "child";
}

// 创建子级对象
var child = new Child();
console.log(child);

```

![image-20200603114841202](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/03/0c5554ef0f0e67405b4cf07499a3bee5.png)

### 组合方式继承

组合继承，也叫做伪经典继承，指的是将原型链或原型式继承和借助构造函数的技术组合在一起，发挥二者长处的一种继承方式。
具体实现的思路就是：

- 使用原型链或原型式继承实现对原型的属性和方法的继承。
- 通过借助构造函数实现对实例对象的属性的继承。

这样，既通过在原型上定义方法实现了函数的重用，又可以保证每个对象都有自己的专有属性。

```javascript
function Parent() {
  // 构造函数的自有属性
  this.name = "张无忌";
}
// 构造函数的原型属性
Parent.prototype.age = 18;

function Child() {
  // 继承父级构造函数中的自有属性
  Parent.call(this);
  this.job = "教主";
}
// 继承父级构造函数中的原型属性
Child.prototype = Parent.prototype;

var child = new Child();

console.log(child.job);
console.log(child.age);
console.log(child.name);

```
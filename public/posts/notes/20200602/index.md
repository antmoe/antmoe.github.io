# 原型（一）


## 原型

### 原型是什么

在 Javascript中，函数是一个包含属性和方法的Function类型的对象。而原型（ Prototype）就是Function类型对象的一个属性。

在函数定义时就包含了 prototype属性，它的初始值是一个空对象。在 Javascript中井没有定义函数的原型类型，所以原型可以是任何类型。

原型是用于保存对象的共享属性和方法的，原型的属性和方法并不会影响函数本身的属性和方法。

原型的默认值是空对象，所有引用类型都是构造函数，所有函数都具有`prototype`属性。

```javascript
// Function 类型的属性 -> 所有函数都具有的属性
console.log(Function.prototype);

function fn() {
  console.log("this is function");
}
// 原型的默认值是空对象
console.log(fn.prototype);
// 函数包含构造函数 -> 所有引用类型都是构造函数
console.log(Number.prototype);
console.log(Object.prototype);

var result = Object.getOwnPropertyDescriptor(Object.prototype, "constructor");
console.log(result);

```



### 获取原型

获取原型的方式有两种

<span class="inline-tag blue">使用访问对象的属性语法结构</span>

```javascript
function fn() {
  console.log("this is function ");
}
// 使用访问对象的属性语法结构
console.log(fn.prototype); // fn {}
console.log(fn["prototype"]); // fn {}
```

<span class="inline-tag blue">Object类提供的getPrototype()方法</span>

```javascript
function fn() {
  console.log("this is function ");
}
console.log(Object.getPrototypeOf(fn)); //[Function]或者ƒ () { [native code] }
```

第二种方式中，在nodejs环境中会打印`[Function]`而在浏览器会打印`ƒ () { [native code] }`

### 新增属性和方法

<span class="inline-tag blue">使用对象新增方式。</span>

```javascript
function fn() {
  console.log("this is function ");
}
// 新增属性或方法
fn.prototype.name = "张无忌";
console.log(fn.prototype.name); // 张无忌
console.log(fn.prototype); // fn { name: '张无忌' }
```

<span class="inline-tag blue">使用defineProperty()方法</span>

```javascript
function fn() {
  console.log("this is function ");
}
// defineProperty()
Object.defineProperty(fn.prototype, "age", {
  value: 10,
  // 如果不修改此属性描述符，则不可枚举
  enumerable: true,
});
console.log(fn.prototype); // fn {age: 10 }
```

## 构造函数的原型

```javascript
// 定义构造函数

function Hero() {
  this.name = "张无忌";
  this.sayMe = function () {
    console.log("this is function ");
  };
}
// 操作构造函数Hero的原型
Hero.prototype.age = 18;
//  利用构造函数来创造对象
var hero = new Hero();

console.log(hero); // Hero { name: '张无忌', sayMe: [Function] }
// 为构造函数的原型新增的属性在创建对象中仍然可以访问
console.log(hero.age); // 18
// 对象小hero中不存在age属性
var result = Object.getOwnPropertyDescriptor(hero, "age");
console.log(result); //undefined

```

以上代码经测试可以发现，为构造函数原型新添加的属性，在其对象中虽可访问但通过`getOwnPropertyDescriptor`方法是得不到的。

![image-20200531163053091](https://cdn.jsdelivr.net/gh/blogimg/picbed@master/2020/05/31/f2875b8030a0dc8606d311643acba7a3.png)

## 原型属性

### 自有属性与原型属性

- 自有属性：通过对象的引用添加的属性。其它对象可能无此属性；即使有，也是彼此独立的属性。
- 原型属性：从原型对象中继承来的属性，一旦原型对象中属性值改变，所有继承自该原型的对象属性均改变。

通过构造函数Hero创建对象时不仅具有构造函数的自有属性，也具有构造函数的原型属性。

通过对象是无法修改原型的值，修改原型的值，必须修改构造函数的原型。

```javascript
// 定义一个构造函数
function Hero(name) {
  // 构造函数本身的属性 成为自有属性
  this.name = name;
  this.sayMe = function () {
    console.log("this is function");
  };
}
// 通过构造函数Hero的prototype新增属性或方法
// 通过原型所定义的属性称为原型属性
Hero.prototype.age = 19;
/**
 * 通过构造函数Hero创建对象时
 *  不仅具有构造函数的自有属性
 *  也具有构造函数的原型属性
 * */
var hero = new Hero("张无忌");
console.log(hero.name); // 张无忌
console.log(hero.age); //19

var hero2 = new Hero("周芷若");
console.log(hero2.name); // 周芷若
console.log(hero2.age); //19

hero.age = 80; // 相当于为hero新增属性
console.log(hero);
console.log(hero.age); //80

console.log(hero2.age); // 19

Hero.prototype.age = 80;

```

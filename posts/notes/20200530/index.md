# Function类型（二）


## 构造函数与函数

定义一个函数时，它既是一个函数也是一个构造函数，同时又是一个对象。

```javascript
function Hero() {
  // 当作是一个函数
  var v = 100;
  // 当作是一个构造函数来使用
  this.set = function (value) {
    v = value;
  };
  this.get = function () {
    return v;
  };
}
// 通过构造函数来创建对象
var hero = new Hero();
hero.set(2);
console.log(hero.get()); // 2

// 为对象Hero添加属性和方法
Hero.age = 18;
console.log(Hero.age); // 18
```

## 定义函数的方式与区别

|     定义方式     |             执行             |      效率      |
| :--------------: | :--------------------------: | :------------: |
|   函数定义语句   |       函数名被声明提前       | 不存在效率问题 |
|   字面量表达式   |   函数体固定，无法动态执行   | 不存在效率问题 |
| Function类型定义 | 函数体是字符串，可以动态执行 |     效率低     |

## Function的属性与方法

### length属性

获取**形参**的个数。调用方式如下：

```javascript
// Function类型的length属性 - 获取函数(形参)的参数的个数
function fn(a, b, d, e, f) {
  console.log("this is a function");
}
fn(1);
console.log(fn.length);  // 5
```

### Function的apply()方法

用于调用一个函数，并且接受指定的this值，以及一个数组作为参数。语法结构如下

`func.apply(thisArg,[argsArray])`

- `thisArg`

  指定`this`的值，表示当前调用函数的对象。如果不使用`this`值时，提供默认为`null`或者`undefined`值

- `argsArray`

  用于接收指定参数的形参。

<div class="snote idea yellow"><p>与函数调用体的区别在于接收的this值</p></div>

```javascript
function fn(a, b) {
  console.log("this is " + a + b);
}
// 调用函数
fn("function", "hello"); // this is functionhello
/**
 * apply(this,args)方法调用
 * 使用的对象调用方法的语法结构 -> 将函数作为对象使用
 * 参数
 *   this - 指定this的值,表示当前调用函数的对象
 *      如果不适用this值时,提供默认为null或者undefined值
 *   args - 数组,用于接收指定函数的实参
 * 与函数调用体的区别在于接收的this值
 */
fn.apply(null, ["function", "张无忌"]); //this is function张无忌
```

### Function的call()方法

Function的 call()方法用于调用一个函数，并且接收指定的this值作为参数，以及参数列表。

`func.call(thisArg,arg1,arg2,...)`

- `thisArg`

  用于指定this的值

- 后边的参数御用接收函数的实参

<div class="snote idea yellow"><p>call()与apply()方法区别 - 在于第二个参数</p></div>

```javascript
/**
 * call()方法 - 用于调用函数
 * 参数
 *   - thisArg - 用于指定this的值
 *   - arg1,arg2,... - 用于接受函数的实参
 * call()与apply()方法区别 - 在于第二个参数
 */
function fn(a, b) {
  console.log("this is function " + a + b);
}
fn.call(null, "12", "34"); //this is function 1234
```

### Function的bind()方法

Function的bind()方法用于创建一个新的函数（称为绑定函数），井且接收指定的this值作为参数，以及参数列表。其语法结构如下

`fun.bind(thisArg[,arg1[,arg2[,...]]])`

- `thisArg`

  指定`this`的值，表示当前调用函数的对象。如果不使用`this`值时，提供默认为`null`或者`undefined`值

- `arg`

  用于接收指定参数的形参。

- 返回值

  返回新创建的函数

- 作用

  实现函数的深复制

<div class="snote idea yellow"><p>验证复制为深复制</p></div>

```javascript
var fn = function () {
  console.log("this is function ");
};
var f = fn.bind();
f(); //this is function 
fn = function () {
  console.log("this is function too");
};
f();//this is function 
```

通过以上代码测试，当声明一个函数后，再次修改这个函数，并不会影响前边复制的f。因此bind方法实现的是深复制。

**函数赋值也为深复制**

```javascript
var a = function () {
  console.log("this is a");
};
var b = a;
b(); // this is a
a = function () {
  console.log("this is new a");
};
b(); // this is a
```

<div class="snote idea yellow"><p>关于bind()方法的参数</p></div>

在复制函数时，bing()方法传入的参数会作为参数调用时默认传入的参数。例如：

```javascript
var fn = function (v) {
  console.log("this is " + v);
};
fn("zhangwuji"); // this is zhangwuji
var f = fn.bind(null, "zhangwuji");
f() // this is zhangwuji
```

但是这并不意味着不能在向这个函数传递参数，例如给`f()`传入参数`'a'`那么相当于调用`fn`函数时传入了两个参数`fn('zhangwuji','a')`。例如如下测试：

```javascript
var fn = function (v+w) {
  console.log("this is " + v+w);
};
fn("zhangwuji"); // this is zhangwujiundefined
var f = fn.bind(null, "zhouzhiruo");
f(" hahaha"); // this is zhouzhiruo hahaha
```

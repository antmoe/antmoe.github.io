# Function类型（四）


### 自调函数

自调函数就是自己调用自己。简单语法如下两种：

```javascript
// 国内常用方式
(function () {
  var w = 100; // 局部变量
  console.log("this is function");
})();
// 表达式方式
(function (v) {
  console.log("表达式" + v);
})("function");

```

- 语法结构

  第一个括号用于定义函数，第二个括号用于调用函数。

- 作用

  用于执行一次性的逻辑任务

- 应用

  作为整体逻辑代码的外层结构

### 作为值的函数

在函数的函数体中定义另一个函数 -> 内容（私有）函数

```javascript
// 作为值的函数
function fn() {
  //在函数的函数体中定义另一个函数 -> 内容（私有）函数
  return function () {
    return 1;
  };
}
var result = fn();
console.log(result); // [Function]
console.log(result()); // 1
```

或者如下，返回一个函数

```javascript
function fn() {
  function n() {
    return 1;
  }
  return n();
}
var result = fn();
console.log(result)
```

### 函数作为对象的方法

```javascript
var fn = function fn() {
  console.log("this is function ");
};
// 将函数作为对象的方法
var obj = {
  fun: fn,
};
obj.fun(); // this is function 
fn(); // this is function 
```



当函数作为对象的方法时，再次修改函数同样不会影响对象中已经赋值。

```javascript
var fn = function fn() {
  console.log("this is function ");
};
// 将函数作为对象的方法
var obj = {
  fun: fn,
};
obj.fun();
fn();

fn = function () {
  console.log("this is function too");
};
obj.fun(); // this is function 
```

## 闭包

### 作用域链

作用域是一层一层向下传递的。

例如

```javascript
var a = "a";
function fun() {
  var b = "b";
  function fn() {
    //相对于f函数作用域的话，c相当于全局变量
    var c = "c";
    function f() {
      //函数作用域
      var d = "d";
      console.log(a); //a
      console.log(b); //b
      console.log(c); //c
      console.log(d); //d
    }
    f();
  }
  fn();
}
fun();

```

### 闭包是什么

简单来说，闭包就是访问在全局范围内访问局部作用域的变量。

以下三种方式均可称为闭包。

```javascript
// 对象与函数

function fn1() {
  var v = 100;
  return {
    get: function () {
      return v;
    },
    set: function (value) {
      v = value;
    },
  };
}
var obj = fn1();
obj.set(200);
console.log(obj.get());
```

```javascript
// 函数与构造函数

function fn2() {
  var v = 100;
  this.get = function () {
    return v;
  };
  this.set = function (value) {
    v = value;
  };
}
var obj = new fn2();
obj.set(200);
console.log(obj.get());
```

```javascript
// 全局变量

var get, set;
function fn3() {
  var v = 100;
  get = function () {
    return v;
  };
  set = function (value) {
    v = value;
  };
}
fn3();
set(200);
console.log(get()); //200

```

<div class="snote danger"><p>回调函数不属于闭包。但加上参数可以改为闭包：</p></div>

```javascript
function fn1(v) {
  var v1 = 100;
  //   console.log(v2);
  v(v1);
}
function fn2(v) {
  var v2 = 200;
  console.log(v);
}
fn1(fn2); // 100

```

<div class="snote idea yellow"><p>闭包结构并不固定，但当内部函数以某一种方式被任何一个外部函数作用域访问时，就可以成为闭包</p></div>

1. 闭包的特点

   - 局部变量

     在函数中定义有共享意义（如：缓存、计数器等）的局部变量。（注：定义成全局变量会对外造成污染）

   - 内部函数

     在函数（f）中声明有内嵌函数，内嵌函数（g）对函数（f）中的局部变量进行访问。

   - 外部使用

     函数（f）向外返回此内嵌函数（g),外部可以通过此内嵌函数持有并访问声明在函数（f）中的局部变量，而此变量在外部是通过其他途径无法访问的。

2. 闭包的作用

   - 提供可共享的局部变量。
   - 保护共享的局部变量。提供专门的读写变量的函数
   - 避免全局污染。

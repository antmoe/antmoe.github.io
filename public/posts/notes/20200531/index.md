# Function类型（三）


## 函数的重载

在其他开发语言中，函数具有一种特性，叫做重载。所谓重载，就是定义多个同名的函数，但每一个函数接收的参数的个数不同，程序会根据调用时传递的实参个数进行判断，具体调用的是哪个函数。

但是在JavaScript中不可以像下面的方式定义：

```javascript
// 在JavaScript如果定义多个同名函数 -
function add(a, b) {
  return a + b;
}

function add(a, b, c) {
  return a + b + c;
}
console.log(add(1, 2)); // NaN
console.log(add(1, 3, 4)); // 8
```

### arguments对象

存在于函数体中的特殊对象(原本是Function类型的arguments属性)。arguments对象是一个类数组对象，其中包含`length`属性：函数实参的个数，其作用是用于接收函数的参数（实参）

```javascript
function fn() {
    console.log(arguments);
    console.log(arguments[0]);
}

fn(1, 2, 3, 4);
// [Arguments] { '0': 1, '1': 2, '2': 3, '3': 4 }
// 1
```

<div class='tip' ><p>模拟函数重载<p></div>

```javascript
function add() {
  var len = arguments.length;
  switch (len) {
    case 2:
      return arguments[0] + arguments[1];
    case 3:
      return arguments[0] + arguments[1] + arguments[2];
    case 4:
      return arguments[0] + arguments[1] + arguments[2] + arguments[3];
  }
}
console.log(add(1, 2));
console.log(add(1, 2, 3));
console.log(add(1, 2, 3, 4));
console.log(add(1, 2, 3, 4, 5));
```

<div class='tip warning'><p>JavaScript中没有函数重载，只能通过模拟来实现<p></div>

## 递归

函数的递归：函数在当前函数体调用自身。

执行方式类似于循环语句的执行方式即反复执行指定的语句块内容。

执行递归函数时，**必须提供结束执行的条件（出口）**

如下为最简单的递归：

```javascript
var v = 0;
function fn() {
  console.log("this is function ");
  v++;
  if (v > 3) {
    return;
  }
  // 调用自身函数
  fn();
}
fn();
```

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/05/29/b2ec28a70c089011527c5e86ea640e45.png)

如果在外部需要释放函数，那么函数内部的自调应该改为`arguments.callee()`。

```javascript
var v = 0;
function fn() {
  console.log("this is function ");
  v++;
  if (v > 3) {
    return;
  }
  // 调用自身函数
  //   fn();
  arguments.callee();
}
var f = fn;
fn = null;
f();
```

## 特殊函数（高阶函数）

### 匿名函数

所谓匿名函数就是没有名字的函数，但JavaScript的语法并不支持匿名函数。因此匿名函数的用法有两个

- 回调函数

  将一个函数作为另一个函数的参数使用，作为参数的函数称为回调函数

- 自调函数

  函数调用自身（定义即调用函数）

### 回调函数

将一个函数作为另一个函数的参数使用，作为参数的函数称为回调函数

回调函数的优势：

- 匿名回调函数节省了全局命名空间
- 将私有的数据内容开放给指定位置使用（仅仅）
- 虽然可以使用私有数据，但不清楚来源一封装

![image-20200529191355824](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/05/29/6cbea9f402e749c982409eec6826c7a1.png)

![image-20200529193718796](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/05/29/1de3fde9794320b4319c2146656189dd.png)

```javascript
var n = function (w) {
  console.log(w);
};
function fn(v) {
  var name = "张无忌";
  v(name); //将局部变量作为v()函数的实参传递
}
fn(function (w) {
  console.log(w); // 张无忌
});

```

# 严格模式（二）


## 函数

### 参数名必须唯一

在严格模式下，要求命名函数的参数必须唯一。

```javascript
function fn(a, a, b) {
  console.log(a + a + b);
}
fn(1, 2, 3); //7
```

例如以上代码，非严格模式下会输出7，两个参数a都会被当作2；但在严格模式下，会抛出错误。

### arguments的不同

在严格模式下， arguments对象的行为也有所不同。

- 非严格模式下，修改命名参数的值也会反应到arguments对象中。
- 严格模式下，命名参数与arguments对象是完全独立的。

```javascript
"use strict";
function fn(value) {
  var value = "张无忌";
  console.log(value); // 张无忌
  console.log(arguments[0]); //严格模式下为周芷若 非严格模式下为周芷若
}
fn("周芷若");

```

<div class="snote msg cyan"><p>非严格模式下arguments对象获取参数的值与形参有关。（如果局部变量与形参名相同，则根据就近原则获取）；严格模式下arguments对象获取参数的值与形参无关。</p></div>

### arguments.callee()

在严格模式下，不能使用armaments对象的callee()方法。

```javascript
"use strict";
function fn() {
  return arguments.callee;
}
fn();

```

以上代码在严格模式下会直接报错。

### 函数声明的限制

在严格模式下，只能在全局域和函数域中声明函数。

```javascript
"use strict";
// 在全局作用域
function fn() {
  function n() {}
}

for (var i = 0; i < 10; i++) {
  // ECMAscript 6 新增 - 存在块级作用域
  var v = 100;
  // 开启严格模式后在块级不能定义函数
  function f() {
    console.log("this is function");
  }
}
console.log(v); // 100
f(); // ReferenceError: f is not defined

```

<div class="snote danger"><p>在严格模式下，函数的定义只能在全局作用域与函数作用域，不能在块级作用域</p></div>



## 增加eval()作用域

在严格模式下，使用`eval()`函数创建的变量只能在`eval()`函数内部使用。

```javascript
eval("var v = 100");
console.log(v);
```

以上代码在非严格模式下会输出`100`，而在严格模式下会抛出错误。

> 在严格模式下，会增加eval作用域。也就是说在eval函数定义的变量只能在当前eval函数使用。

## arguments对象--禁止读写

在严格模式下，禁止使用eval()和arguments作为标示符，也不允许读写它们的值。

- 使用var声明。
- 赋予另一个值
- 尝试修改包含的值。
- 用作函数名。
- 用作命名的函数的参数。
- 在 try-catch语句中用作例外名。

以下语句在严格模式下均会报错：

```javascript
eval = 17;

arguments++;

++eval;

var obj = {
  set p(arguments) {},
};

var eval;

try {
} catch (arguments) {}

function x(eval) {}

function (eval) { }

function arguments() { }

var y = function eval() { }

var f = new Function('arguments', "'use strict';return 17;")

```



## 抑制this

- 在非严格模式下使用数的`apyly()`或`call()`方法时，`null`或`undefined`值会被转换为全局对象。
- 在严格模式下，函数的`this`值始终是指定的值（无论什么值）。

```javascript
"use strict";
var v = 100;

function fn() {
  console.log(this.v);
}

var obj = {
  v: 200,
};
fn.call(null);
```

在严格模式下会抛出错误，必须明确指定this，例如`fn.call(obj);`。

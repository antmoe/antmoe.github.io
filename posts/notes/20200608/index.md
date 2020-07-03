# 错误与异常


## 错误与异常是什么

错误，指程序中的非正常运行状态，在其它编程语言中称为“异常”或“错误”。解释器会为每个错误情形创建并抛出一个Error对象，其中包含错误的描述信息。

通过使用Javascript提供的异常处理语句，可以用结构化的方式来捕捉发生的错误，让异常处理代码与核心业务代码实现分离。

错误与异常处理在应用中的重要性是毋庸置疑的。任何有影响力的Web应用都需要一套完善的错误处理机制。

## try...catch语句

`try`表示标记一块待尝试的语句，如果语句出现错误，则通过`catch`语句进行捕捉。

```javascript
// 用于捕获指定语句块中的错误或异常
try {
  console.log(v); //调用未定义的变量 -> 报错
} catch (error) {
  // 用于处理try语句中的错误
  // error 表示try语句中出现错误的信息
  console.log("改变量未定义");
} finally {
  // catch语句无法处理try语句中的错误或异常时，执行finally语句中的内容
  console.log("");
}
```

`finally`表示最后执行，无论是走`try`还是`catch`都会执行finally语句。

## throw语句

人为抛出错误或异常，语法结构`throw 异常或错误的表达式 `。其表达式允许是任意类型的内容。作用为预判断当前使用的变量、函数或对象是否存在。

```javascript
function fn(v) {
    if (v) {
        return v;
    } else {
        /**
     * throw 语句 - 人为抛出错误或异常
     * 语法结构
     *   - throw 异常或错误的表达式
     *   表达式允许是任意类型的内容
     * 作用 - 预判断当前使用的变量、函数或对象是否存在
     */
        // 真是情况下应抛出一个错误对象
        throw "undefined";
    }
}
// console.log(fn(10));
// console.log(fn());

var result;
try {
    result = fn();
} catch (e) {
    result = "unkown";
    console.log(e); // undefined
}

console.log(result); // unkown

```

## 嵌套try...catch语句

可以嵌套一个或多个try...catch语句。如果一个内部的try...catch语句没有捕捉块，将会启动匹配外部的try...catch语句的捕捉块。

**注意：嵌套在catch语句块内。**

```javascript
try {
    console.log(0);
} catch (e) {
    try {
        console.log(1);
    } catch (e) {
        console.log(2);
    }
}
```

## 错误类型

### 基本错误类型

执行代码期间可能会发生的错误有多种类型，每种错误都有对应的错误类型。当错误发生时，就会抛出对应类型的错误对象。

Error是基本错误类型，其他错误类型都继承自该类型。Error类型的错误很少见，如果有也是浏览器抛出的。这个基本错误类型的主要目的是提供给开发人员抛出自定义错误的。

### 预定义错误类型

|     错误类型     |                             说明                             |
| :--------------: | :----------------------------------------------------------: |
|    `EvaError`    |               表示错误的原因：与`eval()`有关。               |
| `internalError`  |              表示JavaScript引擎内部错误的异常。              |
|   `RangeError`   |        表示错误的原因：数值变量或参数超出其有效范围。        |
| `ReferenceError` |                  表示错误的原因：无效引用。                  |
|  `SyntaxError`   |  表示错误的原因：`eval()`在解析代码的过程中发生的语法错误。  |
|   `TypeError`    |          表示错误的原因：变量或参数不属于有效类型。          |
|    `URIError`    | 表示错误的原因：给`encodeURI()`或`decodeURI()`传递的参数无效。 |

[JavaScript 错误参考](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Errors)

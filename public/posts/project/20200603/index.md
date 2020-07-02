# 基于面向对象的工具库练习


## 前期准备

<div class="snote idea yellow"><p>全局作用域问题</p></div>

解决这个问题是通过**匿名函数**，然后在匿名函数内创建对象，将`window`作为参数传入匿名函数，并将此对象赋值与`window`

```javascript
(function (global) {
  // 判断global对象是否真的存在
  if (!global) {
    console.error("当前环境不是浏览器环境！");
    return false;
  }
  // 定义一个统一对外开放的对象
  var mytool = new Object();
  global.mytool = mytool;
})(window);
```

此时在全局作用域中便存在了一个对象`mytool`。

## 选择器

实现一个选择器，用于替代`getElementById`、`getElementsByClassName`、`getElementsByTagName`三种获取方式。

实现方式，将需要搜索的标签名（id，class，tagname）传入方法参数，通过内部处理返回一个数组。

1. 对于`id`选择器或`class`选择器来说，传入形参为`#id`或`.class`。那么只需要去匹配第一个字符即可。
2. 如果不匹配以上两种情况，那么可以视为`TagName`。

```javascript
mytool.getElement = function (selector) {
    //   判断selector是否为空
    if (selector !== "" && selector !== undefined && selector !== null) {
        // 判断当前选择器
        var firstSelector = selector.slice(0, 1);
        var lastSelector = selector.slice(1);
        var result,
            arr = [];
        if (firstSelector === "#") {
            //   ID查找
            result = document.getElementById(lastSelector);
        } else if (firstSelector === ".") {
            // class查找
            result = document.getElementsByClassName(lastSelector);
        } else {
            // tagname查找
            result = document.getElementsByTagName(selector);
        }
        if (result.length) {
            for (var i = 0; i < result.length; i++) {
                arr.push(result[i]);
            }
        } else {
            arr.push(result);
        }
        return arr;
    }
};
```

## 选择器的改造

1. 定义开放给全局作用域的变量，其具有两重身份

   - 本身应该是一个对象：通过构造函数方式来创建(自身方法和原型方法都存在)

     将之前定义页面元素返回的结果(数组)和当前这个对象进行整合，因此需要使用**类数组对象**

   - 应该是一个函数, 该函数封装定位页面元素功能

<div class="snote idea yellow"><p>类数组对象</p></div>

实现一个类数组对象只需要将某个构造函数的原型指向一个数组即可。例如：

```javascript
function createObject() {
  this.name = "李雷";
  this.sayMe = function () {};
}
// 构造函数的原型属性 -> 其实是一个空对象 -> 利用最简形式实现继承
createObject.prototype = new Array();
// 结构上是一个, 自定义的一个对象 -> 类数组对象
var newObj = new createObject();

newObj.push("xxx");
console.log(newObj);
```

![image-20200606172902611](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/06/275a941dff51a809e1bb69a62015cd01.png)

<div class="snote idea yellow"><p>函数</p></div>

在函数内部创建核心对象，操作在核心对象上，最后返回这个对象。

```javascript
var _mytool = function (selector) {
    // 创建核心对象
    var _tool = new createMyTool();

    // 判断selector是否为空
    if (selector !== "" && selector !== undefined && selector !== null) {
        // 如何判断当前使用的是哪一种选择器? 判断第一个字符是什么
        var firstSelector = selector.slice(0, 1);
        var result;
        if (firstSelector === "#") {
            // 当前就是ID查找
            result = document.getElementById(selector.slice(1));
        } else if (firstSelector === ".") {
            // 当前就是className查找
            result = document.getElementsByClassName(selector.slice(1));
        } else {
            // 当前就是TagName查找
            result = document.getElementsByTagName(selector);
        }

        if (result.length) {
            // 当前得到结果是集合
            for (var i = 0; i < result.length; i++) {
                _tool.push(result[i]);
            }
        } else {
            // 当前得到结果是元素
            _tool.push(result);
        }
    }
    // 在当前函数中返回一个对象
    return _tool;
};
```

<div class="snote quote"><p class='p subtitle'>NOTE</p>


1. 在函数内部定义局部变量、内部函数或对象时, 命名格式经常使用"_"作为前缀

   目的主要为了与真正在全局作用域中定义变量、对象或函数进行区分

2. 在实际开发, 经常会使用一个符号替代对象名. 比如后面要学习的jQuery库, 使用"$"替代对象

</div>

## 选择器的再次改造

1. 首先是需要判断当前的运行环境

   改造的思路为，判断当前环境是否存在`document`，如果存在则为浏览器环境，如果不存在为其他环境。当浏览器环境时，去运行一个回调函数。

   ```javascript
   (function (global, factory) {
       if (global.document) {
           //   浏览器环境
           factory(global);
       } else {
           //   非浏览器环境
       }
   })(window !== undefined ? window : this, function (window) {})
   ```

   于是匿名函数的结构就变成了如上结构。

   *传入的`windows`形参是为了增加功能时直接使用的全局对象。*

2. 开放给全局的对象

   回调函数需要明确的是：还是需要返回一个类数组对象，并且需要开放给全局一个对象来使用。

   ```javascript
   (function (global, factory) {
       if (global.document) {
           //   浏览器环境
           factory(global);
       } else {
           //   非浏览器环境
       }
   })(window !== undefined ? window : this, function (window) {
       //用作核心对象的构造函数
       MyTool.init = function () {};
       MyTool.init.prototype = new Array();
       // 将核心对象开放给全局作用域
       window.MyTool = window.$ = MyTool;
   })
   ```

3. 定义MyTool基本模型

   ```javascript
   var MyTool = function (selector) {
       // 实例核心对象
       var _mytool = new MyTool.init();
       // 如果没有传入参数，那么直接返回核心对象
       if (selector === undefined || selector === null || selector === "") {
           return _mytool;
       }
       // 返回核心对象
       return _mytool;
   };
   ```

4. 完成选择器的功能

   字符串可以使用索引值的方式去取到第一个字符，因此可以替换掉`slice`

   ```javascript
   var MyTool = function (selector) {
       // 实例核心对象
       var _mytool = new MyTool.init();
       // 如果没有传入参数，那么直接返回核心对象
       if (selector === undefined || selector === null || selector === "") {
           return _mytool;
       }
       // 选择器功能
       else if (selector[0] === "#") {
           // 元素的ID属性定位页面元素
           result = _document.getElementById(selector.slice(1));
       } else if (selector[0] === ".") {
           // 元素的class属性定位页面元素
           result = _document.getElementsByClassName(selector.slice(1));
       } else {
           // 元素的名称定位页面元素
           result = _document.getElementsByTagName(selector);
       }
   
       // 将定位页面元素的结果封装到核心对象中
       if (result.length) {
           // 当前得到结果是集合
           for (var i = 0; i < result.length; i++) {
               _mytool.push(result[i]);
           }
       } else {
           // 当前得到结果是元素
           _mytool.push(result);
       }
       // 返回核心对象
       return _mytool;
   };
   
   ```

## 扩展创建标签的功能

扩展标签所需要判断的是开头为`<`，并且最后一个字符为`>`，且长度大于等于3。那么即可视为创建标签元素。

```javascript
else if (
    selector[0] === "<" &&
    selector[selector.length - 1] === ">" &&
    selector.length >= 3
) {
    /*
        创建元素: 参数中截取到标签名
        1. 开始标签中存在属性: 标签名就是从"<"到第一个空格之间
        2. 开始标签中不存在属性: 标签名就是从"<"到第一个">"之间
        实现的思路:
        1. 截取到第一个">"的索引值
        2. 判断从"<"到第一个">"之间是否存在空格
           * 如果存在: 具有属性
           * 如果不存在: 没有属性
       */
    var firstRightArrowIndex = selector.indexOf(">");
    var startTag = selector.slice(0, firstRightArrowIndex + 1);
    var firstSpaceIndex = startTag.indexOf(" ");
    var tagName, textValue;

    if (firstSpaceIndex !== -1) {
        // 开始标签中存在属性
        tagName = selector.slice(1, firstSpaceIndex);
    } else {
        // 开始标签中不存在属性
        tagName = selector.slice(1, firstRightArrowIndex);
    }
    var newElement = _document.createElement(tagName);

    // 是否存在文本内容
    if (selector.match(/[<]/g).length === 2) {
        var lastLeftArrowIndex = selector.lastIndexOf("<");
        textValue = selector.slice(
            firstRightArrowIndex + 1,
            lastLeftArrowIndex
        );

        newElement.textContext = textValue;
    }

    // 是否存在属性
    if (firstSpaceIndex !== -1) {
        var attrArr = startTag.slice(0, firstRightArrowIndex).split(" ");
        for (var i = 1; i < attrArr.length; i++) {
            var attrText = attrArr[i];
            var attrName = attrText.split("=")[0];
            var attrValue = attrText.split("=")[1];
            attrValue = attrValue.slice(1, attrValue.length - 1);

            newElement.setAttribute(attrName, attrValue);
        }
    }

    result = newElement;
}
```



## 开发历程及代码

|    时间    |               开发内容               |
| :--------: | :----------------------------------: |
| 2020-06-07 | 选择器的再次改造、扩展创建标签的功能 |
| 2020-06-06 |             选择器的改造             |
| 2020-06-03 |           前期准备、选择器           |



代码仓库：[mytools](https://gitee.com/antmoe/project/tree/master/2020/06/mytools)

```javascript
(function (global, factory) {
  /**
   * 目标：判断当前使用工具库的环境是否为浏览器环境
   * 如果是浏览器环境，执行对应的逻辑
   * 如果非浏览器环境，执行其他的逻辑
   */
  if (global.document) {
    //   浏览器环境
    factory(global);
  } else {
    //   非浏览器环境
  }
  /**
   *  传递实参时：允许直接传递表达式 -> 将表达式的计算结果作为实参传递
   */
})(window !== undefined ? window : this, function (window) {
  var _document = window.document;
  var MyTool = function (selector) {
    // 返回核心对象
    var _mytool = new MyTool.init(),
      result;
    if (selector === undefined || selector === null || selector === "") {
      return _mytool;
    }
    //   创建标签
    else if (
      selector[0] === "<" &&
      selector[selector.length - 1] === ">" &&
      selector.length >= 3
    ) {
      /*
        创建元素: 参数中截取到标签名
        1. 开始标签中存在属性: 标签名就是从"<"到第一个空格之间
        2. 开始标签中不存在属性: 标签名就是从"<"到第一个">"之间
        实现的思路:
        1. 截取到第一个">"的索引值
        2. 判断从"<"到第一个">"之间是否存在空格
           * 如果存在: 具有属性
           * 如果不存在: 没有属性
       */
      var firstRightArrowIndex = selector.indexOf(">");
      var startTag = selector.slice(0, firstRightArrowIndex + 1);
      var firstSpaceIndex = startTag.indexOf(" ");
      var tagName, textValue;

      if (firstSpaceIndex !== -1) {
        // 开始标签中存在属性
        tagName = selector.slice(1, firstSpaceIndex);
      } else {
        // 开始标签中不存在属性
        tagName = selector.slice(1, firstRightArrowIndex);
      }
      var newElement = _document.createElement(tagName);

      // 是否存在文本内容
      if (selector.match(/[<]/g).length === 2) {
        var lastLeftArrowIndex = selector.lastIndexOf("<");
        textValue = selector.slice(
          firstRightArrowIndex + 1,
          lastLeftArrowIndex
        );

        newElement.textContext = textValue;
      }

      // 是否存在属性
      if (firstSpaceIndex !== -1) {
        var attrArr = startTag.slice(0, firstRightArrowIndex).split(" ");
        for (var i = 1; i < attrArr.length; i++) {
          var attrText = attrArr[i];
          var attrName = attrText.split("=")[0];
          var attrValue = attrText.split("=")[1];
          attrValue = attrValue.slice(1, attrValue.length - 1);

          newElement.setAttribute(attrName, attrValue);
        }
      }

      result = newElement;
    }
    //   定位页面元素
    else if (selector[0] === "#") {
      // 元素的ID属性定位页面元素
      result = _document.getElementById(selector.slice(1));
    } else if (selector[0] === ".") {
      // 元素的class属性定位页面元素
      result = _document.getElementsByClassName(selector.slice(1));
    } else {
      // 元素的名称定位页面元素
      result = _document.getElementsByTagName(selector);
    }

    // 将定位页面元素的结果封装到核心对象中
    if (result.length) {
      // 当前得到结果是集合
      for (var i = 0; i < result.length; i++) {
        _mytool.push(result[i]);
      }
    } else {
      // 当前得到结果是元素
      _mytool.push(result);
    }

    // 返回核心对象
    return _mytool;
  };
  MyTool.init = function () {};
  MyTool.init.prototype = new Array();
  // 将核心对象开放给全局作用域
  window.MyTool = window.$ = MyTool;
});
```



---
title: jQuery原理（入口函数）
date: 2020-06-21T19:42:00+08:00
categories: ["notes"]
---

## 基本结构

jQuery的基本结构如下：

```javascript
(function (window, undefiend) {
    var jQuery = function () {
        return new jQuery.fn.init()
    }
    jQuery.prototype = {
        constructor: jQuery
    }

    jQuery.fn.init.prototype = jQuery.prototype
    window.jQuery = window.$ = jQuery
})(window);
/* 其中fn指代的是原型，因此以上结构可以转换成以下结构 */
(function (window, undefiend) {
    var jQuery = function () {
        return new kjQuery.prototype.init();
    };
    jQuery.prototype = {
        constructor: jQuery,
    };

    jQuery.prototype.init.prototype = jQuery.prototype;

    window.jQuery = window.$ = jQuery;
})(window);

```

1. jQuery的本质是一个闭包

   为了避免多个框架的冲突

2. jQuery如何让外界访问内部定义的局部变量

   ```javascript
   windows.xx = xxx
   ```

3. jQuery为什么要给自己传递一个window参数

   - 为了方便后期压缩代码
   - 为了提升查找的效率

4. jQuery为什么要给自己传递一个undefiend参数

   - 为了方便后期压缩代码
   - IE9以下的浏览器`undefined`可以被修改，为了保证内部使用的`undefined`不被修改，所以需要接收一个正确的`undefined`



## 入口函数测试

1. 传入 `''` `null` `undefined` `NaN` `0`  `false`

   返回空的jQuery对象

   ```javascript
   console.log($())
   console.log($(''))
   console.log($(null))
   console.log($(undefined))
   console.log($(NaN))
   console.log($(0))
   console.log($(false))
   ```

   ![image-20200621153915653](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/21/eef600ae7de42e19d7e545aec1dafa49.png)

2. 字符串

   - 代码片段

     会将创建好的DOM元素存储到jQuery对象中返回

     ```javascript
     console.log($('<p>1</p><p>2</p><p>3</p>'));
     ```

     ![image-20200621155130041](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/21/a6a0ea7c8c2c10ed73b680c05b233104.png)

   - 选择器

     会将找到的所有元素存储到jQuery对象中返回

     ```javascript
     console.log($('li'));
     ```

     ![image-20200621155220061](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/21/dad40be6fbb0f9fde03f86b1fc55957d.png)

3. 数组

   会将数组中存储的元素依次存储到jQuery对象中立返回

   ```javascript
   var arr = [1, 2, 3, 4, 5, 6];
   console.log($(arr));
   var likeArr = { 0: "lnj", 1: "33", 2: "male", length: 3 };
   console.log($(likeArr));
   ```

   ![image-20200621155259905](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/21/e589189c773b1fc2887bfda476ed174b.png)

4. 其他类型（对象、DOM元素、基本数据类型等）

   会将传入的数据存储到jQuery对象中返回

   ```javascript
   function Person() { }
   
   console.log($(new Person()));
   
   console.log($(document.createElement('div')));
   
   console.log($(123));
   console.log($(true));
   ```

   ![image-20200621155438227](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/21/5a197e0b14e90b5ab75a09aad73a01b6.png)



## 入口函数-代码实现

接收参数的实现：在创建时接收一个参数，并且传递给init即可。这样init就可以接收这个参数。

```javascript
var kjQuery = function (selector) {
    return new kjQuery.prototype.init(selector);
};
```

接下来的方法只需要在`init`中定义即可。

```javascript
kjQuery.prototype = {
    constructor: kjQuery,
    init: function (selector) {

    },
};
```



1. 传入 `''` `null` `undefined` `NaN` `0`  `false`

   ```javascript
   if (!selector) {
       return this;
   }
   ```

2. 处理函数

   判断是否为函数，如果是则将传入的参数作为`ready`的回调函数传入。

   ```javascript
   isFunction: function (selector) {
       return typeof selector === "function";
   },
   ```

   ```javascript
   // 2. 方法处理
   else if (kjQuery.isFunction(selector)) {
       kjQuery.ready(selector);
   }
   ```

   在`ready`函数中需要判断页面是否加载，由于IE不支持`addEvem=ntListener`方法添加事件，因此判断页面是否加载只能使用`readyState`判断页面加载状态。当页面加载完成后在进行添加事件的操作。

   ````javascript
   ready: function (fn) {
       // 判断DOM是否加载完毕
       if (document.readyState == "complete") {
           fn();
           //   判断是否含有addEventListener方法
       } else if (document.addEventListener) {
           document.addEventListener("DOMContentLoaded", function () {
               fn();
           });
       } else {
           //   IE兼容
           document.attachEvent("onreadystatechange", function () {
               if ((document.readyState = "complete")) {
                   fn();
               }
           });
       }
   },
   ````

   

3. 字符串

   在这里需要判断是否是字符串并且需要去掉字符串两端的空格。但判断是否为字符串后边可能也会用到，因此定义一个静态方法，通过类名调用。方便后边的操作

   ```javascript
   kjQuery.isString = function (str) {
       return typeof str === "string";
   };
   ```

   去掉两端的空格在传入时去掉即可。同样定义一个静态方法

   ```javascript
   // 0 去除字符串两端的空格
   selector = kjQuery.trim(selector);
   kjQuery.trim = function (str) {
       if (!kjQuery.isString(str)) {
           return str;
       }
       if (str.trim) {
           return str.trim();
       } else {
           // IE兼容处理方案
           return str.replace(/^\s+|\s+$/g, "");
       }
   };
   ```

   - HTML代码

     判断是否为HTML与判断字符串一样，后边也可能会用到，因此定义一个静态方法。

     ```javascript
     kjQuery.isHTML = function (str) {
         return (
             str.charAt(0) == "<" &&
             str.charAt(str.length - 1) == ">" &&
             str.length >= 3
         );
     };
     ```

     ```javascript
     else if (kjQuery.isString(selector)) {
         // 2.1 判断是否是代码片段
         if (kjQuery.isHTML(selector)) {
             // 1. 根据代码片段创建所有的元素
             var temp = document.createElement("div");
             temp.innerHTML = selector;
             // 2. 创建好的一级元素添加到对象
             for (var i = 0; i < temp.children.length; i++) {
                 this[i] = temp.children[i];
             }
             // 3. 给jQuery对象添加length属性
             this.length = temp.children.length;
             // 4. 返回加工好的this(jQuery)
             return this;
         }
         // 2.2 判断是否是选择器
     }
     ```

     > 其中第二三步可以修改为如下写法：
     >
     > ```javascript
     > [].push.apply(this, temp.children);
     > ```
     >
     > 通过apply改变push的this，这样就不会push到数组里，而是push到this（此时为kjQuery对象）中。

   - 选择器

     ```javascript
     // 2.2 判断是否是选择器
     else {
         // 1. 根据传入的选择器找到对应的元素
         var res = document.querySelectorAll(selector);
         // 2. 将找到的元素添加到kjQuery
         [].push.apply(this, res);
         // 3. 返回加工好的this
         return this;
     }
     ```

4. 数组

   注意：但凡将自定义数组转换为真数组或伪数组都先转换为真数组

   ```javascript
   else if (
       typeof selector === "object" &&
       "length" in selector &&
       selector != window
   ) {
       //   3.1 真数组
       if ({}.toString.apply(selector) == "[object Array]") {
           [].push.apply(this, selector);
           return this;
       }
       //   3.2 伪数组
       else {
           // 将自定义的伪数组转换成真数组
           var arr = [].slice.call(selector);
           [].push.apply(this, arr);
           return this;
       }
   }
   ```

   以上代码可优化为如下：

   新增静态方法

   ```javascript
   kjQuery.isObject = function (selector) {
       return typeof selector === "object";
   };
   kjQuery.isWindow = function (selector) {
       return selector === window;
   };
   kjQuery.isArray = function (selector) {
       if (
           kjQuery.isObject(selector) &&
           !kjQuery.isWindow(selector) &&
           "length" in selector
       ) {
           return true;
       }
       return false;
   };
   ```

   ```javascript
   else if (kjQuery.isArray(selector)) {
       var arr = [].slice.call(selector);
       [].push.apply(this, arr);
       return this;
   }
   ```

5. 其他类型（对象、DOM元素、基本数据类型等）

   ```javascript
   else {
       this[0] = selector;
       this.length = 1;
       return this;
   }
   ```

### 真伪数组转换

1. 真数组转换为伪数组

   ```javascript
   var obj = {},arr=[];
   [].push.apply(obj,arr);
   ```

2. 伪数组转换为真数组

   ```javascript
   var obj = {};
   var arr = [].slice.call(obj)
   ```



## 入口函数-extend方法

通过extend方法来为对象或类添加方法。

1. 调用`extend`方法，传入一个对象。

   ```javascript
   function kjQuery() { }
   kjQuery.extend({
       isTest: function () {
           console.log('test');
       }
   })
   ```

2. 在`extend`方法的实现中，遍历传入的对象，并将值添加到类身上作为类的方法。

   ```javascript
   /* 为类和对象添加方法 */
   kjQuery.extend = kjQuery.prototype.extend = function (obj) {
       for (var key in obj) {
           this[key] = obj[key];
       }
   };
   /*
   /* 为类添加方法 */
   kjQuery.extend = function (obj) {
       // this指向kjQuery
       console.log(this);
       for (var key in obj) {
           // kjQuery[key] = obj[key]
           this[key] = obj[key]
       }
   }
   /* 为对象添加方法 */
   kjQuery.extend.prototype = function (obj) {
       // this指向实例化对象
       console.log(this);
       for (var key in obj) {
           // kjQuery[key] = obj[key]
           this[key] = obj[key]
       }
   }
       */
   ```

3. 通过类名调用方法

   ```javascript
   kjQuery.isTest()
   ```

   ![image-20200621191222466](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/21/3efd0ed3ca204917ace2e86b32492ba5.png)

4. 通过对象调用方法

   ```javascript
   var k = new kjQuery();
   k.extend({
       isDemo: function () {
           console.log('demo')
       }
   })
   k.isDemo()
   ```

   ![image-20200621193649802](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/21/dd62c531576727794b64cc69858d4921.png)

   

因此可以将之前定义的静态方法改为如下写法：

```javascript
kjQuery.extend = kjQuery.prototype.extend = function (obj) {
    for (var key in obj) {
        this[key] = obj[key];
    }
};
kjQuery.extend({
    isString: function (str) {
        return typeof str === "string";
    },
    isHTML: function (str) {
        return (
            str.charAt(0) == "<" &&
            str.charAt(str.length - 1) == ">" &&
            str.length >= 3
        );
    },
    trim: function (str) {
        if (!kjQuery.isString(str)) {
            return str;
        }
        if (str.trim) {
            return str.trim();
        } else {
            // IE兼容处理方案
            return str.replace(/^\s+|\s+$/g, "");
        }
    },
    isObject: function (selector) {
        return typeof selector === "object";
    },
    isWindow: function (selector) {
        return selector === window;
    },
    isArray: function (selector) {
        if (
            kjQuery.isObject(selector) &&
            !kjQuery.isWindow(selector) &&
            "length" in selector
        ) {
            return true;
        }
        return false;
    },
    isFunction: function (selector) {
        return typeof selector === "function";
    },
    ready: function (fn) {
        // 判断DOM是否加载完毕
        if (document.readyState == "complete") {
            fn();
            //   判断是否含有addEventListener方法
        } else if (document.addEventListener) {
            document.addEventListener("DOMContentLoaded", function () {
                fn();
            });
        } else {
            //   IE兼容
            document.attachEvent("onreadystatechange", function () {
                if ((document.readyState = "complete")) {
                    fn();
                }
            });
        }
    },
});
```

## 完整代码

至此入口函数部分编写已经完成，下边是工具库的全部代码。

```javascript
(function (window, undefiend) {
  var kjQuery = function (selector) {
    return new kjQuery.prototype.init(selector);
  };
  kjQuery.prototype = {
    constructor: kjQuery,
    init: function (selector) {
      /*
        
        
        代码片段:会将创建好的DOM元素存储到jQuery对象中返回
        选择器: 会将找到的所有元素存储到jQuery对象中返回
        3.数组:
        会将数组中存储的元素依次存储到jQuery对象中立返回
        4.除上述类型以外的:
        会将传入的数据存储到jQuery对象中返回
    */
      // 0 去除字符串两端的空格
      selector = kjQuery.trim(selector);
      // 1.传入 '' null undefined NaN  0  false, 返回空的jQuery对象
      if (!selector) {
        return this;
      }
      // 2. 方法处理
      else if (kjQuery.isFunction(selector)) {
        kjQuery.ready(selector);
      }
      // 3.字符串:
      else if (kjQuery.isString(selector)) {
        // 2.1 判断是否是代码片段
        if (kjQuery.isHTML(selector)) {
          // 1. 根据代码片段创建所有的元素
          var temp = document.createElement("div");
          temp.innerHTML = selector;
          //   // 2. 创建好的一级元素添加到对象
          //   for (var i = 0; i < temp.children.length; i++) {
          //     this[i] = temp.children[i];
          //   }
          //   // 3. 给jQuery对象添加length属性
          //   this.length = temp.children.length;
          [].push.apply(this, temp.children);

          // this是kjQuery
          // 4. 返回加工好的this(jQuery)
        }
        // 2.2 判断是否是选择器
        else {
          // 1. 根据传入的选择器找到对应的元素
          var res = document.querySelectorAll(selector);
          // 2. 将找到的元素添加到kjQuery
          [].push.apply(this, res);
          // 3. 返回加工好的this
        }
      }
      // 3 数组
      else if (kjQuery.isArray(selector)) {
        /*
        //   3.1 真数组
        if ({}.toString.apply(selector) == "[object Array]") {
          [].push.apply(this, selector);
          return this;
        }
        //   3.2 伪数组
        else {
          // 将自定义的伪数组转换成真数组
          var arr = [].slice.call(selector);
          [].push.apply(this, arr);
          return this;
          // 但凡将自定义数组转换为真数组或伪数组都先转换为真数组
        }
        */
        var arr = [].slice.call(selector);
        [].push.apply(this, arr);
      }
      // 4. 其他类型
      else {
        this[0] = selector;
        this.length = 1;
      }
      return this;
    },
  };
  kjQuery.extend = kjQuery.prototype.extend = function (obj) {
    for (var key in obj) {
      this[key] = obj[key];
    }
  };
  kjQuery.extend({
    isString: function (str) {
      return typeof str === "string";
    },
    isHTML: function (str) {
      return (
        str.charAt(0) == "<" &&
        str.charAt(str.length - 1) == ">" &&
        str.length >= 3
      );
    },
    trim: function (str) {
      if (!kjQuery.isString(str)) {
        return str;
      }
      if (str.trim) {
        return str.trim();
      } else {
        // IE兼容处理方案
        return str.replace(/^\s+|\s+$/g, "");
      }
    },
    isObject: function (selector) {
      return typeof selector === "object";
    },
    isWindow: function (selector) {
      return selector === window;
    },
    isArray: function (selector) {
      if (
        kjQuery.isObject(selector) &&
        !kjQuery.isWindow(selector) &&
        "length" in selector
      ) {
        return true;
      }
      return false;
    },
    isFunction: function (selector) {
      return typeof selector === "function";
    },
    ready: function (fn) {
      // 判断DOM是否加载完毕
      if (document.readyState == "complete") {
        fn();
        //   判断是否含有addEventListener方法
      } else if (document.addEventListener) {
        document.addEventListener("DOMContentLoaded", function () {
          fn();
        });
      } else {
        //   IE兼容
        document.attachEvent("onreadystatechange", function () {
          if ((document.readyState = "complete")) {
            fn();
          }
        });
      }
    },
  });
  kjQuery.prototype.init.prototype = kjQuery.prototype;

  window.kjQuery = window.$ = kjQuery;
})(window);

```


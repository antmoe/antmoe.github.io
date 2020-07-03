# 二、jQuery核心函数和工具方法


## jQuery核心函数

jQuery的核心函数就是`$();`，圆括号内可以传递函数、字符串选择器、字符串代码片段、DOM元素等。

- 传递函数

  ```javascript
  $(function () {
      alert(1)
  })
  ```

- 字符串选择器

  返回一个jQuery对象，对象中保存了找到的DOM元素

  ```javascript
  $(function () {
      var $box1 = $(".box1")
      var $box2 = $("#box2")
      console.log($box1)
      console.log($box2)
  })
  ```

  ![image-20200614170145458](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/14/e1c565e92f84e41e4b2d1e3597bcc696.png)

- 字符串代码片段

  返回一个jQuery对象，对象中保存了创建的DOM元素

  ```javascript
  $(function () {
      var $p = $('<p>我是段落</p>')
      console.log($p)
  })
  ```

  ![image-20200614170314789](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/14/0423d06a705af89ab702ca6d1d7a8915.png)

- 接收一个DOM元素

  DOM元素会被包装成一个jQuery对象返回。

  ```javascript
  $(function () {
      var span = document.getElementsByTagName('span')[0]
      console.log(span)
      var $span = $(span)
      console.log($span)
  })
  ```

  ![image-20200614170407589](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/14/76eef71ab7a6494f83aeb8c60d942176.png)

## jQuery对象

jQuery对象是一个伪数组对象（有0到`length-1`的属性，并且有`length`属性）

```javascript
$(function () {
    var $div = $('div')
    console.log($div)
})
```

![image-20200614171552037](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/14/d7c4735e949be667c47fc47b4d061f77.png)

## 静态方法与实例方法

1. 静态方法通过类名调用

   ```javascript
   // 1. 定义一个类
   function AClass() {
   
   }
   // 2. 给这个类添加一个静态方法
   // 直接添加给类的就是静态方法
   AClass.staticMethod = function () {
       alert('staticMethod')
   }
   // 静态方法通过类名调用
   AClass.staticMethod();
   
   
   ```

2. 实例方法通过对象调用

   ```javascript
   // 定义一个类
   function AClass() {
   
   }
   // 给这个类添加一个实例方法
   AClass.prototype.instanceMethod = function () {
       alert('instanceMethod')
   }
   
   // 创建一个实例（创建一个对象）
   var a = new AClass()
   // 实例方法通过类的实例调用
   a.instanceMethod()
   ```

### each方法

<span class="inline-tag red">原生forEach方法</span>可以遍历数组，但**不可以**遍历伪数组。

```javascript
var arr = [1, 3, 5, 7, 9]
/*
        原生遍历：
        第一个参数：遍历到的元素
        第二个参数，遍历到的索引
        注意：原生forEach只能遍历数组，不能遍历伪数组
        */
arr.forEach(function (value, index) {
    console.log(index, value)
})

// 伪数组测试
var obj = { 0: 1, 1: 3, 2: 5, 3: 7, 4: 7, length: 5 }
obj.forEach(function (value, index) {
    console.log(index, value)
})
```

![image-20200614173946296](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/14/f0b2f3b1183aba2bbb2dc8a039e9fc22.png)

<span class="inline-tag red">jQuery的each方法</span>既可以遍历数组，又可以遍历伪数组

```javascript
var arr = [1, 3, 5, 7, 9]
var obj = { 0: 1, 1: 3, 2: 5, 3: 7, 4: 7, length: 5 }       
$.each(arr, function (index, value) {
    console.log(index, value)
})
$.each(obj, function (index, value) {
    console.log(index, value)
})
```

![image-20200614174726345](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/14/216245118a6348f80b982bb876b6c10d.png)

### map方法

<span class="inline-tag red">原生map方法</span>可以遍历数组，但**不可以**遍历伪数组。

```javascript
var arr = [1, 3, 5, 7, 9]
var obj = { 0: 1, 1: 3, 2: 5, 3: 7, 4: 7, length: 5 }
// 1. 利用原生的JS的map方法遍历
/*
        第一个参数：当前遍历到的元素
        第二个参数：当前遍历到的索引
        第三个参数：当前被遍历的数组
        注意点：
        不能遍历伪数组
        */
arr.map(function (value, index, arr) {
    console.log(value, index, arr)
})
obj.map(function (value, index, arr) {
    console.log(value, index, arr)
})
```

![image-20200614175627420](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/14/18d3ddfe7b9dfae91c9970dab771b124.png)

<span class="inline-tag red">jQuery的map方法</span>既可以遍历数组，又可以遍历伪数组

```javascript
var arr = [1, 3, 5, 7, 9]
var obj = { 0: 1, 1: 3, 2: 5, 3: 7, 4: 7, length: 5 }     
$.map(arr, function (value, index) {
    console.log(value, index)
})
$.map(obj, function (value, index) {
    console.log(value, index)
})
```

![image-20200614180008323](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/14/8d6a1d498ba018d11d5e8c664577d0ab.png)

<div class='tip warning'><p>jQuery中的each静态方法和map静态方法的区别<p></div>

1. `each`静态方法默认的返回值就是遍历谁就返回谁，而`map`静态方法默认的返回值就是一个空数组

   ![image-20200614180820494](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/14/b30d27c683b841479b4bd20c3bb6f872.png)

2. `each`静态方法不支持在回调函数中对遍历的数组进行处理，`map`静态方法可以在回调函数中通过`return`对遍历的数组进行处理

   ![image-20200614181236869](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/14/95bf288647e60c22ade4b4fe3fe31ac9.png)

### 去掉字符串首尾空格

`$.trim(str)`，该方法返回一个新的字符串。

```javascript
var str = '    tzk    '
var $res = $.trim(str)
console.log('---' + str + '---') // ---    tzk    ---
console.log('---' + $res + '---') // ---tzk---
```

### 判断传入的对象是否是window对象

`$.isWindow(obj)`，该方法返回一个布尔值。如果传入对象是window则返回true，否则返回false。

```javascript
var w = window
var res = $.isWindow(w);
console.log(res) //true
```

### 判断是否为数组

`$.isArray(arr)`，该方法返回一个布尔值，只有数组才会返回true，其他类型均返回false（包括伪数组）。



![image-20200614182558781](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/14/00ae825e0828ba1ca45966fc08c3fd3f.png)

### 判断是否为函数

`$.isFunction(fn)`，该方法返回一个布尔值。只有是一个函数时，才会返回true。

```javascript
var res = $.isFunction(fn)
```

<div class="snote red"><p>jQuery的本质上就是一个函数。</p></div>

### 暂停ready的执行

默认情况下当页面加载完毕，JQuery的ready入口函数将会自动执行。`$.holdReady(true)`可以暂停入口函数的执行，而`$.holdReady(false)`可以恢复执行。

```html
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.12.4/jquery.js"></script>
        <script>
            // $.holdReady(true) 暂停ready执行
            $.holdReady(true)
            $(document).ready(function () {
                alert('ready')
            });
        </script>
    </head>

    <body>
        <button>回复ready事件</button>
        <script>
            var btn = document.getElementsByTagName('button')[0]
            btn.onclick = function () {
                $.holdReady(false)
            }
        </script>
    </body>

</html>
```

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/14/c40188001dacad4e0807d141cbbe9d69.png)

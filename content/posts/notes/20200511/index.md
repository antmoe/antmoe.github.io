---
title: 14事件
date: 2020-05-11T19:05:50+08:00
categories: ["notes"]
---

# 表单操作

## 获取表单 

<div class="note info icon"><p>获取表单元素</p></div>

1. 通过常规方式

   Document对象方式。`document.getElementById('form')`等。

2. 通过Document的属性`forms`

   `document.forms`

   返回结果为`HTMLCollection`。

3. 通过表单的name名字。

   此方法不推荐。因为在新版本的浏览器中可能不再支持。

   > 如果返回结果为一个时类型为对象，多个时是集合。

<div class="note info icon"><p>获取表单组件元素</p></div>

1. 常规方式

   Document对象方式。`document.getElementById('form_input')`等。

2. 通过表单元素的属性`elements`

   ```javascript
   var f = document.forms[0]
   console.log(f.elements)
   ```

## 表单操作

### 文本框的操作

1. **选择**当前文本框的所有内容

   ```html
   <form action="#" id="myform">
       <input type="text" id="username" name="username" value="请输入用户名">
   </form>
   <script>
       var username = document.getElementById('username')
       username.select()
   </script>
   ```

   ![](https://cdn.jsdelivr.net/gh/blogimg/picbed@latest/2020/05/09/469935a49c4be15b4dcba34edcf7f4ed.png)

2. `select`事件

   简单来说就是当被选择时的触发的事件

   ```html
   <form action="#" id="myform">
       <input type="text" id="username" name="username" value="请输入用户名">
   </form>
   <script>
       var username = document.getElementById('username')
       username.addEventListener('select', function () {
           console.log('select')
       })
   </script>
   ```

   ![](https://cdn.jsdelivr.net/gh/blogimg/picbed@latest/2020/05/09/cc16d11362abb05178d9995f9ff8a91a.png)

3. 获取选择的文本内容

   - `selectionStart`

     选择文本内容的开始索引值

   - `selectionEnd`

     选择文本内容的结束索引值

   ```html
   <form action="#" id="myform">
       <input type="text" id="username" name="username" value="请输入用户名">
   </form>
   <script>
       var username = document.getElementById('username')
       username.addEventListener('select', function () {
           console.log(username.selectionStart, username.selectionEnd, username.value.slice(username.selectionStart, username.selectionEnd))
       })
   </script>
   ```

   ![](https://cdn.jsdelivr.net/gh/blogimg/picbed@latest/2020/05/09/b3f59f1dd81ee78d2ad2b5aa34f3f1ae.png)

4. 设置文本内容

   - `setSelectionRange(start,end,[opt])`

     参数分别为开始位置，结束位置和方向（`forward`、`backward`、`none`，分别表示从前往后，从后往前，选择方向位置或不重要）。

   ```html
   <form action="#" id="myform">
       <input type="text" id="username" name="username" value="请输入用户名">
   </form>
   <script>
       var username = document.getElementById('username')
       username.addEventListener('click', function () {
           username.setSelectionRange(1, 2)
       })
   </script>
   ```

   ![](https://cdn.jsdelivr.net/gh/blogimg/picbed@latest/2020/05/09/4a2ede3b1a080a1fd24c07f847b09769.png)

5. 操作剪切板

   操作剪切板的事件为`copy`、`cut`、`paste`。分别为复制、剪切、粘贴。

   - 复制操作示例

     ```javascript
     username1.addEventListener('copy', function () {
         console.log('这是一个复制操作。。。。')
     })
     ```

     ![](https://cdn.jsdelivr.net/gh/blogimg/picbed@latest/2020/05/11/9139a64f9ebe0478efb64e37bdd4ee2e.png)

   - 剪切操作示例

     ```javascript
     username1.addEventListener('cut', function () {
         console.log('这是一个剪切操作')
     })
     ```

     ![](https://cdn.jsdelivr.net/gh/blogimg/picbed@latest/2020/05/11/4c70e0fd4d2a1c0420617a43e5c6f89f.png)

   - 粘贴操作示例

     ```javascript
     var username2 = document.getElementById('username2')
     username2.addEventListener('paste', function (event) {
         // 阻止默认行为
         event.preventDefault()
         // 为了测试效果，将用户名替换成***
         if (result === '用户名') {
             result = '***'
         }
         username2.value = result
     })
     ```

     ![](https://cdn.jsdelivr.net/gh/blogimg/picbed@latest/2020/05/11/2a6582e629d98dc58b43d4b615b2d595.png)

   <div class="note info icon"><p>通过全局变量方式获取剪切板内容方式</p></div>

   也就是在全局作用域定义一个变量，这个变量用于存储每次用户复制后的内容。

   [https://antmoe.gitee.io/project/2020/05/11/01_操作剪切板.html](https://antmoe.gitee.io/project/2020/05/11/01_操作剪切板.html)

   ```html
   <!DOCTYPE html>
   <html lang="en">
   
       <head>
           <meta charset="UTF-8">
           <meta name="viewport" content="width=device-width, initial-scale=1.0">
           <title>Document</title>
       </head>
   
       <body>
           <form action="">
               <input type="text" id="username1" value="请输入你的用户名">
               <input type="text" id="username2">
               <input type="submit" value="">
           </form>
           <script>
               var username1 = document.getElementById('username1')
               // 全局变量方式
               var result
               // copy操作
               username1.addEventListener('copy', function () {
                   console.log('这是一个复制操作。。。。')
                   var value = username1.value
                   result = value.substring(username1.selectionStart, username1.selectionEnd)
                   // console.log(result)
               })
               // cut操作
               username1.addEventListener('cut', function () {
                   console.log('这是一个剪切操作')
               })
   
               var username2 = document.getElementById('username2')
               username2.addEventListener('paste', function (event) {
                   event.preventDefault()
                   if (result === '用户名') {
                       result = '***'
                   }
                   username2.value = result
               })
           </script>
       </body>
   
   </html>
   ```

   <div class="note info icon"><p>通过DataTransfer对象设置.</p></div>

   1. DataTransfer对象通过事件获取

      存在兼容性问题,因此使用或操作符.

      ```javascript
      username2.addEventListener('paste', function (event) {
          var data = event.clipboardData || window.clipboardData
      })
      ```

   2. DataTransfer提供的方法

      - 为一个给定的类型设置数据

        `setData(in String type,in String data)`

        ```javascript
        var result = '666'
        data.setData('text', result)
        ```

      - 根据指定的类型检索数据

        `getData(in String type)`

        ```javascript
        data.getData('text')
        ```

      - 删除与给定类型关联的数据

        `clearData([in String type])`

   [https://antmoe.gitee.io/project/2020/05/11/02_操作剪切板.html](https://antmoe.gitee.io/project/2020/05/11/02_操作剪切板.html)

   ```html
   <!DOCTYPE html>
   <html lang="en">
   
       <head>
           <meta charset="UTF-8">
           <meta name="viewport" content="width=device-width, initial-scale=1.0">
           <title>Document</title>
       </head>
   
       <body>
           <form action="">
               <input type="text" id="username1" value="请输入你的用户名">
               <input type="text" id="username2">
               <input type="submit" value="">
           </form>
           <script>
               var username1 = document.getElementById('username1')
               // copy操作
               username1.addEventListener('copy', function (event) {
                   var data = event.clipboardData || window.clipboardData
                   console.log(data)
                   console.log('这是一个复制操作。。。。')
                   var value = username1.value
                   result = value.substring(username1.selectionStart, username1.selectionEnd)
                   console.log(result)
                   data.setData('text', result)
               })
               var username2 = document.getElementById('username2')
               username2.addEventListener('paste', function (event) {
                   var data = event.clipboardData || window.clipboardData
                   var result = data.getData('text')
                   event.preventDefault()
                   if (result === '用户名') {
                       result = '***'
                   }
                   username2.value = result
               })
           </script>
       </body>
   
   </html>
   ```

6. 下拉列表操作

   1. `HTMLSelectElement`对象

      ```javascript
      // 属性
      
      // HTMLSelectElement
      var city = document.getElementById('city')
      // <option>的元素个数
      console.log(city.length)
      // <option>的元素
      console.log(city.options)
      // 代表第一个被选中的<option>元素 -1表示没有元素被选中
      console.log(city.selectedIndex) //北苑中<option>的索引值
      
      var city2 = document.getElementById('city2')
      // size属性默认为0 等价于HTML的size属性
      console.log(city2.size)
      // 是否为多选框
      console.log(city2.multiple)
      //方法
      
      // 返回索引值为1的<option>元素.
      console.log(city2.item(1))
      // 删除索引为2的元素
      city2.remove(2)
      // 添加一个元素,在索引0之前
      var o = document.createElement('option')
      o.value = '666'
      o.textContent = '666'
      city2.add(o, 0)
      ```

   2. `HTMLOptionElement`对象

      ```javascript
      // HTMLOptionElement对象提供的属性
      var bj = document.getElementById('bj')
      // 当前元素在其所属的选项列表中的索引值
      console.log(bj.index)
      // 当前<option>元素是否被选中
      console.log(bj.selected)
      // 当前<option>元素的文本内容
      console.log(bj.text)
      // 当前<option>元素的value属性值
      console.log(bj.value)
      ```

      [https://antmoe.gitee.io/project/2020/05/11/03_下拉列表操作.html](https://antmoe.gitee.io/project/2020/05/11/03_下拉列表操作.html)

   ```html
   <!DOCTYPE html>
   <html lang="en">
   
   <head>
       <meta charset="UTF-8">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>Document</title>
   </head>
   
   <body>
       <form action="">
           <select name="" id="city">
               <option id="bj" value="bj">北京</option>
               <option value="nj">南京</option>
               <option value="tj">天津</option>
           </select>
           <select name="" id="city2" multiple size="5">
               <option value="bj">北京</option>
               <option value="nj">南京</option>
               <option value="tj">天津</option>
           </select>
       </form>
       <script>
           // HTMLSelectElement
           var city = document.getElementById('city')
           // 属性
           // <option>的元素个数
           console.log(city.length)
           // <option>的元素
           console.log(city.options)
           // 代表第一个被选中的<option>元素 -1表示没有元素被选中
           console.log(city.selectedIndex) //北苑中<option>的索引值
           var city2 = document.getElementById('city2')
           // size属性默认为0 等价于HTML的size属性
           console.log(city2.size)
           // 是否为多选框
           console.log(city2.multiple)
           // 返回索引值为1的<option>元素.
           console.log(city2.item(1))
           // 删除索引为2的元素
           city2.remove(2)
           // 添加一个元素,在索引0之前
           var o = document.createElement('option')
           o.value = '666'
           o.textContent = '666'
           city2.add(o, 0)
           // HTMLOptionElement对象提供的属性
           var bj = document.getElementById('bj')
           // 当前元素在其所属的选项列表中的索引值
           console.log(bj.index)
           // 当前<option>元素是否被选中
           console.log(bj.selected)
           // 当前<option>元素的文本内容
           console.log(bj.text)
           // 当前<option>元素的value属性值
           console.log(bj.value)
   
       </script>
   </body>
   
   </html>
   ```

## 表单验证

<div class="note info icon"><p>HTML5验证API属性</p></div>

*以下方法通过validity调用.`username.validity.valueMissing`*

|       名称        |  类型   |                             描述                             |
| :---------------: | :-----: | :----------------------------------------------------------: |
|   `customError`   | Boolean | 该元素的自定义有效性消息已经通过调用元素的setCustomValidity() 方法设置成为一个非空字符串. |
| `patternMismatch` | Boolean |            该元素的值与指定的`pattern`属性不匹配.            |
|  `rangeOverflow`  | Boolean |               该元素的值大于指定的 `max`属性.                |
| `rangeUnderflow`  | Boolean |               该元素的值小于指定的 `min`属性.                |
|  `stepMismatch`   | Boolean |           该元素的值不符合由`step`属性指定的规则.            |
|     `tooLong`     | Boolean | 该元素的值的长度超过了HTMLInputElement 或者 HTMLTextAreaElement 对象指定的**maxlength**属性中的值.<br>**注意:**在Gecko中,该属性永远不会为`true`,因为浏览器会阻止元素的值的长度超过**maxlength**. |
|  `typeMismatch`   | Boolean | 该元素的值不符合元素类型所要求的格式(当`type` 是 `email` 或者 `url时`). |
|      `valid`      | Boolean |                其他的约束验证条件都不为true.                 |
|  `valueMissing`   | Boolean |             该元素有 `required` 属性,但却没有值.             |

<div class="note info icon"><p>HTML5验证API方法</p></div>

|            方法名            |                             描述                             |
| :--------------------------: | :----------------------------------------------------------: |
|      `checkValidity()`       |     如果元素的值不存在验证问题，返回true，否则返回 false     |
| `setCustomValidity(message)` | 为元素添加一个自定义的错误消息：如果设置了自定义错误消息，则该元素被认是无效的，并显示指定的错误 |

1. 判断输入是否为空

   ```javascript
   username.addEventListener('blur', function () {
       if (username.validity.valueMissing) {
           console.log('用户名为空了')
       }
   })
   ```

   ![](https://cdn.jsdelivr.net/gh/blogimg/picbed@latest/2020/05/11/aad4e7ed81484508d2d876d4bb299e8b.png)

2. 设置错误提示

   ```javascript
   username.addEventListener('blur', function () {
       if (username.validity.valueMissing) {
           username.setCustomValidity('用户名不能为空')
       }else {
           username.setCustomValidity('')
       }
   })
   ```

   ![](https://cdn.jsdelivr.net/gh/blogimg/picbed@latest/2020/05/11/5719f031680b0a378e8935c84039ca79.png)

   > 需要注意的是,当设置自定义错误后,需要在反情况下再次设置空字符串,否则验证会一致失败.如上代码所示.

> 另外需要注意的是：所有的验证都是在触发提交事件时才会被触发。也就是当点击`submit`按钮时，才会验证。

[https://antmoe.gitee.io/project/2020/05/11/04_HTML5表单验证.html](https://antmoe.gitee.io/project/2020/05/11/04_HTML5表单验证.html)

```html
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
    </head>

    <body>
        <form action="">
            <input type="text" id="username" required pattern="^[0-9a-zA-Z]$">
            <input type="submit">
        </form>
        <script>

            var username = document.getElementById("username")
            /*
            表单组件元素对应的对象提供了validity属性
        */
            // console.log(username.validity)
            // 配合元素中required属性来使用 
            // true 表示当前内容为空  false表示当前元素内容不为空
            // console.log(username.validity.valueMissing)
            username.addEventListener('blur', function () {
                if (username.validity.valueMissing) {
                    username.setCustomValidity('用户名不能为空')
                } else {
                    username.setCustomValidity('')
                }

                if (username.validity.patternMismatch) {
                    username.validity.setCustomValidity('用户名格式错误')
                } else {
                    username.setCustomValidity('')
                }
            })
            // console.log(username.validity.)
        </script>
    </body>

</html>
```



## 表单提交

1. `submit`事件

   ```javascript
   var form = document.forms[0]
   form.addEventListener('submit', function (e) {
       console.log('当前表单以被提交')
       e.preventDefault()
   })
   ```

2. `submit()`

   ```javascript
   var btn = document.getElementById('btn')
   btn.addEventListener('click', function (e) {
       form.submit()
   })
   ```

[https://antmoe.gitee.io/project/2020/05/11/05_表单提交.html](https://antmoe.gitee.io/project/2020/05/11/05_表单提交.html)
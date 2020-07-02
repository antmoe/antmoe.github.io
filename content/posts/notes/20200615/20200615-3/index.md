---
title: 三、jQuery属性操作
date: 2020-06-15T18:50:52+08:00
categories: ["notes"]
tags: ["jQuery"]
---

## jQuery内容选择器

为了方便测试，先将DOM元素写为以下格式：

```html
<div></div>
<div>我是div</div>
<div>我是div123</div>
<div><span></span></div>
<div><p></p></div>
```

1. `:empty`找到既没有文本内容也没有子元素的指定元素。

   *这个选择器对于以上内容只能找到第一个div。*

   ```javascript
   var $div = $('div:empty')
   console.log($div)
   ```

   ![image-20200615142932500](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/15/7a245ffc65436d81ebb2875b9647d9f3.png)

2. `:parent` 找到有文本内容或有子元素的指定元素

   *可以找到除第一个意外的四个元素*

   ```javascript
   var $div = $('div:parent')
   console.log($div)
   ```

   ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/15/d6774408d217ff78660c94fe964ac9e6.png)

3. `:contains(text)`找到包含指定文本内容的指定元素

   *视内容找到包含内容的div*

   ```javascript
   var $div = $('div:contains("我是div123")')
   console.log($div)
   ```

   ![image-20200615143646748](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/15/31e6aadb60a87f1589f604a866403b7c.png)

4. `:has(selector)`找到包含指定子元素的指定元素

   *视搜索内容找到包含此子元素的元素*

   ```javascript
   var $div = $('div:has("span")')
   console.log($div)
   ```

   ![image-20200615143837461](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/15/e49d3e536eb5aa8a172947838aa73369.png)



## 属性和属性节点

1. 什么是属性

   对象身上保存的变量就是属性

   ```javascript
   function Person() {}
   var p = new Person()
   p.name = 'tzk'
   ```

2. 如何操作属性

   对象.属性名称 = 值

   对象.属性名称

   对象['属性名称'] = 值

   对象['属性名称']

   ```javascript
   // 赋值属性
   p['name'] = 'tzk'
   // 获取属性
   console.log(p.name)
   ```

3. 什么是属性节点

   `<span name='xiaokang'></span>` 在编写HTML代码时，在HTML标签中添加的属性就是属性节点。

   在浏览器中找到`span`这个DOM元素之后，展开看到的都是属性。

   在attributes属性中保持的所有内容都是属性节点。

4. 操作属性节点

   ```javascript
   var span = document.getElementsByTagName('span')[0]
   // 设置属性
   span.setAttribute('name', 'tzk')
   // 获取属性
   console.log(span.getAttribute('name'))
   ```

   ![image-20200615145341815](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/15/1d920febfe1d7bc0c5e75e858bd8b046.png)

   ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/15/1d920febfe1d7bc0c5e75e858bd8b046.png)

5. 属性和属性节点的区别

   任何对象都有属性，但只有DOM对象才有属性节点

## attr方法

1. `attr(name|pro|key,val|fn)`方法

   - 获取或者设置属性节点的值

   - 参数

     - 可以传递一个参数，代表获取节点的值

       无论找到多少个元素，只会返回第一个元素指定的属性节点的值。

       ```html
       <!DOCTYPE html>
       <html lang="en">
       
           <head>
               <meta charset="UTF-8">
               <meta name="viewport" content="width=device-width, initial-scale=1.0">
               <title>Document</title>
               <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.12.4/jquery.js"></script>
               <script>
                   $(function () {
                       console.log($("span").attr('class')) // span1
                   })
               </script>
           </head>
       
           <body>
               <span class="span1" name='name1'></span>
               <span class="span2" name='name2'></span>
           </body>
       
       </html>
       ```

     - 也可以传递两个参数，设置属性节点的值

       如果设置值，找到多少个元素就会设置多少个元素。

       如果设置的节点不存在，那么会新增该属性。

       ```html
       <!DOCTYPE html>
       <html lang="en">
       
           <head>
               <meta charset="UTF-8">
               <meta name="viewport" content="width=device-width, initial-scale=1.0">
               <title>Document</title>
               <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.12.4/jquery.js"></script>
               <script>
                   $(function () {
                       $('span').attr('class', 'box')
                   })
               </script>
           </head>
       
           <body>
               <span class="span1" name='name1'></span>
               <span class="span2" name='name2'></span>
           </body>
       
       </html>
       ```

2. `removeAttr(name)`节点

   - 删除属性节点

   - 参数

     会删除所有找到元素指定的属性节点

     - 删除一个节点

       ```html
       <!DOCTYPE html>
       <html lang="en">
       
           <head>
               <meta charset="UTF-8">
               <meta name="viewport" content="width=device-width, initial-scale=1.0">
               <title>Document</title>
               <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.12.4/jquery.js"></script>
               <script>
                   $(function () {
                       $('span').removeAttr('class')
                   })
               </script>
           </head>
       
           <body>
               <span class="span1" name='name1'></span>
               <span class="span2" name='name2'></span>
           </body>
       
       </html>
       ```

       ![image-20200615151335448](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/15/745a70c62bd755cb16ec7bbc04ba39fa.png)

     - 删除多个属性

       只需要在传递参数时用空格隔开即可。

       ```javascript
       $('span').removeAttr('class name')
       ```

       ![image-20200615151424496](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/15/8914eafe82f1703f5f6ad9fd39034bb3.png)

   

## prop方法

`prop`方法与`attr`方法一致。

1. 设置或新增属性

   ```javascript
   $("span").eq(0).prop('demo', 'name1')
   $("span").eq(1).prop('demo', 'tzk')
   ```

   ![image-20200615152658852](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/15/914cffd3aa644a1057208025dd631ee4.png)

2. 获取属性

   ```javascript
    console.log($('span').prop('demo')) //name1
   ```

3. 删除属性

   ```javascript
   $("span").removeProp('demo')
   ```

4. 操作属性节点

   官方推荐在操作属性节点时，具有`true`和`false`两个属性的属性节点，如`checked`, `selected`或者`disabled`使用`prop()`,其他的使用`attr()`

   ```javascript
   console.log($('.input1').prop('checked')) //true
   console.log($('.input1').attr('checked')) //checked
   console.log($('.input2').prop('checked')) //false
   console.log($('.input2').attr('checked')) //undefined
   ```

### 图片切换的小案例

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/15/a1c0a76f7ee40839aec3b74bc70feaf2.png)

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.12.4/jquery.js"></script>
    <script>
        $(function () {
            // 编写jQuery相关代码
            // 1. 给按钮添加点击事件
            var btn = document.getElementsByTagName('button')[0]
            btn.onclick = function () {
                // 2. 获取输入框输入的内容
                var input = document.getElementsByTagName('input')[0]
                var text = input.value
                // 3. 修改img的src属性节点的值
                $('img').attr('src', text)
                // $('img').prop('src', text)
            }
        })
    </script>
</head>

<body>
    <input type="text">
    <button>切换图片</button><br />
    <img src="https://www.baidu.com/img/dongsc_eb45d000832f8e889ff64951eaf7f381.gif" alt="">
</body>

</html>
```

## jQuery类操作相关方法

```html
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <style>
            * {
                margin: 0;
                padding: 0;
            }

            .class1 {
                width: 100px;
                height: 100px;
                background: red;
            }

            .class2 {
                border: 5px solid black
            }
        </style>
        <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.12.4/jquery.js"></script>
        <script>
            $(function () {
                var btns = document.getElementsByTagName('button')
                })
        </script>
    </head>

    <body>
        <button>添加类</button>
        <button>删除类</button>
        <button>切换类</button>
        <div></div>
    </body>

</html>
```



1. 添加与删除类

   ```javascript
   btns[0].onclick = function () {
       // 添加多个类用空格隔开
       $('div').addClass('class1 class2')
   }
   btns[1].onclick = function () {
       // 删除多个类用空格隔开
       $('div').removeClass('class1 class2')
   }
   ```

   ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/15/ae14a1b25cde0b55c306e4928676b34f.png)

2. 切换类

   ```javascript
   btns[2].onclick = function () {
       // 多个用空格隔开
       $('div').toggleClass('class1 class2')
   }
   ```

   ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/15/61e500b7479c6c596b162ceab4901e42.png)



## 文本值相关操作

```html
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <style>
            * {
                margin: 0;
                padding: 0;
            }

            div {
                width: 100px;
                height: 100px;
                border: 1px solid #000;
            }
        </style>
        <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.12.4/jquery.js"></script>
        <script>
            $(function () {
                var btns = document.getElementsByTagName('button')
                })
        </script>
    </head>

    <body>
        <button>设置HTML</button>
        <button>获取HTML</button>
        <button>设置text</button>
        <button>获取text</button>
        <button>设置value</button>
        <button>获取text</button>
        <div></div>
        <input type="text">
    </body>

</html>
```



1. `html([val|fn])`，用于设置元素的html元素。

   类似原生js中的`innerHTML`方法

   - 如果传入参数，则代表将当前元素的html修改为参数输入内容

     ```javascript
     btns[0].onclick = function () {
         $('div').html('<p>我是一个段落<span>我是一个span</span></p>')
     }
     ```

     ![image-20200615174005610](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/15/51944b3da54a4a33f5f3387187466bc5.png)

   - 如果不传入参数，则代表获取当前元素的HTML代码。

     ```javascript
     btns[1].onclick = function () {
         console.log($('div').html())
     }
     ```

     ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/15/dafdc3f6282ea863069836ac8cfc5186.png)

2. `text([val|fn])`

   类似原生js中的`innerText`方法。参数传入与`html()`方法一模一样

   ```javascript
   btns[2].onclick = function () {
       $('div').text('<p>我是一个段落<span>我是一个span</span></p>')
   }
   btns[3].onclick = function () {
       console.log($('div').text())
   }
   ```

   ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/15/ecda8d11282ce6210348c04cb76ffea5.png)

3. `val([val|fn|arr])`

   与value属性类似。参数传入与前两种一模一样。

   ```javascript
   btns[4].onclick = function () {
       $('input').val('请输入内容：')
   }
   btns[5].onclick = function () {
       $('input').val()
   }
   ```

   ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/15/24b96be6f8e034f4045c85f2ee162082.png)



## 操作样式方法

1. 设置属性值

   - 逐个设置

     ```javascript
     $('div').css('width', '100px')
     $('div').css('height', '100px')
     $('div').css('background', 'red')
     ```

   - 链式设置

     如果大于3步，建议分开

     ```javascript
     $('div').css('width', '100px').css('height', '100px').css('background', 'blue')
     ```

   - 批量设置

     参数可以传入一个对象，对象内传入css样式。

     ```javascript
     $('div').css({
         width: '100px',
         height: '100px',
         background: 'red'
     })
     ```

2. 获取css样式。

   传入参数即需要获取的样式名称。

   ```javascript
   console.log($('div').css('width'))
   ```

   ![image-20200615180236759](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/15/00792e5e8293230db6f67e6f8397159c.png)

## 尺寸和位置相关

### 尺寸

以`width()`方法为例。

```html
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <style>
            * {
                margin: 0;
                padding: 0;
            }

            .father {
                width: 200px;
                height: 200px;
                border: 50px solid #000;
                background: red;
                margin-left: 50px;
                position: relative;
            }

            .son {
                width: 100px;
                height: 100px;
                background: blue;
                position: absolute;
                left: 50px;
                top: 50px;

            }
        </style>
        <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.12.4/jquery.js"></script>
        <script>
            $(function () {
                var btns = document.getElementsByTagName('button')
                btns[0].onclick = function () {
                    // 获取元素的宽度
                    console.log($('.father').width()) //200
                }
                btns[1].onclick = function () {
                    console.log($('.father').width('500px'))
                }
            })
        </script>
    </head>

    <body>
        <div class="father">
            <div class="son"></div>
        </div>
        <button>获取</button>
        <button>设置</button>
    </body>

</html>
```

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/15/32c2ed9a615e012ead7c6a2ffeafbb19.png)

### 位置

1. `offset()`获取距离**窗口**的偏移位。

   - 获取

     例如获取距离左边的偏移位`$('div').offset().left`

   - 设置

     参数内传入一个对象，对象内写需要设置的属性

     ```javascript
     btns[1].onclick = function () {
         $('.son').offset({
             left: 10
         })
     }
     ```

   ```html
   <!DOCTYPE html>
   <html lang="en">
   
       <head>
           <meta charset="UTF-8">
           <meta name="viewport" content="width=device-width, initial-scale=1.0">
           <title>Document</title>
           <style>
               * {
                   margin: 0;
                   padding: 0;
               }
   
               .father {
                   width: 200px;
                   height: 200px;
                   border: 50px solid #000;
                   background: red;
                   margin-left: 50px;
                   position: relative;
               }
   
               .son {
                   width: 100px;
                   height: 100px;
                   background: blue;
                   position: absolute;
                   left: 50px;
                   top: 50px;
   
               }
           </style>
           <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.12.4/jquery.js"></script>
           <script>
               $(function () {
                   var btns = document.getElementsByTagName('button')
                   btns[0].onclick = function () {
                       console.log($('.son').offset().left) //150
                   }
                   btns[1].onclick = function () {
                       $('.son').offset({
                           left: 10
                       })
                   }
               })
           </script>
       </head>
   
       <body>
           <div class="father">
               <div class="son"></div>
           </div>
           <button>获取</button>
           <button>设置</button>
       </body>
   
   </html>
   ```

   ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/15/00b11eca3c7cb76223e7ad9b5271eb2b.png)

2. `position`获取元素距离**定位**元素的偏移位

   该方法只有获取不能设置，但可以通过css方式进行设置

   ```html
   <!DOCTYPE html>
   <html lang="en">
   
   <head>
       <meta charset="UTF-8">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>Document</title>
       <style>
           * {
               margin: 0;
               padding: 0;
           }
   
           .father {
               width: 200px;
               height: 200px;
               border: 50px solid #000;
               background: red;
               margin-left: 50px;
               position: relative;
           }
   
           .son {
               width: 100px;
               height: 100px;
               background: blue;
               position: absolute;
               left: 50px;
               top: 50px;
   
           }
       </style>
       <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.12.4/jquery.js"></script>
       <script>
           $(function () {
               var btns = document.getElementsByTagName('button')
               btns[0].onclick = function () {
                   console.log($('.son').position().left) //50
               }
               btns[1].onclick = function () {
                   // 无法设置，即使设置也不生效
                   $('.son').position({
                       left: 10
                   })
               }
           })
       </script>
   </head>
   
   <body>
       <div class="father">
           <div class="son"></div>
       </div>
       <button>获取</button>
       <button>设置</button>
   </body>
   
   </html>
   ```

   ![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/15/c64aa854b3b115cc5935730ad171a882.png)

## scrollTop方法

1. 获取滚动偏移量

   - 元素

     ```javascript
     btns[0].onclick = function () {
         console.log($('.scroll').scrollTop())
     }
     ```

   - 网页

     ```javascript
     console.log($('html').scrollTop())
     ```

     IE浏览器下可能无法获取，需要将`html`换成`body`。常用写法如下：

     ```javascript
     console.log($('html').scrollTop()+$('body').scrollTop())
     ```

2. 设置滚动偏移量

   参数传入为整型，而不是字符串类型。

   - 元素

     ```javascript
     btns[1].onclick = function () {
         $('.scroll').scrollTop(300)
     }
     ```

   - 网页

     ```javascript
     $('html').scrollTop(300)
     ```

     同样的IE浏览器不可使用，需要对`body`进行设置。通常写法如下：

     ```javascript
     $('html,body').scrollTop(300)
     ```

     

   
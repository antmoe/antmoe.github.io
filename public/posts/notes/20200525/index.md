# JavaScript的面向对象与Object对象


# JavaScript中的面向对象

## 面向对象是什么

面向对象编程的全称为 Object Oriented Prograrnming，简称为**OOP**。面向对象编程是用抽象方式创建基于现实世界模型的一种编程模式。

> 面向对象编程可以看作是使用一系列对象相互协作的软件设计。面向对象程序设计的目的是在编程中促进更好的灵活性和可维护性。凭借其对模块化的重视，面向对象的代码开发更简单，更容易理解。
>
> 所有的程序是由一定的属性和行为对象组成的，不同的对象的访问通过函数调用来完成，对象间所有的交流都是通过方法调用，通过对封装对象数据，提高复用率。

面向对象编程的三个主要特征是：封装；2)继承；3)多态。

<div class="note warning icon"><p>任何事物都可以看作对象，相似的可以看作一类。类是群体，对象是个体。</p></div>

JavaScript是一种**基于原型**的面向对象语言，而不是基于类的。

### 封装

只关心入口和出口，而不关心过程

### 继承

继承通常是指类与类之间的关系。如果两个类都有相同的属性或方法，那么可以让一个类继承于另类，这样就不需要在前者再次定义同样的属性或方法。

### 多态

不同的对象可以定义具有相同名称的方法，方法是作用于所在的对象中。这种不同对象通过相同方法的调用实现各自行为的能力，被称之为多态。

## 构造函数

> 构造函数又称为构造器或对象模板，是对象中的一个方法，在实例化时构造器被调用。在 JavaScrip中函数就可以作为构造器使用，因此不需要特别地定义一个构造器方法。

```javascript
/** 创建构造函数
 * 用于创建对象
 *  * 属性
 *  * 方法
 *
 *  function 构造函数名称(){
 *      this.属性名='属性值'
 *      this.方法名=function(){
 *          方法体
 *      }
 *  }
 */
function Hero() {
  this.name = "张无忌";
  this.sayMe = function () {
    console.log("我是张无忌");
  };
}
var hero = new Hero();
console.log(hero);
```



![image-20200525150610774](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/05/25/e5a9ff410ec8b2c51d655e5087357a14.png)

<span class="inline-tag green">为类添加参数</span>

```javascript
function Hero(name) {
  this.name = name;
  this.sayMe = function () {
    console.log("我是" + name);
  };
}
var hero = new Hero("张无忌123");
console.log(hero);
```

![image-20200525151045054](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/05/25/d48c287e11079a8196babfefc59f46ed.png)

<span class="inline-tag grey">函数与构造函数</span>

函数与构造函数并没有本质区别。也可以相互混写，例如：

```javascript
// 1. 函数\构造函数
function Hero() {
  // 局部变量
  var v = 100;
  // 内部函数
  function n() {}
  this.name = "name";
  this.test = function () {
    console.log("test");
  };
}
Hero();
var hero = new Hero();
```

将构造函数的内容写入到函数内容中，通过函数方式调用或者构造函数方式都是可以的，并不会出现语法错误。

![image-20200525152907367](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/05/25/c590d829b70baf5fbaaceb103e557a4a.png)

```javascript
var fun = new Fun();
// 获取V的值
console.log(fun.get());
// 重新设置v的值
fun.set(200)
// 再次打印v的值
console.log(fun.get());

```

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/05/25/24676359ef430eaece3f5423f642cf77.png)

## Object对象

创建对象的三种形式

1. 创建空对象

   ```javascript
   var obj1 = new Object(null);
   var obj2 = new Object(undefined);
   ```

2. 创建一个与给定值对应类型的对象

   ```javascript
   var obj3 = new Object(100);
   console.log(obj3); //[Number: 100]
   ```

3. 当以非构造函数形式被调用时，Object 等同于 new Object()。

   ```javascript
   var obj4 = Object(); //函数调用
   var obj5 = new Object(); //构造函数调用
   ```

### 属性描述符

Javascript提供了一个内部数据结构，用于描述对象的值，控制其行为，例如该属性是否可写、是否可配置、是否可修改以及是否可枚举等。这个内部数据结构被称为“属性描述符”。

**对象里目前存在的属性描述符有两种主要形式：数据描述符和存取描述符。**

### 数据描述符

|       键       |                              值                              |   默认值    |
| :------------: | :----------------------------------------------------------: | :---------: |
|    `value`     | 该属性对应的值，可以是任何有效的Javascript值（数值，对象，函数等）。 | `undefiend` |
|   `writable`   | 当且仅当该属性的`writable`为`true`时， valueオ能被赋值运算符改変。 |   `false`   |
| `configurable` | 当且仅当该属性的`configurable`为`true`时，该属性描述符才能够被改变，同时该属性也能从对应的对象上被删除。 |   `false`   |
|  `enumerable`  | 当且仅当该属性的`enumerable`为`true`时，该属性才能够出现在对象的枚举属性中。 |   `false`   |

### 存取描述符

|       键       |                              值                              | 默认值  |
| :------------: | :----------------------------------------------------------: | :-----: |
|     `get`      | 给属性提供`getter`的方法，如果没有`getter`则为`undefined`。当访问该属性时，该方法会被执行，方法执行时没有参数传入，但是会传人`this`对象。 |         |
|     `set`      | 给属性提供`setter`的方法，如果没有`setter`则为undefined。当属性值修改时，触发执行该方法。该方法将接受唯一参数，即该属性新的参数值 |         |
| `configurable` | 当且仅当该属性的`configurable`为`true`时，该属性描述符才能够被改变，同时该属性也能从对应的对象上被删除。 | `false` |
|  `enumerable`  | 当且仅当该属性的`enumerable`为`true`时，该属性才能够出现在对象的枚举属性中。 | `false` |

### 获取属性描述符

通过`Object.getOwnPropertyNames(object,prop)`方法获取属性描述符，其中:

- `object`

  表示指定属性对应的目标对象

- `prop`

  表示描述符的目标属性名称

- 返回值

  其属性描述符对象

```javascript
/**
 * 通过定义对象(属性火方法)这种方式
 * 属性默认都是数据描述符
 */
var obj = {
  name: "张无忌",
};
/**
 * 使用Object.getOwnPropertyNames()方法获取指定属性的描述符
 *  Object.getOwnPropertyNames(object,prop)
 *  object - 表示指定属性对应的目标对象
 *  prop - 表示描述符的目标属性名称
 *  返回值 - 其属性描述符对象
 *
 *
 * */
var result = Object.getOwnPropertyDescriptor(obj, "name");
console.log(result); //{ value: '张无忌', writable: true, enumerable: true, configurable: true }
console.log(result.value); //张无忌

```

![image-20200525182426781](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/05/25/64d246f4c2025025be3cda1ff7c630d1.png)

### 设置属性描述符

设置属性使用`Object.defineProperty(obj,prop,desc)`方法，他的作用有两个：用于定义目标对象的新属性、修改目标对象的已存在属性。其中：

- `obj`

  表示目标对象

- `prop`

  表示目标对象的目标属性名称

- `desc`

  表示属性描述符,必须是对象的格式。

  ```javascript
  {
      value: ''
  }
  ```

- 返回值

  返回传递的对象

<div class="note info icon"><p>设置value值</p></div>

1. 修改一个值

   ```javascript
   var obj = {
     // 定义对象的同时定义了该属性以及值(可修改,可删除,可枚举)
     name: "张无忌",
   };
   Object.defineProperty(obj, "name", { value: "周芷若" });
   console.log(obj);
   ```

2. 新增一个值

   ```javascript
   Object.defineProperty(obj, "age", {
       value: 18,
   });
   console.log(obj.age); //18
   ```

<span class="inline-tag yellow">与常规方式的区别</span>

- 如果使用"对象名.属性名 = 值" 

  可修改,可删除,可枚举

  ![image-20200525185644351](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/05/25/45b4a6b90bf0280871c7d9bb446c6328.png)

- 如果使用`Object.defineProperty()`方法新增属性

  不可修改命不可删除以及不可枚举

  ![image-20200525185448117](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/05/25/8131ada4df008881f91402ab56d3a1e9.png)

<div class="note danger icon"><p>一旦属性的值是不可修改的，执行修改操作:没有语法错误,但修改无效</p></div>

由图可以得知：用`Object.defineProperty()`方法新增属性后，再次修改后输出，值并未发生变化。

![image-20200525185908552](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/05/25/6032673ec35a73b2696a0c137cd632e7.png)

<div class="note info icon"><p>设置wriable值</p></div>

该值为布尔值，默认为`false`。表示属性值可否被修改。

1. 修改现有属性

   当`writable`为false时，无法修改其属性。

   ```javascript
   var obj = {
     // 定义对象的同时定义了该属性以及值(可修改,可删除,可枚举)
     name: "张无忌",
   };
   // 修改现有属性
   Object.defineProperty(obj, "name", {
     value: "周芷若",
     writable: false,
   });
   console.log(obj.name); //周芷若
   // 修改name属性值
   obj.name = "赵敏";
   console.log(obj.name); //周芷若
   ```

   ![image-20200525190849263](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/05/25/04873fda9f2cfb2ffe27ef4f7fcaae89.png)

2. 新增属性

   与修改同理当`writable`为false时，无法修改其属性。为true时可以修改.

   ![image-20200525191011582](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/05/25/c43e3f51bc843ec84345402e024178fc.png)

   ![image-20200525191025302](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/05/25/e0cc677276fe30bd28332c698cf0a369.png)

<div class="note info icon"><p>设置configurable值</p></div>

Booleant值，表示目标属性的描述符是否可以被修改。当且仅当该属性的configurable为true时，该属性描述符才能够被改变，同时该属性也能从对应的对象上被删除.默认为`false`

![image-20200525191541996](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/05/25/df3517d733fd0b85b26bc7337d205807.png)

![image-20200525191604800](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/05/25/8fc22fdbcda326da3491154e767e81af.png)

<div class="note info icon"><p>设置enumerable值</p></div>

```javascript
var obj = {
  // 定义对象的同时定义了该属性以及值(可修改,可删除,可枚举)
  name: "张无忌",
};
Object.defineProperty(obj, "name", {
  value: "周芷若",
  enumerable: false,
});
console.log(obj.name);

/** 属性描述符enumerable - 控制当前属性是否可被枚举（遍历）
 * 仅能循环遍历对象中可被枚举的属性
 *   * for...in语句
 *   * keys()方法
 * 可以循环遍历对象中可被枚举和不可被枚举的属性
 * getOwnPropertyNames()方法
 */

for (var i in obj) {
  console.log(i);
}

var result1 = Object.keys(obj);
console.log(result1);
var result2 = Object.getOwnPropertyNames(obj);
console.log(result2);

```

以上代码执行结果:

![image-20200525193053912](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/05/25/07637737e8bfc274f255fda583f55b34.png)

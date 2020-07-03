# 继承（一）


## 原型链

### 原型链是什么

如果构造函数或对象A，A的原型指向构造函数或对象B，B的原型再指向构造函数或对象C，以此类推，最终的构造函数或对象的原型指向Objecte的原型。由此形成一条链状结构，被称之为原型链。

按照上述的描述，在B中定义的属性或方法，可以直接在A中使用井不需要定义。这就是继承，它允许每个对象来访问其原型链上的任何属性或方法。

原型链是ECMAScript标准中指定的默认实现继承的方式。

```javascript
// 此方法实现继承并不好，不建议使用
function A() {
  this.a = "a";
}
// 通过构造函数创建对象
var a = new A();
function B() {
  this.b = "b";
}
// 将B的原型指向对象a
B.prototype = a;
var b = new B();
console.log(b.a); //a
console.log(b.b); //b
console.log(b.c); //undefined

function C() {
  this.c = "c";
}
// 将C的原型指向对象b
C.prototype = b;
var c = new C();

console.log(c.a); //a
console.log(c.b); //b
console.log(c.c); //c

```

![image-20200602105216058](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/02/980f0df602d33ab7247a9503b1cffc8b.png)



### 只继承于原型

出于对效率的考虑，尽可能地将属性和方法添加到原型上。

- **不要为继承关系单独创建新对象**
- **尽量减少运行时的方法搜索。**

```javascript
function A() {
  //   this.a = "a";
}

A.prototype.a = "a";
function B() {
  //   this.b = "b";
}

// 将B的原型指向对象a
B.prototype = A.prototype;
// 注意顺序
B.prototype.b = "b";

function C() {
  this.c = "c";
}
// 将C的原型指向
C.prototype = B.prototype;

var c = new C();
console.log(c.a);
console.log(c.b);
console.log(c.c);

```

<div class="snote idea yellow"><p>在此方法中，中间的继承有格式写法的限制要求。但在性能上比原型链好。</p></div>

### 原型链的问题

原型链虽然很强大，用它可以实现Javascript中的继承，但同时也存在着一些问题。

- 原型链实际上是在多个构造函数或对象之间共享属性和方法。

  ```javascript
  function A() {
    //   this.a = "a";
  }
  
  A.prototype.a = "a";
  function B() {
    //   this.b = "b";
  }
  
  // 将B的原型指向对象a
  B.prototype = A.prototype;
  // 注意顺序
  B.prototype.b = "b";
  
  function C() {
    //   this.c = "c";
  }
  // 将C的原型指向
  C.prototype = B.prototype;
  C.prototype.c = "c";
  
  var c = new C();
  console.log(c.a); // a
  console.log(c.b); // b
  console.log(c.c); // c
  
  var b = new B();
  console.log(b.a); // a
  console.log(b.b); // b
  console.log(b.c); // c
  
  var a = new A();
  console.log(a.a); // a
  console.log(a.b); // b
  console.log(a.c); // c
  
  ```

  

- 创建子类的对象时，不能向父级的构造函数传递任何参数。

综上所述，在实际开发中很少会单独使用原型链。

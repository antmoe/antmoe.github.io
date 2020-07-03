# this关键字（二）


### new绑定

在Javascript中，构造函数只是一些使用new操作符时被调用的函数。包括内置对象函数在内的所有函数都可以用new来调用，这种函数调用被称为构造函数调用。

使用new来调用函数，会自动执行下面的操作：

1. 创建（或者说构造）一个全新的对象。
2. 这个新对象会绑定到函数调用的this.
3. 如果函数没有返回其他对象，那么new表达式中的函数调用会自动返回这个新对象。

```javascript
function Hero(name) {
  this.name = name;
}
// this 取决于函数调用的位置
var hero1 = new Hero("张无忌");

var hero2 = new Hero("周芷若");

```

### 示例

```javascript
function Hero() {
  this.name = "张无忌";
  this.sayMe = function () {
    console.log(this.name);
  };
}

function samllHero() {
  Hero.call(this);
  this.age = 19;
  this.sayMe = function () {
    console.log(this.name + this.age);
  };
}

var hero = new samllHero();

hero.sayMe(); //张无忌19

var obj = {
  name: "周芷若",
  age: 80,
  sayMe: hero.sayMe,
};
obj.sayMe(); //周芷若80

```



## 绑定例外

### 被忽略的this

如果把null或者undefined作为this的绑定对象传入call, applya或者bind，这些值在调用时会被忽略，实际应用的是默认绑定规则。

1. 情况1

   ```javascript
   function fn() {
     console.log(this.v);
   }
   var v = 100;
   
   fn.call(null); // node环境下为undefined 浏览器环境下为100
   ```

2. 情况2

   ```javascript
   var result = Math.max.apply(null, [1, 2, 3, 4, 5, 6]);
   console.log(result); // 6
   ```

### 间接引用

有可能（有意或者无意地）创建一个函数的“间接引用”，在这种情况下，调用这个函数会应用默认绑定规则

```javascript
function foo() {
  console.log(this.a);
}
var a = 2;
var o = {
  a: 3,
  foo: foo,
};
o.foo(); //3

var p = { a: 4 };
p.foo = o.foo;
p.foo(); //4
(p.foo = o.foo)(); //node环境下undefined 浏览器环境下为2

```



## 注意事项

### 避免多层this

1. 情况1

   ```javascript
   function fn() {
     console.log(this.a);
     function n() {
       //   this指向全局，因为独立调用
       console.log(this.a);
     }
     n();
   }
   
   fn();
   // undefined
   // undefined
   ```

2. 情况2

   ```javascript
   var obj = {
       v: 100,
       fn: function () {
           console.log(this.v);
           function n() {
               // this指向全局
               console.log(this.v);
           }
           n();
       },
   };
   obj.fn();
   ```

   

### 避免数组方法中的this

1. 情况1

   ```javascript
   var arr = [1, 2, 3, 4, 5, 6];
   arr.forEach(function (value, index) {
     // this指向全局
     console.log(this.v);
   });
   
   ```

2. 情况2

   ```javascript
   var obj = {
     v: 100,
     arr: [1, 2, 3, 4, 5],
     f: function () {
       this.arr.forEach(function (value) {
         // this指向全局
         console.log(this.v);
       });
     },
   };
   obj.f();
   
   ```

   

### 避免回调函数中的this

```javascript
var obj = {
  v: 100,
  f: function () {
    console.log(this.v);
  },
};

obj.f();
function fn(a) {
  // 此时的this指向全局
  a();
}
fn(obj.f);

```

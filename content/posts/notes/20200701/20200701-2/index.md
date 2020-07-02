---
title: 二、ES6新语法
date: 2020-07-01T17:05:00+08:00
categories: ["notes"]
tags: ["ES6"]
---

## let关键字

|   特点   |         `var`关键字          | `let`关键字  |
| :------: | :--------------------------: | :----------: |
| 变量提升 |              √               |      ×       |
|  作用域  | 没有块级作用域，是函数作用域 | 有块级作用域 |
| 重复声明 |              √               |      ×       |
| 重新赋值 |              √               |      √       |

1. 变量提升

   ```javascript
   console.log(age);
   let age = 38;
   ```

   ![image-20200701114547150](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/19d9f5114247333e44745f8e267af1df.png)

2. 作用域

   ```javascript
   for (var i = 0; i < 10; i++) {}
   console.log(i);
   
   for (let n = 0; i < 10; i++) {}
   console.log(n);
   ```

   ![image-20200701114808765](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/484c907316be029f074bdcbc5e49da5f.png)

   图中可对比看出，如果用`var`声明，在循环外部还是可以使用`i`变量；但用`let`声明变量，循环外部不可以使用`n`变量

3. 不可重复声明

   ```javascript
   let num2 = 10;
   let num2 = 20;
   console.log("num2: ", num2);
   ```

   ![image-20200701115104294](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/1c6ac93563f4592f50bd1fd94d629c76.png)

4. 重新赋值

   ```javascript
   let num2 = 10;
   num2 = 20;
   console.log("num2: ", num2);
   ```

   ![image-20200701115202044](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/c26d54b19255edff9d6b5f3f77966ebe.png)

## const关键字

> 使用场景
>
> 1. 一些不会变化的值，比如圆周率PI
> 2. 大事件项目中，保存基地址

1. 没有变量提升

   ![image-20200701115648469](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/26da63873971550e944e15abc009fa66.png)

2. 有块级作用域

   ![image-20200701115756085](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/5447efd30de60d2e64f799787174cdc0.png)

3. 不能重复声明

   ![image-20200701115830566](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/43ff3ec86ca614cd8261628cbc39ced6.png)

4. 不能重新赋值（声明必须要初始化）

   ![image-20200701115846798](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/711696698acae370c823914eb92c8dd3.png)

## 解构赋值

### 对象解构

取对象中属性的值，赋值给变量。

例如对于如下对象来说，在ES5与ES6中将对象赋值于变量的方式

```javascript
let obj = {
  name: "波波",
  age: 38,
  gender: "男",
  score: 88,
};
```

<span class="inline-tag red">ES5中的写法</span>

```javascript
let name1 = obj.name;
let age1 = obj.age;
let gender1 = obj.gender;
let score1 = obj.score;
console.log(name1, age1, gender1, score1);
```

<span class="inline-tag red">ES6中的写法</span>

1. 定义变量名

   ```javascript
   let { name: name2, age: age2, gender: gender2, score: score2 } = obj;
   console.log(name2, age2, gender2, score2);
   ```

2. 变量名可与属性名一致

   ```javascript
   let { name: name, age: age, gender: gender, score: score } = obj;
   console.log(name, age, gender, score);
   ```

3. 当变量名与属性名一致时，可以省略变量名

   ```javascript
   let { name, age, gender, score } = obj;
   console.log(name, age, gender, score);
   ```

以上代码的输出结果都为下图所示

![image-20200701153427629](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/c385077e07719436034a5cefb262276a.png)

<div class="snote idea yellow"><p>当简写时，对象中没有的属性会赋值为undefined</p></div>

```javascript
let obj = {
  name: "波波",
  age: 38,
  gender: "男",
  score: 88,
};
let { name, age, gender, fenshu } = obj;
console.log(name, age, gender, fenshu);
```

![image-20200701153747123](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/c94aa0a25bbd79d6322b7afef0c6a683.png)

<div class="snote idea yellow"><p>简写与全写可以一起用</p></div>

```javascript
let { name, age, gender, score: fenshu } = obj;
console.log(name, age, gender, fenshu);
```

![image-20200701153937328](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/6d9a7fa14e0087b0035e147a90c55464.png)

<div class="snote idea yellow"><p>设置默认值。当对象中没有此属性时会赋值为默认值而不是undefined。如果对象中存在这个属性，那么将赋值为对象中的属性，而不是默认值。</p></div>

```javascript
let { name, age, gender, score: fenshu, height = 180 } = obj;
console.log(name, age, gender, fenshu, height);
```

![image-20200701154223592](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/307b4a24bc06228f9d19eb59a32d8596.png)

<div class="snote idea yellow"><p>赋值一个除了某个属性不存在，但存在其余属性的对象</p></div>

```javascript
let obj = {
  name: "波波",
  age: 38,
  gender: "男",
  score: 100,
};

// obj2相当于是obj对象里面除了name属性之外的属性组成的一个对象
let { name, ...obj2 } = obj;
console.log(obj2); // { age: 38, gender: '男', score: 100 }
```

![image-20200702092507243](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/02/7f36c9d349dfabcb3c4a63f50833941c.png)

### 数组解构

把数组中每一个元素的值依次的赋值给变量。声明如下数组：

```javascript
// 声明一个数组
let arr = [10, 20, 30, 40];
```

<span class="inline-tag red">ES5中的写法</span>

```javascript
let num1 = arr[0];
let num2 = arr[1];
let num3 = arr[2];
let num4 = arr[3];
console.log(num1, num2, num3, num4);
```

<span class="inline-tag red">ES6中的写法</span>

1. 基础写法--一一对应

   ```javascript
   let [num1, num2, num3, num4] = arr;
   console.log(num1, num2, num3, num4);
   ```

   ![image-20200701155309108](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/d1ceb16e582dd46e27c6fafa49ee248c.png)

2. 默认值与没有值时与对象解构一致。

   ```javascript
   let [num1, num2, num3, num4, num5] = arr;
   console.log(num1, num2, num3, num4, num5); // num5为undefined
   
   ```

   ```javascript
   let [num1, num2, num3, num4, num5=5] = arr;
   console.log(num1, num2, num3, num4, num5); // num5为5
   ```

### 解构赋值结合函数声明

<span class="inline-tag red">ES5中的写法</span>

```javascript
function test1(obj) {
  console.log(obj.name, obj.age, obj.gender);
}
test1({
  name: "波波",
  age: 38,
  gender: "男",
});
```

<span class="inline-tag red">ES6中的写法</span>

```javascript
function test2({ name, age, gender, height = 180 }) {
  console.log(name, age, gender, height);
}
test2({
  name: "波波",
  age: 38,
  gender: "男",
});
test2({
  name: "波波",
  age: 38,
  gender: "男",
  height: 160,
});
```

![image-20200701160704150](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/5eb56f7e7c23d6ea3844833151c8f7ac.png)

## 箭头函数

> 简单来说，箭头函数就是匿名函数的一个简写。

```javascript
// 1. 普通的匿名函数
let fn = function (name) {
  console.log("my name is ", name);
};
fn("波波");

// 2. 箭头函数
let fn1 = (name) => console.log("my name is ", name);
fn1("波波");

```

![image-20200701161344962](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/e34256695860c1a204dcfd2e446f2c3f.png)

简写规则：

1. `function`改成`=>`，`=>`可以读成goes to

2. 如果只有一个形参，那就可以省略形参小括号

3. 如果不是一个形参（0个或多个），那就不能省略形参小括号

4. 如果函数体只有一句话，那就可以省略函数体的大括号

5. 如果函数体只有一句话，并且这一句话是`return`返回值，那`return`也要省略

   ```javascript
   let fn1 = function (name) {
     return name + "你好吗?";
   };
   let fn1 = (name) => name + "你好吗?";
   ```

6. 如果函数体不是一句话，那就不能省略这个大括号

```javascript
let fn2 = function (num1, num2) {
  console.log(num1 + num2);
  return num1 + num2 + 30;
};

let fn2 = (num1, num2) => {
  console.log(num1 + num2);
  return num1 + num2 + 30;
};
```

1. 无参数，一句话

   ```javascript
   let fn1 = function () {
     console.log("你好吗");
   };
   let f1 = () => console.log("你好吗");
   ```

2. 一个参数，一句话

   ```javascript
   let fn2 = function (name) {
     console.log(name + "你好吗");
   };
   let fn2 = (name) => console.log(name + "你好吗");
   ```

3. 两个参数，一句话

   ```javascript
   let fn3 = function (name, age) {
     console.log(name + "你好吗,你的年龄是" + age);
   };
   let fn3 = (name, age) => console.log(name + "你好吗,你的年龄是" + age);
   ```

4. 一个参数，一个`return`

   ```javascript
   let fn4 = function (age) {
     return age + 10;
   };
   let fn4 = (age) => age + 10;
   ```

5. 两个参数，多句

   ```javascript
   let fn5 = function (name, age) {
     console.log(name + "你好吗");
     return age + 10;
   };
   let fn5 = (name, age) => {
     console.log(name + "你好吗");
     return age + 10;
   };
   ```

### this指向

箭头函数的`this`由上下文环境决定，其原理就是将箭头函数的上下文`this`保存，在箭头函数内部使用这个被保存的`this`。使用注意：

- 不是什么时候都使用箭头函数

- 不要用`new`关键字调用箭头函数

  ```javascript
  var Fn = (name, age) => {
      this.name = name
      this.age = age
  }
  var obj = new Fn('伦哥', 10) // Fn is not a constructor
  ```

  箭头函数的`this`是由上下文环境决定，而不是`new`关键字来决定

```javascript
var obj = {
    name: '波波',
    sayHi: function () {
        console.log('我的名字是：', this.name) // 我的名字是： 波波
        // 上文环境
        setTimeout(() => {
            console.log('我的名字是：', this.name) // 我的名字是： 波波
        }, 2000)
        // 下文环境
    }
}
obj.sayHi()
```



<div class="snote idea yellow"><p>当多层箭头函数套用时，那么里面的this指向都与最外层的this指向一致。</p></div>

```javascript
var obj = {
    name: '波波',
    sayHi: function () {
        console.log('我的名字是1：', this.name)
        // 上文环境
        setTimeout(() => {
            console.log('我的名字是2：', this.name)
            setTimeout(() => {
                console.log('我的名字是3：', this.name)
                setTimeout(() => {
                    console.log('我的名字是4：', this.name)
                }, 1000)
            }, 1000)
        }, 1000)
        // 下文环境
    }
}
obj.sayHi()
```

![image-20200702094635888](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/02/79e5f4b3090f3f9355579f37f30a694e.png)

## 对象成员简写

```javascript
let name = "千里";
let age = 18;
let gender = "man";
let score = 10;

// es6
let obj = {
  name,
  age,
  gender,
  score,
  sayHi() {
    console.log("哈哈");
  },
};
console.log(obj);
obj.sayHi();

```

![image-20200701164157212](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/2fb8b7c1414953aa40569dafdedcdc95.png)

> 在这种写法中，如果传入一个没有赋值的变量，那么就会报错。例如：

```javascript
let name = "千里";
let age = 18;
let gender = "man";
let score = 10;

// es6
let obj = {
    name,
    age,
    gender,
    score,
    // fenshu, // 会发生报错，因为外部没有此变量，可以修改为下面的写法
    fenshu:score,
    sayHi() {
        console.log("哈哈");
    },
};
console.log(obj);
obj.sayHi();

```

## 扩展（展开）运算符

### 对象展开



```javascript
// 声明一个对象
let chinese = {
    skin: "yellow",
    hair: "black",
    sayHi() {
        console.log("Are you eat?");
    },
};

let CXK = {
    slill: "jump sing rap and play basketball",
    song: "啊哈哈哈",
};
let linge = {
    // skin: "yellow",
    // hair: "black",
    // sayHi() {
    //   console.log("Are you eat?");
    // },
    // slill: "jump sing rap and play basketball",
    // song: "啊哈哈哈",
    // 展开语法 等同于上方写法
    ...chinese,
    ...CXK,
};
console.log(linge);
```

![image-20200701165348837](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/deb1635565a4fbe02bc5b18d3b9eee46.png)



<div class="snote idea yellow"><p>当新增属性时，直接添加即可。如果重新定义已经存在的，那么覆盖原来的。</p></div>

```javascript
let linge = {
  ...chinese,
  ...CXK,
  gender: "Man",
  hair: "白发苍苍",
};
```

![image-20200701165728791](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/0e363daf013eb56e0b1730153195c946.png)

### 数组展开

与对象展开类似。

```javascript
let arr1 = [10, 20, 30];
let arr2 = [40, 50, 60];
let arr3 = [...arr1, ...arr2, 70];
console.log(arr3);
```

![image-20200701170324837](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/96171c6b1f190a712cdb67b256d0c429.png)

使用场景：

1. 数组的拼接

2. 求最大/小值

   ```javascript
   let arr1 = [10, 23, 54, 446, 56, 2];
   let max = Math.max(...arr1);
   console.log(max);
   ```

   



## 数据类型set

作用和数组类型，和数组不同的是set不能存放重复的元素。

1. 基本使用

   ```javascript
   let set1 = new Set([10, 20, 30, 40, 10, 20, 30, 40, 50]);
   console.log(set1);
   ```

   ![image-20200701170935727](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/d5ae978f996078c7560e6516938da7a1.png)

2. 数组去重

   ```javascript
   let arr = [10, 20, 30, 10, 20, 30, 20, 10, 33, 200];
   let set = new Set(arr);
   let arrNew = [...set];
   console.log(arrNew);
   ```

   ![image-20200701171115524](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/48c3fd8692f6dafec708633916ad0442.png)

   也可以改写为如下：

   ```javascript
   let arr = [10, 20, 30, 10, 20, 30, 20, 10, 33, 200];
   let arrNew = [...new Set(arr)];
   console.log(arrNew);
   ```

## 模板字符串

模板字符串会保留原样字符串格式，以及可以占位。其语法为反引号\`\`

```javascript
let author = "波波";
let str1 = `
静夜思
    ${author}
哈哈哈
`;
console.log(str1);

```

![image-20200701171652048](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/d349721ecd546da9a624b2e4ed1571cd.png)

```javascript
let name = "xiaokang";
let age = 12;
function test() {
  return "test";
}
console.log(`my name is ${name} and age is ${age}. ${test()}`);
```

![image-20200701172133560](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/01/bb1783e1985de82b379400274da15c89.png)

## 补充数组的方法

1. `forEach`

   无返回值

   ```javascript
   let arr = [10, 20, 30, 40];
   arr.forEach(function (item, index) {
     // item 遍历出的每一项
     // index 遍历出来的每一项对应的索引
     console.log(item, index);
   });
   ```

2. `map`

   有返回值。

   ```javascript
   let arr = [10, 20, 30, 40];
   let arrNew = arr.map(function (item, index) {
     // item 遍历出的每一项
     // index 遍历出来的每一项对应的索引
     //   console.log(item, index);
     return item * item;
   });
   console.log(arrNew);
   ```

3. `filter`

   ```javascript
   let arr = [10, 20, 11, 21, 30, 31, 23, 43];
   let arrNew = arr.filter((item, index) => {
     console.log(item, index);
     // 如果条件成立,返回当前项
     return item % 2 == 0;
   });
   console.log(arrNew); //[ 10, 20, 30 ]
   ```

<span class="inline-tag green">数组的其他应用</span>

1. 数组降维

   将二维数组降维为一维数组

   ```javascript
   // 将二维数组将为一维数组
   var arr = [[10, 20], [30, 40, 50], [60, 79, 80]]
   var arrNew = []
   arr.forEach(v => {
       arrNew.push(...v)
   })
   console.log(arrNew); // [10, 20, 30, 40, 50, 60, 79, 80]
   ```

2. 数组的去重（排序法）

   ```javascript
   var arr = [10, 20, 30, 23, 4, 512, 20, 10];
   var arrNew = [];
   arr.sort((a, b) => {
     return a - b;
   });
   console.log(arr); // [4, 10, 10, 20, 20, 23, 30, 512];
   arr.forEach((v, i) => {
     if (v != arr[i + 1]) {
       arrNew.push(v);
     }
   });
   console.log(arrNew); // [ 4, 10, 20, 23, 30, 512 ]
   ```

3. 数组去重（对象法）

   原理：利用对象属性不能同名。

   ```javascript
   // 使用对象法
   var obj = {};
   var arrNew = [];
   // 遍历要去重的数组
   arrNew.forEach((v) => {
     if (obj[v] == undefined) {
       arrNew.push(v); // 不存在九江这个v存起来
       obj[v] = 1; // 随意写，作为属性的值（避免undefined）
     }
   });
   ```

4. 数组升维

   假设从后端拿到的数据为如下格式：

   ```javascript
   var arr = [
       { type: "电子产品", name: "iPhone", price: 8888 },
       { type: "家具", name: "桌子", price: 100 },
       { type: "食品", name: "瓜子", price: 10 },
       { type: "家具", name: "椅子", price: 380 },
       { type: "电子产品", name: "小米手机", price: 1380 },
       { type: "食品", name: "辣条", price: 5 },
       { type: "食品", name: "咖啡", price: 50 },
   ];
   ```

   第一种：

   ```javascript
   var obj = {}; //将测type有没有重复的
   var arrNew = []; // 升级后的二维数组
   // 1. 将type去重，找出所有的产品类型
   // 遍历这个arr一维数组
   arr.forEach((v) => {
     if (obj[v.type] == undefined) {
       obj[v.type] = 1;
       //   把这个数组放到arrNew中
       arrNew.push({
         type: v.type,
         data: [v],
       });
     } else {
       // 判断当前v输入arrNew中的哪一类
       arrNew.forEach((v2, j) => {
         if (v.type == v2.type) {
           arrNew[j].data.push(v);
         }
       });
     }
   });
   console.log(arrNew);
   ```

   第二种：

   ```javascript
   var obj = {}; //将测type有没有重复的
   var arrNew = []; // 升级后的二维数组
   var index = 0; // 用于记录索引
   arr.forEach((v) => {
     if (obj[v.type] == undefined) {
       obj[v.type] = index++;
       //   把这个数组放到arrNew中
       arrNew.push({
         type: v.type,
         data: [v],
       });
     } else {
       var _index = obj[v.type];
       arrNew[_index].data.push(v);
     }
   });
   console.log(arrNew);
   
   ```

   ![image-20200702112619895](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/02/ca2a6774a5f313d1b2f6a544a198182a.png)

## babel将ES6代码转为ES5

[https://www.babeljs.cn/](https://www.babeljs.cn/) 


# jQuery原理（原型上的属性、方法）


## jQuery原型上的属性

```javascript
kjQuery.prototype = {
    constructor: kjQuery,
    init: function (selector) {},
    // 版本号
    jquery: "1.1.0",
    // 实例默认的选择器取值
    selector: "",
    // 实例默认的长度
    length: 0,
    // 给实例添加新元素
    push: [].push,
    // 对实例中的元素进行排序
    sort: [].sort,
    // 按照指定下标指定数量删除元素，也可以替换删除的元素
    splice: [].splice,
};
```

关于三个方法（push,sort,splice）以push为例：

1. 通过`[].push`找到数组的push方法
2. 但是对象的push方法由对象调用，那么`this`就指向了对象（jQuery）
3. 所以也就相当于`[].push.apply(this)`将元素添加到对象身上

## jQuery原型上的方法

### toArray

把实例转换为数组返回

```javascript
toArray: function () {
    return [].slice.call(this);
},
```

### get

取指定下标的元素，获取的是原生DOM

```javascript
get: function (num) {
    if (arguments.length === 0) {
        // 没有传入参数
        return this.toArray();
    } else if (num >= 0) {
        // 传入大于0的数字
        return this[num];
    } else {
        // 传入了负数
        return this[this.length + num];
    }
},
```

### eq

获取指定下标的元素，获取的是jQuery类型的实例对象

```javascript
eq: function (num) {
    if (arguments.length === 0) {
        // 没有传入参数
        return new kjQuery();
    } else {
        // 传入了参数
        return kjQuery(this.get(num));
    }
},
```



### first与last

1. `first`：获取实例中的第一个元素，是jQuery类型的实例对象

   ```javascript
   first: function () {
       return this.eq(0);
   },
   ```

2. `last`：获取实例中的最后一个元素，是jQuery类型的实例对象

   ```javascript
   last: function () {
       return this.eq(-1);
   },
   ```

### each

遍历实例，把遍历到的数据传给回调使用

jQuery存在两个each方法，一个类方法，一个对象方法。当实现类方法时，只需要让对象方法调用类方法即可实现。

1. 类方法

   ```javascript
   kjQuery.extend({
       each: function (obj, fn) {
           // 1. 判断是否是数组
           var res;
           if (kjQuery.isArray(obj)) {
               for (var i = 0; i < obj.length; i++) {
                   // res = fn(i, obj[i]);
                   // 将this修改为指向value
                   res = fn.call(obj[i], i, obj[i]);
                   if (res == true) {
                       continue;
                   } else if (res === false) {
                       break;
                   }
               }
           }
           // 2. 判断是否是对象
           else if (kjQuery.isObject(obj)) {
               for (var key in obj) {
                   // res = fn(key, obj[key]);
                   // 将this修改为指向value
                   res = fn.call(obj[key], key, obj[key]);
                   if (res == true) {
                       continue;
                   } else if (res === false) {
                       break;
                   }
               }
           }
           return obj;
       },
   });
   ```

2. 对象方法

   ```javascript
   kjQuery.prototype = {
       each: function (fn) {
           return  kjQuery.each(this, fn);
       },
   };
   ```

### map

遍历实例，把遍历到的数据传给回调使用，然后把回调的返回值收集起来组成一个新的数组返回

> map方法与each方法的区别
>
> each静态方法默认的返回值就是, 遍历谁就返回谁； map静态方法默认的返回值是一个空数组
>
> each静态方法不支持在回调函数中对遍历的数组进行处理；map静态方法可以在回调函数中通过return对遍历的数组进行处理, 然后生成一个新的数组返回

```javascript
kjQuery.extend({
    map: function (obj, fn) {
        var res = [];
        var temp;
        if (kjQuery.isArray(obj)) {
            for (var i = 0; i < obj.length; i++) {
                temp = fn(obj[i], i);
                if (temp) {
                    res.push(temp);
                }
            }
        } else if (kjQuery.isObject(obj)) {
            for (var key in obj) {
                temp = fn(obj[key], key);
                if (temp) {
                    res.push(temp);
                }
            }
        }
        return res;
    },
})
```



# jQuery原理（事件操作相关方法）


## on方法

```javascript
// 事件操作相关方法
kjQuery.prototype.extend({
    on: function (name, callBack) {
        this.each(function (key, ele) {
            // 2. 判断当前元素中是否有保存所有事件的对象
            if (!ele.eventsCache) {
                ele.eventsCache = {};
            }
            // 3. 判断对象中有没有对应类型的数组
            if (!ele.eventsCache[name]) {
                ele.eventsCache[name] = [];
                // 4. 将回调函数添加到数组中
                ele.eventsCache[name].push(callBack);
                // 5. 添加对应类型的事件
                kjQuery.addEvent(ele, name, function () {
                    kjQuery.each(ele.eventsCache[name], function (k, method) {
                        method();
                    });
                });
            } else {
                ele.eventsCache[name].push(callBack);
            }
        });
    },
});
```

将事件名称作为一个对象的键来存储，具体事件放到该键对应的数组中。

## off方法

```javascript
off: function (name, callBack) {
    // 1. 判断是否传入参数
    if (arguments.length == 0) {
        this.each(function (key, ele) {
            ele.eventsCache = {};
        });
    } else if (arguments == 1) {
        this.each(function (key, ele) {
            ele.eventsCache[name] = [];
        });
    } else if (arguments.length == 2) {
        this.each(function (key, ele) {
            kjQuery.each(ele.eventsCache[name], function (index, method) {
                if (method === callBack) {
                    ele.eventsCache[name].splice(index, 1);
                }
            });
        });
    }
},
```



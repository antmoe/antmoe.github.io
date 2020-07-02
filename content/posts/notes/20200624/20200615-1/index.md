---
title: jQuery原理（属性操作相关方法）
date: 2020-06-24T17:04:50+08:00
categories: ["notes"]
tags: ["jQuery"]
---

## attr方法

设置或者获取元素的属性节点值

```javascript
//属性操作相关的方法
kjQuery.prototype.extend({
    attr: function (attr, value) {
        //    1. 判断是否是字符串
        if (kjQuery.isString(attr)) {
            if (arguments.length == 1) {
                return this[0].getAttribute(attr);
            } else {
                this.each(function (key, ele) {
                    ele.setAttribute(attr, value);
                });
            }
        }
        //    2. 判断是否是对象
        else if (kjQuery.isObject(attr)) {
            var $this = this;
            // 遍历取出所有属性节点的名称和对应值
            $.each(attr, function (key, value) {
                //    遍历取出所有的元素
                $this.each(function (k, ele) {
                    ele.setAttribute(key, value);
                });
            });
        }
        return this;
    },
});
```

## prop方法

设置或者获取元素的属性值

```javascript
prop: function () {
    //    1. 判断是否是字符串
    if (kjQuery.isString(attr)) {
        if (arguments.length == 1) {
            return this[0][attr];
        } else {
            this.each(function (key, ele) {
                ele[attr] = value;
            });
        }
    }
    //    2. 判断是否是对象
    else if (kjQuery.isObject(attr)) {
        var $this = this;
        // 遍历取出所有属性节点的名称和对应值
        $.each(attr, function (key, value) {
            //    遍历取出所有的元素
            $this.each(function (k, ele) {
                ele[key] = value;
            });
        });
    }
    return this;
},
```

> 与attr方法相似。

## css方法

设置获取样式

```javascript
css: function (attr, value) {
    //    1. 判断是否是字符串
    if (kjQuery.isString(attr)) {
        if (arguments.length == 1) {
            return kjQuery.getStyle(this[0], attr);
        } else {
            this.each(function (key, ele) {
                ele.style[attr] = value;
            });
        }
    }
    //    2. 判断是否是对象
    else if (kjQuery.isObject(attr)) {
        var $this = this;
        // 遍历取出所有属性节点的名称和对应值
        $.each(attr, function (key, value) {
            //    遍历取出所有的元素
            $this.each(function (k, ele) {
                ele.style[key] = value;
            });
        });
    }
    return this;
},
```

## val方法

```javascript
val: function (content) {
    if (arguments.length == 0) {
        return this[0].value;
    } else {
        this.each(function (key, ele) {
            ele.value = content;
        });
        return this;
    }
},
```

## addClass方法

给元素添加一个或多个指定的类

```javascript
addClass: function (name) {
    if (arguments.length == 0) {
        return this;
    } else {
        // 1. 对传入的类名进行切割
        var names = name.split(" ");
        // 2. 遍历取出所有的元素
        this.each(function (key, ele) {
            // 遍历数组取出每一个类名
            $.each(names, function (k, value) {
                // 判断指定元素中是否包含指定的类名
                if (!$(ele).hasClass(value)) {
                    ele.className = ele.className + " " + value;
                }
            });
        });
        return this;
    }
},
```

## removeClass方法

删除元素中一个或多个指定的类

```javascript
removeClass: function (name) {
    if (arguments.length == 0) {
        this.each(function (key, ele) {
            ele.className = "";
        });
    } else {
        // 1. 对传入的类名进行切割
        var names = name.split(" ");
        // 2. 遍历取出所有的元素
        this.each(function (key, ele) {
            // 遍历数组取出每一个类名
            $.each(names, function (k, value) {
                // 判断指定元素中是否包含指定的类名
                if ($(ele).hasClass(value)) {
                    ele.className = (" " + ele.className + " ").replace(
                        " " + value + " ",
                        ""
                    );
                }
            });
        });
    }
    return this;
},
```

## toggleClass方法

没有则添加,有则删除

```javascript
toggleClass: function (name) {
    if (arguments.length == 0) {
        this.removeClass();
    } else {
        // 1. 对传入的类名进行切割
        var names = name.split(" ");
        // 2. 遍历取出所有的元素
        this.each(function (key, ele) {
            // 遍历数组取出每一个类名
            $.each(names, function (k, value) {
                // 判断指定元素中是否包含指定的类名
                if ($(ele).hasClass(value)) {
                    // 删除
                    $(ele).removeClass(value);
                } else {
                    // 添加
                    $(ele).addClass(value);
                }
            });
        });
    }
    return this;
},
```


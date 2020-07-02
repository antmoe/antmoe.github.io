---
title: jQuery原理（DOM操作相关方法）
date: 2020-06-23T11:35:00+08:00
categories: ["notes"]
---

## empty方法

清空指定元素中的所有内容。也就是遍历内容，然后将其`innerHTML`清空。

```javascript
kjQuery.prototype.extend({
    empty: function () {
        // 遍历所有找到的元素
        this.each(function (k, v) {
            v.innerHTML = '';
        });
        // 返回this对象为了方便链式编程
        return this;
    },
})
```

## remove方法

删除所有的元素或指定元素。判断是否传入参数，如果传入参数，则删除指定元素，否则删除全部。

> JavaScript元素不能自己删除自己，只能通过上级元素删除。

```javascript
remove: function (sele) {
    if (arguments.length === 0) {
        // 遍历指定的元素
        this.each(function (k, v) {
            // 根据遍历到的元素找到父元素
            var parent = v.parentNode;
            // 通过父元素删除指定元素
            parent.removeChild(v);
        });
    } else {
        var $this = this;
        // 根据传入的选择器 找到对应的元素
        $(sele).each(function (key, value) {
            var type = value.tagName;
            $this.each(function (k, v) {
                var t = v.tagName;
                if (t === type) {
                    // 根据遍历到的元素找到父元素
                    var parent = value.parentNode;
                    // 通过父元素删除指定元素
                    parent.removeChild(value);
                }
            });
        });
    }

    return this;
},
```

## html方法

设置所有元素的内容，获取第一个元素的内容

```javascript
html: function (content) {
    if (arguments.length === 0) {
        return this[0].innerHTML;
    } else {
        this.each(function (k, v) {
            v.innerHTML = content;
        });
    }
},
```

## text方法

设置所有元素的文本内容，获取所有元素的文本

```javascript
text: function (content) {
    if (arguments.length === 0) {
        var res = "";
        this.each(function (k, v) {
            res += v.innerText;
        });
        return res;
    } else {
        this.each(function (k, v) {
            v.innerText = content;
        });
    }
},
```

## appendTo方法

将元素添加到指定元素内部的最后

1. 如果指定元素有多个,会将元素拷贝多份添加到指定元素中
2. 给appendTo方法传递字符串, 会根据字符串找到所有对应元素后再添加
3. 给appendTo方法传递jQuery对象,会将元素添加到jQuery对象保存的所有指定元素中
4. 给appendTo方法传递DOM元素, 会将元素添加到所有指定DOM元素中

```javascript
appendTo: function (sele) {
    // 1. 统一的将传入的数据传递给核心函数
    var $target = $(sele);
    var $this = this;
    var res = [];
    // 2. 遍历取出所有指定元素
    $.each($target, function (key, value) {
        // 遍历取出所有的元素
        $this.each(function (k, v) {
            if (key == 0) {
                // 直接添加
                value.appendChild(v);
                res.push(v);
            } else {
                var temp = v.cloneNode(true);
                value.appendChild(temp);
                res.push(v);
            }
        });
    });
    return $(res);
},
```

## prependTo方法

将元素添加到指定元素内部的最前面。

与appendTo方法一模一样，只不过将添加方法换成了`insertBefore`。

```javascript
prependTo: function (sele) {
    // 1. 统一的将传入的数据传递给核心函数
    var $target = $(sele);
    var $this = this;
    var res = [];
    // 2. 遍历取出所有指定元素
    $.each($target, function (key, value) {
        // 遍历取出所有的元素
        $this.each(function (k, v) {
            if (key == 0) {
                // 直接添加
                value.insertBefore(v, value.firstChild);
                res.push(v);
            } else {
                var temp = v.cloneNode(true);
                value.insertBefore(temp, value.firstChild);
                res.push(v);
            }
        });
    });
    return $(res);
},
```

## append

将元素添加到指定元素内部的最后

```javascript
append: function (sele) {
    // 判断传入的参数是否是字符串
    if (kjQuery.isString(sele)) {
        this[0].innerHTML += sele;
    } else {
        $(sele).appendTo(this);
    }
    return this;
},
```



## prepend方法

将元素添加到指定元素内部的最后面

```javascript
prepend: function (sele) {
    // 判断传入的参数是否是字符串
    if (kjQuery.isString(sele)) {
        this[0].innerHTML = sele + this[0].innerHTML;
    } else {
        $(sele).prependTo(this);
    }
    return this;
},
```

## insertBefore方法

将元素添加到指定元素外部的前面

```javascript
insertBefore: function (sele) {
    // 1.统一的将传入的数据转换为jQuery对象
    var $target = $(sele);
    var $this = this;
    var res = [];
    // 2.遍历取出所有指定的元素
    $.each($target, function (key, value) {
        var parent = value.parentNode;
        // 2.遍历取出所有的元素
        $this.each(function (k, v) {
            // 3.判断当前是否是第0个指定的元素
            if (key === 0) {
                // 直接添加
                parent.insertBefore(v, value);
                res.push(v);
            } else {
                // 先拷贝再添加
                var temp = v.cloneNode(true);
                parent.insertBefore(temp, value);
                res.push(temp);
            }
        });
    });
    // 3.返回所有添加的元素
    return $(res);
},
```

## insertAfter方法

将元素添加到指定元素外部的后面

```javascript
insertAfter: function (sele) {
    // 1.统一的将传入的数据转换为jQuery对象
    var $target = $(sele);
    var $this = this;
    var res = [];
    // 2.遍历取出所有指定的元素
    $.each($target, function (key, value) {
        var parent = value.parentNode;
        var nextNode = $.get_nextsibling(value);
        // 2.遍历取出所有的元素
        $this.each(function (k, v) {
            // 3.判断当前是否是第0个指定的元素
            if (key === 0) {
                // 直接添加
                parent.insertBefore(v, nextNode);
                res.push(v);
            } else {
                // 先拷贝再添加
                var temp = v.cloneNode(true);
                parent.insertBefore(temp, nextNode);
                res.push(temp);
            }
        });
    });
    // 3.返回所有添加的元素
    return $(res);
},
```

## before

```javascript
before: function (sele) {
    // 1.统一的将传入的数据转换为jQuery对象
    var $target = $(sele);
    var $this = this;
    $this.each(function (k, v) {
        var parent = v.parentNode
        if (k == 0) {
            parent.insertBefore($target.get(0), v)
        } else {
            var temp = $target.get(0).cloneNode(true)
            parent.insertBefore(temp, v)
        }
    })
    // 3.返回所有添加的元素
    return $this
},
```

## after

```javascript
after: function (sele) {
    // 1.统一的将传入的数据转换为jQuery对象
    var $target = $(sele);
    var $this = this;
    $this.each(function (k, v) {
        var nextNode = $.get_nextsibling(v)
        var parent = v.parentNode
        if (k == 0) {
            parent.insertBefore($target.get(0), nextNode)
        } else {
            var temp = $target.get(0).cloneNode(true)
            parent.insertBefore(temp, nextNode)
        }
    })
    // 3.返回所有添加的元素
    return $this
},
```



## replaceAll

替换所有指定元素

> 1. 将元素插入到指定元素的前面
> 2. 将指定元素删除

```javascript
replaceAll: function (sele) {
    // 1.统一的将传入的数据转换为jQuery对象
    var $target = $(sele);
    var $this = this;
    var res = [];
    // 2.遍历取出所有指定的元素
    $.each($target, function (key, value) {
        var parent = value.parentNode;
        // 2.遍历取出所有的元素
        $this.each(function (k, v) {
            // 3.判断当前是否是第0个指定的元素
            if (key === 0) {
                // 直接添加
                $(v).insertBefore(value)
                //将元素删除
                $(value).remove()
                res.push(v)
            } else {
                // 先拷贝再添加
                var temp = v.cloneNode(true);
                $(temp).insertBefore(value);
                $(value).remove()
                res.push(temp);
            }
        });
    });
    // 3.返回所有添加的元素
    return $(res);
}
```

## next方法与prev方法

```javascript
kjQuery.prototype.extend({
    next: function (sele) {
        var res = [];
        if(arguments.length === 0){
            // 返回所有找到的
            this.each(function (key, value) {
                var temp = kjQuery.get_nextsibling(value);
                if(temp != null){
                    res.push(temp);
                }
            });
        }else{
            // 返回指定找到的
            this.each(function (key, value) {
                var temp = kjQuery.get_nextsibling(value)
                $(sele).each(function (k, v) {
                    if(v == null || v !== temp) return true;
                    res.push(v);
                });
            });
        }
        return $(res);
    },
    prev: function (sele) {
        var res = [];
        if(arguments.length === 0){
            this.each(function (key, value) {
                var temp = njQuery.get_previoussibling(value);
                if(temp == null) return true;
                res.push(temp);
            });
        }else{
            this.each(function (key, value) {
                var temp = njQuery.get_previoussibling(value);
                $(sele).each(function (k, v) {
                    if(v == null || temp !== v) return true;
                    res.push(v);
                })
            });
        }
        return $(res);
    }
});
```

```javascript
kjQuery.prototype = {
    get_nextsibling: function (n) {
        var x = n.nextSibling;
        while (x != null && x.nodeType != 1) {
            x = x.nextSibling;
        }
        return x;
    },
    get_previoussibling: function (n) {
        var x = n.previousSibling;
        while (x != null && x.nodeType != 1) {
            x = x.previousSibling;
        }
        return x;
    },
};
```


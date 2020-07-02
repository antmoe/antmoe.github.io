---
title: 模仿一个在线文档
date: 2020-05-18T21:54:50+08:00
categories: ["project"]
---

## 项目需求

1. 在线输入多行文字
2. 选择文本可设置字体大小、加粗、斜体、下划线、删除线、字体颜色和背景颜色
3. 允许输入无序列表和有序列表
4. 允许设置1~6级标题
5. 允许插入图片

## 项目开发历史

完整的项目地址：[https://antmoe.gitee.io/project/2020/05/OnlineDoc/](https://antmoe.gitee.io/project/2020/05/OnlineDoc/)

- 2020-05-19

  [https://antmoe.gitee.io/project/2020/05/OnlineDoc/](https://antmoe.gitee.io/project/2020/05/OnlineDoc/)

  <div class="checkbox green checked"><input type="checkbox" checked="checked"><p>图片插入（本地图片）</p></div>

  <div class="checkbox green checked"><input type="checkbox" checked="checked"><p>字体颜色、背景颜色</p></div>

  <div class="checkbox green checked"><input type="checkbox" checked="checked"><p>撤销、取消样式</p></div>

- 2020-05-18

  https://antmoe.gitee.io/project/2020/05/18/

  <div class="checkbox green checked"><input type="checkbox" checked="checked"><p>多行文字</p></div>

  <div class="checkbox green checked"><input type="checkbox" checked="checked"><p>字体大小</p></div>

  <div class="checkbox green checked"><input type="checkbox" checked="checked"><p>加粗、斜体、下划线、删除线</p></div>

  <div class="checkbox green checked"><input type="checkbox" checked="checked"><p>无序、有序列表</p></div>

  <div class="checkbox green checked"><input type="checkbox" checked="checked"><p>1~6级标题</p></div>

  <div class="checkbox minus yellow checked"><input type="checkbox" checked="checked"><p>【完成部分】只能插入拥有绝对链接的图片（外链）</p></div>
  
  <div class="checkbox times red checked"><input type="checkbox" checked="checked"><p>【未完成】字体、背景颜色设置</p></div>

## 项目开发历程

这里主要说一下完成这个项目的过程中遇到的问题及问题解决方案。

<span class="inline-tag blue">开发思路</span>

1. 需要一个框，用于输入文字，并且这个框可以支持html标签

   iframe实现 参考文章：https://www.cnblogs.com/xiangxs/p/5120574.html

2. 选中文本修改其样式

   参考文章：http://16bing.com/2017/04/18/ref-iframe/

   MDN参考：https://developer.mozilla.org/zh-CN/docs/Web/API/Document/execCommand

3. 插入图片

   - 直接通过`input`获取后，通过`insertImage`命令插入。

     由于无法获取真实地址，因此此方法只能插入外链图片即上传图床后插入链接。

   - 直接插入HTML标签

     未测试

4. 设置颜色

   通过一个div或者颜色版获取到用户选择的颜色，然后进行设置。

### 输入框

输入框首先明确的是`textarea`标签虽然可以实现多行文本，但无法插入样式标签即不能解析标签。于是通过百度得知：**可以使用`iframe`标签。**

```html
<iframe id="text" frameborder="0"></iframe>
<script>
    var edit = document.getElementById("text").contentWindow;
    // 控制整个文档可编辑
    edit.document.designMode = "On";
    // 表明元素是否是可编辑的
    edit.document.contentEditable = "ture";
</script>
```

上边这段代码主要用途就是使`iframe`元素处于可编辑状态。

### 基本设置

这里的基本设置主要是指`execCommand`命令只传第一个参数的设置项。包括加粗、斜体、下划线、删除线、有序列表、无序列表。

这些设置的实现思路几乎一致。主要通过为HTML标签设置自定义属性` data-set`用于控制点击时所触发的动作。

```html
<i class="iconfont icon-jiacu" id="bold" data-set="bold"></i>
<script>
    bold.addEventListener('click', singleSet)
    function singleSet() {
        var action = this.getAttribute('data-set')
        edit.document.execCommand(action, false, null);
    }
</script>
```

### 两个参数的设置

两个参数的设置目前包括设置字体大小及插入标题。因为涉及到了选择，因此需要通过用户具体选择的是那一个才能执行相应的功能。

#### 字体大小

鼠标悬停显示使用的方式为最基本的父子级嵌套。为了减少重复性样式，子级统一为一个class名。这样就能实现多个子级共用一个样式了。

```html
<i class="iconfont icon-fontsize" id="fontsize" data-set="fontsize">
    <ul class="child">
        <li data-set="fontSize" data-value="1">1</li>
        <li data-set="fontSize" data-value="2">2</li>
        <li data-set="fontSize" data-value="3">3</li>
        <li data-set="fontSize" data-value="4">4</li>
        <li data-set="fontSize" data-value="5">5</li>
        <li data-set="fontSize" data-value="6">6</li>
        <li data-set="fontSize" data-value="7">7</li>
    </ul>
</i>
```

<span class="inline-tag red">关于HTML标签</span>

- `data-set`

  表示需要执行命令的动作名称

- `data-value`

  表示动作的参数即第三个参数

<span class="inline-tag red">关于绑定事件</span>

绑定事件如果每一个都获取那就太难了！！因此使用事件委托的方式。需要注意的是为了准确获取到子级`child`，可以先获取父级（因为设置了ID），然后通过父级获取`child`。达到准确获得。

> 为父级绑定事件，在事件内进行判断（class名、nodeName均可）

```javascript
var Fontsize = document.getElementById('fontsize')
var setFontSize = Fontsize.getElementsByClassName('child')[0]
setFontSize.addEventListener('click', function (e) {
    var target = e.target
    if (target.nodeName === 'LI') {
        edit.document.execCommand(target.getAttribute('data-set'), true, target.getAttribute('data-value'));
    }
})
```

#### 标题标签

标题标签遇到的问题主要是Chrome不兼容问题，疑似根本没有`heading`命令。于是只能用`formatBlock`命令替代，但参数需要加上尖括号，例如：

```html
<i class="iconfont icon-biaoti" id="heading" data-set="heading">
    <ul class="child">
        <li data-set="formatBlock" data-value="<H1>">插入H1</li>
        <li data-set="formatBlock" data-value="<H2>">插入H2</li>
        <li data-set="formatBlock" data-value="<H3>">插入H3</li>
        <li data-set="formatBlock" data-value="<H4>">插入H4</li>
        <li data-set="formatBlock" data-value="<H5>">插入H5</li>
        <li data-set="formatBlock" data-value="<H6>">插入H6</li>
    </ul>
</i>
<script>
    var heading = document.getElementById('heading')
    var heading_child = heading.getElementsByClassName('child')[0]
    heading_child.addEventListener('click', function (e) {
        var target = e.target
        if (target.nodeName === 'LI') {
            console.log(1)
            edit.document.execCommand(target.getAttribute('data-set'), true, target.getAttribute('data-value'));
        }
    })
</script>
```

关于事件绑定，同样的使用事件委托。

### 插入图片

插入图片时如果使用外链地址，那么可以直接插入。例如：

```javascript
edit.document.execCommand("insertImage", true, 'https://ae01.alicdn.com/kf/H355adba4500642949f3d43d001b83ac3b.jpg');
```

但是由于JavaScript限制，不能直接获取图片的真实地址。但返回的地址时`Blob:xxxx`，通过以上方式好像不可以。因此准备尝试通过自定义标签的方式插入。

<span class="inline-tag grey">2020-05-19完成本地图片的插入</span>

这个功能很简单，主要思路是将图片载入后，将其转换`data`格式的即可。绑定事件即`input`按钮改变时触发。

```javascript
insertImage.addEventListener('change', function (e) {
    // TAG 创建一个File对象
    var reader = new FileReader();
    // 加载文件内容
    reader.readAsDataURL(e.target.files[0]);
    // 当内容加载完成后执行的动作
    reader.onload = function (evt) {
        edit.document.execCommand("insertHTML", true, '<img src="' + evt.target.result + '">');

    }
})
```

关于文件对象更多参考于MDN：[https://developer.mozilla.org/zh-CN/docs/Web/API/File/Using_files_from_web_applications](https://developer.mozilla.org/zh-CN/docs/Web/API/File/Using_files_from_web_applications)

### 颜色设置

颜色选择器主要用于控制背景颜色和文字颜色。因为默认的`input`框难以改变其样式，因此将其透明度改为0，并且覆盖到标签上，实现点击标签触发按钮的假象。改变其颜色同样为`input`绑定`change`事件。颜色值为`input`的`value`

```javascript
// 设置背景颜色
hiliteColor_value.addEventListener('change', function () {
    hiliteColor.style.color = getColor(hiliteColor_value)
    edit.document.execCommand('hiliteColor', true, getColor(hiliteColor_value));
})
// 设置文字颜色
foreColor_value.addEventListener('change', function () {
    foreColor.style.color = getColor(foreColor_value)
    edit.document.execCommand('foreColor', true, getColor(foreColor_value));
})
// NOTE 颜色处理---获取颜色
function getColor(element) {
    return element.value
}
```



## 遇到的其他问题

1. 我的双参数函数貌似没有用到
2. <span class="inline-tag green">DONE</span>本地图片无法显示问题
3. <span class="inline-tag green">DONE</span>关于颜色的调色板不知如何调出




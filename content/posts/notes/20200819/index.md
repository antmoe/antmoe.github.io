---
title: Chrome代码调试指南
date: 2020-08-19T17:20:00+08:00
categories: ["notes"]
---

## 打开开发者工具

1. 在Chrome菜单选择：更多工具->开发者工具

2. 在页面原色上右键单击，选择检查

3. 快捷键

   - 打开最近关闭状态

     `cmd+opt+i`或`ctrl+shift+i`

   - 快速查看DOM或样式

     `Command+Option+c`或`Control+shift+c`

   - 快速进入Console查看log运行JavaScript

     `Command+Option+j`或`Control+shift+j`

   - F12打开

## 使用Elements调试DOM

### 查看与选择DOM节点

1. 将鼠标移动到需要被查看的元素
2. 右键选择检查

![image-20200819101826232](https://files.alexhchu.com/2020/08/19/0de677afb360f.png)

> 通过开发者工具左上角的小箭头可以选择需要查看的元素

![image-20200819101911149](https://files.alexhchu.com/2020/08/19/d7548c659f6b2.png)

![image-20200819101926899](https://files.alexhchu.com/2020/08/19/72275f89d86fa.png)

通过如上图所示按钮，也可以定义调试工具所处位置。

### 实时编辑HTML和DOM节点

在调试工具处，双击dom节点即可进入编辑。

![d5469863-68f6-4bab-97db-e677decb7226](https://files.alexhchu.com/2020/08/19/225b2233e79f6.gif)

> 也可以通过右键节点选择编辑HTML模式。

![image-20200819102413228](https://files.alexhchu.com/2020/08/19/d524b033d3578.png)

### 在Console中访问节点

1. 通过document.querySelectAll访问

   ![image-20200819102648246](https://files.alexhchu.com/2020/08/19/50e6424c49816.png)

2. 通过$0快速访问选中元素

   ![acc2bde7-d65d-4a52-934e-0ffeae65ad63](https://files.alexhchu.com/2020/08/19/629ab4ae3620a.gif)

3. 拷贝->js path

   ![image-20200819102911893](https://files.alexhchu.com/2020/08/19/130bf2a92ebd3.png)

   复制出的路径是通过`querySelector`接口选择的元素

### 给DOM中断点调试

1. 在属性修改时打断点
2. 节点删除时打断点
3. 子树修改时打断点

通过对需要调试元素右键选择`break on`即可选择调试方式。

![image-20200819103225069](https://files.alexhchu.com/2020/08/19/efef8feaccbfe.png)

## 调试样式及CSS

### 查看与编辑css

在调试工具右侧即可看到样式

![image-20200819104003961](https://files.alexhchu.com/2020/08/19/73933ceaff3cf.png)

通过filter也可以过滤（搜索）某个属性

![image-20200819104035524](https://files.alexhchu.com/2020/08/19/2f1033055f6bd.png)

点击空白处也可以新增属性；点击前边的勾也可以使此属性失效。

![a3627d23-7c37-449d-b49d-5ac72830c7e9](https://files.alexhchu.com/2020/08/19/b5db90e6b4dc4.gif)

### 在元素中增加类与伪类

1. 通过点击hov按钮，可以选择伪类。例如点击`:hover`表示模拟鼠标悬停。

   ![image-20200819104612846](https://files.alexhchu.com/2020/08/19/05a0682fd31d0.png)

2. 点击cls按钮，可以为元素添加一个类

   ![image-20200819104707614](https://files.alexhchu.com/2020/08/19/1f9a3978275ab.png)

3. 点击加号，表示可以新建一个类

   ![image-20200819104730926](https://files.alexhchu.com/2020/08/19/eb9e202936447.png)

### 快速调试CSS数值及颜色图形动画

当鼠标悬停到`...`图标时可以看到如下

![image-20200819105332830](https://files.alexhchu.com/2020/08/19/d8a5725cb8db8.png)

![image-20200819105353894](https://files.alexhchu.com/2020/08/19/540fa6af614cf.png)

点击即可展开可视化界面。

![image-20200819105602864](https://files.alexhchu.com/2020/08/19/ea40c7a2d7155.png)

通过选择`more tools -> Animations`即可调出动画窗口。

![image-20200819105904622](https://files.alexhchu.com/2020/08/19/27f43d01b18f9.png)

当触发动画时就会自动录制，并且可以通过下方的属性可视化调试。

## 使用Console调试Javascript

### Console交互式命令

![image-20200819110537426](https://files.alexhchu.com/2020/08/19/d381efe9171fc.png)

在Console处可以写任意JavaScript代码。

### 在Console中调试log消息

1. 普通信息

   ```javascript
   console.log('普通信息')
   ```

   ![image-20200819112243040](https://files.alexhchu.com/2020/08/19/5cfb2473ca91b.png)

2. warn告警信息

   ```javascript
   console.warn('告警信息')
   ```

   ![image-20200819112252191](https://files.alexhchu.com/2020/08/19/63f0603b3de1a.png)

3. 错误信息

   ```javascript
   console.error('错误信息')
   ```

   ![image-20200819112300854](https://files.alexhchu.com/2020/08/19/750533498ecbd.png)

4. 展示json格式的复杂信息

   ```javascript
   var t = [
       {name:'666',age:'17',sex:'男'},
       {name:'666',age:'17',sex:'男'},
       {name:'666',age:'17',sex:'男'}
   ]
   console.table(t)
   ```

   ![image-20200819112314090](https://files.alexhchu.com/2020/08/19/4a126ef52c4c9.png)

5. 信息组展示

   ```javascript
   var label = '一组信息'
   console.group(label)
   console.info('Log')
   console.info('warn')
   console.info('error')
   console.groupEnd(label)
   ```

   ![image-20200819112326629](https://files.alexhchu.com/2020/08/19/a6857d6bf6244.png)

6. 定制样式

   ```javascript
   var styles = 'color:red;background:black;font-size:20px;'
   console.log("%c样式展示",styles)
   ```

   ![image-20200819112336966](https://files.alexhchu.com/2020/08/19/311123aeb803d.png)

7. 网络请求错误展示

   当请求资源不存在或其他信息时打印的日志。

   ![image-20200819112435350](https://files.alexhchu.com/2020/08/19/a853f5d4b127c.png)

8. 断言

   ```javascript
   console.assert(false,'断言失败')
   ```

   ![image-20200819112446959](https://files.alexhchu.com/2020/08/19/d62050aab3a17.png)

9. 查看代码执行时间

   ```javascript
   console.time()
   var l = 1
   console.timeEnd()
   ```

   ![image-20200819112455085](https://files.alexhchu.com/2020/08/19/63a8487b3d17a.png)

10. 清除打印日志

    ```javascript
    console.clear()
    ```

    

### 调试JavaScript的基本流程

1. 在代码中写入`debugger`

2. 断点调试

   ![image-20200819124436110](https://files.alexhchu.com/2020/08/19/0f58b218a3db5.png)

![image-20200819124512724](https://files.alexhchu.com/2020/08/19/b13024125c32b.png)

可以通过图中表示的几个按钮进行调试。按钮从左向右依次表示

- 恢复代码执行

- 跳过下一个函数执行

- 进入下一个函数执行

- 跳出函数

- 单步执行

  

![image-20200819124950781](https://files.alexhchu.com/2020/08/19/96c5f22e2bffd.png)

也可以通过下方事件进行监听。

### Sources面板

1. 调出面板

   ![image-20200819144101488](https://files.alexhchu.com/2020/08/19/96908279d11d5.png)

   左侧为全局的静态资源，选择一个文件也可以对源文件进行编辑。

2. 按住`ctrl+p`可以全局搜索某个资源

   ![image-20200819144144830](https://files.alexhchu.com/2020/08/19/26ee6c46e2193.png)

3. 按住`ctrl+shift+p`可以输入一些命令

   ![image-20200819144249607](https://files.alexhchu.com/2020/08/19/787b9a7b2f789.png)

### 使用Snippets来复制Debugging

简单来说就是为当前页面新加一个代码片段。

1. 打开Snippets面板

   ![image-20200819144839591](https://files.alexhchu.com/2020/08/19/023a091356481.png)

2. 编写需要添加的代码片段

   ![image-20200819144916847](https://files.alexhchu.com/2020/08/19/9b3e6410c26b1.png)

3. 执行代码片段

   ![image-20200819144935685](https://files.alexhchu.com/2020/08/19/a2e456f29757a.png)

4. 即可看到console里边输出了`test`

   ![image-20200819144959422](https://files.alexhchu.com/2020/08/19/459214374dd81.png)

### 使用DevTools作为Text IDE

1. 通过`Sources->Filesystem`唤起面板

   ![image-20200819145733957](https://files.alexhchu.com/2020/08/19/a0ba4d34310a5.png)

2. 添加文件夹

   添加文件夹需要允许浏览器获取权限

   ![image-20200819145848143](https://files.alexhchu.com/2020/08/19/bb469f06bd72f.png)

3. 注意

   在此修改的内容等同于直接修改文件。

## 调试网络

### Network面板

![image-20200819150253455](https://files.alexhchu.com/2020/08/19/f7e85268f451a.png)

### 使用Network详细分析请求

![image-20200819151457490](https://files.alexhchu.com/2020/08/19/5f2df5adceea3.png)

1. filter

   过滤只能过滤出下方已经展示的请求包含的地址。而无法过滤内容。

2. 搜索

   可以搜索到返回数据内容

3. Preserver log

   可以在跳转时保留网络请求日志

4. Disable cache

   不使用缓存

### 使用Network Waterfall分析页面载入性能

![image-20200819152817560](https://files.alexhchu.com/2020/08/19/a60cb62e3e6f7.png)

![image-20200819152831145](https://files.alexhchu.com/2020/08/19/07e8791bbf190.png)

## 客户端存储Application面板

### 查看与调试Cookie

![image-20200819153112232](https://files.alexhchu.com/2020/08/19/e6fdd277d4e2a.png)

通过上方的filter可以进行过滤，同样的也可以删除或新增Cookie。

### 查看LocalStorage与SessionStorage

![image-20200819153556477](https://files.alexhchu.com/2020/08/19/15409b7e39e0f.png)

与Cookie类似。

## 移动端H5页面调试

### 模拟移动端设备

![image-20200819153727727](https://files.alexhchu.com/2020/08/19/7711476b08411.png)

### 使用Chrome DevTools进行H5页面开发

1. 通过使用`show sensors`命令呼出Sensors面板进行调试

   ![image-20200819154334119](https://files.alexhchu.com/2020/08/19/75693c792eda3.png)

   在Edge中为传感器。

   ![image-20200819154442591](https://files.alexhchu.com/2020/08/19/088fc4e4cad34.png)

   ![image-20200819154524467](https://files.alexhchu.com/2020/08/19/2cec6dae663f2.png)

2. 网络菜单

   ![image-20200819154604472](https://files.alexhchu.com/2020/08/19/84928179890da.png)

   ![image-20200819154611722](https://files.alexhchu.com/2020/08/19/4e7cbbd2af4ed.png)

   在chrome为`network`

   ![image-20200819154707177](https://files.alexhchu.com/2020/08/19/647e3b45624c9.png)

## 在Chrome DevTools中集成React和Vue插件

### 集成React插件

由于国内无法使用Google商店，因此建议使用Edge商店。

![image-20200819154825420](https://files.alexhchu.com/2020/08/19/3a3d8d9d6d98b.png)

安装此插件后，如果网页是由react开发的，那么开发者工具会多出一个react的选项，并且插件图标是点亮的。

![image-20200819155208648](https://files.alexhchu.com/2020/08/19/24d47921f7c1d.png)

![image-20200819155218066](https://files.alexhchu.com/2020/08/19/954aacdab1a7b.png)

### 集成VUE插件

与React插件类似。
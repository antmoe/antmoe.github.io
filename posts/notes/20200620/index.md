# 八、jQuery的QQ音乐播放器


## 项目资料

<div class="btns rounded grid5">
    <a href="https://gitee.com/antmoe/project/tree/master/2020/06/qqMusic" title="查看源码"><i class="fa fa-download"></i> 查看源码</a>
    <a href="https://antmoe.gitee.io/project/2020/06/qqMusic/" title="在线DEMO"><i class="fas fa-book-open"></i> 在线Demo</a>
</div>

## 基本框架及顶部布局

![image-20200618170522288](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/18/44c18ebc0f094265a0e93f0f74e310cf.png)

```html
<div class="header">
    <h1 class="logo"><a href="#"></a></h1>
    <ul class="register">
        <li>注册</li>
        <li>登陆</li>
    </ul>
</div>
<div class="content">
    <div class="content_in"></div>
</div>
<div class="footer">
    <div class="footer_in"></div>
</div>
```

```css
* {
  margin: 0;
  padding: 0;
}
.header {
  width: 100%;
  height: 45px;
  background: red;
}
.header .logo {
  float: left;
  margin-left: 20px;
  opacity: 0.5;
}
.header .logo:hover {
  opacity: 1;
}
.header .logo a {
  display: inline-block;
  width: 78px;
  height: 21px;
  background: url("../images/player_logo.png") no-repeat 0 0;
}
.header .register {
  float: right;
  line-height: 25px;
}
.header .register li {
  list-style: none;
  float: left;
  margin-right: 20px;
  color: #fff;
  opacity: 0.5;
  cursor: pointer;
}
.header .register li:hover {
  opacity: 1;
}
.content {
  width: 100%;
  height: 460px;
  background: blue;
}
.content .content_in {
  width: 1200px;
  height: 100%;
  background: deeppink;
  margin: 0 auto;
}
.footer {
  width: 100%;
  height: 60px;
  background: green;
  position: absolute;
  bottom: 0;
  left: 0;
}
.footer .footer_in {
  width: 1200px;
  height: 100%;
  background: plum;
  margin: 0 auto;
}
```

## 工具条

![image-20200618172255517](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/18/a3a51a448acd8b37bcd723c3e7a31ff7.png)

工具条使用span作为按钮，里边为图片加文字。

```html
<div class="content_in">
    <div class="content_left">
        <div class="content_toolbar">
            <span><i></i>收藏</span>
            <span><i></i>添加到</span>
            <span><i></i>下载</span>
            <span><i></i>删除</span>
            <span><i></i>清空列表</span>
        </div>
    </div>
</div>
```

```css
.content .content_in .content_left {
    float: left;
    width: 800px;
    height: 100%;
    background: pink;
}
.content_left .content_toolbar {
    width: 100%;
    height: 40px;
    background: #000;
}
.content_toolbar span {
    display: inline-block;
    width: 122px;
    height: 100%;
    line-height: 40px;
    text-align: center;
    box-sizing: border-box;
    border: 1px solid #fff;
    color: #fff;
    opacity: 0.5;
    cursor: pointer;
}
.content_toolbar span:hover {
    opacity: 1;
}
.content_toolbar span i {
    display: inline-block;
    width: 18px;
    height: 18px;
    background: url("../images/icon_sprite.png") no-repeat;
    margin-right: 10px;
    vertical-align: -5px;
}
.content_toolbar span:nth-child(1) i {
    background-position: -60px -20px;
}
.content_toolbar span:nth-child(2) i {
    background-position: -20px -20px;
}
.content_toolbar span:nth-child(3) i {
    background-position: -40px -240px;
}
.content_toolbar span:nth-child(4) i {
    background-position: -100px -20px;
}
.content_toolbar span:nth-child(5) i {
    background-position: -40px -300px;
}
```

## 歌曲列表

![image-20200618185026610](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/18/bde3b657699574304aa447a623775b2c.png)

歌曲列表可以视作逐行的列表，第一行为标题，下边为歌曲。

```html
<div class="content_left">
    <div class="content_list">
        <ul>
            <li class="list_title">
                <div class="list_check"><i></i></div>
                <div class="list_number"></div>
                <div class="list_name">歌曲</div>
                <div class="list_singer">歌手</div>
                <div class="list_time">时长</div>
            </li>
            <li class="list_music">
                <div class="list_check"><i></i></div>
                <div class="list_number">1</div>
                <div class="list_name">哈哈哈</div>
                <div class="list_singer">TZK</div>
                <div class="list_time">03:17</div>
            </li>
        </ul>
    </div>
</div>
```

```css
/* TAG 播放列表布局 */
.content_list li {
  list-style: none;
  width: 100%;
  height: 50px;
  background: orangered;
  border: 1px solid rgba(255, 255, 255, 0.5);
  box-sizing: border-box;
}
.content_list li div {
  float: left;
  color: #fff;
  text-align: 50px;
  opacity: 0.5;
}
.content_list .list_check {
  width: 50px;
  height: 100%;
  background: #000;
  text-align: center;
}
.content_list .list_check i {
  display: inline-block;
  width: 14px;
  height: 14px;
  border: 1px solid #000;
}
.content_list .list_number {
  width: 20px;
  height: 100%;
  background: green;
}
.content_list .list_name {
  width: 50%;
  height: 100%;
  background: #ccc;
}
.content_list .list_singer {
  width: 20%;
  height: 100%;
  background: pink;
}
```

## 完善播放列表

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/18/3666faff71758dadb53a745ea03a13d4.png)

1. 选择框

   伪选择框，使用图片，当被点击时，切换图片

2. 鼠标悬停的图标

   使用a标签加背景图即可。使用jQuery监听鼠标的移入移出事件。

```html
<li class="list_music">
    <div class="list_check"><i></i></div>
    <div class="list_number">1</div>
    <div class="list_name">哈哈哈
        <div class="list_menu">
            <a href="javascript:;" title="播放"></a>
            <a href="javascript:;" title="添加"></a>
            <a href="javascript:;" title="下载"></a>
            <a href="javascript:;" title="分享"></a>
        </div>
    </div>
    <div class="list_singer">TZK</div>
    <div class="list_time">
        <span>04:12</span>
        <a href="javascript:;" title="删除"></a>
    </div>
</li>
```

```css
.list_name .list_menu {
    margin-top: 5px;
    float: right;
    margin-right: 20px;
    display: none;
}
.list_name .list_menu a {
    display: inline-block;
    width: 36px;
    height: 36px;
    background: url("../images/icon_list_menu.png") no-repeat 0 0;
}
.list_name .list_menu a:nth-child(1) {
    background-position: -120px 0;
}
.list_name .list_menu a:nth-child(2) {
    background-position: -120px -80px;
}
.list_name .list_menu a:nth-child(3) {
    background-position: -120px -120px;
}
.list_name .list_menu a:nth-child(4) {
    background-position: -120px -40px;
}
.content_list .list_time a {
    display: inline-block;
    width: 36px;
    height: 36px;
    background: url("../images/icon_list_menu.png") no-repeat -120px -160px;
    float: left;
    margin-top: 5px;
    display: none;
}
```

```javascript
$(function () {
  // 1. 监听歌曲的移入移出事件
  $(".list_music").hover(
    function () {
      //   显示子菜单
      $(this).find(".list_menu").stop().fadeIn(100);
      $(this).find(".list_time a").stop().fadeIn(100);
      //   隐藏时长
      $(this).find(".list_time span").stop().fadeOut(100);
    },
    function () {
      //   隐藏子菜单
      $(this).find(".list_menu").stop().fadeOut(100);
      $(this).find(".list_time a").stop().fadeOut(100);
      //   显示时长
      $(this).find(".list_time span").stop().fadeIn(100);
    }
  );
  // 2. 监听复选框的点击事件
  $(".list_check").click(function () {
    $(this).toggleClass("list_checked");
  });
});

```

## 自定义滚动条 

![image-20200618194035573](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/18/6a53212b81e00cb2af8931e538db6879.png)

自定义滚动条使用了一个jQuery插件[jQuery custom content scroller](http://manos.malihu.gr/jquery-custom-content-scroller/)。利用这个插件可以轻松设置滚动条样式。

1. 引入CSS文件

2. 在jQuery下方引入JS文件

3. 为需要添加的元素调用`mCustomScrollbar()`方法

   ```javascript
   $(".content_list").mCustomScrollbar();
   ```

4. 为该元素添加自定义属性`data-mcs-theme="dark"`

   ```html
   <div class="content_list" data-mcs-theme='minimal-dark'></div>
   ```

5. 小细节（修改其默认样式）

   ![image-20200618194130417](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/18/87a462d99ba4a7e3a305bf05276c2c81.png)

   根据图中所示，可以将滚动条的宽度增加。

   ```css
   /* 滚动条 */
   ._mCS_1 .mCSB_scrollTools .mCSB_dragger_bar {
   width: 8px;
   }
   ```

## 音乐歌曲信息

![image-20200618200547905](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/18/75e3582fd62919bc49e2adc6fa148284.png)

```html
<div class="content_right">
    <div class="song_info">
        <a href="javascript;;" class="song_info_pic">
            <img src="images/lnj.jpg" alt="">
        </a>
        <div class="song_info_name">歌曲名称:
            <a href="javascript:;">xiaokang</a>
        </div>
        <div class="song_info_singer">歌手名:
            <a href="javascript:;">xiaokang</a>
        </div>
        <div class="song_info_ablum">专辑名:
            <a href="javascript:;">xiaokang</a>
        </div>
    </div>
    <ul class="song_lyric">
        <li class="cur">第一条歌词</li>
        <li>第二条歌词</li>
    </ul>
</div>
```

```css
.content_right .song_info {
    text-align: center;
    color: rgba(255, 255, 255, 0.5);
    line-height: 30px;
}

.song_info .song_info_pic {
    display: inline-block;
    background: url("../images/album_cover_player.png") no-repeat 0 0;
    width: 201px;
    height: 180px;
    text-align: left;
}
.song_info_pic img {
    width: 180px;
    height: 180px;
}
.song_info div a {
    text-decoration: none;
    color: #fff;
    opacity: 0.5;
}
.song_info div a:hover {
    opacity: 1;
}
.content_right .song_lyric {
    background: gray;
    text-align: center;
    margin-top: 30px;
}
.content_right .song_lyric li {
    list-style: none;
    line-height: 30px;
    color: rgba(255, 255, 255, 0.5);
    font-weight: bold;
}
.content_right .song_lyric .cur {
    color: #31c27c;
}
```

## 底部结构

### 基本结构

![image-20200619103844876](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/19/c6d96e88d0943ef49ea141cf8a9566c4.png)

进度条可大致分为四部分

1. 图标

   使用a标签加背景图即可

2. 歌曲进度条（红色区域）

   因为此区域需包含进度条及歌曲名称、时间等信息。因此使用div作为布局

3. 音量部分（绿色区域）

   此部分包含图标及一个拖动条，因此也使用div作为盒子进行布局。

```html
<div class="footer_in">
    <a href="javascript:;" class="music_pre"></a>
    <a href="javascript:;" class="music_play"></a>
    <a href="javascript:;" class="music_next"></a>
    <div class="music_progress_info"></div>
    <a href="javascript:;" class="music_mode"></a>
    <a href="javascript:;" class="music_fav"></a>
    <a href="javascript:;" class="music_down"></a>
    <a href="javascript:;" class="music_comment"></a>
    <a href="javascript:;" class="music_only"></a>
    <div class="music_voice_info"></div>
</div>
```

```css
.footer_in a {
    display: inline-block;
    text-decoration: none;
    color: #fff;
    background: url("../images/player.png") no-repeat 0 0;
    margin-right: 20px;
}
.footer_in .music_pre {
    width: 19px;
    height: 20px;
    background-position: 0 -30px;
}
.footer_in .music_play {
    width: 21px;
    height: 29px;
    background-position: 0 0;
}
.footer_in .music_next {
    width: 19px;
    height: 20px;
    background-position: 0 -52px;
}
.footer_in .music_progress_info {
    display: inline-block;
    width: 670px;
    height: 40px;
    background-color: red;
}
.footer_in .music_mode {
    width: 26px;
    height: 25px;
    background-position: 0px -205px;
}
.footer_in .music_fav {
    width: 24px;
    height: 21px;
    background-position: 0px -96px;
}
.footer_in .music_down {
    width: 22px;
    height: 21px;
    background-position: 0px -120px;
}
.footer_in .music_comment {
    width: 24px;
    height: 24px;
    background-position: 0px -400px;
}
.footer_in .music_only {
    width: 74px;
    height: 27px;
    background-position: 0px -281px;
}
.footer_in .music_voice_info {
    display: inline-block;
    width: 100px;
    background: green;
    height: 40px;
}
```

### 进度条

![image-20200619111902832](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/19/93922a996de782562a84c13aae8e2452.png)

![image-20200619111910450](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/19/4383bbd8b5fac89d49976c0b3b28b09e.png)

1. 歌曲部分的结构

   - 信息部分

     两个span元素即可

   - 进度条

     一种通用的结构。三层结构分别表示背景、前景、圆。

     ```html
     <div class="music_progress_bar">
         <div class="music_progress_line">
             <div class="music_progress_dot"></div>
         </div>
     </div>
     ```

     ![image-20200619112258786](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/19/4787e1ff460ccc2f6fce54a8f52ee0f9.png)

2. 音量部分

   与歌曲信息的进度条同理，图标同样使用a标签与图片结合。

```html
<div class="music_progress_info">
    <div class="music_progress_top">
        <span class="music_progress_name">666/666</span>
        <span class="music_progress_time">00:00 / 05:23</span>
    </div>
    <div class="music_progress_bar">
        <div class="music_progress_line">
            <div class="music_progress_dot"></div>
        </div>
    </div>
</div>
<div class="music_voice_info">
    <a href="javascript:;" class="music_voice_icon"></a>
    <div class="music_voice_bar">
        <div class="music_voice_line">
            <div class="music_voice_dot"></div>
        </div>
    </div>
</div>
```

```css
/* 歌曲进度条 */
.footer_in .music_progress_info {
    display: inline-block;
    width: 670px;
    height: 40px;
    background-color: red;
}
.music_progress_info .music_progress_top {
    width: 100%;
    height: 30px;
    line-height: 30px;
    background: #000000;
    color: #fff;
}
.music_progress_top .music_progress_name {
    float: left;
    opacity: 0.5;
}
.music_progress_top .music_progress_name:hover {
    opacity: 1;
}
.music_progress_top .music_progress_time {
    float: right;
    opacity: 0.5;
}

.music_progress_info .music_progress_bar {
    width: 100%;
    height: 4px;
    background: rgba(255, 255, 255, 0.5);
    margin-top: 5px;
}
.music_progress_bar .music_progress_line {
    width: 100%;
    height: 100%;
    background: #ffffff;
}
.music_progress_bar .music_progress_dot {
    width: 14px;
    height: 14px;
    border-radius: 50%;
    background: #fff;
    position: relative;
    top: -5px;
    left: 100px;
    cursor: pointer;
}
/* 音量控制 */
.footer_in .music_voice_info {
    display: inline-block;
    width: 100px;
    background: green;
    height: 40px;
    position: relative;
}
.music_voice_info .music_voice_icon {
    width: 26px;
    height: 21px;
    background-position: 0 -144px;
    position: absolute;
    left: 0;
    top: 10px;
}
.music_voice_info .music_voice_bar {
    width: 70px;
    height: 4px;
    background: rgba(255, 255, 255, 0.5);
    position: absolute;
    right: 0;
    top: 18px;
}
.music_voice_bar .music_voice_line {
    width: 50px;
    height: 100%;
    background: #ffffff;
}
.music_voice_bar .music_voice_dot {
    width: 14px;
    height: 14px;
    border-radius: 50%;
    background: #ffffff;
    position: absolute;
    top: -5px;
    left: 50px;
}
```

### 底部微调完善

![image-20200619114423558](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/19/732909165c4918c7280eedb8c4e21ad3.png)

```css
.footer {
    height: 80px;
}
.footer_in .music_play {
    vertical-align: -5px;
}
.footer_in .music_progress_info {
    top: 10px;
}
.footer_in .music_voice_info {
    top: 10px;
}
/* 播放按钮点击 */
.footer_in .music_play2 {
    background-position: -30px 0;
}
/* 循环模式样式切换 */
.footer_in .music_mode2 {
    width: 23px;
    height: 20px;
    background-position: 0px -260px;
}
.footer_in .music_mode3 {
    width: 25px;
    height: 19px;
    background-position: 0px -74px;
}
.footer_in .music_mode4 {
    width: 26px;
    height: 25px;
    background-position: 0px -232px;
}
/* 喜欢按钮 */
.footer_in .music_fav2 {
    background-position: -30px -96px;
}
/* 纯净模式 */
.footer_in .music_only2 {
    background-position: 0px -310px;
}
```

## 高斯模糊背景

![image-20200619115743728](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/19/d41e42b140cc17867c173a7cd5d2ae83.png)

模糊背景通过使用一张图加一个淡灰色的蒙版即可。

```html
<div class="footer"></div>
<div class="mask_bg"></div>
<div class="mask"></div>
```

```css
/* 背景设置 */
.mask_bg {
    position: absolute;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background: url("../images/lnj.jpg") no-repeat 0 0;
    background-size: cover;
    z-index: -2;
    filter: blur(100px);
}
.mask {
    position: absolute;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    z-index: -1;
    background: rgba(0, 0, 0, 0.35);
}
```

## 加载歌曲

加载歌曲使用了jQuery得Ajax方法。通过一个json文件获取歌曲的相关信息。

![image-20200619143939845](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/19/32487c0184d8590b09675a59eb8e5ee8.png)

```javascript
// 3. 加载歌曲列表
function getPlayerList() {
    $.ajax({
        url: "./source/musiclist.json",
        dataType: "json",
        success: function (data) {
            // 3.1 遍历获取到的数据创建每一条音乐
            var $musicList = $(".content_list ul");
            $.each(data, function (index, ele) {
                var $item = createMusicItem(index, ele);
                $musicList.append($item);
            });
        },
        error: function (e) {
            console.log(e);
        },
    });
}
getPlayerList();
// 创建一条音乐的方法
function createMusicItem(index, music) {
    var $item = $(
        '<li class="list_music"><div class="list_check "><i></i></div><div class="list_number">' +
        (index + 1) +
        '</div><div class="list_name">' +
        music.name +
        '<div class="list_menu"><a href="javascript:;" title="播放"></a><a href="javascript:;" title="添加"></a><a href="javascript:;" title="下载"></a><a href="javascript:;" title="分享"></a></div></div><div class="list_singer">' +
        music.singer +
        '</div><div class="list_time"><span>' +
        music.time +
        '</span><a href="javascript:;" title="删除"></a></div></li>'
    );
    return $item;
}
```

### 完善事件

由于音乐列表改成了js动态创建，那么就会导致曾经绑定的事件失效，因此需要修改为事件委托方式。

```javascript
// 1. 监听歌曲的移入移出事件
$(".content_list").delegate(".list_music", "mouseenter", function () {
    //   显示子菜单
    $(this).find(".list_menu").stop().fadeIn(100);
    $(this).find(".list_time a").stop().fadeIn(100);
    //   隐藏时长
    $(this).find(".list_time span").stop().fadeOut(100);
});
$(".content_list").delegate(".list_music", "mouseleave", function () {
    //   隐藏子菜单
    $(this).find(".list_menu").stop().fadeOut(100);
    $(this).find(".list_time a").stop().fadeOut(100);
    //   显示时长
    $(this).find(".list_time span").stop().fadeIn(100);
});

// 2. 监听复选框的点击事件
$(".content_list").delegate(".list_check", "click", function () {
    $(this).toggleClass("list_checked");
});
```

## 音乐播放图标切换

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/19/d02d8622e0b3976babb969f55ca28dfb.png)

为此按钮添加事件同样需要以事件委托的方式。当点击后会发生两件事：

1. 将其他播放按钮改为暂停状态
2. 将底部播放按钮修改

```javascript
// 3. 添加子菜单播放按钮的监听
var $musicPlay = $(".music_play");
$(".content_list").delegate(".list_menu_play", "click", function () {
    // 3.1 切换播放的图标
    $(this).toggleClass("list_menu_play2");
    // 3.2 复原其他的播放图标
    $(this)
        .parents(".list_music")
        .siblings()
        .find(".list_menu_play")
        .removeClass("list_menu_play2");
    // 3.3 同步底部播放按钮
    if ($(this).attr("class").indexOf("list_menu_play2") != -1) {
        // 当前是播放状态
        $musicPlay.addClass("music_play2");
    } else {
        $musicPlay.removeClass("music_play2");
    }
});
```

## 音乐播放状态切换

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/19/c2167e86eabe2c0543a833ea9d51dcf6.png)

要想控制单个，必须设置时对单个设置，而不是全部，因此css部分需要微调。

```css
.content_list li div {
    color: rgba(255, 255, 255, 0.5);
}
.content_list .list_check i {
    opacity: 0.5;
}
.content_list .list_checked i {
    opacity: 1;
}
.list_name .list_menu a {
    opacity: 0.5;
}
.list_name .list_menu a:hover {
  opacity: 1;
}
.content_list .list_time a {
    opacity: 0.5;
}
.content_list .list_time a:hover {
  opacity: 1;
}
```

将css修改完成后，接下来就是在JavaScript绑定的事件中进行修改了。

```javascript
// 3.3 同步底部播放按钮
if ($(this).attr("class").indexOf("list_menu_play2") != -1) {
    // 当前是播放状态
    $musicPlay.addClass("music_play2");
    // 让文字高亮
    $(this).parents(".list_music").find("div").css("color", "#fff");
} else {
    $musicPlay.removeClass("music_play2");
    // 让文字不高亮
    $(this)
        .parents(".list_music")
        .find("div")
        .css("color", "rgba(255,255,255,0.5)");
}
```

## 序号动画

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/19/33a3a3e0d0b392590b16e2b39a6c7867.png)

动画采用图片的方式实现。当点击时，因此文字，并且显示图片。并作一些排他设置。

```javascript
$(".content_list").delegate(".list_menu_play", "click", function () {
    var $item = $(this).parents(".list_music");
    // 3.1 切换播放的图标
    $(this).toggleClass("list_menu_play2");
    // 3.2 复原其他的播放图标
    $(this)
        .parents(".list_music")
        .siblings()
        .find(".list_menu_play")
        .removeClass("list_menu_play2");
    // 3.3 同步底部播放按钮
    if ($(this).attr("class").indexOf("list_menu_play2") != -1) {
        // 当前是播放状态
        $musicPlay.addClass("music_play2");
        // 让文字高亮
        $item.find("div").css("color", "#fff");
        $item.siblings().find("div").css("color", "rgba(255,255,255,0.5)");
    } else {
        $musicPlay.removeClass("music_play2");
        // 让文字不高亮
        $item.find("div").css("color", "rgba(255,255,255,0.5)");
    }
    // 3.4 切换序号的状态
    $item.find(".list_number").toggleClass("list_number2");
    $item.siblings().find(".list_number").removeClass("list_number2");
});
```

```css
.content_list .list_number2 {
    color: transparent !important;
    background: url("../images/wave.gif") no-repeat 0 0;
}
```

## 播放工具类封装

![image-20200619185250834](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/19/3f1d8fb5debc4b7eb8ed57f5b74c30c7.png)

```javascript
(function (window) {
    function Player() {
        return new Player.prototype.init();
    }
    Player.prototype = {
        constructor: Player,
        init: function () {},
    };
    Player.prototype.init.prototype = Player.prototype;
    window.Player = Player;
})(window);

```

1. 封装一个类，返回原型上的`init()`方法

   也就是通过`init()`创建类

2. 定义这个类的原型

   将构造函数指向`Player`，并定义`init`方法

3. 将`Player`原型上的`init`方法的原型指向`Player`的原型

4. 将这个对象开放给window

## 音乐的播放暂停

1. 在HTML页面插入一个`audio`标签，用于播放音乐

2. 引入player工具库

3. 实例化一个`Player`对象，并且传入`audio`对象

4. 当按钮被点击时，调用播放音乐的方法

5. 实现播放/暂停音乐的方法

   1. 当创建音乐标签时，在标签中保存索引及音乐信息

      ```javascript
      // 定义一个方法创建一条音乐
      function createMusicItem(index, music) {
          var $item = $(...);
          $item.get(0).index = index;
          $item.get(0).music = music;
          return $item;
      }
      ```

   2. 接收两个参数，分别为`index`和`music`信息

   3. 定义一个遍历，用于记录当前索引

   4. 判断是否为同一首音乐

   ```javascript
   Player.prototype = {
       currentIndex: -1,
       playMusic: function (index, music) {
           // 判断是否是同一首音乐
           if (this.currentIndex == index) {
               // 同一首音乐
               if (this.audio.paused) {
                   this.audio.play();
               } else {
                   this.audio.pause();
               }
           } else {
               //   不是同一首音乐
               this.$audio.attr("src", music.link_url);
               this.audio.play();
               this.currentIndex = index;
           }
       },
   };
   ```

   

## 底部播放/暂停/上一首/下一首

底部播放暂停的逻辑：

1. 播放暂停

   - 从未播放过

     播放第一首

   - 播放过

     继续播放

   ```javascript
   $musicPlay.click(function () {
       // 判断有没有播放过音乐
       if (player.currentIndex == -1) {
           // 没有播放过
           $(".list_music").eq(0).find(".list_menu_play").trigger("click");
       } else {
           // 已经播放过
           $(".list_music")
               .eq(player.currentIndex)
               .find(".list_menu_play")
               .trigger("click");
       }
   });
   ```

   

2. 上一首/下一首

   - 第一首

     上一首为最后一首

   - 最后一首

     下一首为第一首

   ```javascript
   // 5 监听底部控制区域上一首按钮的点击
   $(".music_pre").click(function () {
       $(".list_music")
           .eq(player.preIndex())
           .find(".list_menu_play")
           .trigger("click");
   });
   // 6 监听底部控制区域下一首按钮的点击
   $(".music_next").click(function () {
       $(".list_music")
           .eq(player.nextIndex())
           .find(".list_menu_play")
           .trigger("click");
   });
   ```

   对象的`preIndex`与`nextIndex`方法用于处理索引。

   ```javascript
   preIndex: function () {
       var index = this.currentIndex - 1;
       if (index < 0) {
           index = this.musicList.length - 1;
       }
       return index;
   },
       nextIndex: function () {
           var index = this.currentIndex + 1;
           if (index > this.musicList.length - 1) {
               index = 0;
           }
           return index;
       },
   ```

   

## 删除歌曲

删除数据时需要注意的就是前台删除数据后，后台也无需保存数据。并且需要对标签保存的数据进行重新排序

```javascript
// 7. 监听删除按钮的点击
$(".content_list").delegate(".list_menu_del", "click", function () {
    // 找到被点击的音乐
    var $item = $(this).parents(".list_music");
    // 判断当前删除的是否是正在播放的
    if ($item.get(0).index == player.currentIndex) {
        $(".music_next").trigger("click");
    }
    $item.remove();
    player.changeMusic($item.get(0).index);
    // 重新排序
    $(".list_music").each(function (index, ele) {
        ele.index = index;
        $(ele)
            .find(".list_number")
            .text(index + 1);
    });
});
```

删除后需要注意删除的数据是否是正在播放的音乐的前边，如果是需要将索引-1。否则会出现下一曲跳歌的现象。

```javascript
changeMusic: function (index) {
    // 删除对应的数据
    this.musicList.splice(index, 1);
    //判断当前删除的是否是正在播放的前面的音乐
    if (index < this.currentIndex) {
        this.currentIndex = this.currentIndex - 1;
    }
},
```

## 切换歌曲信息

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/20/8632eab4433442f11a7833d7970c5617.png)

更换歌曲信息涉及到的基本信息包括：

1. 右侧信息栏

   - 图片
   - 歌手
   - 歌曲名
   - 专辑名

2. 底部控制条的名称、时间

   

实现这个这个功能也很简单，只是一些元素的替换。调用位置有两处

1. 第一次获取歌曲时（成功）的回调

   初始化列表的第一个音乐

2. 当点击其他歌曲时

```javascript
// 2. 初始化歌曲信息
function initMusicInfo(music) {
    // 获取对应的元素
    var $musicImage = $(".song_info_pic img");
    var $musicName = $(".song_info_name a");
    var $musicSinger = $(".song_info_singer a");
    var $musicAblum = $(".song_info_ablum a");
    var $musicProgressName = $(".music_progress_name");
    var $musicProgressTime = $(".music_progress_time");
    var $musicBg = $(".mask_bg");
    // 给获取的到的元素赋值
    $musicImage.attr("src", music.cover);
    $musicName.text(music.name);
    $musicSinger.text(music.singer);
    $musicAblum.text(music.album);
    $musicProgressName.text(music.name + "/" + music.singer);
    $musicProgressTime.text("00:00 / " + music.time);
    $musicBg.css("background", 'url("' + music.cover + '")');
}
$.ajax({
    success: function (data) {
        initMusicInfo(data[0]);
    },
});
$(".content_list").delegate(".list_menu_play", "click", function () {
    // 3.6 切换歌曲信息
    initMusicInfo($item.get(0).music);
});
```



## 进度条的实现

![image-20200620145737711](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/20/6ba3b0baf6cdbf58b4538c56540138a0.png)

1. 获取被点击位置距离窗口的位置
2. 获取默认距离窗口的位置
3. 被点击的位置减去默认距离窗口的位置
4. 点击进度条时，调整小圆点以及前景色的位置

```javascript
progressClick: function () {
    var $this = this; //this 是progress
    // 监听背景的点击
    this.$progressBar.click(function (event) {
        //   获取背景距离窗口默认的位置
        var normalLeft = $(this).offset().left;
        //   获取点击的位置距离窗口默认的位置
        var eventLeft = event.pageX;
        //   设置前景的宽度
        $this.$progressLine.css("width", eventLeft - normalLeft);
        $this.$progressDot.css("left", eventLeft - normalLeft);
    });
},
```

### 进度条的拖动

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/20/c64d95768f57d9656334a9a0e7a851f9.png)

1. 鼠标拖拽使用`mousemove`方法监听，但必须在鼠标按下后监听
2. 实现逻辑与点击一致
3. 鼠标抬起则释放`mousemove`事件即可

```javascript
progressMove: function () {
    var $this = this;
    // 1. 监听的鼠标的按下事件
    this.$progressBar.mousedown(function () {
        //   获取背景距离窗口默认的位置
        var normalLeft = $(this).offset().left;

        // 2. 监听鼠标的移动事件
        $(document).mousemove(function () {
            //   获取点击的位置距离窗口默认的位置
            var eventLeft = event.pageX;
            //   设置前景的宽度
            $this.$progressLine.css("width", eventLeft - normalLeft);
            $this.$progressDot.css("left", eventLeft - normalLeft);
        });
    });

    // 3. 监听鼠标的抬起事件
    $(document).mouseup(function () {
        $(document).off("mousemove");
    });
},
```

## 音乐时间、进度条同步

![](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/20/a2e6c665a031662dab8730edbb46b750.png)

<span class="inline-tag red">音乐时间同步</span>

通过`timeupdate`事件监听是否播放，正在播放时，会不断触发这个事件。在事件内部通过`duration`与`currentTime`获取当前时长和总时长。

于是可以在`player`类中新增加方法

```javascript
musicTimeUpdate: function (callBack) {
    var $this = this;
    this.$audio.on("timeupdate", function () {
        var duration = $this.audio.duration;
        var currentTime = $this.audio.currentTime;
        var timeStr = $this.formatDate(currentTime, duration);
        callBack(currentTime, duration, timeStr);
    });
},
    // 格式化时间
    formatDate: function (currentTime, duration) {
        // 结束时间
        var endMin = parseInt(duration / 60);
        var endSec = parseInt(duration % 60);
        if (endMin < 10) {
            endMin = "0" + endMin;
        }
        if (endSec < 10) {
            endSec = "0" + endSec;
        }

        // 开始时间
        var startMin = parseInt(currentTime / 60);
        var startSec = parseInt(currentTime % 60);
        if (startMin < 10) {
            startMin = "0" + startMin;
        }
        if (startSec < 10) {
            startSec = "0" + startSec;
        }
        return startMin + ":" + startSec + " / " + endMin + ":" + endSec;
    },
```

在我们的`index.js`中只需要调用这个方法即可。

```javascript
// 8. 监听播放的进度
player.musicTimeUpdate(function (currentTime, duration, timeStr) {
    // 同步时间
    $(".music_progress_time").text(timeStr);
});
```

<span class="inline-tag red">进度条同步</span>

同样的为进度条新增方法`setProgress`

```javascript
setProgress: function (value) {
    if (value < 0 || value > 100) return;
    this.$progressLine.css({
        width: value + "%",
    });
    this.$progressDot.css({
        left: value + "%",
    });
},
```

这样完成后，在主函数中计算出当前时间所占比例即可调用此方法进行设置。

```javascript
// 8. 监听播放的进度
player.musicTimeUpdate(function (currentTime, duration, timeStr) {
    // 同步进度条
    // 计算播放比例
    var value = (currentTime / duration) * 100;
    progress.setProgress(value);
});
```

因为使用了百分比进行修改元素，那么css的定位方式也需要修改一下：

```css
.music_progress_info .music_progress_bar {
  position: relative;
}
.music_progress_bar .music_progress_dot {
  position: absolute;
}
```

## 点击进度条与歌曲同步

实现思路：

1. 计算出总时长除以已播放时长的比例
2. 将歌曲进度设置为歌曲时长乘以上一步的比例

```javascript
progress.progressClick(function (value) {
    player.musicSeekTo(value);
});
progress.progressMove(function (value) {
    player.musicSeekTo(value);
});
```

```javascript
musicSeekTo: function (value) {
    this.audio.currentTime = this.audio.duration * value;
},
```

为了实现拖拽时声音能够继续播放，因此将设置的方法改到mouseup事件中

```javascript
progressMove: function (callBack) {
    var $this = this;
    var normalLeft, eventLeft;
    // 1. 监听的鼠标的按下事件
    this.$progressBar.mousedown(function () {
        //   获取背景距离窗口默认的位置
        normalLeft = $(this).offset().left;
        $this.isMove = true;
        // 2. 监听鼠标的移动事件
        $(document).mousemove(function () {
            //   获取点击的位置距离窗口默认的位置
            eventLeft = event.pageX;
            //   设置前景的宽度
            $this.$progressLine.css("width", eventLeft - normalLeft);
            $this.$progressDot.css("left", eventLeft - normalLeft);
        });
    });

    // 3. 监听鼠标的抬起事件
    $(document).mouseup(function () {
        $(document).off("mousemove");
        $this.isMove = false;
        // 计算进度条的比例
        var value = (eventLeft - normalLeft) / $this.$progressBar.width();
        callBack(value);
    });
},
```

## 声音控制

声音控制与进度条控制几乎一致

```javascript
var $voiceBar = $(".music_voice_bar");
var $voiceLine = $(".music_voice_line");
var $voiceDot = $(".music_voice_dot");
voicePregress = Progress($voiceBar, $voiceLine, $voiceDot);
voicePregress.progressClick(function (value) {
    player.musicVoiceSeekTo(value);
});
voicePregress.progressMove(function (value) {
    player.musicVoiceSeekTo(value);
});
}
```

接下来为`player`类新增方法即可。

```javascript
musicVoiceSeekTo: function (value) {
    // 取值0~1
    this.audio.volume = value;
},
```

### bug修复

1. 音乐进度的跳转应为一个正常的数字

   ```javascript
   musicSeekTo: function (value) {
       if (isNaN(value)) return;
       this.audio.currentTime = this.audio.duration * value;
   },
   ```

2. 音量同理且音量范围为0~1

   ```javascript
   musicVoiceSeekTo: function (value) {
       if (isNaN(value)) return;
       if (value < 0 || value > 1) return;
       // 取值0~1
       this.audio.volume = value;
   },
   ```

3. 拖拽超出范围

   ```javascript
   progressMove: function (callBack) {
       var barWidth = this.$progressBar.width();
       // 1. 监听的鼠标的按下事件
       this.$progressBar.mousedown(function () {
           $(document).mousemove(function () {
               var offset = eventLeft - normalLeft;
               if (offset >= 0 && offset <= barWidth) {
                   //   设置前景的宽度
                   $this.$progressLine.css("width", eventLeft - normalLeft);
                   $this.$progressDot.css("left", eventLeft - normalLeft);
               }
           });
       });
   ```

   

## 歌词设置

### 歌词解析并且加载（创建）

![image-20200620174503437](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/06/20/c9ff8d630d1f80dbefae6f39268e5300.png)

解析创建一个新的类用于解析歌词。

```javascript
(function (window) {
    function Lyric(path) {
        return new Lyric.prototype.init(path);
    }
    Lyric.prototype = {
        constructor: Lyric,
        init: function (path) {
            this.path = path;
        },
        // 保存匹配的时间
        times: [],
        // 保存匹配的歌词
        lyrics: [],
        loadLyric: function (callBack) {
            var $this = this;
            $.ajax({
                url: $this.path,
                dataType: "text",
                success: function (data) {
                    $this.pareLyric(data);
                    callBack();
                },
                error: function (e) {},
            });
        },
        // 解析歌词的方法
        pareLyric: function (data) {
            var $this = this;
            var array = data.split("\n");
            // 正则表达式匹配内容
            var timeReg = /\[(\d*:\d*\.\d*)\]/;
            // 遍历取出每一条歌词
            $.each(array, function (index, ele) {
                //   处理歌词
                var lrc = ele.split("]")[1];
                //   排除空字符串(没有歌词)
                if (lrc.length == 1) return true;
                $this.lyrics.push(lrc);
                var res = timeReg.exec(ele);
                if (res == null) return true;
                var timeStr = res[1];
                var res2 = timeStr.split(":");
                var min = parseInt(res2[0]) * 60;
                var sec = parseFloat(res2[1]);
                var time = parseFloat(Number(min + sec).toFixed(2));
                $this.times.push(time);
            });
            console.log($this.times);
            console.log($this.lyrics);
        },
    };
    Lyric.prototype.init.prototype = Lyric.prototype;
    window.Lyric = Lyric;
})(window);

```

接下来只需要在自己的JavaScript中初始化这个类并且调用方法即可。

```JavaScript
// 3. 初始化歌词信息
function initMusicLyric(music) {
    var lyric = new Lyric(music.link_lrc);
    var $lryicContainer = $(".song_lyric");
    lyric.loadLyric(function () {
        // 创建歌词列表
        $.each(lyric.lyrics, function (index, ele) {
            var $item = $("<li>" + ele + "</li>");
            $lryicContainer.append($item);
        });
    });
}
```

创建好了之后，还需要对样式进行一点点小的修改

```css
.content_right .song_lyric {
  height: 150px;
  overflow: hidden;
}
```



### 歌词同步

歌词同步需要在监听播放的进度中去设置

```javascript
// 8. 监听播放的进度
player.musicTimeUpdate(function (currentTime, duration, timeStr) {
    // 实现歌词的同步
    var index = lyric.currentIndex(currentTime);
    var $item = $(".song_lyric li").eq(index);
    $item.addClass("cur");
    $item.siblings().removeClass("cur");
    if (index <= 2) return;
    $(".song_lyric").css({
        marginTop: (-index + 2) * 30,
    });
});
```

因为使用了`margin-top`滚动歌词，那么需要将html也该动。

```html
<div class="song_lyric_container">
    <ul class="song_lyric"></ul>
</div>
```

为了实现切换歌曲时，歌词也可以切换，也需要在切换歌曲时将保存的歌曲信息也切换。

```javascript
loadLyric: function (callBack) {
    $this.times = [];
    $this.lyrics = [];
},
```

```javascript
function initMusicLyric(music) {
    $lryicContainer.html("");
}
$(".content_list").delegate(".list_menu_play", "click", function () {
    // 3.7切换歌词信息
    initMusicLyric($item.get(0).music);
});
```



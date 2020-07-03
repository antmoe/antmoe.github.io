---
title: 五、express实战-英雄管理系统
date: 2020-07-03T14:55:50+08:00
categories: ["notes"]
tags: ["Node"]
---

{% btns rounded grid5 %}
{% cell 查看源码, https://gitee.com/antmoe/project/tree/master/2020/07/03/ManagerHero, fa fa-download %}
{% endbtns %}

## 后端路由

简单来说，注册路由就是写接口



## 登录接口

登录接口实现很简单，只需要接收post传来的参数，然后进行验证即可。

```javascript
const express = require("express");
const bodyParser = require("body-parser");

app.use(bodyParser.urlencoded({ extended: false }));
// 登录接口
app.post("/login", (req, res) => {
  // 接收用户传递过来的用户名和密码
  let { username, password } = req.body;
  if (username == "admin" && password == "123") {
    res.send({
      code: 200,
      msg: "登陆成功",
    });
  } else {
    res.send({
      code: 400,
      msg: "登陆失败",
    });
  }
});
app.listen(3000, () => {
  console.log("开启成功");
});

```

## 获取所有英雄接口

获取所有英雄接口需要调用工具的方法。

```javascript
const path = require("path");
// 导入自己写的模块(需要拼接绝对路径)
const db = require(path.join(__dirname, "utils", "db.js"));
// 获取所有英雄接口
app.get("/getAllHero", (req, res) => {
  // 调用自己写的db.js模块中的方法,获取所有英雄
  let list = db.getHeros();
  res.send({
    code: 200,
    data: list,
  });
});
```

## 根据ID获取英雄

```javascript
app.get("/getHeroById", (req, res) => {
    let { id } = req.query;
    let result = db.getHeroById(id);
    if (result != false) {
        res.send({
            code: 200,
            msg: "获取成功",
            data: result,
        });
    } else {
        res.send({
            code: 400,
            msg: "获取失败",
        });
    }
});
```

## 前端页面--登录

登录页面使用Ajax向后端发送请求即可。

```javascript
$(function () {
    $('.login').on('click', function (e) {
        e.preventDefault()
        let username = $('#username').val().trim()
        let password = $('#password').val().trim()
        $.ajax({
            type: 'post',
            url: 'http://127.0.0.1:3000/login',
            data: {
                username,
                password
            },
            success: function (backData) {
                if (backData.code == 200) {
                    alert('登录成功')
                    window.location.href = 'index.html'
                } else {
                    alert(backData.msg)
                }
            }
        })
    })
}
 )
```

## 前端页面--显示数据

当页面一加载，首先应自动发送请求获取全部的英雄数据。然后通过模板引擎渲染。

```javascript
$(function () {
    $.ajax({
        type: 'get',
        url: 'http://127.0.0.1:3000/getAllHero',
        success: function (res) {
            console.log(res)
            // var temp = template('cq', res);
            // $('tbody').html(temp)
            if (res.code == 200) {
                // 通过模板引擎渲染
                var resHtml = template('cq', res)
                console.log(resHtml)
                $('tbody').html(resHtml)
            }
        }
    })
})
```

```html
// 模板引擎
<script type="text/html" id="cq">
  {{each data v}}
  <tr>
    <td><img src="{{v.icon}}"></td>
    <td>{{v.name}}</td>
    <td>{{v.skill}}</td>
    <td>
      <button onclick="location.href='./edit.html?id={{v.id}}'" class="btn btn-primary">编辑</button>
      <button  data-id='{{v.id}}' class="btn btn-danger delete">删除</button>
    </td>
    </tr>
  {{/each}}
</script>
```

**由于我们的上传目录(`uploads`)没有暴露，因此外部不可以访问到，需要将此目录暴露出去，这样就能解决图片无法加载的问题。**

## 删除数据

```javascript
$('tbody').on('click', '.delete', function () {
    var that = this;
    // console.log(this)
    var id = $(this).attr('data-id').trim();
    if (confirm('你要删除吗??')) {
        $.ajax({
            type: 'get',
            url: 'http://127.0.0.1:3000/delete',
            data: {
                id: id
            },
            success: function (res) {
                // console.log(res)
                if (res.code == 200) {
                    $(that).parent().parent().remove();
                }
            }
        })
    }
})
```

## 修改数据

```javascript
  $(function () {
    var id = window.location.search.split('=')[1];
    console.log(id)
    $.ajax({
      type: 'get',
      url: 'http://127.0.0.1:3000/getHeroById',
      data: {
        id: id
      },
      success: function (res) {
        // console.log(res)
        if (res.code == 200) {
          $('#heroName').val(res.data.name)

          $('#skillName').val(res.data.skill);
          $('.preview').attr('src', res.data.icon);
          $('#id').val(id)
        }
      }
    })

    $('#heroIcon').on('change', function () {
      // console.log()
      var fileName = URL.createObjectURL(this.files[0]);
      $('.preview').attr('src', fileName)
    })

    //保存数据
    $('.btn-save').on('click', function (e) {
      e.preventDefault();
      var formData = new FormData($('form')[0]);
      $.ajax({
        type: 'post',
        url: 'http://127.0.0.1:3000/edit',
        data: formData,
        contentType: false,
        processData: false,
        success: function (res) {
          //   console.log(res)

          if (res.code == 200) {
            alert(res.msg);
            window.location.href = './index.html';

          } else {
            alert(res.msg)
          }
        }
      })
    })
  })

```

## 服务器重定向

```javascript
// 如果找不到页面
app.use((req, res) => {
  // 服务器重定向：主动修改地址栏
  res.writeHead(302, {
    Location: "http://www.baidu.com",
  });
  res.end();
});
```


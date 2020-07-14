---
title: Express框架实现一个简单的博客系统
date: 2020-07-12T21:52:50+08:00
categories: ["project"]
---

<div class="btns rounded grid5"><a href="https://gitee.com/antmoe/project/tree/master/2020/07/blog2" title="下载源码"><i class="fa fa-download"></i> 下载源码</a></div>

## 前言

这篇文章是记录一下自己动手完成一个博客开发的历程。

一个前台靠扒别人页面后端靠layui实现的博客。

![首页](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/13/244442f2e505ab0d8b1bc032725e2504.png)

![image-20200714194648159](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/14/a1090a1fdc3aa727169d60dbefe48f64.png)

![image-20200714194728055](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/14/aae763ed824cb73a9ec0eb0b71e950e0.png)

![代码高亮](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/13/e15ccca249be19620ef4bb3cf6dcec2a.png)



至此博客开坑任务基本完成![doge-小康博客](https://cdn.jsdelivr.net/gh/blogimg/emotion/bili_tv_gif/doge.gif)

## 2020-07-14

![image-20200714192957395](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/14/6bbadafe8244df6cee5005e668f8089a.png)

![image-20200714193549647](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/14/6ade24c88fae1fb67d8fe24a66d9713c.png)

![image-20200714193640122](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/14/b59cf27ea7db1e1553334e25183d362e.png)



<div class="checkbox green checked">
  <input type="checkbox" checked />
  <p>一个404页面</p>
</div>

<div class="checkbox green checked">
  <input type="checkbox" checked />
  <p>后台部分列表可以进行搜索</p>
</div>

<div class="checkbox green checked">
  <input type="checkbox" checked />
  <p>修改了部分逻辑，略微减少代码量</p>
</div>

<div class="checkbox green checked">
  <input type="checkbox" checked />
  <p>文章可指定显示顺序</p>
</div>

<div class="checkbox green checked">
  <input type="checkbox" checked />
  <p>去除了部分不必要的页面</p>
</div>

<div class="checkbox green checked">
  <input type="checkbox" checked />
  <p>前台可以修改个人信息</p>
</div>

<div class="checkbox red checked">
  <input type="checkbox"  checked/>
  <p>下次更新可能要等8月3日之后了！！！</p>
</div>

### 模糊搜索及表格重载

利用layui的表格重载进行模糊搜索。（实现这个着实麻烦）

1. 在头部工具条添加搜索框

   ```pug
   script#toolbarDemo(type='text/html').
   <div>搜索配置：
   <div class="layui-inline">
   <input class="layui-input" id="search" name="search" autocomplete="off">
   </div>
   <button class="layui-btn layui-btn-sm"  data-type="reload" id="search-btn">搜索</button>
   <a class="layui-btn layui-btn-sm" lay-event="addConfig">添加配置</a>
   </div>
   ```

2. 为表格绑定重载事件

   ```javascript
   layui.use('table', function () {
       ....
       , id: "configTable"
       $('body').delegate('#search-btn', 'click', function () {
           // 获取输入框的值
           var val  =$('#search').val()
           // 重载的表格，也就是上边的ID
           table.reload('configTable', {
               page: {
                   curr: 1 //重新从第 1 页开始
               }
               // where表示附加的条件
               , where: {
                   search: val
               },
           }, 'data');
       })
   }
   ```

3. 重写获取数据的接口

   方法

   ```javascript
   getConfig: function (page, limit,search) {
       obj = {}
       var find = {}
       // 需要判断search是否传入从而设置是否需要查询条件
       if(search){
           find={
               $or:[
                   {configdesc:{$regex:search}},
                   {configname:{$regex:search}},
                   {configvalue:{$regex:search}},
               ]}
       }
       return Config.countDocuments().then((count) => {
           return Config.find(find)
               .skip((parseInt(page) - 1) * parseInt(limit))
               .limit(parseInt(limit))
               .sort({configname: -1})
               .then(result => {
               obj['data'] = result
               obj['count'] = count
               return obj
           })
       })
   
   },
   ```

   调用

   ```javascript
   // 获取配置接口
   router.get('/pages/setting/config', (req, res) => {
       let {page, limit,search} = req.query
       console.log(page, limit,search)
       configUtils.getConfig(page, limit,search)
           .then((result) => {
           res.send({
               code: 0,
               count: result.count,
               data: result.data,
               message: ''
           })
       })
   })
   ```

   

## 2020-07-13

前台

<div class="checkbox green checked">
  <input type="checkbox" checked />
  <p>文章支持markdown解析及代码高亮（highlight）</p>
</div>

<div class="checkbox green checked">
  <input type="checkbox" checked />
  <p>文章置顶</p>
</div>

<div class="checkbox green checked">
  <input type="checkbox" checked />
  <p>文章分页显示</p>
</div>

<div class="checkbox green checked">
  <input type="checkbox" checked />
  <p>分类文章</p>
</div>

<div class="checkbox green checked">
  <input type="checkbox" checked />
  <p>修改登陆注册的UI</p>
</div>

后台

<div class="checkbox green checked">
  <input type="checkbox" checked />
  <p>可以修改用户头像以及昵称</p>
</div>

前台

<div class="checkbox green checked">
  <input type="checkbox" checked />
  <p>根据登陆用户头像显示头像</p>
</div>

<div class="checkbox green checked">
  <input type="checkbox" checked />
  <p>根据用户昵称显示作者（文章）昵称</p>
</div>

<div class="checkbox green checked">
  <input type="checkbox" checked />
  <p>Aplayer播放器</p>
</div>
待完善

<div class="checkbox yellow checked">
  <input type="checkbox" checked />
  <p>评论虽然可以分页，但存在小bug</p>
</div>

<div class="checkbox yellow checked">
  <input type="checkbox" checked />
  <p>由于开始时考虑不周，导致置顶无法自定义顺序</p>
</div>

<div class="checkbox yellow checked">
  <input type="checkbox" checked />
  <p>由于前期不了解layui，因此导致一些布局等出现了小问题</p>
</div>

<div class="checkbox yellow checked">
  <input type="checkbox" checked />
  <p>其他问题发现中。。。</p>
</div>

功能开坑

<div class="checkbox red">
  <input type="checkbox" />
  <p>前台可以修改个人信息</p>
</div>




### 设置某个字段查询不显示

```javascript
password:{
    type:String,
    select:false
},
```

### 置顶文章

置顶文章需要设置一个字段，用于记录这篇文章是否置顶。然后按时间排序。

```javascript
sort({hot:-1,_id: -1})
```

得益于可以传入多个参数。

### markdown解析及代码高亮（highlight）

markdown解析借助于[marked](https://www.npmjs.com/package/marked)插件得以实现；highlight则是借助于[highlight.js](https://www.npmjs.com/package/highlight.js)得以实现。

```javascript
marked.setOptions({
    highlight: function (code) {
        return require('highlight.js').highlightAuto(code).value
    }
})
result.data[0].context = marked(result.data[0].context)
```

## 2020-07-12

前台

<div class="checkbox green checked">
  <input type="checkbox" checked />
  <p>首页及某个文章的显示</p>
</div>

<div class="checkbox green checked">
  <input type="checkbox" checked />
  <p>评论的发表</p>
</div>

<div class="checkbox green checked">
  <input type="checkbox" checked />
  <p>登陆与注册</p>
</div>

<div class="checkbox green checked">
  <input type="checkbox" checked />
  <p>分类的显示</p>
</div>
<div class="checkbox red">
  <input type="checkbox" />
  <p>前台分类获取文章</p>
</div>

<div class="checkbox red">
  <input type="checkbox" />
  <p>前台文章分页显示</p>
</div>

<div class="checkbox red">
  <input type="checkbox" />
  <p>用户头像、昵称</p>
</div>

<div class="checkbox red">
  <input type="checkbox" />
  <p>markdown解析</p>
</div>


后台

<div class="checkbox green checked">
  <input type="checkbox" checked />
  <p>文章管理（新增、修改、删除）</p>
</div>

<div class="checkbox green checked">
  <input type="checkbox" checked />
  <p>评论管理（删除）</p>
</div>

<div class="checkbox green checked">
  <input type="checkbox" checked />
  <p>用户管理（密码修改）</p>
</div>

<div class="checkbox green checked">
  <input type="checkbox" checked />
  <p>全局配置（标题等全局信息）</p>
</div>

<div class="checkbox green checked">
  <input type="checkbox" checked />
  <p>分类管理（新增、修改、删除）</p>
</div>

未完成（待完成）

<div class="checkbox red">
  <input type="checkbox" />
  <p>前台分类获取文章</p>
</div>

<div class="checkbox red">
  <input type="checkbox" />
  <p>前台文章分页显示</p>
</div>

<div class="checkbox red">
  <input type="checkbox" />
  <p>用户头像、昵称</p>
</div>

<div class="checkbox red">
  <input type="checkbox" />
  <p>markdown解析</p>
</div>

<div class="checkbox red">
  <input type="checkbox" />
  <p>...</p>
</div>

### layui模板动态表格

```javascript
layui.use('table', function(){
	var table = layui.table,
		$=layui.jquery,
		admin = layui.admin
	table.render({
		elem: '#test'
		,url:'/api/article/list'
		,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模
		,title: '文章数据表'
		,page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
			layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
			//,curr: 5 //设定初始在第 5 页
			,groups: 3 //只显示 1 个连续页码
			,first: false //不显示首页
			,last: false //不显示尾页
			,limit:10

		},
		parseData:function (result) {
			return {
				"code":0,
				"msg":'666',
				"data":result.data,
				'count':result.count
			}
		}
		,cols: [[
			{field:'_id', title:'ID', fixed: 'left', sort: true}
			,{field:'title', title:'标题', sort: true}
			,{field:'description', title:'描述'}
			,{field:'author', title:'作者',  edit: 'text', sort: true,templet:function (obj) {
					return obj.author.username
				}}
			,{field:'category', title:'分类', sort: true,templet:function (obj) {
					return obj.category.name
				}}
			,{field:'comments', title:'评论数', sort: true,templet:function (obj) {
					return obj.comments.length
				}}
			,{fixed: 'right', title:'操作', toolbar: '#barDemo'}
		]]

	});

	//头工具栏事件
	table.on('toolbar(test)', function(obj){
		var checkStatus = table.checkStatus(obj.config.id);
		switch(obj.event){
			case 'getCheckData':
				var data = checkStatus.data;
				layer.alert(JSON.stringify(data));
				break;
			case 'getCheckLength':
				var data = checkStatus.data;
				layer.msg('选中了：'+ data.length + ' 个');
				break;
			case 'isAll':
				layer.msg(checkStatus.isAll ? '全选': '未全选');
				break;

			//自定义头工具栏右侧图标 - 提示
			case 'LAYTABLE_TIPS':
				layer.alert('这是工具栏右侧自定义的一个图标按钮');
				break;
		};
	});

	//监听行工具事件
	table.on('tool(test)', function(obj){
		var data = obj.data;
		//console.log(obj)
		if(obj.event === 'del'){
			layer.confirm('真的删除行么', function(index){
				console.log(obj.data._id)
				$.ajax({
					url:'/admin/pages/article/delete?id='+obj.data._id,
					success:function (backData) {
						obj.del();
						layer.close(index);
					}
				})

			});
		} else if(obj.event === 'edit'){
			console.log(obj.data._id)
			layer.open({
				type: 2,
				skin: 'layui-layer-demo', //样式类名
				title: '编辑',
				closeBtn: 1, //不显示关闭按钮
				anim: 2,
				area: ['893px', '600px'],
				shadeClose: true, //开启遮罩关闭
				content: '/admin/pages/article/edit.html?id='+obj.data._id
			});
		}
	});
});
```

其中`cols`表示显示的行，利用`field`属性可以自动获取返回数据对应的键。但是如果数据的某个值为一个对象，那么是无法通过`.`运算符取到对象的内容。此时需要解析数据

```javascript
table.render({
            elem: '#itemslist',
            url:'XXXXXXXXX',
            id:'itemslist',
            title: '关联客户信息',
            where:where,
            page:false,
            cols: [[
                {field: 'name', title: '客户', minWidth: 210,width: 180,height:60, align: 'left'},
                {field: 'total', title: '数量', minWidth: 120,width: 140,align: 'left'},
                {field: 'unit_name', title: '商品单位', minWidth: 120,width: 160,align: 'left'},
                {field: 'address', title: '地址', minWidth: 120,width: 260,align: 'left'},
                {field: 'remark', title: '备注', minWidth: 120, align: 'left'},
            ]],
            parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code": res.code, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.data.items.length, //解析数据长度
                    "data": res.data.items //解析数据列表
                };
            },
            done:function (res, curr, count) {
                var info = res.data.Order;
                if(info.item_title){
                   $("#item_title").html(info.item_title);
                }
            }
        });
```

> 数据返回的格式：
>
> ```javascript
> {
>     code:0,
>     count:200,
>     data:[]
> }
> ```
>
> 其中响应代码默认为0，count表示数据总数量（用于分页）。data为真实的数据。

### 删除关联数据

例如如下数据结构

```javascript
{
  createAt: 2020-07-12T14:05:58.654Z,
  _id: 5f0b18ddebfa0e171463148f,
  author: 5f0972f32e19df3a7846d826,
  post: {
    title: '一篇新的文章',
    description: '描述',
    hot: false,
    mete: [],
    comments: [ 5f0b16103b438e54a497e632, 5f0b18ddebfa0e171463148f ],
    createAt: 2020-07-12T13:36:29.499Z,
    upDate: 2020-07-12T13:36:29.499Z,
    _id: 5f0b11fb2433c835a017c061,
    author: 5f0972f32e19df3a7846d826,
    context: '正文',
    category: 5f09a72a1055a7296c035cb3,
    __v: 2
  },
  context: '123123132231',
  __v: 0
}
```

post为引用类型，当删除`comments`表中的某个值时，自动的将comments字段对应的数据也删除。

```javascript
deleteComment:function(id){
    return Comments.findOne({_id:id})
        .populate('post')
        .then(comments=>{
        Article.update({_id:comments.post._id},{$pull:{comments:id}}).then(result=>{
            return  Comments.remove({_id:id})
        })
    })
},
```


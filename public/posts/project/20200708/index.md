# NodeJs博客系统开发


<div class="btns rounded grid5"><a href="https://gitee.com/antmoe/project/tree/master/2020/07/blog2" title="下载源码"><i class="fa fa-download"></i> 下载源码</a></div>

## 前言

这篇文章是记录一下自己动手完成一个博客开发的历程。

## 2020-07-12

到目前为止博客完成内容

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



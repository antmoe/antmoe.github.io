---
title: 三、MongoDB高级操作
date: 2020-07-08T11:01:50+08:00
categories: ["notes"]
tags: ["Node"]
---

## 排序&分页

准备数据

```sql
use test3
db.c1.insert({_id:1,name:"a",sex:1,age:1})
db.c1.insert({_id:2,name:"a",sex:1,age:2})
db.c1.insert({_id:3,name:"b",sex:2,age:3})
db.c1.insert({_id:4,name:"c",sex:2,age:4})
db.c1.insert({_id:5,name:"d",sex:2,age:5})

db.c1.find()
```

### 排序

```sql
db.集合名.find().sort(JSON数据)
```

![image-20200708154749926](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/0b38307896f164dc7b238767097b75f1.png)

### Limit与Skip方法

```sql
db.集合名.find().sort().skip(数字).limit(数字)
```

- skip跳过指定数量（可选）
- limit限制查询的数量

> 使用`.count()`可以统计数量
>
> ![image-20200708155902088](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/d9e185ef995d75f34e5c29d5bc474995.png)

### 实例练习

1. 跳过0条数据，查询两条

   ```sql
   db.c1.find().sort({age:-1}).skip(0).limit(2)
   db.c1.find().sort({age:-1}).limit(2)
   ```

   ![image-20200708155135127](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/f6bcb99223cc2b1d3625b46d4badcfde.png)

2. 跳过两条数据，查询两条数据

   ```sql
   db.c1.find().sort({age:-1}).skip(2).limit(2)
   ```

   ![image-20200708155409337](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/205a1a751f517c4e6de7c5407b6f2dba.png)

3. 数据库1-10数据，每页显示两条

   ```sql
   db.集合名.find().skip().limit(2)
   ```

   > skip计算公式：（当前页-1）\* 每页显示条数

## 聚合查询

```sql
db.聚合名称.aggregate([
    {管道:{表达式}}
    ....
])
```

| 常用管道 |               说明               |
| :------: | :------------------------------: |
| `$group` | 将集合中的文档分组，用于统计结果 |
| `$match` | 过滤数据，只要输出符合条件的文档 |
| `$sort`  |        聚合数据进一步排序        |
| `$skip`  |          跳过指定文档数          |
| `$limit` |      限制集合数据返回文档数      |

| 常用表达式 |              说明               |
| :--------: | :-----------------------------: |
|   `$sum`   | 总和  `$sum:1`同`count`表示统计 |
|   `$avg`   |              平均               |
|   `$min`   |             最小值              |
|   `$max`   |             最大值              |

### 实例练习

准备数据

```sql
use test4
db.c1.insert({_id:1,name:"a",sex:1,age:1})
db.c1.insert({_id:2,name:"a",sex:1,age:2})
db.c1.insert({_id:3,name:"b",sex:2,age:3})
db.c1.insert({_id:4,name:"c",sex:2,age:4})
db.c1.insert({_id:5,name:"d",sex:2,age:5})
```

> `_id`键表示按哪一个字段分组，需要显示的列新增字段即可。

1. 统计男生、女生的总年龄

   ```sql
   db.c1.aggregate([
       {
           $group:{
           _id:"$sex",
           rs:{$sum:"$age"}
           }
       }
   ])
   ```

   ![image-20200708162849482](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/2f7207ad362f00f73338996b37f0d230.png)

2. 统计男生、女生的总人数

   ```sql
   db.c1.aggregate([
       {
           $group:{
           _id:"$sex",
           rs:{$sum:1}
           }
       }
   ])
   ```

   

3. 求学生总数和平均年龄

   ```sql
   db.c1.aggregate([
   {
       $group:{
       _id:null,
       total_num:{$sum:1},
       total_avg:{$avg:"$age"}
       }
       }
   ])
   ```

   ![image-20200708163511493](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/cfbc913cf45edd10ab6c634e4a0f513b.png)

4. 查询男生、女生人数，按人数升序

   ```sql
   db.c1.aggregate([
       {
           $group:{
           _id:"$sex",
           rs:{$sum:1}
           }
       },
       {
           $sort:{rs:1}
       }
   ])
   ```

## 索引

<span class="inline-tag blue">创建索引</span>

```sql
db.集合名.createIndex(带创建索引的列[,额外选项])
```

- 带创建索引的列:{键:1,键:-1}

  1表示升序，-1表示降序

- 额外选项

  设置索引的名称或者唯一索引等等

<span class="inline-tag blue">删除索引</span>

- 全部删除

  ```sql
  db.集合名.dropIndexes()
  ```

- 删除指定

  ```sql
  db.集合名.dropIndex(索引名)
  ```

<span class="inline-tag blue">查看索引语法</span>

```sql
db.集合名.getIndexes()
```

### 实例练习

数据准备

```sql
//选择数据库
use test5;
//向数据库中添加数据
for(var i=0;i<100000;i++){
db.c1.insert({'name':"aaa"+i,"age":i});
}
```

![image-20200708170010949](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/eee07bbb7d085b680b191fdd8f1bb7f6.png)

1. 给name添加普通索引

   ```sql
   db.c1.createIndex({name:1})
   ```

   ![1585476182255](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/43e548555ac3392875c7b9bc9071dab9.png)

2. 删除name索引

   ```sql
   db.c1.dropIndex('name_1')
   ```

   ![image-20200708170307519](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/3226e9823ee931019fc17624240a1ad7.png)

3. 给name创建索引并起名webopenfather 

   ```sql
   db.c1.createIndex({name:1},{name:'webopenfather'})
   ```

   ![image-20200708170412526](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/998b9712108e8cfe5a001008a9f25e1f.png)

4. 创建复合/组合索引

   给name和age添加组合索引

   ```sql
   db.c1.createIndex({name:1,age:1})
   ```

   ![image-20200708170624911](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/67f890d0d5059ccc5911d996a0679bc7.png)

5. 创建唯一索引

   ```sql
   db.c1.createIndex(待添加索引的列,{unique:列名})
   ```



### 分析索引（explain）

```sql
db.集合名.find().explain('executionStats')
```

![1585461681918](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/d08e4b45600b66873e1a6ce85b4278d7.png)

> COLLSCAN 全表扫描
> IXSCAN  索引扫描
> FETCH   根据索引去检索指定document

> 测试：age未添加索引情况
> 语法：db.c1.find({age:18}).explain('executionStats');
>
> ![1585477310460](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/afd37c1004926e9fa901a1b75a800ca7.png) 
>
> 测试：age添加索引情况
> 语法：db.c1.createIndex({age: 1})
> 继续：db.c1.find({age:18}).explain('executionStats')
> ![1585477412871](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/7ea13aaaf35e33ee32ee461302827d04.png) 



### 选择规则

- 为常做条件、排序、分组的字段建立索引

- 选择唯一性索引							

  同值较少如性别字段

- 选择较小的数据列，为较长的字符串使用前缀索引   

  索引文件更小



## MongoDB权限机制

```sql
db.createUser({ 
    "user" : "账号",
    "pwd": "密码",
    "roles" : [{ 
        role: "角色", 
        db: "所属数据库"
    }] 
})
```

|    角色种类    |                             说明                             |
| :------------: | :----------------------------------------------------------: |
|  超级用户角色  |                            `root`                            |
| 数据库用户角色 |                     `read`、`readWrite`                      |
| 数据库管理角色 |                    `dbAdmin`、`userAdmin`                    |
|  集群管理角色  | `clusterAdmin`、`clusterManager`、`clusterMonitor`、`hostManager` |
|  备份恢复角色  |                     `backup`、`restore`                      |
| 所有数据库角色 | `readAnyDatabase`、`readWriteAnyDatabase`、`userAdminAnyDatabase`、`dbAdminAnyDatabase` |

|          角色          |                           角色说明                           |
| :--------------------: | :----------------------------------------------------------: |
|         `root`         |         只在admin数据库中可用。超级账号，超级权限；          |
|         `read`         |                    允许用户读取指定数据库                    |
|      `readWrite`       |                    允许用户读写指定数据库                    |
|       `dbAdmin`        | 允许用户在指定数据库中执行管理函数，如索引创建、删除，查看统计或访问system.profile； |
|  `dbAdminAnyDatabase`  |    只在admin数据库中可用，赋予用户所有数据库的dbAdmin权限    |
|     `clusterAdmin`     | 只在admin数据库中可用，赋予用户所有分片和复制集相关函数的管理权限 |
|      `userAdmin`       | 允许用户向system.users集合写入，可以找指定数据库里创建、删除和管理用户 |
| `userAdminAnyDatabase` |   只在admin数据库中可用，赋予用户所有数据库的userAdmin权限   |
|   `readAnyDatabase`    |      只在admin数据库中可用，赋予用户所有数据库的读权限       |
| `readWriteAnyDatabase` |     只在admin数据库中可用，赋予用户所有数据库的读写权限      |

### 开启验证模式

1. 添加超级管理员

   ```sql
   use admin
   db.createUser({ 
       "user" : "root",
       "pwd": "root",
       "roles" : [{ 
           role: "root", 
           db: "admin"
       }] 
   })
   ```

   ![image-20200708173257120](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/3b6da821731c957898d4cffaf5b9cada.png)

   ![image-20200708173457799](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/5c8ee2a15576986ecf6b51d58f19bf37.png)

2. 退出卸载服务

   需要使用管理员模式打开终端

   ```bash
   mongod --remove
   ```

   ![image-20200708173734958](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/d1ddc74838fc6cf32cc23dd1bfc06f4c.png)

3. 重新安装需要输入账号密码的服务

   在原安装命令基础上加`--auth`即可

   ```bash
   mongod --install --dbpath F:\MongoDB\data --logpath F:\MongoDB\logs\mongoDB2.log --auth
   ```

   ![image-20200708173918620](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/32d2576f7eb3d5e82dfc1f1db2876f0e.png)

4. 启动服务

   ```bash
   net start mongodb
   ```

   ![image-20200708173935044](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/0947a790438763a9cb8d704e19cf878f.png)

### 通过超级管理员账号登陆

1. 第一种方式

   ```sql
   mongo 服务器IP地址:端口/数据库 -u 用户名 -p 密码
   ```

   ![image-20200708174319993](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/1bf6e474540d958f6c35e2657aeb4538.png)

2. 第二种方式

   - 先登录
   - 选择数据库
   - 输入`db.auth(用户名,密码)`

   ![image-20200708174425029](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/726d94a691bda354dcc54293fe01d4fa.png)

### 实例练习

准备数据

```sql
use shop;
for(var i=1; i<=10; i++) {
 db.goods.insert({"name":"goodsName"+i,"price":i});
}
```



1. 添加用户并设置权限

   ```sql
   use shop
   
   // 只能读
   db.createUser({ 
       "user" : "shop1",
       "pwd": "shop1",
       "roles" : [{ 
           role: "read", 
           db: "shop"
       }] 
   })
   // 只能写
   db.createUser({ 
       "user" : "shop2",
       "pwd": "shop2",
       "roles" : [{ 
           role: "readWrite", 
           db: "shop"
       }] 
   })
   ```

   ![image-20200708174755182](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/bc8cd4b11dd94f25f4efb1a89385d4b7.png)

   



## 备份还原

### 备份

```sql
mongodump -h -port -u -p -d -o
```

- -h表示服务器IP地址（不写默认本机）
- -port表示端口（默认27017）
- -u表示账号
- -p表示密码
- -d表示数据库（数据库不写则导出全部）
- -o备份到指定目录ia

1. 备份**所有数据**到`F:\MongoDB\back`

   ```bash
   mongodump -u root -p root -o F:\MongoDB\back
   ```

   ![image-20200708175626591](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/27c57fc89d5d45777079f91b24e9dc60.png)

   ![image-20200708175638005](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/c5eb5ab076d1a0b2c5021bb8691e5e44.png)

   

2. 备份**指定数据**到`F:\MongoDB\back1`

   ```sql
   mongodump -u shop2 -p shop2 -d shop -o F:\MongoDB\back1
   ```

   因为数据库是属于shop1与shop2的，因此导出需要使用这两个账号。

   ![image-20200708180050665](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/2dbd144506222baa8ff4fd756c1ac6b3.png)

### 还原数据

```sql
mongorestore -h -port -u -p --drop -d
```

- -d 不写则还原全部数据
- --drop表示先删除在导出，不写则覆盖

1. 还原所有数据

   ![image-20200708180544852](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/bde0980c7c9f04748b9759fbfd192cba.png)

   ```sql
   mongorestore -u root -p root --drop F:\MongoDB\back
   ```

   ![image-20200708180657258](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/068889a84c79f41946a1cecbad15796b.png)

   ![image-20200708180708196](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/6692eedca2023ba1c8de6d7777c997e8.png)

2. 备份指定数据库

   备份指定数据库，不能使用root账户，需要使用有写权限的账户。且需要指定具体文件名。

   ```sql
   mongorestore -u shop2 -p shop2 -d shop --drop F:\MongoDB\back1\shop
   ```

   ![image-20200708181317726](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/2b35fe35278d973ad26f3c56dbadfde3.png)



## 可视化工具

[Robo 3T](https://robomongo.org/download)

### 安装

1. ![image-20200708181718492](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/3d4e688cdb597cdb8237f14af0678c09.png)
2. ![image-20200708181725531](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/0552455db9fa3b1488a98b0640f5096c.png)
3. ![image-20200708181738210](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/b33481db34f6899bf390f3a04de1eb2d.png)
4. ![image-20200708181744557](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/9a42fd0116b05bfbc0df5de0fb93f138.png)
5. ![image-20200708181753490](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/cce481ae808b9ef343a32a4112efa3e7.png)

### 使用

1. 创建链接

   ![image-20200708181900681](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/e1384458a97e83e9f8f9cb9eab2b66e4.png)

2. 授权

   ![image-20200708182040323](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/b2600ee9838edf9324e5812dbf217659.png)

3. 此时可以看到所有数据库

   ![image-20200708182120705](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/0871373441d60aa034b06cf5b839801c.png)

> 对于可视化工具，我个人更喜欢Navicat
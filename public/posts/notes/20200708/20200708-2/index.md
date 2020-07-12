# 二、MongoDB基本操作及增删改查


## 基本操作

登陆数据库

```bash
mongo
```

### 查看数据库

语法

```sql
show databases;
```

![image-20200708135132816](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/3182a965d1dfd5bf1b062f0256cef82f.png)

### 选择数据库

```sql
use 数据库名
```

![image-20200708135204173](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/cd6cb40242715180b0caea722f3ada43.png)

如果切换到一个没有的数据库，例如`use admin2`，那么会隐式创建这个数据库。（后期当该数据库有数据时，系统自动创建）

```sql
use admin2
```

![image-20200708135402830](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/349774b3caed7941339ee109595ff191.png)

### 查看集合

```sql
show collections
```

![image-20200708135654724](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/d033db28289e9381b9a442e77826aefc.png)

### 创建集合

```sql
db.createCollection('集合名')
```

![image-20200708135818996](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/62e46049716993d198b9003bd8ccd43b.png)

### 删除集合

```sql
db.集合名.drop()
```

![image-20200708135904893](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/3cfaece4b4e1031ef111f26001244e5f.png)

### 删除数据库

1. 通过`use`语法选择数据
2. 通过`db.dropDataBase()`删除数据库

![image-20200708140359164](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/bb2ce8d5056e575a3fb2c8535653114f.png)

## 增删改查

### C增

```sql
db.集合名.insert(JSON数据)
```

如果集合存在，那么直接插入数据。如果集合不存在，那么会隐式创建。

> 在test2数据库的c1集合中插入数据（姓名叫webopenfather年龄18岁）
>
> ```sql
> use test2
> db.c1.insert({uname:"webopenfather",age:18})
> ```
>
> - 数据库和集合不存在都隐式创建
> - 对象的键统一不加引号（方便看），但是查看集合数据时系统会自动加
> - mongodb会给每条数据增加一个全球唯一的`_id`键 
>
> ![image-20200708141215126](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/c72af3cd9c0145ece61d7aac83012e43.png)

1. `_id`键的组成

   ![1584876662100](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/8a9bb3f1ad8158b015c5b6225e5d6fa1.png)

2. 自己增加`_id`

   可以，只需要给插入的JSON数据增加_id键即可覆盖（但实战强烈不推荐）

   `db.c1.insert({_id:1, uname:"webopenfather", age:18})`

   ![image-20200708141526348](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/e7888cc7bf3ae4f09340e89e31495cc7.png)

3. 一次性插入多条数据

   传递数据，数组中写一个个JSON数据即可。

   ```sql
   db.c1.insert([
       {uname:"z3", age:3},
       {uname:"z4", age:4},
       {uname:"w5", age:5}
   ])
   ```

   ![image-20200708141643413](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/1b0cb2a21b807dcbc6e89e5990efded1.png)

4. 快速插入10条数据

   由于mongodb底层使用JS引擎实现的，所以支持部分js语法。因此：可以写for循环

   ```sql
   for (var i=1; i<=10; i++) {
       db.c2.insert({uanme: "a"+i, age: i})
   }
   ```

   ![image-20200708142047091](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/38a2830201c37f173bcfda8984bcf7a0.png)



### R查询文档

```sql
db.集合名.find(条件[,查询的列])
```

|          条件          |        写法        |
| :--------------------: | :----------------: |
|     查询所有的数据     |    `{}`或者不写    |
|   查询`age=6`的数据    |     `{age:6}`      |
| 既要`age=6`又要性别=男 | `{age:6,sex:'男'}` |

|  查询的列（可选参数）   |   写法    |
| :---------------------: | :-------: |
|   查询全部列（字段）    |   不写    |
|   只显示age列（字段）   | `{age:1}` |
| 除了age列（字段）都显示 | `{age:0}` |

其他语法

```sql
db.集合名.find({
            键:{运算符：值}
            }) 
```

| 运算符 |   作用   |
| :----: | :------: |
|  $gt   |   大于   |
|  $gte  | 大于等于 |
|  $lt   |   小于   |
|  $lte  | 小于等于 |
|  $ne   |  不等于  |
|  $in   |    in    |
|  $nin  |  not in  |

#### 实例练习

1. 查询所有数据

   ```sql
   db.c1.find()
   ```

   ![1584879409036](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/37fc37460378972c530e76ae3abf6965.png)

   系统的`_id`无论如何都会存在

2. 查询age大于5的数据

   ```sql
   db.c1.find({age:{$gt:5}})
   ```

   ![image-20200708143634776](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/5fd7ebdc372dce37fefd36cc4f8944b6.png)

3. 查询年龄是5岁、8岁、10岁的数据

   ```sql
   db.c2.find({age:{$in:[5,8,10]}})
   ```

   ![image-20200708144003354](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/158e14d8baa0f56abacd46c8ac274d31.png)

4. 只看年龄列，或者年龄以外的列

   ![image-20200708144049382](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/91bcc38662f171c733a47f91935ceec2.png)

### U修改文档

```sql
db.集合名.update(条件,新数据[是否新增,是否修改多条,])
```

- 新数据

  此数据需要使用修改器，如果不使用，那么会将新数据替换原来的数据。

  ```sql
  db.集合名.update(条件,{修改器:{键:值}}[是否新增,是否修改多条,])
  ```

  | 修改器  | 作用     |
  | :-----: | :------- |
  |  $inc   | 递增     |
  | $rename | 重命名列 |
  |  $set   | 修改列值 |
  | $unset  | 删除列   |

- 是否新增

  指条件匹配不到数据则插入(`true`是插入，`false`否不插入默认)

  ```sql
  db.c3.update({uname:"zs30"},{$set:{age:30}},true)
  ```

  ![image-20200708151113714](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/e05952c64636480315119749f616353d.png)

- 是否修改多条

  指将匹配成功的数据都修改（`true`是，`false`否默认）

  ```sql
  db.c3.update({uname:"zs2"},{$set:{age:30}},false,true)
  ```

  ![image-20200708151328323](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/6ba669b7d5bd0d6b99b11d4da6592f1f.png)



#### 实例练习

准备工作

```sql
use test2;
for(var i = 1; i<= 10; i++){
	db.c3.insert( {"uname":"zs"+i,"age":i} );
}
```

1. 将`{uname:"zs1"}`改为`{uname:"zs2"}`

   ```sql
   db.c3.update({uname:"zs1"},{$set:{uname:"zs2"}})
   ```

   ![image-20200708145408835](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/43faf08cc186e600477e9a04522da222.png)

2. 给`{uname:"zs10"}`的年龄加2岁或减2岁

   ```sql
   db.c3.update({uname:"zs10"},{$inc:{age:2}})
   ```

   ![image-20200708145752429](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/ff0fa7ecaa6ad12231bdac18ebd67127.png)

   递减只需要将2改为`-2`即可。

3. 综合练习

   插入数据：`db.c4.insert( {uname:"神龙教主",age:888,who:"男",other:"非国人"});`

   需求：

   - `uname`改成 `webopenfather`

     可以使用修改器`$set`

   - `age`增加111

     可以使用修改器`$inc`

   - `who`改字段`sex`

     可以使用修改器`$rename`

   - `other`删除

     可以使用修改器`$unset`

   ```javascript
   db.c4.update({uname:'神龙教主'},
                {$set:{uname:'webopenfather'},
                 $inc:{age:111},
                 $rename:{who:"sex"},
                 $unset:{other:true}
                })
   ```

   ![image-20200708150646154](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/5b54d3429f191c7360ad80a967ad0b53.png)

### 删除文档

```sql
db.集合名.remove(条件[,是否删除一条])
```

- 是否删除一条

  true：是（删除的数据为第一条）

  ![image-20200708151712548](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/7e5671d614ee683be4b966f49ac5cae2.png)

  false：否

```sql
db.c3.remove({uname:"zs3"})
```

![image-20200708151920899](https://cdn.jsdelivr.net/gh/blogimg/HexoStaticFile2@latest/2020/07/08/fc39535e4d2e3f1a7cbec5b59c3e2063.png)

## 总结

高级开发攻城狮统称：所有数据库都需要增删改查CURD标识

MongoDB删除语法：remove 



增Create

````sql
db.集合名.insert(JSON数据)
````

删Delete

````sql
db.集合名.remove(条件 [,是否删除一条true是false否默认])

也就是默认删除多条
````

改Update

```sql
db.集合名.update(条件， 新数据  [,是否新增,是否修改多条])

升级语法db.集合名.update(条件，{修改器：{键：值}})
```

查Read

```sql
db.集合名.find(条件 [,查询的列])
```





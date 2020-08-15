---
title: git的基础使用
date: 2020-08-15T14:50:50+08:00
categories: ["notes"]
tags: ["Node"]
---

## Git是什么

> ![image-20200815104605450](https://files.alexhchu.com/2020/08/15/921fcc97345ab.png)
>
> 分布式版本控制系统的安全性要高很多，因为每个开发人员电脑里都有完整的版本库，某一个开发人员的电脑坏掉了不要紧，随便从其他开发人员那里复制一个就可以了。而集中式版本控制系统的中央服务器要是出了问题，所有开发人员都没法工作。

Gt是一个开源的分布式版本控制系统，可以有效、高速的处理从很小到非常大的项目版本管理。

G是Linus Torvalds为了帮助管理 Linux内核开发而开发的一个开放源码的版本控制软件。 Torvalds开始着手开发Gt是为了作为一种过渡方来替代Bitkeeper，后者之前一直是Lnux内核开发人员在全球使用的主要源代码工具。

尽管最初Git的开发是为了辅助Linux内核开发的过程，但是已经发现在很多其他自由软件项目中也使用了Git。

## GIT

安装可以到[官网](https://git-scm.com/)下载对应系统的安装包进行安装。然后正常的安装流程即可。

![image-20200815112858150](https://files.alexhchu.com/2020/08/15/f4dd7cf11652f.png)

### 安装后的配置

通过右键即可看到`Git Bash Here`，即可打开git bash工具。

通过输入`git --version`也可以看到版本号。

![image-20200815105432030](https://files.alexhchu.com/2020/08/15/d5e43993f607c.png)

```bash
git config --global user.name "Your Name"
git config --global user.email "email@example.com"
```

安装完成后需要设置用户信息，因为Git是分布式版本控制系统，所以每一台电脑注册用户信息（名称和Emai地址）。

值得注意的是， git config命令的 global参数，表示当前这台电脑上所有的Git仓库都会使用这个配置，当然也可以对某个仓库指定不同的用户名和Emai地址。

### 工作区、暂存区和版本库

![image-20200815110308616](https://files.alexhchu.com/2020/08/15/4dffffdbab440.png)

- 工作区

  当前电脑里能看到的目录

- 暂存区

  英文交stage或index。一般存放在`.git`目录下的index文件（`.git/index`）中，所以我们把暂存区有时也叫作索引（index）

- 版本库

  工作区有一个隐藏目录`.git`，这个不算工作区，而是Git的版本库。

### Git常见的操作

1. clone

   ```bash
   git clone Repo
   ```

   ![image-20200815111357538](https://files.alexhchu.com/2020/08/15/199a43bd6ebcd.png)

2. 添加到版本库

   ```bash
   git add fileName
   ```

   ![image-20200815111513972](https://files.alexhchu.com/2020/08/15/773c9c1e5577d.png)

   > 需要进入到版本库目录才可以使用此命令。

3. 将添加的文件提交到版本库

   ```bash
   git commit -m 'message' [file Name]
   ```

   ![image-20200815111715947](https://files.alexhchu.com/2020/08/15/cd41f6f1f54b7.png)

   > `git commit`命令后可以添加文件名称，表示只提交这个文件，但一般不会跟文件名称，表示全部提交。

4. 将本地版本库Push到远程库中

   ```bash
   git push URL master
   ```

   ![image-20200815112810004](https://files.alexhchu.com/2020/08/15/1bca247edcd52.png)

5. 从远程库更新到本地库

   ```bash
   git pull
   ```

   ![image-20200815113234094](https://files.alexhchu.com/2020/08/15/319fb6ea2f524.png)

6. 查看上次修改的信息

   ```bash
   git status
   ```

7. 查看执行git status命令结果的详情信息

   ```bash
   git diff
   ```

   `git diff`命令显示已写入缓存与已修改但尚未写入缓存的改动的区别。

   - 查看尚未缓存的改动

     `git dff`

   - 查看已缓存的改动

     `git diff --cached`

   - 查看已缓存的与未缓存的所有改动

     `git diff HEAD`

   - 显示摘要而非整个dif

     `git diff --stat`

### Git分支管理

每一种版本控制系统都以某种形式支持分支。使用分支意味着可以从开发主线上分离开来，然后在不影响主线的同时继续工作。

有人把Git的分支模型称为"必杀技特性",而正是因为它，将Git从版本控制系统家族里区分出来。

1. 创建分支

   ```bash
   git branch name
   ```

   ![image-20200815114513318](https://files.alexhchu.com/2020/08/15/bd5cf6dca6092.png)

   如果只输入`git branch`那么将显示当前的分支，有标识的表示当前正在使用的分支。

   ![image-20200815114620749](https://files.alexhchu.com/2020/08/15/834da7f59f2e5.png)

2. 切换分支

   ```bash
   git checkout name
   ```

   ![image-20200815114719083](https://files.alexhchu.com/2020/08/15/431fbdb20c79d.png)

3. 合并分支

   ```bash
   # 切换到主分支
   git checkout master
   # 将某个分支合并到master分支
   git merge name
   ```

   如果两个分支同一文件同一行都发生了修改，那么将不会自动合并分支，而是需要处理冲突。

   ![image-20200815115610742](https://files.alexhchu.com/2020/08/15/94d91c4d974a5.png)

4. 删除分支

   ```bash
   git branch -d dev
   ```

   ![image-20200815120329189](https://files.alexhchu.com/2020/08/15/26b66e2fa4c8f.png)

5. 推送分支时，删除多余分支

   ```bash
   git push origin --delete branchName
   ```

### 合并分支遇到冲突

![image-20200815115757045](https://files.alexhchu.com/2020/08/15/0e83cbedad5bf.png)

可以通过VSCODE中的插件进行快速的合并。合并完成后通过`git add `命令告诉git冲突已经解决。

![image-20200815120034510](https://files.alexhchu.com/2020/08/15/2128d79019559.png)


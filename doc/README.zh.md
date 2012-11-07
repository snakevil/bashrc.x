Bashrc.X
========

加强型 [BASH][] 配置文件
----------------------

继承 [ProfileX][] 的体验，完全重写，效率提高有约3~5倍。

安装与卸载
--------

出于泛用性考虑，放弃了 [ProfileX][] 所采用地 [GNU Makefile](http://www.gnu.org/software/make/manual/make.html) 技术。直接复制下面地相应代码到命令行并执行，即可完成安装或卸载操作。

### 安装

```shell
'mkdir' -p ~/.local && cd ~/.local
[ -d bashrc.x.git/.git ] || 'rm' -fr bashrc.x.git && 'git' clone git://github.com/snakevil/bashrc.x bashrc.x.git
[ -L bashrc.x ] || 'rm' -fr bashrc.x && 'ln' -s bashrc.x.git/src bashrc.x
for i in bash_profile bashrc; do 'rm' -fr ~/.$i; 'ln' -s .local/bashrc.x/etc/$i ~/.$i; done
cd -
```

### 卸载

```shell
'rm' -fr ~/.bash_profile ~/.bashrc ~/.local/bashrc.x ~/.local/bashrc.x.git
```

功能简介
-------

### 执行流程

![执行流程](/snakevil/bashrc.x/master/doc/workflow.png)

### 提示字段

![提示案例](/snakevil/bashrc.x/master/doc/prompting-sample.png)

* `Wed Nov 07` - **日期**
* <`hg` - **`SUDO`模式扮演用户**
* (`snakevil`) - **登录用户**
* @`.94.32` - **`IP`后两段**
* :`/h*/s*/Doc*/P*/bashrc.x.git` - **当前目录路径_（压缩版）_**
* /`g` - **当前目录版本库类型**
* `master`> - **当前目录版本库分支名**
* `16:20` - **时间**
* i`15` - **指令历史序号**
* j`1` - **后台保持任务数**
* l`0.69` - **系统负载**
* c`0s679` - **上条指令执行时间**
* e`148` - **上条指令退出码**

###### Copyright © 2012 [Snakevil Zen][me]. ALL RIGHTS RESERVED.

[profilex]: /snakevil/profilex (ProfileX)
[bash]: http://www.gnu.org/software/bash/manual/html_node/index.html
[me]: https://szen.in

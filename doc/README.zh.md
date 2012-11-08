Bashrc.X
========

加强型 [BASH][] 配置文件
------------------------

继承 [ProfileX][] 的体验，完全重写，效率提高有约3~5倍。

安装与卸载
----------

出于泛用性考虑，放弃了 [ProfileX][] 所采用地
[GNU Makefile](http://www.gnu.org/software/make/manual/make.html) 技术。
直接复制下面地相应代码到命令行并执行，即可完成安装或卸载操作。

### 安装 ###

```shell
'mkdir' -p ~/.local && cd ~/.local
[ -d bashrc.x.git/.git ] || \
  'rm' -fr bashrc.x.git && \
    'git' clone git://github.com/snakevil/bashrc.x bashrc.x.git
[ -L bashrc.x ] || 'rm' -fr bashrc.x && 'ln' -s bashrc.x.git/src bashrc.x
for i in bash_profile bashrc; do
  'rm' -fr ~/.$i
  'ln' -s .local/bashrc.x/etc/$i ~/.$i
done
cd -
```

### 卸载 ###

```shell
'rm' -fr ~/.bash_profile ~/.bashrc ~/.local/bashrc.x ~/.local/bashrc.x.git
```

个性定制
--------

### 提示颜色 ###

提示所用的颜色变量共18种，由 [etc/bashrc.d/05-colors.sh](/snakevil/bashrc.x/blob/master/src/etc/bashrc.d/05-colors.sh) 定义。

如需更改提示颜色，需创建`~/.bashrc.x/colors.rc`配置文件，定义不同提示字段的颜色。

`Bashrc.X`已定义的提示颜色有：

* `$__BASHRC_X_PROMPTC_DEFAULT` - **提示默认色**，默认为`$Chblack`
* `$__BASHRC_X_PROMPTC_USER` - **用户字段色**，默认为`$Ccyan`
* `$__BASHRC_X_PROMPTC_SUSER` - **`SUDO` 模式扮演用户字段色**，默认为`$Cred`
* `$__BASHRC_X_PROMPTC_IP` - **`IP` 字段色**，默认为`$Cpurple`
* `$__BASHRC_X_PROMPTC_PWD` - **当前目录路径字段色**，默认为`$Cyellow`
* `$__BASHRC_X_PROMPTC_VCS` - **当前目录版本库分支字段色**，默认为`$Cgreen`
* `$__BASHRC_X_PROMPTC_LOAD` - **负载字段默认色**，默认为`$Chgreen`
* `$__BASHRC_X_PROMPTC_LOAD2` - **负载字段（0.10-1.00）阶段色**，默认为`$Chyellow`
* `$__BASHRC_X_PROMPTC_LOAD3` - **负载字段（1.00+）阶段色**，默认为`$Chred`
* `$__BASHRC_X_PROMPTC_TC` - **上条指令执行时间字段色**，默认为`$Cwhite`
* `$__BASHRC_X_PROMPTC_EXIT` - **上条指令退出码字段色**，默认为`$Chred`

功能简介
--------

### 执行流程 ###

![执行流程](https://raw.github.com/snakevil/bashrc.x/master/doc/workflow.png)

### 提示字段 ###

动态提示内容的修正，由 [etc/bashrc.d/99-prompt.sh](/snakevil/bashrc.x/blob/master/src/etc/bashrc.d/99-prompt.sh) 完成。

![提示案例](https://raw.github.com/snakevil/bashrc.x/master/doc/prompting-sample.png)

* `Wed Nov 08` - **日期**
* <`root` - **`SUDO` 模式扮演用户**
* (`snakevil`) - **登录用户**
* @`.94.32` - **`IP` 后两段**
* :`/h*/s*/Doc*/P*/ba*/s*/e*/bashrc.d` - **当前目录路径 _（压缩版）_ **
* /`g` - **当前目录版本库类型**
* `master`> - **当前目录版本库分支名**
* `10:26` - **时间**
* j`1` - **后台保持任务数**
* l`1.15` - **系统负载**
* c`0s54` - **上条指令执行时间**
* e`148` - **上条指令退出码**

###### Copyright © 2012 [Snakevil Zen][me]. ALL RIGHTS RESERVED. ######

[profilex]: /snakevil/profilex (ProfileX)
[bash]: http://www.gnu.org/software/bash/manual/html_node/index.html
[me]: https://szen.in

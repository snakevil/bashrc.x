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

功能简介
--------

### 执行流程 ###

![执行流程](https://raw.github.com/snakevil/bashrc.x/master/doc/workflow.png)

如图所示，`Bashrc.X`默认的
[etc/bashrc.d](https://github.com/snakevil/bashrc.x/tree/master/src/etc/bashrc.d)
目录下的`[0-9][0-9]-*.sh`脚本，和`~/.bashrc.x/bashrc.d`目录下的同规则文件，会按
照先文件名、后目录（`Bashrc.X`默认脚本优先）的方式排序，并依此执行。

### 提示字段 ###

动态提示内容的修正，由
[etc/bashrc.d/99-prompt.sh](https://github.com/snakevil/bashrc.x/blob/master/src/etc/bashrc.d/99-prompt.sh)
完成。

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

个性定制
--------

### 功能配置 ###

使用配置指令`config-bashrc.x`，可以使`Bashrc.X`的功能配置组合更加灵活。如：

* `prompt.exit` - **启用／禁用指令退出码提示插件**
* `prompt.ip.cut` - **启用／禁用IP截取模式**
* `prompt.jobs` - **启用／禁用后台保持任务提示插件**
* `prompt.load` - **启用／禁用系统负载提示插件**
* `prompt.pwd.compressed` - **启用／禁用当前目录路径压缩模式**
* `prompt.time-consumed` - **启用／禁用指令执行时间提示插件**
* `prompt.vcs` - **启用／禁用版本库分支提示插件**
* `prompt.vcs.delim` - **设置版本库分支提示插件引导内容**

如需更多更全的配置变量及帮助信息，请查看`config-bashrc.x --help`和
`config-bashrc.x -la`。

### 提示颜色 ###

提示所用的颜色变量共18种，由
[etc/bashrc.d/05-colors.sh](https://github.com/snakevil/bashrc.x/blob/master/src/etc/bashrc.d/05-colors.sh)
定义。

如需更改提示颜色，需创建`~/.bashrc.x/colors.rc`配置文件，定义不同提示字段的颜色。

`Bashrc.X`已定义的提示颜色有：

* `$__BASHRC_X_PROMPTC_DEFAULT` - **提示默认色**，默认为`$Chblack`
* `$__BASHRC_X_PROMPTC_USER` - **用户字段色**，默认为`$Ccyan`
* `$__BASHRC_X_PROMPTC_SUSER` - **`SUDO` 模式扮演用户字段色**，默认为`$Cred`
* `$__BASHRC_X_PROMPTC_IP` - **`IP` 字段色**，默认为`$Cpurple`
* `$__BASHRC_X_PROMPTC_SSH_IP` - **`SSH`链接`IP`字段色**，默认为`$Chblue`
* `$__BASHRC_X_PROMPTC_PWD` - **当前目录路径字段色**，默认为`$Cyellow`
* `$__BASHRC_X_PROMPTC_VCS` - **当前目录版本库分支字段色**，默认为`$Cgreen`
* `$__BASHRC_X_PROMPTC_JOBS` - **后台保持任务字段色**，默认为`$Chwhite`
* `$__BASHRC_X_PROMPTC_LOAD` - **负载字段默认色**，默认为`$Chgreen`
* `$__BASHRC_X_PROMPTC_LOAD2` - **负载字段（0.10-1.00）阶段色**，默认为`$Chyellow`
* `$__BASHRC_X_PROMPTC_LOAD3` - **负载字段（1.00+）阶段色**，默认为`$Chred`
* `$__BASHRC_X_PROMPTC_TC` - **上条指令执行时间字段色**，默认为`$Cwhite`
* `$__BASHRC_X_PROMPTC_EXIT` - **上条指令退出码字段色**，默认为`$Chred`

### 功能扩展 ###

在`~/.bashrc.x/bashrc.d`目录下创建文件名称符合`[0-9][0-9]-*.sh`规则的脚本。从下
次开始启动命令行，其中的脚本内容就会作为定制的功能扩展执行了。

### 提示插件 ###

在`Bashrc.X`中，提示插件也以功能扩展脚本的形式实现。但为了使定制的提示插件能够完
美工作，还需要注意以下两点：

#### 1. 插件内容显示位置 ####

![插件位置](https://raw.github.com/snakevil/bashrc.x/master/doc/plugins-positions.png)

#### 2. 插件定义函数规范 ####

1. 文件名

    为了兼容性，我们建议插件的文件名应该符合`9[0-8]-prompt-*.sh`规则。

2. 函数名

    函数名应该符合`__BASHRC_X_PROMPT_*`规则。请尽量使用更有语义的名字，以免造成
    既有插件工作不正常，或该插件自身工作不正常。

3. 函数输出

    鉴于 [BASH][] 的函数定义无法直接返回需要的结果，我们使用特殊数组变量`_p`作为
    返回结果变量。

    ```shell
    _p=(
      1  # 控制内容显示位置。可选值为“1”或“2”，分别对应当前工作目录后的位置，和
         # 提示符前的位置。
      "" # 控制内容，包括颜色定义。
    )
    ```

如有需要，请阅读范例：
[etc/bashrc.d/90-prompt-jobs.sh](https://github.com/snakevil/bashrc.x/blob/master/src/etc/bashrc.d/90-prompt-jobs.sh)
。

###### Copyright © 2012 [Snakevil Zen][me]. ALL RIGHTS RESERVED. ######

[profilex]: https://github.com/snakevil/profilex (ProfileX)
[bash]: http://www.gnu.org/software/bash/manual/html_node/index.html
[me]: https://szen.in

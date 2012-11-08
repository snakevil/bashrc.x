Bashrc.X
========

Enhanced [BASH][] Profiles
--------------------------

Rewritten to have the same experience, but 3~5 times more faster than
[ProfileX][].

INSTALL and UNINSTALL
---------------------

For most widely usage,
[GNU Makefile](http://www.gnu.org/software/make/manual/make.html), which used by
[ProfileX][], has been abandoned. Copy and then execute the following
corresponding codes, INSTALLation or UNINSTALLation would be done.

### INSTALL ###

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

### UNINSTALL ###

```shell
'rm' -fr ~/.bash_profile ~/.bashrc ~/.local/bashrc.x ~/.local/bashrc.x.git
```

Customization
-------------

### PROMPTing Colors ###

Totally 18 colors variables, which are provided by
[etc/bashrc.d/05-colors.sh](/snakevil/bashrc.x/blob/master/src/etc/bashrc.d/05-colors.sh),
are used for PROMPTing.

To re-color the PROMPTing as you like, please create `~/.bashrc.x/colors.rc`,
and defined corresponding variables.

Colors defeind by `Bashrc.X`:

* `$__BASHRC_X_PROMPTC_DEFAULT` - **Default color**, defaults as `$Chblack`
* `$__BASHRC_X_PROMPTC_USER` - **User color**, defaults as `$Ccyan`
* `$__BASHRC_X_PROMPTC_SUSER` - **Effective user color in `SUDO` mode**, defaults as `$Cred`
* `$__BASHRC_X_PROMPTC_IP` - **`IP` color**, defaults as `$Cpurple`
* `$__BASHRC_X_PROMPTC_PWD` - **`CWD` color**, defaults as `$Cyellow`
* `$__BASHRC_X_PROMPTC_VCS` - **Repository branch color at `CWD`**, defaults as `$Cgreen`
* `$__BASHRC_X_PROMPTC_LOAD` - **Load default color**, defaults as `$Chgreen`
* `$__BASHRC_X_PROMPTC_LOAD2` - **Load color as notice (0.10-1.00)**, defaults as `$Chyellow`
* `$__BASHRC_X_PROMPTC_LOAD3` - **Load color as warning (1.00+)**, defaults as `$Chred`
* `$__BASHRC_X_PROMPTC_TC` - **Time consumed color by last command**, defaults as `$Cwhite`
* `$__BASHRC_X_PROMPTC_EXIT` - **Exit code color of last command**, defaults as `$Chred`


Architecture Details
--------------------

### Execution Workflow ###

![Execution Workflow](https://raw.github.com/snakevil/bashrc.x/master/doc/workflow.png)

### PROMPTing Fields ###

Dynamic PROMPTing contents would be generated and merged by
[etc/bashrc.d/99-prompt.sh](/snakevil/bashrc.x/blob/master/src/etc/bashrc.d/99-prompt.sh).

![PROMPTing Sample](https://raw.github.com/snakevil/bashrc.x/master/doc/prompting-sample.png)

* `Wed Nov 08` - **Date**
* <`root` - **Effective user in `SUDO` mode**
* (`snakevil`) - **Login user**
* @`.94.32` - **Last 2 parts of `IP`**
* :`/h*/s*/Doc*/P*/ba*/s*/e*/bashrc.d` - **`CWD`_(compressed)_ **
* /`g` - **Repository type at `CWD`**
* `master`> - **Repository branch at `CWD`**
* `10:26` - **Time**
* j`1` - **Jobs in background**
* l`1.15` - **Load**
* c`0s54` - **Time consumed by last command**
* e`148` - **Exit code of last command**

###### Copyright © 2012 [Snakevil Zen][me]. ALL RIGHTS RESERVED. ######

[profilex]: /snakevil/profilex (ProfileX)
[bash]: http://www.gnu.org/software/bash/manual/html_node/index.html
[me]: https://szen.in

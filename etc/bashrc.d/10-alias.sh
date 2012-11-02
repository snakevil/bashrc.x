# ~/.local/bashrc.x/etc/bashrc.d/10-alias.sh
#
# This file is part of bashrc.x.
#
# bashrc.x is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# bashrc.x is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with bashrc.x.  If not, see <http://www.gnu.org/licenses/>.
#
# @package   bashrc.x
# @author    Snakevil Zen <zsnakevil@gmail.com>
# @copyright © 2012 szen.in
# @license   http://www.gnu.org/licenses/gpl.html

alias cat='cat -sb'
alias cp='cp -ai'
alias df='df -Th'

'type' colordiff &> /dev/null \
  && alias diff='colordiff -u' \
  || alias diff='diff -u'

alias du='du -ch --time'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias free='free -m'
alias grep='grep --color=auto'
alias la='ll -A'
alias ll='ls -hl'

case `'uname' -s` in
  Linux )
    _ii_=linux
    ;;
  *[Bb][Ss][Dd] | Darwin )
    _ii_=unix
    ;;
  * )
    _ii_=wtf
    ;;
esac
[ -z "$('ls' --version 2> /dev/null | 'grep' GNU 2> /dev/null)" ] \
  || _ii_=linux
[ cygwin != "$TERM" ] || _ii_=cygwin
case $_ii_ in
  cygwin )
    alias ls='ls -F --color=auto --show-control-chars'
    ;;
  linux )
    alias ls='ls -F --color=auto'
    ;;
  unix )
    alias ls='ls -FG'
    ;;
esac

alias mkdir='mkdir -p'
alias more='less'
alias mv='mv -i'
alias ps='ps -ewwo"user,tty,pid,ppid,state,etime,pcpu,pmem,time,args"'
alias rm='rm -i'
alias su='sudo -s'
alias vi='vim'

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

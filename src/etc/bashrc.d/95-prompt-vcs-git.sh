# ~/.local/bashrc.x/etc/bashrc.d/95-prompt-vcs-git.sh
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

_bashrc.x-which 'awk' 'git' && {
  [ -n "${BASHRCX_COLORS['vcs']}" ] || BASHRCX_COLORS['vcs']="$Cgreen"

  function _bashrc.x-prompt-1.00-vcs.git {
    _pret=(1 "")
    [ -n "${BASHRCX_OPTS['prompt.vcs']}" ] || return
    [ -z "${BASHRCX_VARS['vcs.git.expired']}" -a "s${BASHRCX_VARS['pwd.old']}" = "s$PWD" ] || {
      BASHRCX_VARS['vcs.git']=`'git' symbolic-ref HEAD | 'awk' -F'/' '{print $3}'`
      BASHRCX_VARS['vcs.git.expired']=''
    }
    [ -z "${BASHRCX_VARS['vcs.git']}" ] && {
      'alias' gcd > /dev/null 2>&1 && 'unalias' gcd || return
      'alias' git > /dev/null 2>&1 && 'unalias' git || return
    } || {
      _pret[1]="\\[${BASHRCX_COLORS['default']}\\]"
      _pret[1]="${_pret[1]}${BASHRCX_OPTS['prompt.vcs.delim']}g"
      _pret[1]="${_pret[1]}\\[${BASHRCX_COLORS['vcs']}\\]${BASHRCX_VARS['vcs.git']}"
      'alias' gcd="cd '$('git' rev-parse --show-toplevel)'"
      'alias' git="BASHRCX_VARS['vcs.git.expired']=1; git"
    }
  }
}

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

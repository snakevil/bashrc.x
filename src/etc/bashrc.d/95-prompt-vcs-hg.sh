# ~/.local/bashrc.x/etc/bashrc.d/95-prompt-vcs-hg.sh
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

_bashrc.x-which 'hg' && {
  [ -n "${BASHRCX_COLORS['vcs']}" ] || BASHRCX_COLORS['vcs']="$Cgreen"

  function _bashrc.x-prompt-1.00-vcs.hg {
    _pret=(1 "")
    [ -n "${BASHRCX_OPTS['prompt.vcs']}" ] || return
    [ -z "${BASHRCX_VARS['vcs.hg.expired']}" -a "s${BASHRCX_VARS['pwd.old']}" = "s$PWD" ] || {
      BASHRCX_VARS['vcs.hg']=`'hg' branch 2> /dev/null`
      BASHRCX_VARS['vcs.hg.expired']=''
    }
    [ -z "${BASHRCX_VARS['vcs.hg']}" ] && {
      'alias' hcd > /dev/null 2>&1 && 'unalias' hcd || return
      'alias' hg > /dev/null 2>&1 && 'unalias' hg || return
    } || {
      _pret[1]="\\[${BASHRCX_COLORS['default']}\\]"
      _pret[1]="${_pret[1]}${BASHRCX_OPTS['prompt.vcs.delim']}h"
      _pret[1]="${_pret[1]}\\[${BASHRCX_COLORS['vcs']}\\]${BASHRCX_VARS['vcs.hg']}"
      'alias' hcd="cd '`'hg' root 2> /dev/null`'"
      'alias' hg='BASHRCX_VARS['vcs.hg.expired']=1; hg'
    }
  }
}

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

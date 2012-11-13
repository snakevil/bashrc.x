# ~/.local/bashrc.x/etc/bashrc.d/90-prompt-mem.sh
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

_bashrc.x-which 'awk' 'date' 'free' && {
  [ -n "${BASHRCX_COLORS['mem']}" ] || {
    BASHRCX_COLORS['mem']="$Cgreen"
    BASHRCX_COLORS['mem.2']="$Cyellow"
    BASHRCX_COLORS['mem.3']="$Cred"
  }

  BASHRCX_VARS['mem']='0.0'
  BASHRCX_VARS['mem.time']=0

  function _bashrc.x-prompt-2.20-mem {
    _pret=(2 "")
    [ -n "${BASHRCX_OPTS['prompt.mem']}" ] || return
    local t1=`'date' +%s` t2
    let t2=${BASHRCX_VARS['mem.time']}+${BASHRCX_OPTS['prompt.mem.interval']}
    [ $t1 -lt $t2 ] || {
      BASHRCX_VARS['mem']=`'free' \
        | 'awk' '"Mem:"==$1{printf "%0.1f",($3-$7)/$2*100}'`
      BASHRCX_VARS['mem.time']=$_t
    }
    _pret[1]="\\[${BASHRCX_COLORS['default']}\\]m"
    case "${BASHRCX_VARS['mem']}" in
      ?.? | [1-3]?.? )
        _pret[1]="${_pret[1]}\\[${BASHRCX_COLORS['mem']}\\]"
        ;;
      [4-7]?.? )
        _pret[1]="${_pret[1]}\\[${BASHRCX_COLORS['mem.2']}\\]"
        ;;
      * )
        _pret[1]="${_pret[1]}\\[${BASHRCX_COLORS['mem.3']}\\]"
        ;;
    esac
    _pret[1]="${_pret[1]}${BASHRCX_VARS['mem']}"
    _pret[1]="${_pret[1]}\\[${BASHRCX_COLORS['default']}\\]%"
  }
}

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

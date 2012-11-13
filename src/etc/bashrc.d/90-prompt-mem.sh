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

[ -n "$__BASHRC_X_PROMPTC_MEM" ] || {
  export __BASHRC_X_PROMPTC_MEM="$Cgreen"
  export __BASHRC_X_PROMPTC_MEM2="$Cyellow"
  export __BASHRC_X_PROMPTC_MEM3="$Cred"
}

export __BASHRC_X_PROMPT_MEM=(
  0
  0
)

__BASHRC_X_PROMPT_MEM() {
  _p=(2 "")
  [ -n "${__BASHRC_X_CONFIG[prompt.mem]}" ] || return
  local _t=`'date' +%s`
  local _x=`'expr' ${__BASHRC_X_PROMPT_MEM[1]} + ${__BASHRC_X_CONFIG[prompt.mem.interval]}`
  [ $_t -lt $_x ] || {
    __BASHRC_X_PROMPT_MEM[0]=`'free' \
      | 'awk' '"Mem:"==$1{printf "%0.1f",($3-$7)/$2*100}'`
    __BASHRC_X_PROMPT_MEM[1]=$_t
  }
  _p[1]="\\[$__BASHRC_X_PROMPTC_DEFAULT\\]m"
  case "${__BASHRC_X_PROMPT_MEM[0]}" in
    ?.? | [1-3]?.? )
      _p[1]="${_p[1]}\\[$__BASHRC_X_PROMPTC_MEM\\]"
      ;;
    [4-7]?.? )
      _p[1]="${_p[1]}\\[$__BASHRC_X_PROMPTC_MEM2\\]"
      ;;
    * )
      _p[1]="${_p[1]}\\[$__BASHRC_X_PROMPTC_MEM3\\]"
      ;;
  esac
  _p[1]="${_p[1]}${__BASHRC_X_PROMPT_MEM[0]}"
  _p[1]="${_p[1]}\\[${__BASHRC_X_PROMPTC_DEFAULT}\\]%"
}

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

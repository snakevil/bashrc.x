# ~/.local/bashrc.x/etc/bashrc.d/99-prompt.sh
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

export __BASHRC_X_PROMPT_IP=`'ifconfig' 2> /dev/null \
  | 'awk' '!x&&/inet /&&!/127\./{x=1;split($2,y,".");print "."y[3]"."y[4]}'`

[ -z "${__BASHRC_X_PROMPT_IP}" ] \
  || PS1=`'echo' "${PS1}" | 'sed' -e 's/\\\\h/'"${__BASHRC_X_PROMPT_IP}/g"`

export __BASHRC_X_PROMPT_OLDPWD=""

export __BASHRC_X_PROMPT_PS="${PS1}"

__BASHRC_X_PROMPT() {
  local _e=$? _i _p _s="" _t _x=("" "")
  history -a
  for _t in `'compgen' -A function __BASHRC_X_PROMPT_`; do
    _p=(0 "")
    $_t
    [ -z "${_p[0]}" ] || {
      case ${_p[0]} in
        1 )
          _x[0]="${_x[0]}${_p[1]}"
          ;;
        2 )
          _x[1]="${_x[1]}${_p[1]}"
          ;;
      esac
    }
  done
  [ 0 -eq $_e ] \
    || _x[1]="${_x[1]} e\\[\\e[1;31m\\]${_e}\\[\\e[0m\\e[1;30m\\]"
  [ -z "${_x[0]}" ] || _s="${_s};s/>/${_x[0]//\\/\\\\}>/"
  [ -z "${_x[1]}" ] || _s="${_s};s/] /${_x[1]//\\/\\\\}] /"
  [ -z "${_s}" ] || PS1=`'echo' "${__BASHRC_X_PROMPT_PS}" | 'sed' -e "${_s}"`
  __BASHRC_X_PROMPT_OLDPWD="${PWD}"
}
export PROMPT_COMMAND=__BASHRC_X_PROMPT

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

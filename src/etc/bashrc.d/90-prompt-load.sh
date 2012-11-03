# ~/.local/bashrc.x/etc/bashrc.d/90-prompt-load.sh
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

export __BASHRC_X_PROMPT_LOAD=(0.00 0)

__BASHRC_X_PROMPT_LOAD() {
  _p=(2 "")
  local _t=`'date' +%s`
  [ $_t -lt `'expr' ${__BASHRC_X_PROMPT_LOAD[1]} + 30` ] \
    || __BASHRC_X_PROMPT_LOAD=(
      `'uptime' \
        | 'awk' -F'load average' '{print $2}' \
        | 'awk' '{split($2,x,",");print x[1]}'`
      $_t
    )
  _p[1]="${_p[1]} l\\["
  case "${__BASHRC_X_PROMPT_LOAD[0]}" in
    0.0? )
      _p[1]="${_p[1]}\\e[1;32m\\]"
      ;;
    0.?? )
      _p[1]="${_p[1]}\\e[1;33m\\]"
      ;;
    * )
      _p[1]="${_p[1]}\\e[1;31m\\]"
      ;;
  esac
  _p[1]="${_p[1]}${__BASHRC_X_PROMPT_LOAD[0]}\\[\\e[0m\\e[1;30m\\]"
}

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

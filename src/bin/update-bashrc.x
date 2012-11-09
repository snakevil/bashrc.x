#!/bin/sh
#
# Updates `Bashrc.X' to the latest version.
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

readonly UBX_CMD=`'basename' "$0"`

_ubx_halt_() {
  local _e=255 _m=""
  [ 0 -eq $# ] || {
    _e=$1
    shift
    [ 0 -eq $# ] || _m="$@"
  }
  [ -z "${_m}" ] || echo "${UBX_CMD}: $_m" >&2
  [ 0 -ne $_e ] || 'date' +%Y%m%d > ~/.bashrc.x/updaterc
  exit $_e
}

[ -d "$('readlink' -f ~/.local/bashrc.x)/../.git" ] \
  || _ubx_halt_ 254 'Not a git repository.'

cd ~/.local/bashrc.x

m=`'git' pull 2> /dev/null`

[ 0 -eq $? ] || _ubx_halt_ 254 'Failed.'

[ 'sAlready up-to-date.' != "s$m" ] || _ubx_halt_ 0 "$m"

_ubx_halt_ 0 `'git' log -n1 --format='format:Updated to %h (%s)' 2> /dev/null`

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

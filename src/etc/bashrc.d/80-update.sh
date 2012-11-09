# ~/.local/bashrc.x/etc/bashrc.d/80-update.sh
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

__BASHRC_X_UPDATE() {
  local _c=(
    `'cat' ~/.bashrc.x/updaterc 2> /dev/null`
  ) _m _t=`'date' +%Y%m%d`
  [ "s${_c[0]}" = "s$_t" ] || {
    echo $_t > ~/.bashrc.x/updaterc
    local _a=(
      'git://github.com/snakevil/bashrc.x'
      'git://github.com/snakevil/bashrc.x.git'
      'git@github.com:snakevil/bashrc.x'
      'git@github.com:snakevil/bashrc.x.git'
      'https://github.com/snakevil/bashrc.x'
      'https://github.com/snakevil/bashrc.x.git'
    ) _b _d=`'readlink' -f ~/.local/bashrc.x` _s _v=()
    _s=`cd "$_d"; 'git' remote show origin 2> /dev/null \
      | 'awk' '"Fetch" == $1 {print $3}'`
    [ -n "$_s" ] || return
    for _i in ${_a[@]}; do
      [ "s$_i" != "s$_s" ] || {
        _i=''
        break
      }
    done
    [ -z "$_i" ] || return
    _b=`cd "$_d"; 'git' symbolic-ref HEAD 2> /dev/null`
    [ -n "$_b" ] || return
    _v=(
      `cd "$_d"; 'git' log -n1 --format='format:%H' 2> /dev/null`
      `cd "$_d"; 'git' ls-remote origin -h "$_b" 2> /dev/null | 'cut' -f1`
    )
    [ -n "${_v[0]}" -a -n "${_v[1]}" ] || return
    [ "s${_v[0]}" = "s${_v[1]}" ] || {
      _c[1]=1
      echo 1 >> ~/.bashrc.x/updaterc
    }
  }
  [ -z "${_c[1]}" ] || {
    _m="\n\e[1;31mBashrc.X: new version found!"
    _m="$_m run "'`'"\e[1;32mupdate-bashrc.x\e[1;31m' to update.\e[0m"
    echo -e "$_m" >&2
  }
}
__BASHRC_X_UPDATE
unset -f __BASHRC_X_UPDATE

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

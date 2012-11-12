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
  [ -z "${_c[1]}" ] || {
    _m="\n\e[1;33mBashrc.X: new version found!"
    _m="$_m run "'`'"\e[1;32mupdate-bashrc.x\e[1;33m' to update.\e[0m"
    'echo' -e "$_m" >&2
    return
  }
  [ "s${_c[0]}" = "s$_t" ] || {
    local _b _d=`'readlink' -f ~/.local/bashrc.x` _v=()
    [ -d "$_d/../.git" ] || return
    'echo' -ne "\n\e[1;33mBashrc.X: checking update..." >&2
    'echo' $_t > ~/.bashrc.x/updaterc
    _b=`cd "$_d"; 'git' symbolic-ref HEAD 2> /dev/null`
    [ -n "$_b" ] && {
      _v=(
        `cd "$_d"; 'git' log -n1 --format='format:%H' 2> /dev/null`
        `cd "$_d"; 'git' ls-remote origin -h "$_b" 2> /dev/null | 'cut' -f1`
      )
      [ -n "${_v[0]}" -a -n "${_v[1]}" ] && {
        [ "s${_v[0]}" = "s${_v[1]}" ] && 'echo' -e "up-to-date.\e[0m" >&2 \
          || {
          _c[1]=1
          _m="run "'`'"\e[1;32mupdate-bashrc.x\e[1;33m' to update"
          _m="$_m the new version!"
          'echo' 1 >> ~/.bashrc.x/updaterc
          'echo' -e "$_m" >&2
        }
        return
      }
    }
    'echo' -e "\e[1;31mfailed.\e[0m"
  }
}
__BASHRC_X_UPDATE
unset -f __BASHRC_X_UPDATE

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

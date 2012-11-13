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

_bashrc.x-which 'cat' 'cut' 'date' 'git' 'readlink' && {
  cc=(`'cat' ~/.bashrc.x/updaterc`)
  tt=`'date' +'%Y%m%d'`
  [ -n "${cc[1]}" ] && {
    mm="\e[1;33mbashrc.x: new version found!"
    mm="$mm run "'`'"\e[1;32mupdate-bashrc.x\e[1;33m' to update.\e[0m"
    echo -e "\n$mm" >&3
    return
  } || {
    dd=`'readlink' -f ~/.local/bashrc.x`
    [ ! -d "$dd" -o "s${cc[0]}" = "s$tt" ] || {
      echo -ne "\n\e[1;33mbashrc.x: checking update..." >&3
      echo $tt > ~/.bashrc.x/updaterc
      bb=`cd "$dd"; 'git' symbolic-ref HEAD`
      [ -z "$bb" ] || vv=(
          `cd "$dd"; 'git' log -n1 --format='format:%H'`
          `cd "$dd"; 'git' ls-remote origin -h "$bb" | 'cut' -f1`
        )
      [ -z "$bb" -o -z "${vv[0]}" -o -z "${vv[1]}" ] \
        && echo -e "\e[1;31mfailed.\e[0m" >&3 \
        || {
          [ "s${vv[0]}" = "s${vv[1]}" ] && 'echo' -e "up-to-date.\e[0m" >&2 \
          || {
            cc[1]=1
            mm="run "'`'"\e[1;32mupdate-bashrc.x\e[1;33m' to update"
            mm="$mm the new version!"
            echo 1 >> ~/.bashrc.x/updaterc
            echo -e "$mm" >&3
          }
        }
    }
  }
  unset -v cc vv
}

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

# ~/.local/bashrc.x/etc/bashrc.d/05-colors.sh
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

'which' dircolors > /dev/null 2>&1 && {
  [ -r ~/.bashrc.x/dircolors ] \
    && eval `'dircolors' -b ~/.bashrc.x/dircolors` \
    || [ -r ~/.local/bashrc.x/etc/dircolors ] \
      && eval `'dircolors' -b ~/.local/bashrc.x/etc/dircolors`
}
export LSCOLORS="ExgxfxfhCxfedeCbCdedeb"

export GREP_COLOR="01;32"

export Cnone='\e[0m'
export Cblack='\e[30m'
export Cred='\e[0;31m'
export Cgreen='\e[0;32m'
export Cyellow='\e[0;33m'
export Cblue='\e[0;34m'
export Cpurple='\e[0;35m'
export Ccyan='\e[0;36m'
export Cwhite='\e[0;37m'
export Chblack='\e[1;30m'
export Chred='\e[1;31m'
export Chgreen='\e[1;32m'
export Chyellow='\e[1;33m'
export Chblue='\e[1;34m'
export Chpurple='\e[1;35m'
export Chcyan='\e[1;36m'
export Chwhite='\e[1;37m'

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

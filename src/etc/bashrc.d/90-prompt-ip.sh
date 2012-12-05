# ~/.local/bashrc.x/etc/bashrc.d/90-prompt-ip.sh
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

_bashrc.x-which 'awk' 'ifconfig' && {
  BASHRCX_VARS['ip']=`'ifconfig' \
    | 'awk' '!x&&/inet /&&!/127\./{x=1;sub(/^.*:/,"",$2);print $2}'`

  [ -z "${BASHRCX_VARS['ip']}" ] \
    || BASHRCX_VARS['ip.cut']=`echo "${BASHRCX_VARS['ip']}" \
      | 'awk' -F'.' '{print $3 "." $4}'`
}

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

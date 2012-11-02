# ~/.local/bashrc.x/etc/bashrc.d/90-prompt-pwd.sh
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

export __BASHRC_X_PROMPT_PWD="${PWD}"

__BASHRC_X_PROMPT_PWD() {
  _p=(0 "")
  [ "${__BASHRC_X_PROMPT_OLDPWD}" == "${PWD}" ] || {
    __BASHRC_X_PROMPT_PWD=`
    'echo' "${PWD/$HOME/~}" \
      | 'awk' -F'/' '1 < NF {
          i = "*"
          j = $1 "/"
          for ( k = 2; k < NF; k++ ) {
            l = length( $k )
            for ( m = 1; m <= l; m++) {
              n = 0
              o = "ls -d " j substr( $k, 1, m ) "* 2> /dev/null"
              while ( 0 < ( o | getline p) ) n++
              close( o )
              if ( 1 == n ) break
            }
            if ( m == l ) j = j $k "/"
            else
              j = j substr( $k, 1, m ) i "/"
          }
          print j $NF
        }'`
  }
}

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

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

_bashrc.x-which 'gawk' && {
  function _bashrc.x-prompt-0.00-pwd {
    local dd
    case "$PWD" in
      "$HOME" )
        dd='~'
        ;;
      "$HOME/"* )
        dd="${PWD/$HOME/~}"
        ;;
      * )
        dd="$PWD"
        ;;
    esac
    _pret=(0 "")
    [ -n "${BASHRCX_OPTS['prompt.pwd.compressed']}" ] || {
      BASHRCX_VARS['pwd']="$dd"
      return
    }
    [ "s${BASHRCX_VARS['pwd.old']}" = "s$PWD" ] || {
      BASHRCX_VARS['pwd']=`echo "$dd" \
        | 'gawk' -F'/' '1 < NF {
            i = "*"
            j = $1 "/"
            for ( k = 2; k < NF; k++ ) {
              l = length( $k )
              for ( m = 1; m <= l; m++) {
                n = 0
                o = "ls -dF " j substr( $k, 1, m ) "*"
                while ( 0 < ( o | getline p ) )
                  if ( "/" == substr( p, length( p ) ) ) n++
                close( o )
                if ( 1 == n ) break
              }
              if ( m + 2 > l ) j = j $k "/"
              else
                j = j substr( $k, 1, m ) i "/"
            }
            print j $NF
          }'`
    }
  }
}

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

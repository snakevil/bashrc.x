# ~/.local/bashrc.x/etc/bashrc.d/90-prompt-time-consumed.sh
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

_bashrc.x-which 'awk' 'date' && {
  [ -n "${BASHRCX_COLORS['time-consumed']}" ] \
    || BASHRCX_COLORS['time-consumed']="$Cwhite"

  function _bashrc.x-prompt-2.30-time-consumed {
    _pret=(2 "")
    [ -n "${BASHRCX_OPTS['prompt.time-consumed']}" ] || return
    local tt=`echo "$('date' +'%s.%N') ${BASHRCX_VARS['checkpoint']}" \
      | 'awk' '{
          z = $1 - $2
          split( z % 60, y, "." )
          n = substr( y[2], 1, 2 )
          s = y[1] "s"
          d = h = m = ""
          x = int( z / 60 )
          if ( x ) {
            m = ( x % 60 ) "m"
            x = int( x / 60 )
            if ( x ) {
              h = ( x % 24 ) "h"
              x = int( x / 24 )
              if ( x )
                d = x "d"
            }
          }
          if ( length( d ) ) print d h m
          else if ( length( h ) ) print h m s
          else if ( length( m ) ) print m s n
          else print s n
        }'`
    _pret[1]="\\[${BASHRCX_COLORS['default']}\\]c"
    _pret[1]="${_pret[1]}\\[${BASHRCX_COLORS['time-consumed']}\\]$tt"
  }
}

# REF # http://www.twistedmatrix.com/users/glyph/preexec.bash.txt

_bashrc.x-which 'date' && {
  function _bashrc.x-checkpoint {
    [ -z "${BASHRCX_VARS['checkpoint.ok']}" ] || {
      BASHRCX_VARS['checkpoint']=`'date' +'%s.%N'`
      BASHRCX_VARS['checkpoint.ok']=''
    }
    _="$1"
  }
  trap '_bashrc.x-checkpoint "$_"' 'DEBUG'
}

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

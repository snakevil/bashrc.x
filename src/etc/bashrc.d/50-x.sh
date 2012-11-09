# ~/.local/bashrc.x/etc/bashrc.d/50-x.sh
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

# {{{1 x

_x() {
  COMPREPLY=()
  [ "$1" = "$3" -o '-' = "${3:0:1}" ] || return
  [ '--help' != "$3" -a '--version' != "$3" ] || return
  COMPREPLY=(`'compgen' -W " $("$1" --help | 'awk' -v"p=$3" '
        p == $1 {
          next
        }
        "-" == substr( p, 1, 1 ) && "--" == substr( $1, 1, 2 ) {
          next
        }
        "-" == substr( $1, 1, 1 ) {
          print $1
        }
      '
    ) $([ '-c' = "$3" ] || 'x' -s) " -- "$2"`)
}
'complete' -F _x x

# }}}1

# {{{1 xad

_xad() {
  COMPREPLY=()
  [ "$1" = "$3" -o '-' = "${3:0:1}" ] || return
  [ '--help' != "$3" -a '--version' != "$3" ] || return
  local _r=`'basename' "$PWD" | 'sed' -e 's/[^a-zA-Z0-9]//g'`
  'x' -q "$_r" > /dev/null && _r=""
  COMPREPLY=(`'compgen' -W " $("$1" --help | 'awk' -v"p=$3" '
        p == $1 {
          next
        }
        "-" == substr( p, 1, 1 ) && "--" == substr( $1, 1, 2 ) {
          next
        }
        "-" == substr( $1, 1, 1 ) {
          print $1
        }
      '
    ) $_r " -- "$2"`)
}
'complete' -F _xad xad

# }}}1

# {{{1 xcd

xcd() {
  [ 1 -eq $# -a '--help' != "$1" ] || {
    'cat' << X_HELP
Usage: xcd [ALIAS]
Change working directory to the corresponding path to the ALIAS.

Mandatory arguments to long options are mandatory for short options too.
      --help     display this help and exit
      --version  output version information and exit

Exit status:
 0  if OK,
 1  if found none or more than 1 alias,
 2  if found invalid alias,
 3  if trying any non-existant alias,
 4  if trying any non-existant directory.

Report bugs to zsnakevil@gmail.com
X_HELP
    [ 1 -eq $# ] || return 1
    return
  }
  [ '--version' != "$1" ] || {
    'x' --version
    return
  }
  local _a="${1/\/*/}" _p
  [ -n "$_a" -a 's' = "s$(echo "$_a" | 'tr' -d '[:alnum:]')" ] || {
    echo 'xcd: invalid `'"$_a' with symbols" >&2
    return 2
  }
  _p=`'x' -q "$_a"`
  [ 0 -eq $? -a -n "$_p" ] || {
    echo 'xcd: non-existant `'"$_a'" >&2
    return 3
  }
  _p="${1/$_a/$_p}"
  [ -d "$_p" ] || {
    echo 'xcd: non-existant `'"$_p'" >&2
    return 4
  }
  cd "$_p"
}

_xcd() {
  local _a _e _l=() _p _s _t
  COMPREPLY=()
  [ "s$1" = "s$3" ] || return
  [ -n "$2" -a 's-' != "s${2:0:1}" ] || {
    COMPREPLY=(`'compgen' -W "--help --version $('x' -s)" -- "$2"`)
    return
  }
  _a="${2/\/*/}"
  _p=`'x' -q "$_a"`
  _e=$?
  [ 0 -eq $_e ] || {
    _l=(`'compgen' -W "$('x' -s | 'xargs' -i echo '{}/')" -- "$2"`)
    [ 1 -eq ${#_l[@]} ] || {
      COMPREPLY=(${_l[@]})
      return
    }
    _a="${_l[0]%/}"
    _p=`'x' -q "$_a"`
  }
  _t="${2/$_a/$_p}"
  [ "s$_t" != "s$2" ] || _t="$_p"
  [ "s$_t" != "s$_p" ] || _t="$_t/"
  while 'true'; do
    _l=(`'compgen' -d -- "$_t"`)
    [ 1 -eq ${#_l[@]} ] || {
      [ 0 -eq ${#_l[@]} ] && {
        _t="${_t/$_p/$_a}"
        [ "s$_t" = "s$2" ] && COMPREPLY=() || COMPREPLY=("$_t")
      } || COMPREPLY=(${_l[@]/$_p/$_a})
      return
    }
    _t="${_l[0]}/"
  done
}
'complete' -o nospace -F _xcd xcd

# }}}1

# {{{1 xrm

_xrm() {
  local _l="$('x' -s | 'awk' -v"p=$3" '
        p != $1 {
          print
        }
      '
    )"
  COMPREPLY=()
  [ "$1" = "$3" -o '-' = "${3:0:1}" ] || {
    COMPREPLY=(`'compgen' -W "$_l" -- "$2"`)
    return
  }
  [ '--help' != "$3" -a '--version' != "$3" ] || return
  COMPREPLY=(`'compgen' -W " $("$1" --help | 'awk' -v"p=$3" '
        p == $1 {
          next
        }
        "-" == substr( p, 1, 1 ) && "--" == substr( $1, 1, 2 ) {
          next
        }
        "-" == substr( $1, 1, 1 ) {
          print $1
        }
      '
    ) $_l " -- "$2"`)
}
'complete' -F _xrm xrm

# }}}1

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

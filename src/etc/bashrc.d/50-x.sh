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

_bashrc.x-which 'awk' 'x' && {
  function _x {
    COMPREPLY=()
    [ "$1" = "$3" -o '-' = "${3:0:1}" ] || return
    [ '--help' != "$3" -a '--version' != "$3" ] || return
    COMPREPLY=(`compgen -W " $("$1" --help | 'awk' -v"p=$3" '
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
  complete -F '_x' 'x'
}

# }}}1

# {{{1 xad

_bashrc.x-which 'awk' 'basename' 'sed' 'x' && {
  function _xad {
    COMPREPLY=()
    [ "$1" = "$3" -o '-' = "${3:0:1}" ] || return
    [ '--help' != "$3" -a '--version' != "$3" ] || return
    local rr=`'basename' "$PWD" | 'sed' -e 's/[^a-zA-Z0-9]//g'`
    'x' -q "$rr" && rr=""
    COMPREPLY=(`compgen -W " $("$1" --help | 'awk' -v"p=$3" '
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
      ) "$rr" " -- "$2"`)
  }
  complete -F '_xad' 'xad'
}

# }}}1

# {{{1 xcd

_bashrc.x-which 'cat' 'tr' 'x' && {
  function xcd {
    [ 1 -eq $# -a 's--help' != "s$1" ] || {
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
    [ 's--version' != "s$1" ] || {
      'x' --version
      return
    }
    local aa="${1/\/*/}" pp
    [ -n "$aa" -a 's' = "s$(echo "$aa" | 'tr' -d '[:alnum:]')" ] || {
      echo 'xcd: invalid `'"$aa' with symbols" >&2
      return 2
    }
    pp=`'x' -q "$aa"`
    [ 0 -eq $? -a -n "$pp" ] || {
      echo 'xcd: non-existant `'"$aa'" >&2
      return 3
    }
    pp="${1/$aa/$pp}"
    [ -d "$pp" ] || {
      echo 'xcd: non-existant `'"$pp'" >&2
      return 4
    }
    cd "$pp"
  }
}

_bashrc.x-which 'true' 'x' 'xargs' && {
  function _xcd {
    local aa ee ll=() pp tt
    COMPREPLY=()
    [ "$1" = "$3" ] || return
    [ -n "$2" -a 's-' != "s${2:0:1}" ] || {
      COMPREPLY=(`compgen -W "--help --version $('x' -s)" -- "$2"`)
      return
    }
    aa="${2/\/*/}"
    pp=`'x' -q "$aa"`
    ee=$?
    [ 0 -eq $ee ] || {
      ll=(`compgen -W "$('x' -s | 'xargs' -i echo '{}/')" -- "$2"`)
      [ 1 -eq ${#ll[@]} ] || {
        COMPREPLY=(${ll[@]})
        return
      }
      aa="${ll[0]%/}"
      pp=`'x' -q "$aa"`
    }
    tt="${2/$aa/$pp}"
    [ "s$tt" != "s$2" ] || tt="$pp"
    [ "s$tt" != "s$pp" ] || tt="$tt/"
    while 'true'; do
      ll=(`compgen -d -- "$tt" | 'tr' ' ' '|'`)
      ll=("${ll[@]/|/ }")
      [ 1 -eq ${#ll[@]} ] || {
        [ 0 -eq ${#ll[@]} ] && {
          tt="${tt/$pp/$aa}"
          [ "s$tt" = "s$2" ] && COMPREPLY=() || COMPREPLY=("$tt")
        } || COMPREPLY=("${ll[@]/$pp/$aa}")
        return
      }
      tt="${ll[0]}/"
    done
  }
  complete -o 'nospace' -F '_xcd' 'xcd'
}

# }}}1

# {{{1 xrm

_bashrc.x-which 'awk' 'x' && {
  function _xrm {
    local ll="$('x' -s | 'awk' -v"p=$3" '
          p != $1 {
            print
          }
        '
      )"
    COMPREPLY=()
    [ "$1" = "$3" -o '-' = "${3:0:1}" ] || {
      COMPREPLY=(`compgen -W "$ll" -- "$2"`)
      return
    }
    [ '--help' != "$3" -a '--version' != "$3" ] || return
    COMPREPLY=(`compgen -W " $("$1" --help | 'awk' -v"p=$3" '
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
      ) $ll " -- "$2"`)
  }
  complete -F '_xrm' 'xrm'
}

# }}}1

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

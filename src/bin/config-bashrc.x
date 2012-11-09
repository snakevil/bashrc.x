#!/bin/sh
#
# Configs `Bashrc.X'.
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

readonly CBX_CMD=`'basename' "$0"`
readonly CBX_CFG="$HOME/.bashrc.x/config"

# {{{1 common functions

# {{{2 _cbx_m_illegal_option_()
_cbx_m_illegal_option_() {
  echo "illegal option -- $1"
}
# }}}2

# {{{2 _cbx_m_internal_()
_cbx_m_internal_() {
  echo 'internal logic confusion `'"$1'"
}
# }}}2

# {{{2 _cbx_halt_()
_cbx_halt_() {
  local _e=255 _m=""
  [ 0 -eq $# ] || {
    _e=$1
    shift
    [ 0 -eq $# ] || _m="$@"
  }
  [ -z "${_m}" ] || echo "${CBX_CMD}: $_m" >&2
  exit $_e
}
# }}}2

# {{{2 _cbx_warn_()
_cbx_warn_() {
  echo "${CBX_CMD}: $*" 1>&2
}
# }}}2

# }}}1

# {{{1 _cbx_dispatch_()
_cbx_dispatch_() {
  local _f _o
  for _o; do
    case "$_o" in
      --help )
        _cbx_help_
        return
        ;;
      --version )
        _cbx_version_
        return
        ;;
    esac
  done
  while 'getopts' ':adel' _o; do
    [ 0 -eq $? ] || {
      _cbx_help_ 1
      return
    }
    case "$_o" in
      'a' )
        CBX_OPTION="$CBX_OPTION$_o"
        ;;
      'd' )
        [ -n "$CBX_SUBCMD" ] \
          && _cbx_warn_ `_cbx_m_illegal_option_ 'd'` \
          || CBX_SUBCMD='remove'
        ;;
      'e' )
        [ -n "$CBX_SUBCMD" ] \
          && _cbx_warn_ `_cbx_m_illegal_option_ 'e'` \
          || CBX_SUBCMD='export'
        ;;
      'l' )
        [ -n "$CBX_SUBCMD" ] \
          && _cbx_warn_ `_cbx_m_illegal_option_ 'l'` \
          || CBX_SUBCMD='list'
        ;;
      * )
        _cbx_warn_ `_cbx_m_illegal_option_ $OPTARG`
        ;;
    esac
  done
  shift `'expr' $OPTIND - 1`
  [ -n "$CBX_SUBCMD" ] || {
    case $# in
      0 )
        CBX_SUBCMD='help'
        ;;
      1 )
        CBX_SUBCMD='query'
        ;;
      * )
        CBX_SUBCMD='set'
        ;;
    esac
  }
  _f="_cbx_${CBX_SUBCMD}_"
  'type' "$_f" > /dev/null 2>&1 \
    && "$_f" "$@" \
    || _cbx_halt_ 254 `_cbx_m_internal_ $CBX_SUBCMD`
}
# }}}1

# {{{1 _cbx_help_()
_cbx_help_() {
  'cat' << CBX_HELP
Usage: update-bashrc.x -e
       update-bashrc.x -d VARIABLE
       update-bashrc.x -l[a]
       update-bashrc.x VARIABLE VALUE
Operate the configuration VARIABLEs of Bashrc.X.

Mandatory arguments to long options are mandatory for short options too.
  -a             list all variables including unset
  -d             unset variable
  -e             export all variables as BASH script
  -l             list set variables
      --help     display this help and exit
      --version  output version information and exit

Exit status:
 0  if OK,
 1  if encoutering any illegal option,
 2  if operating on any unknown config variable,
 3  if deleting any unset variable.

Report bugs to zsnakevil@gmail.com
CBX_HELP
  exit $CBX_PARAMS
}
# }}}1

# {{{1 _cbx_version_()
_cbx_version_() {
  'cat' << CBX_VERSION
config-bashrc.x 1.0
Copyright (C) 2012 Snakevil Zen.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Snakevil Zen.
CBX_VERSION
}
# }}}1

# {{{1 _cbx_awk_()
_cbx_awk_() {
  [ -f $CBX_CFG ] || 'touch' $CBX_CFG
  'awk' -v "kk=$1" -v "ff=$CBX_CFG.tmp" -v "o=$CBX_OPTION" -v "vv=$2" \
    -v "xx=$CBX_CMD" -v "xxx=$CBX_SUBCMD" '
      function c2v ( x, y ) {
        y = tolower( x )
        if ( "1" == y || "on" == y || "yes" == y || "true" == y )
          return 1
        if ( "0" == y || "off" == y || "no" == y || "false" == y )
          return 0
        if ( "\"" == substr( y, 1, 1 ) && "\"" == substr( y, length( y ) ) )
          return substr( x, 2, length( x ) - 2 )
        if ( "'"'"'" == substr( y, 1, 1 ) && "'"'"'" == substr( y, length( y ) ) )
          return substr( x, 2, length( x ) - 2 )
        return x
      }
      function v2c ( x ) {
        if ( 1 == x )
          return "on"
        if ( 0 == x )
          return "off"
        if ( x ~ /\s*/ )
          return "'"'"'" x "'"'"'"
        return x
      }
      function v4e ( x ) {
        if ( 1 == x )
          return "1"
        if ( 0 == x )
          return ""
        return x
      }
      BEGIN {
        dd[ "prompt.ip.cut"         ] = 1
        dd[ "prompt.pwd.compressed" ] = 1
        dd[ "prompt.vcs"            ] = 1
        dd[ "prompt.vcs.delim"      ] = "/"
        dd[ "prompt.jobs"           ] = 1
        dd[ "prompt.load"           ] = 1
        dd[ "prompt.time-consumed"  ] = 1
        dd[ "prompt.exit"           ] = 1
        if ( length( kk ) ) {
          if ( ! ( kk in dd ) ) {
            print xx ": unknown variable `" kk "'"'"'" > "/dev/stderr"
            exit 2
          }
          if ( length( vv ) )
            vv = c2v( vv )
        }
        i = length( o )
        for ( j = 1; j <= i; j ++ )
          oo[ substr( o, j, 1 ) ] = 1
      }
      2 < NF && "#" != $1 && "=" == $2 {
        if ( ! ( $1 in dd ) ) {
            print xx ": unknown variable `" $1 "'"'"'" > "/dev/stderr"
            next
        }
        i = $3
        if ( 3 < NF )
          for ( j = 4; j <= NF; j ++ )
            i = i FS $j
        cc[ $1 ] = c2v( i )
        nn ++
      }
      END {
        if ( "export" == xxx ) {
          print "declare -Ax __BASHRC_X_CONFIG"
          for ( i in dd ) {
            printf "%s", "__BASHRC_X_CONFIG[" i "]='"'"'"
            if ( i in cc )
              print v4e( cc[ i ] ) "'"'"'"
            else
              print v4e( dd[ i ] ) "'"'"'"
          }
          exit
        }
        if ( "list" == xxx ) {
          OFS=" : "
          if ( "a" in oo ) {
            for ( i in dd ) {
              j = length( i )
              if ( k < j )
                k = j
            }
            k = "%-" k "s"
            for ( i in dd ) {
              if ( i in cc )
                print sprintf( k, i ), v2c( cc[ i ] )
              else
                print sprintf( k, i ), v2c( dd[ i ] )
            }
          } else {
            for ( i in cc ) {
              j = length( i )
              if ( k < j )
                k = j
            }
            k = "%-" k "s"
            for ( i in cc )
              print sprintf( k, i ), v2c( cc[ i ] )
          }
          exit
        }
        if ( "query" == xxx ) {
          if ( kk in cc )
            print v2c( cc[ kk ] )
          else
            print v2c( dd[ kk ] )
          exit
        }
        if ( "remove" == xxx ) {
          if ( ! ( kk in cc ) ) {
            print xx ": unset `" kk "'"'"'" > "/dev/stderr"
            exit 3
          }
          delete cc[ kk ]
          nn --
        }
        if ( "set" == xxx ) {
          if ( ! ( kk in cc ) )
            nn ++
          cc[ kk ] = vv
        }
        if ( ! nn )
          printf "%s", "" > ff
        else
          for ( i in cc )
            print i " = " v2c( cc[ i ] ) >> ff
      }
    ' $CBX_CFG
    [ ! -f "$CBX_CFG.tmp" ] || 'mv' -f "$CBX_CFG.tmp" "$CBX_CFG"
}
# }}}1

# {{{1 _cbx_export_()
_cbx_export_() {
  _cbx_awk_
}
# }}}1

# {{{1 _cbx_list_()
_cbx_list_() {
  _cbx_awk_
}
# }}}1

# {{{1 _cbx_query_()
_cbx_query_() {
  _cbx_awk_ "$1"
}
# }}}1

# {{{1 _cbx_remove_()
_cbx_remove_() {
  _cbx_awk_ "$1"
}
# }}}1

# {{{1 _cbx_set_()
_cbx_set_() {
  _cbx_awk_ "$1" "$2"
}
# }}}1

_cbx_dispatch_ "$@"

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

# ~/.local/bashrc.x/etc/bashrc.d/99-prompt.sh
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

export __BASHRC_X_PROMPT_IP=(
  `'ifconfig' 2> /dev/null | 'awk' '!x&&/inet /&&!/127\./{x=1;print $2}'`
  ''
)
[ -z "${__BASHRC_X_PROMPT_IP[0]}" ] \
  || __BASHRC_X_PROMPT_IP[1]=`echo "${__BASHRC_X_PROMPT_IP[0]}" \
    | 'awk' -F. '{print $3, $4}'`

export __BASHRC_X_PROMPT_OLDPWD=""

export __BASHRC_X_PROMPT_PWD="$PWD"

__BASHRC_X_PROMPT_PWD() {
  local _d
  case "$PWD" in
    "$HOME" )
      _d="~"
      ;;
    "$HOME"/* )
      _d="${PWD/$HOME/~}"
      ;;
    * )
      _d="$PWD"
      ;;
  esac
  _p=(0 "")
  [ -n "${__BASHRC_X_CONFIG[prompt.pwd.compressed]}" ] || {
    __BASHRC_X_PROMPT_PWD="$_d"
    return
  }
  [ "$__BASHRC_X_PROMPT_OLDPWD" == "$PWD" ] || {
    __BASHRC_X_PROMPT_PWD=`'echo' "$_d" \
      | 'gawk' -F'/' '1 < NF {
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
            if ( m + 2 > l ) j = j $k "/"
            else
              j = j substr( $k, 1, m ) i "/"
          }
          print j $NF
        }'`
  }
}

export __BASHRC_X_PROMPT_PS="$PS1"

__BASHRC_X_PROMPT() {
  local _e=$? _i _p _s _t _x=("" "")
  history -a
  for _t in `'compgen' -A function __BASHRC_X_PROMPT_`; do
    _p=(0 "")
    $_t
    [ -z "${_p[0]}" ] || {
      case ${_p[0]} in
        1 )
          [ -z "${_p[0]}" ] \
            || _x[0]="${_x[0]}${_p[1]}\\[${__BASHRC_X_PROMPTC_DEFAULT}\\]"
          ;;
        2 )
          [ -z "${_p[1]}" ] \
            || _x[1]="${_x[1]} ${_p[1]}\\[${__BASHRC_X_PROMPTC_DEFAULT}\\]"
          ;;
      esac
    }
  done
  [ -z "$__BASHRC_X_PROMPT_IP" ] \
    || [ -z "${__BASHRC_X_CONFIG[prompt.ip.cut]}" ] \
      && _s="s/\\\\h/${__BASHRC_X_PROMPT_IP[0]}/g;" \
      || _s="s/\\\\h/${__BASHRC_X_PROMPT_IP[1]}/g;"
  [ -z "${__BASHRC_X_CONFIG[prompt.pwd.compressed]}" ] \
    || [ -z "$__BASHRC_X_PROMPT_PWD" ] \
      || _s="${_s}s/\\\\w/${__BASHRC_X_PROMPT_PWD//\//\\/}/g;"
  [ -z "${__BASHRC_X_CONFIG[prompt.exit]}" ] || {
    [ 0 -eq $_e ] || {
      _x[1]="${_x[1]} \\[$__BASHRC_X_PROMPTC_DEFAULT\\]e"
      _x[1]="${_x[1]}\\[$__BASHRC_X_PROMPTC_EXIT\\]$_e"
      _x[1]="${_x[1]}\\[$__BASHRC_X_PROMPTC_DEFAULT\\]"
    }
  }
  [ -z "${_x[0]}" ] || {
    _x[0]="${_x[0]//\\/\\\\}"
    _s="${_s}s/>\\\\n/${_x[0]//\//\\/}>\\\\n/;"
  }
  [ -z "${_x[1]}" ] && {
    _s="${_s}s/ \\[\\] / /;"
  } || {
    _x[1]="${_x[1]:1}"
    _x[1]="${_x[1]//\\/\\\\}"
    _s="${_s}s/\\[\\] /\\[${_x[1]//\//\\/}\\] /;"
  }
  [ -z "$_s" ] || PS1=`'echo' "$__BASHRC_X_PROMPT_PS" | 'sed' -e "$_s"`
  __BASHRC_X_PROMPT_OLDPWD="$PWD"
  __BASHRC_X_CHECKPOINT[1]="ready"
}
export PROMPT_COMMAND=__BASHRC_X_PROMPT

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

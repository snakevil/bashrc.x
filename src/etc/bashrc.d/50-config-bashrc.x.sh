# ~/.local/bashrc.x/etc/bashrc.d/50-config-bashrc.x.sh
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

config-bashrc.x() {
  local _c=`'which' 'config-bashrc.x' 2>/dev/null` _e _s
  "$_c" "$@"
  _e=$?
  [ 0 -eq $# -o 's-' = "s${1:0:1}" -a 's-d' != "s$1" ] || {
    __BASHRC_X_PROMPT_OLDPWD=''
    'eval' "$("$_c" -e | 'grep' -v '^declare')"
  }
  return $_e
}

_config_bashrcx() {
  COMPREPLY=()
  [ "$1" = "$3" ] || {
    case "$3" in
      -l )
        COMPREPLY=( '-a' )
        ;;
      -d )
        COMPREPLY=(`'compgen' -W "$(
            'config-bashrc.x' -l | 'awk' '{print $1}'
          )" -- "$2"`)
        ;;
    esac
    return
  }
  COMPREPLY=(`'compgen' -W " --help --version $(
      'config-bashrc.x' -la | 'awk' '{print $1}'
    ) -d -e -l " -- "$2"`)
}
'complete' -F _config_bashrcx config-bashrc.x

'eval' `'config-bashrc.x' -e`

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

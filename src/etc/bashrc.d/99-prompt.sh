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

_bashrc.x-which 'sed' && {
  BASHRCX_VARS['ps']="$PS1"

  function _bashrc.x-prompt {
    local ee=$? _pret ss tt xx=("" "")
    history -a
    for tt in `'compgen' -A function "${FUNCNAME}-"`; do
      _pret=(0 '')
      "$tt"
      declare -p _pret
      [ -z "${_pret[1]}" ] || {
        case ${_pret[0]} in
          1 )
            xx[0]="${xx[0]}${_pret[1]}\\[${BASHRCX_COLORS['default']}\\]"
            ;;
          2 )
            xx[1]="${xx[1]} ${_pret[1]}\\[${BASHRCX_COLORS['default']}\\]"
            ;;
        esac
      }
    done
    [ -z "${BASHRCX_VARS['ip']}" ] \
      || [ -z "${BASHRCX_OPTS['prompt.ip.cut']}" ] \
        && ss="s/\\\\h/${BASHRCX_VARS['ip']}/g;" \
        || ss="s/\\\\h/${BASHRCX_VARS['ip.cut']}/g;"
    [ -z "${BASHRCX_OPTS['prompt.pwd.compressed']}" ] \
      || [ -z "${BASHRCX_VARS['pwd']}" ] \
        || ss="${ss}s/\\\\w/$(echo "${BASHRCX_VARS['pwd']}" \
            | 'sed' -e 's/\//\\\//g')/g;"
    [ -z "${BASHRCX_OPTS['prompt.exit']}" ] || {
      [ 0 -eq $ee ] || {
        xx[1]="${xx[1]} \\[${BASHRCX_COLORS['default']}\\]e"
        xx[1]="${xx[1]}\\[${BASHRCX_COLORS['exit']}\\]$ee"
        xx[1]="${xx[1]}\\[${BASHRCX_COLORS['default']}\\]"
      }
    }
    [ -z "${xx[0]}" ] || {
      xx[0]="${xx[0]//\\/\\\\}"
      ss="${ss}s/>\\\\n/${xx[0]//\//\\/}>\\\\n/;"
    }
    [ -z "${xx[1]}" ] && {
      ss="${ss}s/ \\[\\] / /;"
    } || {
      xx[1]="${xx[1]:1}"
      xx[1]="${xx[1]//\\/\\\\}"
      ss="${ss}s/\\[\\] /\\[${xx[1]//\//\\/}\\] /;"
    }
    [ -z "$ss" ] || PS1=`'echo' "${BASHRCX_VARS['ps']}" | 'sed' -e "$ss"`
    BASHRCX_VARS['pwd.old']="$PWD"
    BASHRCX_VARS['checkpoint.ok']="ready"
  } 3>&2 > /dev/null 2>&1
  export PROMPT_COMMAND='_bashrc.x-prompt'
}

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

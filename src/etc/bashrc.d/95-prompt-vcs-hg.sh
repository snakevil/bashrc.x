# ~/.local/bashrc.x/etc/bashrc.d/95-prompt-vcs-hg.sh
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

[ -n "$__BASHRC_X_PROMPTC_VCS" ] || export __BASHRC_X_PROMPTC_VCS="$Cgreen"

export __BASHRC_X_PROMPT_VCS_HG=("" "")

__BASHRC_X_PROMPT_VCS_HG() {
  _p=(1 "")
  [ -z "${__BASHRC_X_PROMPT_VCS_HG[1]}" -a "$__BASHRC_X_PROMPT_OLDPWD" == "$PWD" ] \
    || __BASHRC_X_PROMPT_VCS_HG=(
        `'hg' branch 2> /dev/null`
        ""
      )
  [ -z "$__BASHRC_X_PROMPT_VCS_HG" ] && {
    'alias' hcd > /dev/null 2>&1 && 'unalias' hcd || return
    'alias' hg > /dev/null 2>&1 && 'unalias' hg || return
  } || {
    _p[1]="\\[$__BASHRC_X_PROMPTC_DEFAULT\\]/h"
    _p[1]="${_p[1]}\\[$__BASHRC_X_PROMPTC_VCS\\]${__BASHRC_X_PROMPT_VCS_HG[0]}"
    _p[1]="${_p[1]}\\[$__BASHRC_X_PROMPTC_DEFAULT\\]"
    'alias' hcd="cd '`'hg' root 2> /dev/null`'"
    'alias' hg='__BASHRC_X_PROMPT_VCS_HG[1]=1; hg'
  }
}

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

# ~/.local/bashrc.x/etc/bashrc.d/90-prompt-jobs.sh
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

[ -n "$__BASHRC_X_PROMPTC_JOBS" ] || export __BASHRC_X_PROMPTC_JOBS="$Chwhite"

__BASHRC_X_PROMPT_JOBS() {
  _p=(2 "")
  [ -n "${__BASHRC_X_CONFIG[prompt.jobs]}" ] || return
  [ -z "$('jobs' -p)" ] || {
    _p[1]="\\[$__BASHRC_X_PROMPTC_DEFAULT\\]j"
    _p[1]="${_p[1]}\\[$__BASHRC_X_PROMPTC_JOBS\\]\\j"
  }
}

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

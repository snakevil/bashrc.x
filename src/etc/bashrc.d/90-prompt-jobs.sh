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

[ -n "${BASHRCX_COLORS['jobs']}" ] || BASHRCX_COLORS['jobs']="$Chwhite"

function _bashrc.x-prompt-2.00-jobs {
  _pret=(2 "")
  [ -n "${BASHRCX_OPTS['prompt.jobs']}" ] || return
  [ -z "$('jobs' -p)" ] || {
    _pret[1]="\\[${BASHRCX_COLORS['default']}\\]j"
    _pret[1]="${_pret[1]}\\[${BASHRCX_COLORS['jobs']}\\]\\j"
  }
}

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

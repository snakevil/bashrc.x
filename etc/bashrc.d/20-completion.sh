# ~/.local/bashrc.x/etc/bashrc.d/20-completion.sh
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

[ -n "$BASH_COMPLETION" ] || {
  if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
  elif [ -f /user/local/etc/bash_completion ]; then
    . /user/local/etc/bash_completion
  elif [ -f /user/etc/bash_completion ]; then
    . /user/etc/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
}

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

# ~/.local/bashrc.x/etc/bashrc.d/00-env.sh
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

export EDITOR=vim

export INPUTRC=~/.local/bashrc.x/etc/inputrc

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

PATH="/usr/sbin:/usr/bin:/sbin:/bin"
MANPATH='/usr/share/man'
[ -d /usr/local ] && {
  PATH="/usr/local/sbin:/usr/local/bin:${PATH}"
  MANPATH="/usr/local/share/man:${MANPATH}"
}
[ -d /opt/local ] && {
  PATH="/opt/local/sbin:/opt/local/libexec/gnubin:/opt/local/bin:${PATH}"
  MANPATH="/opt/local/libexec/gnubin/man:/opt/local/share/man:${MANPATH}"
}
[ -d ~/.local ] && {
  PATH="${HOME}/.local/sbin:${HOME}/.local/bin:${PATH}"
  MANPATH="${HOME}/.local/share/man:${MANPATH}"
}
[ -d ~/.local/bashrc.x ] \
  && PATH="${HOME}/.local/bashrc.x/sbin:${HOME}/.local/bashrc.x/bin:${PATH}"
[ -d ~/.bashrc.x ] \
  && PATH="${HOME}/.bashrc.x/sbin:${HOME}/.bashrc.x/bin:${PATH}"
export PATH
export MANPATH

PS1="\\n\\[\\e[0m\\e[1;30m\\]\\d <"
[ -n "${SUDO_USER}" ] && {
  PS1="${PS1}\\[\\e[0;31m\\]R\\[\\e[1;30m\\]("
  PS1="${PS1}\\[\\e[0;36m\\]${SUDO_USER}\\[\\e[1;30m\\])@"
} || PS1="${PS1}\\[\\e[0;36m\\]\\u\\[\\e[1;30m\\]@"
PS1="${PS1}\\[\\e[0;35m\\]\\h\\[\\e[1;30m\\]:"
PS1="${PS1}\\[\\e[0;33m\\]\\w\\[\\e[1;30m\\]>\\n"
PS1="${PS1}\\[\\e[1;30m\\]\\A [i\\[\\e[0;37m\\]\!"
PS1="${PS1}\\[\\e[1;30m\\]] \\$\\[\\e[0m\\] "
case "${TERM}" in
  *xterm* | rxvt )
    [ -n "${SUDO_USER}" ] \
      && PS1="\\[\\e]0;R(${SUDO_USER})@\\h:\\w\\007\\]${PS1}" \
      || PS1="\\[\\e]0;\\u@\\h:\\w\\007\\]${PS1}"
    ;;
esac
export PS1

case `'id' -gn` in
  `'id' -un` | staff | users )
    umask 022
    ;;
  * )
    umask 002
    ;;
esac

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

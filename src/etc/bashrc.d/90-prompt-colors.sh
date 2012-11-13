# ~/.local/bashrc.x/etc/bashrc.d/90-prompt-colors.sh
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

BASHRCX_COLORS['default']="$Chblack"
BASHRCX_COLORS['user']="$Ccyan"
BASHRCX_COLORS['user.sudo']="$Cred"
BASHRCX_COLORS['ip']="$Cpurple"
BASHRCX_COLORS['ip.ssh']="$Chblue"
BASHRCX_COLORS['pwd']="$Cyellow"
BASHRCX_COLORS['exit']="$Chred"

[ ! -r ~/.bashrc.x/colors.rc ] || source ~/.bashrc.x/colors.rc

PS1="\\n\\[$Cnone${BASHRCX_COLORS['default']}\\]\\d <"
[ -n "$SUDO_USER" ] && {
  PS1="$PS1\\[${BASHRCX_COLORS['user.sudo']}\\]\\u"
  PS1="$PS1\\[${BASHRCX_COLORS['default']}\\]("
  PS1="$PS1\\[${BASHRCX_COLORS['user']}\\]$SUDO_USER"
  PS1="$PS1\\[${BASHRCX_COLORS['default']}\\])@"
} || {
  PS1="$PS1\\[${BASHRCX_COLORS['user']}\\]\\u"
  PS1="$PS1\\[${BASHRCX_COLORS['default']}\\]@"
}
[ -n "${SSH_CONNECTION}" ] && {
  PS1="$PS1\\[${BASHRCX_COLORS['ip.ssh']}\\]"
} || PS1="$PS1\\[${BASHRCX_COLORS['ip']}\\]"
PS1="$PS1\\h\\[${BASHRCX_COLORS['default']}\\]:"
PS1="$PS1\\[${BASHRCX_COLORS['pwd']}\\]\\w"
PS1="$PS1\\[${BASHRCX_COLORS['default']}\\]>\\n"
PS1="$PS1\\[${BASHRCX_COLORS['default']}\\]\\A [] \\$\\[$Cnone\\] "
case "$TERM" in
  *'xterm'* | 'rxvt' )
    [ -n "$SUDO_USER" ] \
      && PS1="\\[\\e]0;\\u($SUDO_USER)@\\h:\\w\\007\\]$PS1" \
      || PS1="\\[\\e]0;\\u@\\h:\\w\\007\\]$PS1"
    ;;
esac
export PS1

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

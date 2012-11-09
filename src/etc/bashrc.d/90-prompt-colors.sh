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

export __BASHRC_X_PROMPTC_DEFAULT="$Chblack"
export __BASHRC_X_PROMPTC_USER="$Ccyan"
export __BASHRC_X_PROMPTC_SUSER="$Cred"
export __BASHRC_X_PROMPTC_IP="$Cpurple"
export __BASHRC_X_PROMPTC_PWD="$Cyellow"
export __BASHRC_X_PROMPTC_EXIT="$Chred"

[ ! -r ~/.bashrc.x/colors.rc ] || . ~/.bashrc.x/colors.rc

PS1="\\n\\[$Cnone$__BASHRC_X_PROMPTC_DEFAULT\\]\\d <"
[ -n "$SUDO_USER" ] && {
  PS1="$PS1\\[$__BASHRC_X_PROMPTC_SUSER\\]\\u"
  PS1="$PS1\\[$__BASHRC_X_PROMPTC_DEFAULT\\]("
  PS1="$PS1\\[$__BASHRC_X_PROMPTC_USER\\]$SUDO_USER"
  PS1="$PS1\\[$__BASHRC_X_PROMPTC_DEFAULT\\])@"
} || {
  PS1="$PS1\\[$__BASHRC_X_PROMPTC_USER\\]\\u"
  PS1="$PS1\\[$__BASHRC_X_PROMPTC_DEFAULT\\]@"
}
PS1="$PS1\\[$__BASHRC_X_PROMPTC_IP\\]\\h\\[$__BASHRC_X_PROMPTC_DEFAULT\\]:"
PS1="$PS1\\[$__BASHRC_X_PROMPTC_PWD\\]\\w\\[$__BASHRC_X_PROMPTC_DEFAULT\\]>\\n"
PS1="$PS1\\[$__BASHRC_X_PROMPTC_DEFAULT\\]\\A [] \\$\\[$Cnone\\] "
case "$TERM" in
  *xterm* | rxvt )
    [ -n "$SUDO_USER" ] \
      && PS1="\\[\\e]0;\\u($SUDO_USER)@\\h:\\w\\007\\]$PS1" \
      || PS1="\\[\\e]0;\\u@\\h:\\w\\007\\]$PS1"
    ;;
esac
export PS1

# vim: se ft=sh ff=unix fenc=utf-8 sw=2 ts=2 sts=2:

#!/bin/sh
#
# Installs Bashrc.X online.
#
# @package   bashrc.x
# @author    Snakevil Zen <zsnakevil@gmail.com>
# @copyright © 2014 szen.in
# @license   GPL-3.0

echo 'Installing Bashrc.X ...'
echo

echon() {
  echo "$@" | 'awk' '{printf "%-40s", $0}'
}

yup() {
  echo 'yes'
}

noop() {
  echo 'no'
}

noox() {
  noop
  echo
  echo "FAILURE: $@."
  exit 1
}

whichq() {
  'which' $@ > /dev/null 2>&1
}

echon "checks 'git' ..."
whichq git \
  && yup \
  || noox "'git' is required"

cd "$HOME"
[ -d '.local' ] || 'mkdir' .local
cd .local

echon 'checks local Bashrc.X ...'
result=
[ -f 'bashrc.x/etc/bashrc.d/00-env.sh' ] \
  && 'git' -C bashrc.x log -n1 > /dev/null 2>&1 \
  && result=1
[ -n "$result" ] && yup || {
  noop
  'rm' -fr bashrc.x .bashrc.x.git
  echon 'downloads (please wait) ...'
  'git' clone git://github.com/snakevil/bashrc.x .bashrc.x.git > /dev/null 2>&1 \
    && 'ln' -s .bashrc.x.git/src bashrc.x \
    && yup \
    || noox "Request to 'github.com' halt"
}

echon 'replaces profiles ...'
cd ..
'rm' -fr .bashrc .bash_profile \
  && 'ln' -s .local/bashrc.x/etc/bashrc .bashrc \
  && 'ln' -s .local/bashrc.x/etc/bash_profile .bash_profile \
  && yup \
  || noox "'.bashrc' and '.bash_profile' access denied"

echo
echo 'COMPLETED. Thanks for loving me 8-p'

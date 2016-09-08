#!/bin/bash

# install bash configuration (create appropriate symlinks)

# echo commands before execution (useful for tracing)
set -x

# exit script at first error
set -e

BASHCONF_DIR=~/.bash-conf

rm -f ~/.bashrc ~/.profile ~/.bash_profile ~/.inputrc

ln -s $BASHCONF_DIR/bashrc          ~/.bashrc
ln -s $BASHCONF_DIR/profile         ~/.profile
ln -s $BASHCONF_DIR/bash_profile    ~/.bash_profile
ln -s $BASHCONF_DIR/inputrc         ~/.inputrc

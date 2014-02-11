# This file is ~/.bashrc

# From `Difference between .bashrc and .bash_profile`__:
#
# ~/.bashrc is the place to put stuff that applies only to bash itself, such as
# alias and function definitions, shell options, and prompt settings. (You
# could also put key bindings there, but for bash they normally go into
# ~/.inputrc.)
#
# .. _`Difference between .bashrc and .bash_profile`: http://superuser.com/questions/183870/difference-between-bashrc-and-bash-profile/183980

BASHCONF_DIR=$HOME/.bash-conf

## Some aliases
alias ls="ls -G --color=auto"
alias l="ls"
alias la="ls -a"
alias ll="ls -l"
alias s='sage'
alias m='make'
alias grep='grep --color=auto'

# set the TERM in tmux so that tmux plays nicely with vim colorscheme
# https://github.com/krisleech/vimfiles/wiki/Fix-solarized-theme-in-tmux
alias tmux="TERM=screen-256color-bce /usr/bin/tmux"

# bash my bash "bookmarks" function
source $BASHCONF_DIR/scripts/go/go.sh

# source platform dependant configs
UNAME=$(uname)
if [[ $UNAME == 'Linux' ]]; then
    source $BASHCONF_DIR/bashrc-linux
elif [[ $UNAME == 'Darwin' ]]; then
    source $BASHCONF_DIR/bashrc-macosx
fi

#export BROWSER="google-chrome"
## Set Firefox as the Sage browser
#export SAGE_BROWSER="google-chrome"


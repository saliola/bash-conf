# This file is ~/.bashrc

# From `Difference between .bashrc and .bash_profile`__:
#
# ~/.bashrc is the place to put stuff that applies only to bash itself, such as
# alias and function definitions, shell options, and prompt settings. (You
# could also put key bindings there, but for bash they normally go into
# ~/.inputrc.)
#
# .. _`Difference between .bashrc and .bash_profile`: http://superuser.com/questions/183870/difference-between-bashrc-and-bash-profile/183980


##################################
#  bash configuration directory  #
##################################

BASHCONF_DIR=$HOME/.bash-conf

########################
#  bookmarks/jumplist  #
########################

# source my bash "bookmarks" function
source $BASHCONF_DIR/scripts/jump/jump.sh

##################
#  bash scripts  #
##################

source $BASHCONF_DIR/scripts/utils.bash

######################################
#  platform-specific configurations  #
######################################

# source platform dependant configs
UNAME=$(uname)
if [[ $UNAME == 'Darwin' ]]; then
    source $BASHCONF_DIR/bashrc-macosx
elif [[ $UNAME == 'Linux' ]]; then
    HOSTNAME=$(hostname)
    if [[ $HOSTNAME == *computecanada.ca || $HOSTNAME == *calculquebec.ca ]]; then
        source $BASHCONF_DIR/bashrc-computecanada
    else
        source $BASHCONF_DIR/bashrc-linux
    fi
fi

############
#  prompt  #
############
# this should come after platform-specfic configurations since that sets $PS1_HOSTNAME
# Reference: https://superuser.com/a/517110

if [[ -z "${PS1_HOSTNAME}" ]]; then
    PS1_HOSTNAME=$(hostname -s);
fi;

function prompt_left() {
    DIR=$(pwd|sed -e "s!$HOME!~!")
    if [ ${#DIR} -gt $(($(tput cols)-40)) ];
    then
        CurDir=${DIR:0:15}...${DIR:${#DIR}-32};
    else
        CurDir=$DIR;
    fi;
    echo -e "${PS1_HOSTNAME}\001\033[00m\002\001\033[33m\002:${CurDir}\001\033[00m\002"
}

function prompt_right() {
    echo -e "\001\033[90m\002[\D{%Y-%m-%d}][\A]\001\033[00m\002"
}

function prompt() {
    compensate=12
    PS1=$(printf "\n%*s\r%s\n》" "$(($(tput cols)+${compensate}))" "$(prompt_right)" "$(prompt_left)")
}
PROMPT_COMMAND=prompt

#############
#  aliases  #
#############

# source aliases file
source $BASHCONF_DIR/bashrc-aliases

#############
#  exports  #
#############

export EDITOR=vim

#export BROWSER="google-chrome"

## Set Firefox as the Sage browser
#export SAGE_BROWSER="google-chrome"

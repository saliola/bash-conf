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
#  sage scripts  #
##################

source $BASHCONF_DIR/scripts/sage-viewer-dir.bash

######################################
#  platform-specific configurations  #
######################################

# source platform dependant configs
UNAME=$(uname)
if [[ $UNAME == 'Darwin' ]]; then
    source $BASHCONF_DIR/bashrc-macosx
elif [[ $UNAME == 'Linux' ]]; then
    HOSTNAME=$(hostname -s)
    if [[ $HOSTNAME == *computecanada.ca || $HOSTNAME == *calculquebec.ca ]]; then
        source $BASHCONF_DIR/bashrc-computecanada
    else
        source $BASHCONF_DIR/bashrc-linux
    fi
fi

############
#  prompt  #
############
# should follow platform-specfic configurations since that sets $PS1_HOSTNAME

if [[ -z "${PS1_HOSTNAME}" ]]; then
    PS1_HOSTNAME=$(hostname -s);
fi;
PROMPT_COMMAND='DIR=`pwd|sed -e "s!$HOME!~!"`; if [ ${#DIR} -gt 58 ]; then CurDir=${DIR:0:12}...${DIR:${#DIR}-43}; else CurDir=$DIR; fi'
export PS1="
$PS1_HOSTNAME\001\033[00m\002\001\033[32m\002:\${CurDir}||\D{%Y-%m-%d}||\t\001\033[00m\002
》"

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

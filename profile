# This file is ~/.profile

# From `Difference between .bashrc and .bash_profile`__:
#
# This is the place to put stuff that applies to your whole session, such as
# programs that you want to start when you log in (but not graphical programs,
# they go into a different file), and environment variable definitions.
#
# .. _`Difference between .bashrc and .bash_profile`: http://superuser.com/questions/183870/difference-between-bashrc-and-bash-profile/183980

##################################
#  bash configuration directory  #
##################################

BASHCONF_DIR=$HOME/.bash-conf

###########################################
#  Load platform specific configurations  #
###########################################

# source platform dependant configs
UNAME=$(uname)
if [[ $UNAME == 'Darwin' ]]; then
    source $BASHCONF_DIR/profile-macosx
elif [[ $UNAME == 'Linux' ]]; then
    HOSTNAME=$(hostname -d)
    if [[ $HOSTNAME == *computecanada.ca || $HOSTNAME == *calculquebec.ca || $HOSTNAME == *sharcnet ]]; then
        source $BASHCONF_DIR/profile-computecanada
    else
        source $BASHCONF_DIR/profile-linux
    fi
fi

#######################################
#  Set the PATH environment variable  #
#######################################

## Add my bin directory to the PATH
export PATH=$HOME/Applications/bin:$PATH

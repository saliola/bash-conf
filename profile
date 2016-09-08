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

#######################################
#  Set the PATH environment variable  #
#######################################

## Add my bin directory to the PATH
export PATH=~/Applications/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/opt/bin

###########################################
#  Load platform specific configurations  #
###########################################

# source platform dependant configs
UNAME=$(uname)
if [[ $UNAME == 'Linux' ]]; then
    source $BASHCONF_DIR/profile-linux
elif [[ $UNAME == 'Darwin' ]]; then
    source $BASHCONF_DIR/profile-macosx
fi

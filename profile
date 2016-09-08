# This file is ~/.profile

# From `Difference between .bashrc and .bash_profile`__:
#
# This is the place to put stuff that applies to your whole session, such as
# programs that you want to start when you log in (but not graphical programs,
# they go into a different file), and environment variable definitions.
#
# .. _`Difference between .bashrc and .bash_profile`: http://superuser.com/questions/183870/difference-between-bashrc-and-bash-profile/183980

## Add my bin directory to the PATH
PATH=~/Applications/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/opt/bin

# source platform dependant configs
UNAME=$(uname)
if [[ $UNAME == 'Linux' ]]; then
    PATH=$PATH:/usr/texbin
elif [[ $UNAME == 'Darwin' ]]; then
    PATH=$PATH:/Library/TeX/texbin
fi

export PATH=$PATH

## Configure special keys

# clear settings
setxkbmap -option

# map CapsLock to Ctrl
setxkbmap -option ctrl:nocaps

# set left Ctrl as Compose key
setxkbmap -option compose:lctrl

# swap Alt and Command keys on the Mac Keyboard
HOSTNAME=$(hostname)
if [ $HOSTNAME = "macbookpro" ]; then
    setxkbmap -option altwin:swap_alt_win
fi

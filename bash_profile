# This file is ~/.bash_profile

# From `Difference between .bashrc and .bash_profile`__:
#
# ~/.bash_profile can be used instead of ~/.profile, but you also need to include
# ~/.bashrc if the shell is interactive. I recommend the following contents.
#
# .. _`Difference between .bashrc and .bash_profile`: http://superuser.com/questions/183870/difference-between-bashrc-and-bash-profile/183980

if [ -r ~/.profile ]; then
    source ~/.profile;
fi

case "$-" in
    *i*)
        if [ -r ~/.bashrc ]; then
            source ~/.bashrc;
        fi;;
esac

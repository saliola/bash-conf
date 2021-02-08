bash-conf
=========

Installation::

    git clone git@github.com:saliola/bash-conf.git ~/.bash-conf
    cd ~/.bash-conf
    sh install.sh

Difference between .bashrc, .bash_profile, .profile
----------------------------------------------------

From `Difference between .bashrc and .bash_profile`_:

``~/.profile``: is the place to put stuff that applies to your whole session,
such as programs that you want to start when you log in (but not graphical
programs, they go into a different file), and environment variable definitions.

``~/.bashrc``: is the place to put stuff that applies only to bash itself,
such as alias and function definitions, shell options, and prompt settings.
(You could also put key bindings there, but for bash they normally go into
~/.inputrc.)

``~/.bash_profile``: can be used instead of ~/.profile, but you also need to
include ~/.bashrc if the shell is interactive. I recommend the following
contents in ~/.bash_profile::

    if [ -r ~/.profile ]; then . ~/.profile; fi
    case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac

.. _`Difference between .bashrc and .bash_profile`: http://superuser.com/questions/183870/difference-between-bashrc-and-bash-profile/183980


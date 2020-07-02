function _my_git_cmd() {
    if [ $# -eq 0 ] ; then
        git status
    else
        git $@
    fi
}

alias g='_my_git_cmd'

# source platform dependant configs
UNAME=$(uname)
if [[ $UNAME == 'Darwin' ]]; then
    source $BASHCONF_DIR/scripts/git-completion.bash
elif [[ $UNAME == 'Linux' ]]; then
    HOSTNAME=$(hostname -s)
    if [[ $HOSTNAME == beluga* || $HOSTNAME == blg* ]]; then
        source /cvmfs/soft.computecanada.ca/nix/var/nix/profiles/16.09/etc/bash_completion.d/git-completion.bash
    else
        source /usr/share/bash-completion/completions/git
    fi;
fi

complete -o default -o nospace -F _git g

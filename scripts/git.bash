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
if [[ $UNAME == 'Linux' ]]; then
    source /usr/share/bash-completion/completions/git
elif [[ $UNAME == 'Darwin' ]]; then
    source $BASHCONF_DIR/scripts/git-completion.bash
fi

complete -o default -o nospace -F _git g

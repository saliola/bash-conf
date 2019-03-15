function _my_git_cmd() {
    if [ $# -eq 0 ] ; then
        git status
    else
        git $@
    fi
}

alias g='_my_git_cmd'
source /usr/share/bash-completion/completions/git
complete -o default -o nospace -F _git g

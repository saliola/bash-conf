# Bash bookmarks
#
# Adapted from:
#    http://stackoverflow.com/questions/7374534/directory-bookmarking-for-bash
#    http://ivan.fomentgroup.org/blog/2010/01/29/zsh-bookmarks-for-cd-change-directory-with-completion/
#
# Bookmarks are stored in a file (see $GO_BOOKMARKS_DB).
# Each line of the file corresponds to a bookmark, the syntax is:
#
#   bookmark -> target
#
# To make things more portable, it is better to use ~ of $HOME instead of
# /home/username. This script substitutes ~ for $HOME when creating bookmarks.

cecho() {
    tput setaf 5
    echo "$1"
    tput sgr0
}

function go() {
    USAGE="Usage: $FUNCNAME [add|cd|delete|del|edit|help|list|ls] [bookmark]" ;

    GO_BOOKMARKS_DB=~/.bash-conf/scripts/go/go_bookmarks_db.txt

    if  [ ! -e $GO_BOOKMARKS_DB ] ; then
        touch $GO_BOOKMARKS_DB
    fi

    case $1 in

        add) shift
            if [ -z "$1" ] ; then
                BOOKMARK=$(basename $PWD)
            else
                BOOKMARK="$1"
            fi
            TEST_BOOKMARK=$(grep -e "^$BOOKMARK ->" $GO_BOOKMARKS_DB)
            if [ -z "$TEST_BOOKMARK" ] ; then
                TARGET=${PWD/$HOME/\$HOME}
                cecho "$FUNCNAME: add bookmark: $BOOKMARK -> $TARGET"
                echo "$BOOKMARK -> \"$TARGET\"" >> $GO_BOOKMARKS_DB
            else
                cecho "$FUNCNAME: Bookmark already exists: $BOOKMARK" ;
            fi
            ;;

        cd) shift
            BOOKMARK=$(grep -e "^$1 ->" $GO_BOOKMARKS_DB)
            if [ -z "$BOOKMARK" ] ; then
                cecho "$FUNCNAME: Bookmark does not exist: $1" ;
            else
                NEWDIR=$(echo $BOOKMARK | sed 's/^.*-> //')
                cecho "$FUNCNAME: cd $NEWDIR"
                eval "cd $NEWDIR"
            fi
            ;;

        cd_subdir) shift
            cecho "$FUNCNAME: cd \"$@\""
            eval "cd \"$@\""
            ;;

        delete) shift
            BOOKMARK=$(grep -e "^$1 ->" $GO_BOOKMARKS_DB)
            if [ -z "$BOOKMARK" ] ; then
                cecho "$FUNCNAME: No such bookmark: $1" ;
            else
                sed -i.bak "/^$1 ->/d" $GO_BOOKMARKS_DB
                cecho "$FUNCNAME: delete bookmark: $BOOKMARK"
            fi
            ;;

        del) shift
            $FUNCNAME delete $1 ;
            ;;

        edit) shift
            $EDITOR $GO_BOOKMARKS_DB
            ;;

        go_database_file) shift
            echo $GO_BOOKMARKS_DB ;
            ;;

        help) echo "$USAGE" ;
            ;;

        list) shift
            cat $GO_BOOKMARKS_DB
            ;;

        ls)
            $FUNCNAME list ;
            ;;

        # otherwise:
        # - list bookmarks, if no arguments
        # - cd to bookmark, if one argument
        # - cd to subdirectory
        *)
            if [ -z "$1" ] ; then
                $FUNCNAME list ;
            elif [ -z "$2" ] ; then
                $FUNCNAME cd $1 ;
            else
                go cd $1
                shift
                $FUNCNAME cd_subdir "$@" ;
            fi;

    esac
}

_go()
{
    local cur pre

    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    pre=${COMP_WORDS[COMP_CWORD-1]}

    if [ $COMP_CWORD -eq 1 ]; then
        BOOKMARKS=$(cat $(go go_database_file) | sed 's/ ->.*$//')
        COMPREPLY=( $(compgen -W "$BOOKMARKS" -- $cur) )
    elif [ $COMP_CWORD -eq 2 ]; then
        BOOKMARK=$(grep -e "^$pre ->" $(go go_database_file))
        if [ -z "$BOOKMARK" ] ; then
            COMPREPLY=()
        else
            TARGET_DIR=$(echo $BOOKMARK | sed 's/^.*-> //')
            eval "cd $TARGET_DIR"
            _filedir
        fi
    else
        COMPREPLY=()
    fi

    return 0
}

complete -F _go -o filenames go

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
                echo "$FUNCNAME: add bookmark: $BOOKMARK -> $TARGET"
                echo "$BOOKMARK -> \"$TARGET\"" >> $GO_BOOKMARKS_DB
            else
                echo "$FUNCNAME: Bookmark already exists: $BOOKMARK" ;
            fi
            ;;

        cd) shift
            BOOKMARK=$(grep -e "^$1 ->" $GO_BOOKMARKS_DB)
            if [ -z "$BOOKMARK" ] ; then
                echo "$FUNCNAME: Bookmark does not exist: $1" ;
            else
                NEWDIR=$(echo $BOOKMARK | sed 's/^.*-> //')
                echo "$FUNCNAME: cd $NEWDIR"
                eval "cd $NEWDIR"
            fi
            ;;

        delete) shift
            BOOKMARK=$(grep -e "^$1 ->" $GO_BOOKMARKS_DB)
            if [ -z "$BOOKMARK" ] ; then
                echo "$FUNCNAME: No such bookmark: $1" ;
            else
                sed -i.bak "/^$1 ->/d" $GO_BOOKMARKS_DB
                echo "$FUNCNAME: delete bookmark: $BOOKMARK"
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

        # otherwise: list if no arguments ; else cd to bookmark
        *)
            if [ -z "$1" ] ; then
                $FUNCNAME list ;
            else
                $FUNCNAME cd $1 ;
            fi;

    esac
}

_go()
{
    local cur
    cur=${COMP_WORDS[COMP_CWORD]}
    BOOKMARKS=$(cat $(go go_database_file) | sed 's/ ->.*$//')
    COMPREPLY=($(compgen -W "$BOOKMARKS" -- $cur))
    return 0
}

complete -F _go -o filenames go

# count the number of entries in the current/specified directory
function count_files () {
    ls -1 $@ | wc -l
}
alias cf=count_files

# extract a tar.bz2 file OR tar & bzip2 the specified directory
function tarfile_util () {
    if [ $# -eq 0 ] ; then
        echo "usage: tf [dir_to_archive|archive_to_extract]"
    elif [[ -d $1 ]]; then
        echo "tarfile_util: archiving $1 to ${1%/}.tar.bz2"
        tar cjvf "${1%/}.tar.bz2" "$1"
    elif [[ $(file $1) == *"bzip2 compressed data"* ]]; then
        echo "tarfile_util: extracting $1"
        tar xjvf "$1"
    else
        echo "usage: tf [dir_to_archive|archive_to_extract]"
    fi;
}
alias tf=tarfile_util

# create a timestamped copy of a file
alias timestamp=$BASHCONF_DIR/scripts/timestamp.sh

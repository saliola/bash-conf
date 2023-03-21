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

# cd to the most recently used sage_viewer* directory
function sage-viewer-dir() {
    if [[ $(uname) == 'Darwin' ]]; then
        sage_viewer_dirs=$(find $TMPDIR -type d -name 'sage_viewer*' 2> /dev/null)
        sage_viewer_dir=$(ls -td1 $sage_viewer_dirs | head -1)
    else
        sage_viewer_dir=$(ls -td1 $HOME/.sage/temp/$(hostname)/*/sage_viewer* | head -1)
    fi;
    echo "most recently used sage_viewer director: $sage_viewer_dir"
    cd $sage_viewer_dir
}

# create a timestamped copy of a file
alias timestamp=$BASHCONF_DIR/scripts/timestamp.sh

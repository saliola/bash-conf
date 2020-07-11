#!/bin/bash
#
# Create a timestamped copy of a file.
#
# Example:
#   > timestamp filename.txt
#   > ls -1 filename*.txt
#   filename.txt
#   filename-2013-10-15.txt

# Uncomment for debugging
#set -xv

if [ -z "$1" ]; then
    USAGE="Usage: $(basename $0) [-s|-l] file"
    echo $USAGE
    exit
fi

case "$1" in

    -s) shift
        DATE=$(date +"%F")
        ;;

    -l) shift
        DATE=$(date +"%Y-%m-%d-%H-%M")
        ;;

    *)
        DATE=$(date +"%F")
        ;;

esac

DIRNAME=$(dirname "$1")
ORIGINAL_FILENAME=$(basename "$1")

if [[ $ORIGINAL_FILENAME == "."* ]] ; then
    # THIS IS A DOTFILE
    TIMESTAMPED_FILENAME="$ORIGINAL_FILENAME-$DATE"
else
    EXTENSION="${ORIGINAL_FILENAME##*.}"
    FILENAME="${ORIGINAL_FILENAME%.*}"
    TIMESTAMPED_FILENAME="$FILENAME-$DATE.$EXTENSION"
fi
ORIGINAL_FILENAME=$DIRNAME/$ORIGINAL_FILENAME
TIMESTAMPED_FILENAME=$DIRNAME/$TIMESTAMPED_FILENAME

cp -ir $ORIGINAL_FILENAME $TIMESTAMPED_FILENAME


# CHECK : diff the two files
diff $ORIGINAL_FILENAME $TIMESTAMPED_FILENAME
status=$?
if [ $status -ne 0 ]; then
    echo "$0: cp unsuccessful"
    exit $status
fi

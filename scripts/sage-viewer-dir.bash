# cd to the most recently used sage_viewer* directory


function sage-viewer-dir() {
    sage_viewer_dir=$(ls -td1 $HOME/.sage/temp/$(hostname)/*/sage_viewer* | head -1)
    echo "most recently used sage_viewer director: $sage_viewer_dir"
    cd $sage_viewer_dir
}

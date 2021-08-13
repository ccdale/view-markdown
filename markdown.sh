#!/bin/bash

# exit on any error
set -e

# usage statement
function USAGE()
{
    echo "
    Usage:
        $ME <filename.md>

    Utility to convert a markdown formatted file to html and automatically
    open it in a browser tab.
    The html file (and the temp directory) are deleted when this script exits.
    "
}

# temp directory to work in
TMPD="$(mktemp -d)"
# remove temp directory at script end
trap 'rm -rf -- "$TMPD"' EXIT

# use 'open' on OSX and xdg-open on Linux
if ! XOPEN=$(which open 2>/dev/null); then
    if ! XOPEN=$(which xdg-open 2>/dev/null); then
        echo "No Browser open command found, sorry."
        exit 1
    fi
fi
if [ -z $XOPEN ]; then
    echo "Still no browser open command found."
    exit 1
fi

# ensure that pandoc is installed
if ! PANDOC=$(which pandoc 2>/dev/null); then
    echo "Please install pandoc and try again."
    exit 1
fi

# script name
ME=$(basename $0)

# markdown file to convert
mfn=$1
if [ -z $mfn ]; then
    USAGE
    exit 1
fi

if [ "$mfn" = "-h" -o "$mfn" = "--help" ]; then
    USAGE
    exit 0
fi

# just the filename
bmfn=$(basename $mfn)
# replace the file extension
hmfn=${bmfn%.md}.html
# test for a .markdown file extension if necessary
if [ "$hmfn" = "${bmfn}.html" ]; then
    hmfn=${bmfn%.markdown}.html
fi

tfn=${TMPD}/${hmfn}
# cp $mfn $TMPD

# cd $TMPD
$PANDOC $mfn -o $tfn

$XOPEN $tfn

# wait for browser to open a tab and read the file
sleep 3

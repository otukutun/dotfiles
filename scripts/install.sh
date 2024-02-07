#!/bin/sh

set -e
tempfile=/tmp/dotfiles.zip
workspace=$HOME/dotfiles

curl -LSfs -o ${tempfile} https://github.com/otukutun/dotfiles/archive/main.zip

# Unzip installer into workspace
unzip -oq ${tempfile} -d ${workspace}

# Move to repository root path
pushd ${workspace}/dotfiles-main > /dev/null

# Run installer

# Move to original path
popd > /dev/null

# Cleanup
rm -rf ${tempfile}

#!/bin/bash
#This script finds all files with th extension .sh and updates the mod to +x
#Execute this if you are doing a native install on Ubuntu as sometimes the .sh files are 
#not copied with 'execute' permission & you would get 'Permission Denied' error

cd ../../
echo $PWD

echo "All .sh files will be changed with  +x mod ... please wait."

# This will update the mode for all shell scripts to +x
find . -type f -name '*.sh' -exec chmod +x {} \;

echo "Done"
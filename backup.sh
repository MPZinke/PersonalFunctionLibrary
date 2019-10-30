#!/bin/bash

###################################################
#
#	-Back upfile from path given to pwd
#	-If file already exists, change to _old
#
###################################################

fullpath=$1
file="${fullpath##*/}"
name=${file%.*}
oldfile="${name}_old.${file##*.}"
path="${fullpath%/*}/"

# file does not exist
if [ ! -f $fullpath ] 
then
	if [ ! -d  $path ] 
	then
		echo -e "\033[0;31m$path is not a valid directory\033[0;39m"
	else
		echo -e "\033[0;31mNo file $file at $path\033[0;39m"
	fi
# copy to same folder (just creates copy with _old suffix)
elif  [[ "$PWD/" == $path ]] || [[ $path == "./" ]] || [[ $fullpath != *"/"* ]] 
then
	if [ -f "$PWD/$oldfile" ] 
	then
		rm "$PWD/$oldfile"
	fi
	cp $file "$PWD/$oldfile"
	echo -e '\033[0;33mNow you have the same file in the folder twice\033[0;39m'
# change existing file to _old suffix, copy new over
elif [ -f $file ] \
	&& mv $file "$PWD/$oldfile" \
	&& cp $fullpath "$PWD/$file";
then
	echo -e "\033[0;32mBacked up $file and archived previous addition at $(date +%T)\033[0;39m"
# no file, copy over
elif [ ! -f $file ] \
	&& cp $fullpath "$PWD/$file";
then
	echo -e "\033[0;32mBacked up $file at $(date +%T)\033[0;39m"
else
	echo -e "\033[0;31mFailed to back up $file\033[0;39m"
fi

# created by: MPZinke on 02.15.19
# edited by: MPZinke on 10.26.19 for allow for exported path to work on PWD
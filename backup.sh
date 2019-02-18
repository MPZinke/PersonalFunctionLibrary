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
elif  [[ "$PWD" == $path ]] || [[ $path == "./" ]] 
then
	if [ -f "$oldfile" ] 
	then
		rm $oldfile
	fi
	cp $file $oldfile
	echo -e '\033[0;33mNow you have the same file in the folder twice\033[0;39m'
# change existing file to _old suffix, copy new over
elif [ -f $file ] \
	&& mv $file "$oldfile" \
	&& cp $fullpath $file;
then
	echo -e "\033[0;32mBacked up $file and archived previous addition at $(date +%T)\033[0;39m"
# no file, copy over
elif [ ! -f $file ] \
	&& cp $fullpath $file;
then
	echo -e "\033[0;32mBacked up $file at $(date +%T)\033[0;39m"
else
	echo -e "\033[0;31mFailed to back up $file\033[0;39m"
fi

# created by: MPZinke on 02.15.19
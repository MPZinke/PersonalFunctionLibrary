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
path="${fullpath%/*}"

# file does not exist
if [ ! -f $fullpath ] 
then
	if [ ! -d  $path ] 
	then
		echo  "$path is not a valid directory"
	else
		echo "No file $file at $path"
	fi
# copy to same folder (just creates copy with _old suffix)
elif  [[ "$PWD" == $path ]] || [[ $path == "." ]]
then
	if [ -f "$oldfile" ] 
	then
		rm $oldfile
	fi
	cp $file $oldfile
	echo 'Now you have the same file in the folder twice'
# change existing file to _old suffix, copy new over
elif [ -f $file ] \
	&& mv $file "$oldfile" \
	&& cp $fullpath $file;
then
	echo "Backed up $file and archived previous addition"
# no file, copy over
elif [ ! -f $file ] \
	&& cp $fullpath $file;
then
	echo "Backed up $file"
else
	echo "Failed to back up $file"
fi

# created by: MPZinke on 02.15.19
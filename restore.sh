#!/bin/bash

###################################################
#
#	-Bash script to replace (test) file with template 
#
###################################################

file=$1
name="${file##.*}"
extension="${file##*.}"
path="~/Templates/"

if [ ! -f "${path}template.$extension" ] 
then
	echo "There is no template for $file"
else 
	if [ -f $file ] 
	then
		rm test.cpp || { echo "Failed to remove pre-existing file $file" ; exit 1; }
	fi
	cp "${path}template.$extension" $file || echo "Failed to copy template to $file"
fi


# created by: MPZinke on 02.09.19
# edited by MPZinke on 02.15.19 for fewer conditions
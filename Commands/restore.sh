#!/bin/bash

###################################################
#
#	-Bash script to replace (test) file with template 
#
###################################################

file=$1
name="${file##.*}"
extension="${file##*.}"
template_path="~/Templates/"

if [ ! -f "${template_path}template.$extension" ] 
then
	echo "There is no template for $file"
else 
	if [ -f $file ] 
	then
		rm $file || { echo "Failed to remove pre-existing file $file" ; exit 1; }
	fi
	cp "${template_path}template.$extension" "$PWD/$file" || echo "Failed to copy template to $file"
fi


# created by: MPZinke on 02.09.19
# edited by: MPZinke on 02.15.19 for fewer conditions
# edited by: MPZinke on 10.26.19 to fix file removal command
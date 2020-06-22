#!/bin/bash

###################################################
#
#	-Bash script to automatically compile/run
#	 scripts
#
###################################################

file=$1
extension="${file##*.}"
if [ "$extension" = "cpp" ]
then
		if g++ $file; then
				./a.out
		fi
elif [ "$extension" = "c" ]
then
		if gcc $file; then
				./a.out
		fi
elif [ "$extension" = "java" ]
then
		if javac $file; then
				java "${file%.*}"
		fi
elif [ "$extension" = "py" ] 
then
	python3 $file
fi

# created by: MPZinke on 01.18.19
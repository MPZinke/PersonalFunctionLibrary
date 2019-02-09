#!/bin/bash

###################################################
#
#	-Bash script to replace (test) file with template 
#
###################################################

file=$1
extension="${file##*.}"
if [ "$extension" = "cpp" ]
then
	if [ -f test.cpp ] && rm test.cpp;
	then
		plates/template.cpp $file
	elif [ ! -f test.cpp ]
	then
		cp ~/Templates/template.cpp $file
	fi
elif [ "$extension" = "c" ]
then
	if [ -f test.c ] && rm test.c;
	then
		cp ~/Templates/template.c $file
	elif [ ! -f test.c ]
	then
		cp ~/Templates/template.c $file
	fi
elif [ "$extension" = "java" ]
then
	if [ -f Test.java ] && rm Test.java;
	then
		cp ~/Templates/template.java $file
	elif [ ! -f Test.java ]
	then
		cp ~/Templates/template.java $file
	fi
elif [ "$extension" = "py" ] 
then
	if [ -f test.py ] && rm test.py;
	then
		cp ~/Templates/template.py $file
	elif [ ! -f test.py ]
	then
		cp ~/Templates/template.py $file
	fi
fi

# created by: MPZinke on 02.09.19
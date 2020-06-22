#!/bin/bash

###########################################################################
#
#	created by: MPZinke
#	on 02.13.20
#
#	DESCRIPTION: cd file (cdf)
#		cd into director of passed file
#	BUGS:
#	FUTURE:
#
###########################################################################

FILE=$1
if [ -d "$FILE" ]; then
	cd "$FILE"
elif [ -f "$FILE" ]; then
	cd "$(dirname $FILE)"
else
	echo -e "\033[0;31mNo such file or directory $FILE\033[0;39m"
fi

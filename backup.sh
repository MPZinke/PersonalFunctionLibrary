#!/bin/bash

###########################################################################
#
#	created by: MPZinke
#	on 02.15.19
#	edited by: MPZinke on 10.26.19 for allow for exported PATH to work on PWD
#	edited by: MPZinke on 02.15.20 to allow for copying of folders
#
#	DESCRIPTION:  Backup files for folders to directory command is called PWD.  If backing 
#		up to a filename that already exists, program will rename preexisting version with a
#		suffix of current time
#	BUGS:  Folder backing up is not fully functional (does not copy well within folder)
#			DO NOT USE ! COMMAND WITH THIS
#	FUTURE:
#
###########################################################################

FULLFILE=$1
# FILEPATH="${FULLFILE%/*}/"
FILEPATH="$(dirname $FULLFILE)"

FILE="$(basename $FULLFILE)"
FILEEXTENSION="${FILE##*.}"
FILENAME=${FILE%.*}

DATELABEL="_$(date +%Y%m%d\_%H%M%S)"

COPYFILE="${FILENAME}_copy.${FILEEXTENSION}"
COPYFILEDATE="${FILENAME}_copy${DATELABEL}.${FILEEXTENSION}"
COPYFOLDER="${FILE}_copy"

OLDFILE="${FILENAME}${DATELABEL}.${FILEEXTENSION}"
OLDFOLDER="${FILE}${DATELABEL}"

# folder supplied
if [ -d $FULLFILE ]
then
	if  [[ "$PWD" == $FILEPATH ]] || [[ $FILEPATH == "." ]] 
	then 
		# check if copy name exists in current folder: if yes, add datelabel
		if [ -d "./$COPYFOLDER" ]; then
			COPYFOLDER+="${DATELABEL}"
		fi
		cp -R "./${FILE}" "${COPYFOLDER}" \
		&& echo -e '\033[0;33mYou have copied this folder to the same folder\033[0;39m'
	else 		
		# if a file by that name already exists in PWD, add _old suffix
		if [ -d "./${FILE}" ]; then
			# catalogue old backup
			mv "./${FILE}" "${OLDFOLDER}" \
			&& echo -e "\033[0;32mArchived previous addition to $FILE\033[0;39m"
		fi
		cp -R $FULLFILE "./${FILE}" \
		&& echo -e "\033[0;32mBacked up $FILE\033[0;39m"
	fi

# this is a file
elif [ -f $FULLFILE ]
then

	# check if file is backup to same location (if same director, path == './', only the filename)
	# if it is, then a copy of it is desired
	if  [[ "$PWD" == $FILEPATH ]] || [[ $FILEPATH == "." ]] 
	then
		if [ -f "./${COPYFILE}" ]; then
			COPYFILE="${COPYFILEDATE}"
		fi
		cp "./${FILE}" "${COPYFILE}" \
		&& echo -e '\033[0;33mYou have copied this file to the same folder\033[0;39m'
	else
		# if a file by that name already exists in PWD, catalogue it
		if [ -f "./${FILE}" ]; then
			mv "./${FILE}" "${OLDFILE}" \
			&& echo -e "\033[0;32mArchived previous addition to ${OLDFILE}\033[0;39m"
		fi

		cp $FULLFILE $FILE \
		&& echo -e "\033[0;32mBacked up $FILE\033[0;39m"
	fi

# this does not exist
else
	# folder does not exist
	if [ ! -d $FILEPATH ]; then
		echo -e "\033[0;31m$FILEPATH is not a valid directory\033[0;39m"
	else
		echo -e "\033[0;31mNo file $FILE at $FILEPATH\033[0;39m"
	fi
fi

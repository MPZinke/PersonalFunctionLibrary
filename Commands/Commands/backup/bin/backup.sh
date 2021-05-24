#!/bin/bash

########################################################################################################################
#                                                                                                                      #
#   created by: MPZinke                                                                                                #
#   on ..                                                                                                              #
#                                                                                                                      #
#   DESCRIPTION:                                                                                                       #
#   BUGS:                                                                                                              #
#   FUTURE:                                                                                                            #
#                                                                                                                      #
########################################################################################################################


DATABACKUP_DRIVE="/dev/sdc1"
DATABACKUP_PATH="/media/mpzinke/DataBackup"

SYSTEMBACKUP_DRIVE="/dev/sdc2"
SYSTEMBACKUP_PATH="/media/mpzinke/SystemBackup"

GIT_ZIP_FILE="/media/mpzinke/DataBackup/GitReposCopies/GitRepos.$(date '+%Y.%m.%d').zip"
MAIN_ZIP_FILE="/media/mpzinke/DataBackup/MainCopies/Main.$(date '+%Y.%m.%d').zip"
ENVIRONMENT_ZIP_FILE="/media/mpzinke/SystemBackup/Profile/Profile.$(date '+%Y.%m.%d').zip"

MAT="/home/mpzinke/"


if [ ! "$(ls -A $DATABACKUP_PATH)" ]
then
	echo "Data Backup drive is not mounted"
	sudo mount "$DATABACKUP_DRIVE" "$DATABACKUP_PATH"
fi


if [ ! "$(ls -A $SYSTEMBACKUP_PATH)" ]
then
	echo "System Backup drive is not mounted"
	sudo mount "$SYSTEMBACKUP_DRIVE" "$SYSTEMBACKUP_PATH"
fi


### Backup Git Repos ###
sudo zip -r "$GIT_ZIP_FILE" "${MAT}.GitRepos" /home/git

### Backup Environment ###
sudo zip "$ENVIRONMENT_ZIP_FILE" "${MAT}.bashrc" "${MAT}.bash_profile" "${MAT}.colorcodes" "${MAT}.config/neofetch/config.conf"

### Backup User Data ###
sudo zip -r "$MAIN_ZIP_FILE" "${MAT}Main"

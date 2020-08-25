#!/bin/bash

###########################################################################
#
#	created by: MPZinke
#	on ..
#
#	DESCRIPTION:
#	BUGS:
#	FUTURE:
#
###########################################################################

# —————————————————— INSTALLS ——————————————————

# installs
sudo apt-get update
sudo apt-get upgrade


# ——————————————— PERSONAL COMMANDS ——————————————

sudo mkdir /Commands

#cd file's directory
sudo mkdir /Commands/cdf
sudo mkdir /Commands/cdf/bin
sudo cp cdf.sh /Commands/cdf/bin/cdf
sudo chmod +x /Commands/cdf/bin/cdf

# run
sudo mkdir /Commands/run
sudo mkdir /Commands/run/bin
sudo cp run.sh /Commands/run/bin/run
sudo chmod +x /Commands/run/bin/run

# restore
sudo mkdir /Commands/res
sudo mkdir /Commands/res/bin
sudo cp restore.sh /Commands/res/bin/res
sudo chmod +x /Commands/res/bin/res
# transfer templates
sudo cp -rf Templates/ /Commands/res/bin

# backup
sudo mkdir /Commands/backup
sudo mkdir /Commands/backup/bin
sudo cp backup.sh /Commands/backup/bin/backup
sudo chmod +x /Commands/backup/bin/backup

# create repo on git server
sudo mkdir /Commands/create_repo
sudo mkdir /Commands/create_repo/bin
sudo cp create_repo.sh /Commands/create_repo/bin/create_repo
sudo chmod +x /Commands/create_repo/bin/create_repo

# —————————— ADD PATHS AND ALIASES TO BASH PROFILE —————————

# add paths to bash profile
BASH_FILE=$1

if [ -f $BASH_FILE ]
then
	cp $BASH_FILE "$BASH_FILE\_copy"
	bash_profile_additions.txt >> $BASH_FILE
fi

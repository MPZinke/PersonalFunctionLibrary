#!/bin/bash

##########################################################################################
#
#	created by: MPZinke
#	on 2020.10.4
#
#	DESCRIPTION:	Install personal commands to linux system & create executables
#	BUGS:		-
#	FUTURE:	-
#
##########################################################################################

# —————————————————— INSTALLS ——————————————————


# ——————————————— PERSONAL COMMANDS ——————————————

sudo mkdir /Commands
sudo cp -R ./Commands/* /Commands

sudo chmod +x /Commands/backup/bin/backup
sudo chmod +x /Commands/cdf/bin/cdf
sudo chmod +x /Commands/create_repo/bin/create_repo
sudo chmod +x /Commands/mvR/bin/mvR
sudo chmod +x /Commands/res/bin/res
sudo chmod +x /Commands/run/bin/run

#!/bin/bash

###########################################################################
#
#	created by: MPZinke
#	on 2020.08.25
#
#	DESCRIPTION:  Script to initiate the origin of new git repository on local device.
#	BUGS:  
#	FUTURE:
#
###########################################################################


repo_name=$1
repo_path="/home/git"

if [ -d "$repo_path/$repo_name.git" ]; then
	echo "Error: repo already exists"
else
	mkdir "$repo_path/$repo_name.git" && \
	echo "Created repo folder" && \
	git init "$repo_path/$repo_name.git" --bare && \
	echo "Successfully initiated origin for $repo_name.git"
fi

#!/bin/bash

# Klimbim Software collection, A bag full of things
# Copyright (C) 2011-2023 Johannes 'Banana' Keßler
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.


# 2016 http://www.bananas-playground.net 
# create a loop which checks for file modifications. 
# If so start a process
# this loop waits 10 seconds and checks if there are files modified in the past 10 seconds.

# color the output
cecho () {
	local red='\033[0;31m'
	local blue='\033[0;34m'
	local green='\033[0;32m'
	local cyan='\033[0;36m'
	local purple='\033[0;35m'
	local brown='\033[0;33m'
	local yellow='\033[1;33m'
	local white='\033[1;37m'
	local black='\033[0;30m'

	local message=$1
	local color=${!2-$white}

	echo -en "$color"
	echo "$message"
	echo -en "\033[0m" # reset color

	return
}

target=/path/to/dir;
found=;

if [ -z $target ] ; then
	cecho "Missing target" red;
	exit 1;
fi


if [ -d "$target" ]; then	
	while : 
	do
		found=`find $target -mtime -10s -type f`
				
		if [ ! -z "$found" ] ; then
			cecho "do some'";
		fi
		sleep 10
	done	
fi


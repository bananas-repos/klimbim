#!/bin/bash

# This program is free software: you can redistribute it and/or modify
# it under the terms of the COMMON DEVELOPMENT AND DISTRIBUTION LICENSE
#
# You should have received a copy of the
# COMMON DEVELOPMENT AND DISTRIBUTION LICENSE (CDDL) Version 1.0
# along with this program.  If not, see http://www.sun.com/cddl/cddl.html

# 2013 https://github.com/jumpin-banana

# this function prints the given string in the given colour in a bash shell
# either include this function directly into your script or source it as an
# external file.
#
# usage example:
# cecho "this is green" green; # prints the string in green
#
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


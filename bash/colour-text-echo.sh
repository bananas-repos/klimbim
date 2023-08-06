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

# 2013 http://www.bananas-playground.net

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


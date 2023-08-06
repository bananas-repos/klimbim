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


# 2023 http://www.bananas-playground.net
# this is a small example how to use getops in bash

SELF=`basename "$0"`

Help() {
   # Display Help
   echo "Syntax: ${SELF} [-n|h|v|V]"
   echo "Available ptions are:"
   echo "-n    Input your name."
   echo "-h    Print this Help."
   echo "-v    Verbose mode."
   echo "-V    Print software version and exit."
   echo
}

VERBOSE="false"
NAME=""

while getopts "hvVn:" option ; do
	case $option in
		h) Help 
			exit;;
		v) VERBOSE="true" ;;
		V) echo "Version 1.0"
			exit;;
		n) NAME=$OPTARG ;;

		?) # Invalid option
			Help
			exit;;
	esac
done

if [[ -z "$NAME" ]] ; then
	echo 'Missing -n' >&2
	exit 1
fi


echo "${NAME}"
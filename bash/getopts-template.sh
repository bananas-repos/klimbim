#!/bin/bash

# This program is free software: you can redistribute it and/or modify
# it under the terms of the COMMON DEVELOPMENT AND DISTRIBUTION LICENSE
#
# You should have received a copy of the
# COMMON DEVELOPMENT AND DISTRIBUTION LICENSE (CDDL) Version 1.0
# along with this program.  If not, see http://www.sun.com/cddl/cddl.html
#
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
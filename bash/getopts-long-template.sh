#!/bin/bash
set -euo pipefail

# This program is free software: you can redistribute it and/or modify
# it under the terms of the COMMON DEVELOPMENT AND DISTRIBUTION LICENSE
#
# You should have received a copy of the
# COMMON DEVELOPMENT AND DISTRIBUTION LICENSE (CDDL) Version 1.0
# along with this program.  If not, see http://www.sun.com/cddl/cddl.html
#
# 2023 http://www.bananas-playground.net

# getopts long example and template
# more detail can be found here https://www.shellscript.sh/examples/getopt/


Help() {
	echo
	echo "Syntax: `basename "$0"` -n [-h|v|V]"
	echo "Available ptions are:"
   	echo "-n  | --name Input your name."
	echo "[-h | --help Print this Help and exit.]"
	echo "[-v | --verbose Verbose mode.]"
	echo "[-V | --version Print software version and exit.]"
	echo
}

VERBOSE="false"
NAME=""

VALID_ARGS=$(getopt -o 'vVhn:' --long verbose,version,help,name: -- "$@")
if [[ $? -ne 0 ]]; then
    exit 1;
fi

eval set -- "$VALID_ARGS"
while [ : ]; do
	case "$1" in
		-n | --name)
			NAME="$2"
			shift 2 
			;;

		-v | --verbose) 
			VERBOSE="true"
			shift 
			;;

		-V | --version)
			echo "Version 1.0" 
			shift
			exit ;;
   
		-h | --help)
			Help
			exit 0
			;;
		--) shift
			break
			;;
		*)  echo "Unexpected option: $1"
       		Help 
       		exit
       		;;
	esac
done
shift "$(($OPTIND -1))"


if [[ -z "$NAME" ]] ; then
	echo 'Missing option -n | --name' >&2
	exit 1
fi

if [[ "${VERBOSE}" == "true" ]] ; then
	echo "DEBUG: Provided ${NAME} for option n"
fi

echo "Your are: ${NAME}"

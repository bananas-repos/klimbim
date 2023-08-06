#!/bin/bash
set -euo pipefail

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

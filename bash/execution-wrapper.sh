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

# 2020 https://www.bananas-playground.net
# this file can be used to wrap the execution of a
# command which needs to be ox independent or
# needs other commands before or after

# the following example detects the os type
# sets env vars and executes a command befor and after

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux)
		cmd="some-command_linux-amd64";
	;;
	Darwin)
		cmd="some-command_darwin-amd64";
	;;
	*)      
		echo "UNKNOWN System:${unameOut}";
	    exit
	;;
esac

# this path detection works on linux and mac
SCRIPT="$(readlink "$0")";
SCRIPTPATH="$(dirname "$SCRIPT")"

# change dir since the executed script is within a git repo
cd $SCRIPTPATH;
git pull;

# set some EVN, execute and after quit of the cmd, do a git update
SOME_ENV_VAR=$SCRIPTPATH/a.db ./${cmd} && git commit -am"`date +'%c'`" && git push;

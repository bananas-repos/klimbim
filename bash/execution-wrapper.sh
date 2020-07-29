#!/bin/bash

# This program is free software: you can redistribute it and/or modify
# it under the terms of the COMMON DEVELOPMENT AND DISTRIBUTION LICENSE
#
# You should have received a copy of the
# COMMON DEVELOPMENT AND DISTRIBUTION LICENSE (CDDL) Version 1.0
# along with this program.  If not, see http://www.sun.com/cddl/cddl.html

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

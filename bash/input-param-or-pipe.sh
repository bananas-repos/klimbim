#!/bin/bash

# This program is free software: you can redistribute it and/or modify
# it under the terms of the COMMON DEVELOPMENT AND DISTRIBUTION LICENSE
#
# You should have received a copy of the
# COMMON DEVELOPMENT AND DISTRIBUTION LICENSE (CDDL) Version 1.0
# along with this program.  If not, see http://www.sun.com/cddl/cddl.html
#
# 2022 http://www.bananas-playground.net

# this shows a simple method on how to get input from args or pipe


INPUT_TEXT="default value"
if test -n "$1"; then
	INPUT_TEXT=$1; # args $1
elif test ! -t 0; then
	INPUT_TEXT=$(</dev/stdin) # piped
fi

echo ${INPUT_TEXT}

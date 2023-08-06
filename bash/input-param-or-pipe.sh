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


# 2022 http://www.bananas-playground.net
# this shows a simple method on how to get input from args or pipe


INPUT_TEXT="default value"
if test -n "$1"; then
	INPUT_TEXT=$1; # args $1
elif test ! -t 0; then
	INPUT_TEXT=$(</dev/stdin) # piped
fi

echo ${INPUT_TEXT}

#!/bin/bash
set -euo pipefail

# Klimbim Software collection, A bag full of things
# Copyright (C) 2011-2024 Johannes 'Banana' Keßler
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

# 2024 http://www.bananas-playground.net
# A simple wrapper around browserless requests based on the free acccount.
# You need an API.
# Important note: It will not always work. This is not an error. It depends
# on the way the target webpage is build.

command -v curl >/dev/null 2>&1 || { echo >&2 "I require curl (https://curl.haxx.se/) but it's not installed.  Aborting."; exit 1; }

# add your browserless io token
BROWSERLESSURL="https://chrome.browserless.io/screenshot?token=XXXXXXXXX"
USAGE="screenshot-browserless.sh 'URL' file.jpeg"

if [ $# -lt 2 ]; then
	echo "Missing required URL or file";
	echo ${USAGE}
	exit 2;
fi;

curl -s -X POST "${BROWSERLESSURL}" -H 'Cache-Control: no-cache' -H 'Content-Type: application/json' \
-d '{"url": "'"${1}"'", "waitFor" : 5000, "options": { "fullPage": true,"type": "jpeg","quality": 75 } }' -o ${2}


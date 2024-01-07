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
# A simple wrapper around google pagespeed request which extracts
# a page screenshot
# Important note: It will not always work. This is not an error. It depends
# on the way the target webpage is build.

command -v curl >/dev/null 2>&1 || { echo >&2 "I require curl (https://curl.haxx.se/) but it's not installed.  Aborting."; exit 1; }
command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq (https://jqlang.github.io/jq/) but it's not installed.  Aborting."; exit 1; }
command -v base64 >/dev/null 2>&1 || { echo >&2 "I require base64 (https://www.gnu.org/software/coreutils/) but it's not installed.  Aborting."; exit 1; }

USERAGENT="Mozilla/5.0 (X11; Linux x86_64; rv:121.0) Gecko/20100101 Firefox/121.0"
PAGESPEEDURL="https://www.googleapis.com/pagespeedonline/v5/runPagespeed?&screenshot=true&url="
USAGE="screenshot-google.sh 'URL' file.webp"

if [ $# -lt 2 ]; then
	echo "Missing required URL or file";
	echo ${USAGE}
	exit 2;
fi;

curl -s -H "Cache-Control: no-cache" -H "User-Agent: ${USERAGENT}" "${PAGESPEEDURL}${1}" \
| jq -r '.lighthouseResult.fullPageScreenshot.screenshot.data' | cut -d "," -f 2 \
| base64 --decode > ${2}


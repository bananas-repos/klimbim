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
# More information and resources can be found here
# https://www.bananas-playground.net/2023/05/db-delay-notify/

# station eva#
STATIONID=""
# destination eva# Show only for destination
# train changes are not accounted for. It only shows train which 
# start at STATIONID and end at DESTINATIONID
DESITNATIONID=""
# can be dep (departure) or arr (arrival)
BOARDTYPE="dep"
# show only delays
# the delay limit is 5min.
DELAY="false"
# which type of transport will be shown
FILTER="11111"
# print some debug info
DEBUG="false"

USAGE="Usage: db-delay.sh STATIONID BOARDTYPE[dep|arr] DELAY[true|false] [DESITNATIONID]"

if [[ $# -ge 1 ]] && [[ -n "$1" ]]; then
	STATIONID=$1;
else
	echo "Missing argument STATIONID"
	echo "${USAGE}"
	exit 1
fi

if [[ $# -ge 2 ]] && [[ -n "$2" ]]; then
	BOARDTYPE=$2;
else
	echo "Missing argument BOARDTYPE"
	echo "${USAGE}"
	exit 1
fi

if [[ $# -ge 3 ]] && [[ -n "$3" ]]; then
	DELAY=$3;
else
	echo "Missing argument DELAY"
	echo "${USAGE}"
	exit 1
fi

if [[ $# -ge 4 ]] && [[ -n "$4" ]]; then
	DESITNATIONID=$4;
fi


# the endpoint
DBURL="https://reiseauskunft.bahn.de/bin/bhftafel.exe/dn?L=vs_java&start=yes&boardType=${BOARDTYPE}&input=${STATIONID}&productsFilter=${FILTER}&time=actual"

if [[ "$DELAY" == "true" ]] ; then
	DBURL+="&delayedJourney=on";
fi

if [[ ! -z "$DESITNATIONID" ]] ; then
	DBURL+="&dirInput=${DESITNATIONID}";
fi

# Return value not really clear yet.
# If nothing is found, just the station text is returned.
# If there is no delay (if delay=true) an error is returned. Why?
# A succesful minimal result is 4 lines
# Nothing is one line
# No delays two lines with error in the second
CALLRESULT=`curl -s "${DBURL}"`
LINES=`wc -l <<< "${CALLRESULT}"`


NOTIFYTEXT="Something wrong"
if [[ "$DELAY" = true ]] && [[ $LINES > 3 ]]; then
	NOTIFYTEXT="Delays\n${CALLRESULT}"
elif [[ "$DELAY" = true ]] && [[ $CALLRESULT == *"error"* ]]; then
	NOTIFYTEXT=`echo "${CALLRESULT}" | head -1`
	NOTIFYTEXT+="\nNo delays yet"
else 
	NOTIFYTEXT=${CALLRESULT}
fi

if [[ "${DEBUG}" == "true" ]] ; then
	echo "${DBURL}"
	echo "${CALLRESULT}"
	echo "${LINES}"
	echo -e "${NOTIFYTEXT}"
fi


BOTTOKEN="xxxxxxxxxxxxxxxx"
CHAT_ID="xxxxxxxxxxx"
TELURL="https://api.telegram.org/bot$BOTTOKEN/sendMessage"

curl -s -X POST -H 'Content-Type: application/json' -d '{"chat_id": "'${CHAT_ID}'", "text": "'"${NOTIFYTEXT}"'", "disable_notification": false}' ${TELURL} > /dev/null 2>&1

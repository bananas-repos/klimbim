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
# this is a simple bash script witch accepts a text input as arg1 or pipe
# and writes this text to your telegram chat
# https://core.telegram.org/bots
# https://core.telegram.org/bots#6-botfather


BOTTOKEN="xxxxxxxxxxxxxxxx"
CHAT_ID="xxxxxxxxxxx"
URL="https://api.telegram.org/bot$BOTTOKEN/sendMessage"

INPUT_TEXT="Something is ready..."
if test -n "$1"; then
	INPUT_TEXT=$1;
elif test ! -t 0; then
	INPUT_TEXT=$(</dev/stdin)
fi

curl -s -X POST -H 'Content-Type: application/json' -d '{"chat_id": "'${CHAT_ID}'", "text": "'"${INPUT_TEXT}"'", "disable_notification": false}' ${URL} > /dev/null 2>&1

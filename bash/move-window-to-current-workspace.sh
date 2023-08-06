#!/usr/bin/env -S bash -e

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


# 2023 https://www.bananas-playground.net
# Get a window of a workspace indentified by a name
# Not very safe in case of errors. Use at onw risk
# needs xdotool, wmctrl, xprop, wmctrl

if [ -z "$1" ]
  then
    echo "Missing string to search for"
	exit 1;
fi

WINDOWNAME_TO_SEARCH=$1
CURRENT_WORKSPACE=$(xdotool get_desktop)

HEX_ID=$(wmctrl -lx | grep -i ${WINDOWNAME_TO_SEARCH} | awk '{print $1}')
WINDOW_ID=$(printf "%d" ${HEX_ID})

# remember if it was maximized
WINDOW_STAGE=$(xprop -id ${WINDOW_ID=} _NET_WM_STATE | awk '{ print $3 }')

# Un-maximize current window so that it can be moved
wmctrl -ir ${WINDOW_ID=} -b remove,maximized_vert,maximized_horz

xdotool set_desktop_for_window ${WINDOW_ID} ${CURRENT_WORKSPACE} && xdotool windowactivate ${WINDOW_ID}

# Maximize if it was before the move
if [ "${WINDOW_STAGE=}" = "_NET_WM_STATE_MAXIMIZED_HORZ," ]; then
    wmctrl -ir ${WINDOW_ID=} -b add,maximized_vert,maximized_horz
fi


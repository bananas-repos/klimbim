#!/usr/bin/env -S bash -e

# Get a window of a workspace indentified by a name
# Not very safe in case of errors. Use at onw risk

# This program is free software: you can redistribute it and/or modify
# it under the terms of the COMMON DEVELOPMENT AND DISTRIBUTION LICENSE
#
# You should have received a copy of the
# COMMON DEVELOPMENT AND DISTRIBUTION LICENSE (CDDL) Version 1.0
# along with this program.  If not, see http://www.sun.com/cddl/cddl.html

# 2023 https://www.bananas-playground.net


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


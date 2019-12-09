#!/bin/bash
#
# Move the current window to the next monitor.
#
# original code from:
# https://unix.stackexchange.com/questions/48456/xfce-send-window-to-other-monitor-on-keystroke/322904#322904

# run script with -r or -l as a keyboard shurtcut and the current active window will be moved.
# works with horizontal monitors. Needs to be improved to work with vertical ones.
# change MONITOR_COUNT below to your needs.

# needs the following applications
# xdpyinfo
# xdotool
# xprop
# wmctrl
# xwininfo

# This program is free software: you can redistribute it and/or modify
# it under the terms of the COMMON DEVELOPMENT AND DISTRIBUTION LICENSE
#
# You should have received a copy of the
# COMMON DEVELOPMENT AND DISTRIBUTION LICENSE (CDDL) Version 1.0
# along with this program.  If not, see http://www.sun.com/cddl/cddl.html

# 2018-2019 http://www.bananas-playground.net


# set this variable to your monitor count
MONITOR_COUNT=3;

screen_width=$(xdpyinfo | awk -F" |x" '/dimensions:/ { print $7 }')
screen_height=$(xdpyinfo | awk -F" |x" '/dimensions:/ { print $8 }')
window_id=$(xdotool getactivewindow)

case $1 in
    -l )
        display_width=$((screen_width / MONITOR_COUNT * 2)) ;;
    -r )
        display_width=$((screen_width / MONITOR_COUNT)) ;;
esac

# Remember if it was maximized.
window_state=$(xprop -id $window_id _NET_WM_STATE | awk '{ print $3 }')

# Un-maximize current window so that we can move it
wmctrl -ir $window_id -b remove,maximized_vert,maximized_horz

# Read window position
x=$(xwininfo -id $window_id | awk '/Absolute upper-left X:/ { print $4 }')
y=$(xwininfo -id $window_id | awk '/Absolute upper-left Y:/ { print $4 }')

# Subtract any offsets caused by window decorations and panels
x_offset=$(xwininfo -id $window_id | awk '/Relative upper-left X:/ { print $4 }')
y_offset=$(xwininfo -id $window_id | awk '/Relative upper-left Y:/ { print $4 }')
x=$((x - x_offset))
y=$((y - y_offset))

# Fix Chromium app view issue of small un-maximized size
width=$(xdotool getwindowgeometry $window_id | awk -F" |x" '/Geometry:/ { print $4 }')
if [ "$width" -lt "150" ]; then
  display_width=$((display_width + 150))
fi

# Compute new X position
new_x=$((x + display_width))
# Compute new Y position
new_y=$((y + screen_height))

# If we would move off the right-most monitor, we set it to the left one.
# We also respect the window's width here: moving a window off more than half its width won't happen.
if [ $((new_x + width / 2)) -gt $screen_width ]; then
  new_x=$((new_x - screen_width))
fi

height=$(xdotool getwindowgeometry $window_id | awk -F" |x" '/Geometry:/ { print $5 }')
if [ $((new_y + height / 2)) -gt $screen_height ]; then
  new_y=$((new_y - screen_height))
fi

# Don't move off the left side.
if [ $new_x -lt 0 ]; then
  new_x=0
fi

# Don't move off the bottom
if [ $new_y -lt 0 ]; then
  new_y=0
fi

# Move the window
xdotool windowmove $window_id $new_x $new_y

# Maintain if window was maximized or not
if [ "${window_state}" = "_NET_WM_STATE_MAXIMIZED_HORZ," ]; then
    wmctrl -ir $window_id -b add,maximized_vert,maximized_horz
fi

#!/bin/bash

# Center the current actve window based on screen and window size
# create a kyboard shortcut to execute the script

# needs the following applications
# xdotool
# xdpyinfo

# This program is free software: you can redistribute it and/or modify
# it under the terms of the COMMON DEVELOPMENT AND DISTRIBUTION LICENSE
#
# You should have received a copy of the
# COMMON DEVELOPMENT AND DISTRIBUTION LICENSE (CDDL) Version 1.0
# along with this program.  If not, see http://www.sun.com/cddl/cddl.html

# 2019 https://www.bananas-playground.net

screenWidth=$(xdpyinfo | awk -F" |x" '/dimensions:/ { print $7 }')
screenHeight=$(xdpyinfo | awk -F" |x" '/dimensions:/ { print $8 }')
window_id=$(xdotool getactivewindow)

width=$(xdotool getwindowgeometry $window_id | awk -F" |x" '/Geometry:/ { print $4 }')
height=$(xdotool getwindowgeometry $window_id | awk -F" |x" '/Geometry:/ { print $5 }')

newPosX=$((screenWidth/2-width/2))
newPosY=$((screenHeight/2-height/2))

xdotool getactivewindow windowmove "$newPosX" "$newPosY"
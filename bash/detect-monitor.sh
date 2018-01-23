#!/usr/bin/env bash

# detect on which monitor the current active window is
# limitation are with negative position coordinates.

# needs the following applications
# xdotool
# xwininfo
# xrandr

# This program is free software: you can redistribute it and/or modify
# it under the terms of the COMMON DEVELOPMENT AND DISTRIBUTION LICENSE
#
# You should have received a copy of the
# COMMON DEVELOPMENT AND DISTRIBUTION LICENSE (CDDL) Version 1.0
# along with this program.  If not, see http://www.sun.com/cddl/cddl.html

# 2018 http://www.bananas-playground.net

OFFSET_RE="[\+\-]([-0-9]+)[\+\-]([-0-9]+)"

# Get the window position
window_id=$(xdotool getactivewindow)
posx=$(xwininfo -id $window_id | awk '/Absolute upper-left X:/ { print $4 }')
posy=$(xwininfo -id $window_id | awk '/Absolute upper-left Y:/ { print $4 }')

# Subtract any offsets caused by window decorations and panels
x_offset=$(xwininfo -id $window_id | awk '/Relative upper-left X:/ { print $4 }')
y_offset=$(xwininfo -id $window_id | awk '/Relative upper-left Y:/ { print $4 }')
posx=$((posx - x_offset))
posy=$((posy - y_offset))

# Loop through each screen and compare the offset with the window
# coordinates.
while read name width height xoff yoff
do
  if [ "$posx" -ge "$xoff" \
    -a "$posy" -ge "$yoff" \
    -a "$posx" -lt "$(($xoff+$width))" \
    -a "$posy" -lt "$(($yoff+$height))" ]
  then
    monitor=$name   
  fi
done < <(xrandr | grep -w connected |
  sed -r "s/^([^ ]*).*\b([-0-9]+)x([-0-9]+)$OFFSET_RE.*$/\1 \2 \3 \4 \5/" |
  sort -nk4,5)

# If we found a monitor, echo it out, otherwise print an error.
if [ ! -z "$monitor" ]
then
  echo $monitor
  exit 0
else
  echo "Couldn't find any monitor for the current window." >&2
  echo "Or the top left pos is moved out of the screen and thus a negative pos." >&2
  exit 1
fi

#!/bin/bash

# Simple example how to detect if a command is available
# otherwise print message and exit

# This program is free software: you can redistribute it and/or modify
# it under the terms of the COMMON DEVELOPMENT AND DISTRIBUTION LICENSE
#
# You should have received a copy of the
# COMMON DEVELOPMENT AND DISTRIBUTION LICENSE (CDDL) Version 1.0
# along with this program.  If not, see http://www.sun.com/cddl/cddl.html

# 2019 https://www.bananas-playground.net

# In this example we need curl to be iinstalled.
# If not print message and exit.
command -v curl >/dev/null 2>&1 || { echo >&2 "I require curl (https://curl.haxx.se/) but it's not installed.  Aborting."; exit 1; }

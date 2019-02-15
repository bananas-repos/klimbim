#!/bin/bash

# This program is free software: you can redistribute it and/or modify
# it under the terms of the COMMON DEVELOPMENT AND DISTRIBUTION LICENSE
#
# You should have received a copy of the
# COMMON DEVELOPMENT AND DISTRIBUTION LICENSE (CDDL) Version 1.0
# along with this program.  If not, see http://www.sun.com/cddl/cddl.html

# 2019 http://www.bananas-playground.net


# last month problem
# info date
# The fuzz in units can cause problems with relative items.
# For example, `2003-07-31 -1 month' might evaluate to 2003-07-01,
# because 2003-06-31 is an invalid date.
# To determine the previous month more reliably, you can ask for the month before the 15th of the current month.

LAST_MONTH=`date -d "$(date +%Y-%m-15) -1 month" +%Y-%m`

echo $LAST_MONTH

exit 0;
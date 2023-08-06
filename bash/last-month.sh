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
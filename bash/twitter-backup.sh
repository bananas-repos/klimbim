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

# 2011 http://www.bananas-playground.net
# this script should be run with a cronjob once a day to get the rss streem for the given screenname

# the current date in YYYY-m-d format
# more information with "man date"
curDay=`date +%F`;

# replace the SCREENNAME with the twitter name
wget -q --output-document=/path/to/twitter-name_$curDay.rss "http://api.twitter.com/1/statuses/user_timeline.rss?screen_name=SCREENNAME"

exit 0;

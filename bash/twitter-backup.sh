#!/bin/bash

# This program is free software: you can redistribute it and/or modify
# it under the terms of the COMMON DEVELOPMENT AND DISTRIBUTION LICENSE
#
# You should have received a copy of the
# COMMON DEVELOPMENT AND DISTRIBUTION LICENSE (CDDL) Version 1.0
# along with this program.  If not, see http://www.sun.com/cddl/cddl.html

# 2011 https://github.com/jumpin-banana


# this script should be run with a cronjob once a day to get the rss streem for the given screenname

# the current date in YYYY-m-d format
# more information with "man date"
curDay=`date +%F`;

# replace the SCREENNAME with the twitter name
wget -q --output-document=/path/to/twitter-name_$curDay.rss "http://api.twitter.com/1/statuses/user_timeline.rss?screen_name=SCREENNAME"

exit 0;

#!/bin/sh

# This program is free software: you can redistribute it and/or modify
# it under the terms of the COMMON DEVELOPMENT AND DISTRIBUTION LICENSE
#
# You should have received a copy of the
# COMMON DEVELOPMENT AND DISTRIBUTION LICENSE (CDDL) Version 1.0
# along with this program.  If not, see http://www.sun.com/cddl/cddl.html

# 2011 https://github.com/jumpin-banana

#
# wait for user input with either Y or y to proceed
# proceed without any delay
# if not then exit
#

read -p "Are you sure? (Y/y) " -n 1
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

# do something
echo "asdasd";

exit 1;

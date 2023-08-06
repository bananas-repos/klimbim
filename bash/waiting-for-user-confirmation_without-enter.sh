#!/bin/sh

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

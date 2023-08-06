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

# 2020
# this example show how to search multiple repos in the current
# directory. Use this to create your own command and search.

for d in */; do
  git -C "$d" --no-pager rev-list --all | xargs git -C "$d" --no-pager grep -l SEARCHTERM >> search.log;
done;
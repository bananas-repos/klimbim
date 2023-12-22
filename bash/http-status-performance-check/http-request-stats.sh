#!/bin/bash
set -euo pipefail

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

# use this to get make a simple http call and get some stats about it.
# see https://curl.se/docs/manpage.html about the --write-out <format> of http-request-stats-format.txt

echo "$(date "+%F %T")" "$(curl -w "@/path/to/http-request-stats-format.txt" -o /dev/null -s "https://www.domain-to-check.tld/path")" >> /path/to/result.txt

:: utf8filenamecheck Check if all the filenames in a fiven folder are UTF-8
:: Copyright (C) 2023  Johannes 'Banana' Keﬂler
:: 
:: This program is free software: you can redistribute it and/or modify
:: it under the terms of the GNU General Public License as published by
:: the Free Software Foundation, either version 3 of the License, or
:: (at your option) any later version.
:: 
:: This program is distributed in the hope that it will be useful,
:: but WITHOUT ANY WARRANTY; without even the implied warranty of
:: MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
:: GNU General Public License for more details.
:: 
:: You should have received a copy of the GNU General Public License
:: along with this program.  If not, see <https://www.gnu.org/licenses/>.
@echo off
cls
gcc -std=c99 -march=native -O3 -Wall -Iargtable/ -Isimdutf8check/ utf8filenamecheck.c argtable/argtable3.c -o bin/utf8filenamecheck.exe
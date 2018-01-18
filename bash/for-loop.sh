#!/bin/bash

# This program is free software: you can redistribute it and/or modify
# it under the terms of the COMMON DEVELOPMENT AND DISTRIBUTION LICENSE
#
# You should have received a copy of the
# COMMON DEVELOPMENT AND DISTRIBUTION LICENSE (CDDL) Version 1.0
# along with this program.  If not, see http://www.sun.com/cddl/cddl.html

# 2011 http://www.bananas-playground.net

#Hier eine Schleife die für jede Ausgabe vom dem Befehl in `` eine Aktion ausführt.
#Hier gibt sie jeden Ordner in dem Aktuellen Verzeichnis aus.

for dir in `find . -mindepth 1 -maxdepth 1 -type d`; do
	echo $dir;
done;
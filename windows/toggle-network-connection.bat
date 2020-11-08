:: This program is free software: you can redistribute it and/or modify
:: it under the terms of the COMMON DEVELOPMENT AND DISTRIBUTION LICENSE
:: You should have received a copy of the
:: COMMON DEVELOPMENT AND DISTRIBUTION LICENSE (CDDL) Version 1.0
:: along with this program.  If not, see http://www.sun.com/cddl/cddl.html
::
:: 2020 http://91.132.146.200:3000/Banana/klimbim
:: 
:: Use this script for windows to toggle your network connection
:: Replace Ethernet with the name of your network connection and execute
:: this with admin priviliges
::
@echo off
cls
ping google.com
IF ERRORLEVEL 1 goto ACTIVATE
IF ERRORLEVEL 0 goto DEACTIVATE

:ACTIVATE
netsh interface set interface "Ethernet" admin=enable
exit

:DEACTIVATE
netsh interface set interface "Ethernet" admin=disable
exit

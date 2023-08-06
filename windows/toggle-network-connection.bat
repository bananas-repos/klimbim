:: Klimbim Software collection, A bag full of things
:: Copyright (C) 2011-2023 Johannes 'Banana' Keßler
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
::You should have received a copy of the GNU General Public License
::along with this program.  If not, see <https://www.gnu.org/licenses/>.
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

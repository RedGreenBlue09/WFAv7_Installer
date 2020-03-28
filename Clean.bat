@echo off
cd /D "%~dp0"
del diskpart.txt>nul
del diskpart1.txt>nul
del diskpart2.txt>nul

set /p CYN=Do you want to delete Drivers folder? (Y/N) 
if "%CYN%"=="" goto ChooseDev
if %CYN%==Y rd /s /q Drivers\
if %CYN%==y rd /s /q Drivers\
if %CYN%==N exit
if %CYN%==n exit

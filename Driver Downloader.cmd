@echo off
cd /D "%~dp0"
for /f "tokens=3" %%a in ('Reg Query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild ^| findstr /ri "REG_SZ"') do set WinBuild=%%a
if %WinBuild% LSS 9600 (
	title ERROR!
	color 0c
	echo ----------------------------------------------------------------
	echo   This Windows version is not supported by WFAv7 Installer.
	echo   Please use Windows 8.1+ ^(Build 9600+^) 
	echo   Current OS build: %WinBuild%
	pause
	exit
)

if %WinBuild% LSS 10586 (
	if %PROCESSOR_ARCHITECTURE% EQU x86 Files\ansicon32 -p
	if %PROCESSOR_ARCHITECTURE% EQU AMD64 Files\ansicon64 -p
)
title WFAv7 Driver Downloader 3.6
set "ESC="

:ChooseDev
cd /D "%~dp0"
set Model=
cls
color 0f
echo  %ESC%[93m//////////////////////////////////////////////////////////////////////////////////////////////
echo  //                               %ESC%[97mWFAv7 Driver Downloader 3.6%ESC%[93m                                //
echo  //                                   %ESC%[97mby RedGreenBlue123%ESC%[93m                                     //
echo  //////////////////////////////////////////////////////////////////////////////////////////////%ESC%[92m
echo.
echo Choose your Device Model below%ESC%[32m:
echo  %ESC%[36m1)%ESC%[97m Lumia 930
echo  %ESC%[36m2)%ESC%[97m Lumia 929 (Icon)
echo  %ESC%[36m3)%ESC%[97m Lumia 1520
echo  %ESC%[36m4)%ESC%[97m Lumia 1520 AT^&T
echo  %ESC%[36m5)%ESC%[97m Lumia 830 Global
echo  %ESC%[36m6)%ESC%[97m Lumia 735 Global
echo  %ESC%[36m7)%ESC%[97m Lumia 640 XL LTE Global
echo  %ESC%[36m8)%ESC%[97m Lumia 640 XL LTE AT^&T
echo  %ESC%[36mA)%ESC%[97m Lumia 920
echo  %ESC%[36mB)%ESC%[97m Lumia 1020
echo  %ESC%[36mC)%ESC%[97m Lumia 1020 AT^&T

set /p "Model=%ESC%[92mDevice%ESC%[92m: %ESC%[0m"
if not defined Model goto ChooseDev
set "Model=%Model:"=%"

if "%Model%" EQU "1" (goto DoDownload)
if "%Model%" EQU "2" (goto DoDownload)
if "%Model%" EQU "3" (goto DoDownload)
if "%Model%" EQU "4" (goto DoDownload)
if "%Model%" EQU "5" (goto DoDownload)
if "%Model%" EQU "6" (goto DoDownload)
if "%Model%" EQU "7" (goto DoDownload)
if "%Model%" EQU "8" (goto DoDownload)
if /I "%Model%" EQU "A" (goto DoDownload)
if /I "%Model%" EQU "B" (goto DoDownload)
if /I "%Model%" EQU "C" (goto DoDownload)
goto ChooseDev

::------------------------------------------------------------------
:: Constants

:DoDownload

:: Exe

set "SVNLoc=%~dp0\Files\DownloaderFiles\svn"
set "Aria2cLoc=%~dp0\Files\DownloaderFiles\aria2c"

cls
color 0b

:: Get latest release
::set "Tag=v2111.1"
::goto Models

echo Getting release tags ...

for /f "usebackq" %%A in (`"%SVNLoc%" ls https://github.com/WOA-Project/Lumia-Drivers/tags/`) do (
	set "Tag=%%A"
)
set "Tag=%Tag:~0,-1%"
:: Remove / at the end

: Models

set "RepoSvnLink=https://github.com/WOA-Project/Lumia-Drivers/tags/%Tag%"
set "DefDirLink=https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/%Tag%/definitions"

if "%Model%" EQU "1" (
	set "DrvDir=Lumia930"
	set "DefLink=%DefDirLink%/930.txt"
	set "Def=930.txt"
)
if "%Model%" EQU "2" (
	set "DrvDir=LumiaIcon"
	set "DefLink=%DefDirLink%/icon.txt"
	set "Def=icon.txt"
)
if "%Model%" EQU "3" (
	set "DrvDir=Lumia1520"
	set "DefLink=%DefDirLink%/1520upsidedown.txt"
	set "Def=1520upsidedown.txt"
)
if "%Model%" EQU "4" (
	set "DrvDir=Lumia1520-AT&T"
	set "DefLink=%DefDirLink%/1520attupsidedown.txt"
	set "Def=1520attupsidedown.txt"
)
if "%Model%" EQU "5" (
	set "DrvDir=Lumia830"
	set "DefLink=%DefDirLink%/830.txt"
	set "Def=830.txt"
)
if "%Model%" EQU "6" (
	set "DrvDir=Lumia735"
	set "DefLink=%DefDirLink%/735.txt"
	set "Def=735.txt"
)
if "%Model%" EQU "7" (
	set "DrvDir=Lumia640XL"
	set "DefLink=%DefDirLink%/640xl.txt"
	set "Def=640xl.txt"
)
if "%Model%" EQU "8" (
	set "DrvDir=Lumia640XL-AT&T"
	set "DefLink=%DefDirLink%/640xlatt.txt"
	set "Def=640xlatt.txt"
)
if /I "%Model%" EQU "A" (
	set "DrvDir=Lumia920"
	set "DefLink=%DefDirLink%/920.txt"
	set "Def=920.txt"
)
if /I "%Model%" EQU "B" (
	set "DrvDir=Lumia1020"
	set "DefLink=%DefDirLink%/1020.txt"
	set "Def=1020.txt"
)
if /I "%Model%" EQU "C" (
	set "DrvDir=Lumia1020-AT&T"
	set "DefLink=%DefDirLink%/1020att.txt"
	set "Def=1020att.txt"
)

::------------------------------------------------------------------
:: Download

setlocal EnableDelayedExpansion

:: README

if not exist Drivers\ mkdir Drivers
cd Drivers\
if not exist README.md "%Aria2cLoc%" -q "https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/%Tag%/README.md"

:: Delete old drivers

set "Errors=0"
if exist !DrvDir!\ (
	echo Removing old drivers ...
	rd /s /q !DrvDir!\
)

:: Download drivers

md !DrvDir!
echo Downloading definition file ...
"%Aria2cLoc%" -q -d "!DrvDir!" "%DefLink%"

for /f "tokens=*" %%A in (!DrvDir!\!Def!) do (
	set Drv=%%A
	set DrvLink=!Drv:\=/!
	title Downloading "!Drv!" package ...
	echo Downloading "!Drv!" package ...
	"%SVNLoc%" export "%RepoSvnLink%!DrvLink!" "!DrvDir!\!Drv!">nul
	if %ErrorLevel% NEQ 0 (
		set /a "Errors+=1"
	)
)

:: Reset

set "DrvDir="
set "DefLink="
set "Def="

echo.
color 0a
echo Download completed with %Errors% error(s).
pause
goto ChooseDev

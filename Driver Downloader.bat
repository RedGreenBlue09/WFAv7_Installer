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
echo Installer is loading ... [100%%]
if %WinBuild% LSS 10586 (
	if %PROCESSOR_ARCHITECTURE% EQU x86 Files\ansicon32 -p
	if %PROCESSOR_ARCHITECTURE% EQU AMD64 Files\ansicon64 -p
)
title WFAv7 Driver Downloader 2.4
Files\cmdresize 96 24 96 2000
set "ESC="

:: Constants
set "SVNLoc=%~dp0\Files\DownloaderFiles\svn"
set "WGETLoc=%~dp0\Files\DownloaderFiles\wget"
set "SzLoc=%~dp0\Files\DownloaderFiles\7za"
set "RepoSvnLink=https://github.com/WOA-Project/Lumia-Drivers/trunk"
set "DefDirLink=https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/main/definitions"

:ChooseDev
cd /D "%~dp0"
set Model=
cls
color 0f
echo  %ESC%[93m//////////////////////////////////////////////////////////////////////////////////////////////
echo  //                               %ESC%[97mWFAv7 Driver Downloader 3.1%ESC%[93m                                //
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
echo  %ESC%[36mD)%ESC%[97m Lumia 950
echo  %ESC%[36mE)%ESC%[97m Lumia 950 XL
set /p Model=%ESC%[92mDevice%ESC%[92m: %ESC%[0m
if "%Model%" EQU "" goto ChooseDev

::------------------------------------------------------------------

cls
color 0b
setlocal EnableDelayedExpansion
if not exist Drivers\ mkdir Drivers
cd Drivers\
if not exist README.md "%WGETLoc%" https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/main/README.md --no-check-certificate -OReadme.md >nul 2>&1

::------------------------------------------------------------------

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
if /I "%Model%" EQU "D" (
	set "DrvDir=Lumia950"
	set "DefLink=%DefDirLink%/Desktop/ARM32/Internal/950.txt"
	set "Def=950.txt"
)
if /I "%Model%" EQU "E" (
	set "DrvDir=Lumia950XL"
	set "DefLink=%DefDirLink%/Desktop/ARM32/Internal/950xl.txt"
	set "Def=950xl.txt"
)

::------------------------------------------------------------------

if exist !DrvDir!\ (
	echo Removing old drivers ...
	rd /s /q !DrvDir!\
)
echo Downloading definition file ...
"%WGETLoc%" %DefLink% --no-check-certificate -O!Def! >nul 2>&1
for /F "tokens=*" %%A IN (!Def!) do (
	set Drv=%%A
	set DrvLink=!Drv:\=/!
	title Downloading "!Drv!" package ...
	echo Downloading "!Drv!" package ...
	"%SVNLoc%" export "%RepoSvnLink%!DrvLink!" "!DrvDir!\!Drv!">nul
)

set "DrvDir="
set "DefLink="
set "Def="

echo.
color 0a
echo Downloading Drivers Done^^!
pause
goto ChooseDev

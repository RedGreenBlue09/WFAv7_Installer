:: This file is licensed under the Microsoft Reciprocal License (MS-RL).
:: A copy of this license is provided in the file LICENSE-SCRIPTS.txt.

@echo off
setlocal EnableDelayedExpansion
cd /D "%~dp0"

for /f "tokens=3" %%a in ('Reg Query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild ^| findstr /r /i "REG_SZ"') do set "WinBuild=%%a"
if %WinBuild% LSS 10586 (
	Files\ansicon_%PROCESSOR_ARCHITECTURE% -p
)

title WFAv7 Driver Downloader 3.8
set "ESC="

::------------------------------------------------------------------
:ChooseDev
set "Model="
cls
color 0f
echo  %ESC%[93m//////////////////////////////////////////////////////////////////////////////////////////////
echo  //                               %ESC%[97mWFAv7 Driver Downloader 3.8%ESC%[93m                                //
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
echo  %ESC%[36m7)%ESC%[97m Lumia 650
echo  %ESC%[36m8)%ESC%[97m Lumia 640 XL LTE Global
echo  %ESC%[36m9)%ESC%[97m Lumia 640 XL LTE AT^&T
echo  %ESC%[36mA)%ESC%[97m Lumia 520
echo  %ESC%[36mB)%ESC%[97m Lumia 920
echo  %ESC%[36mC)%ESC%[97m Lumia 1020
echo  %ESC%[36mD)%ESC%[97m Lumia 1020 AT^&T

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
if "%Model%" EQU "9" (goto DoDownload)
if /I "%Model%" EQU "A" (goto DoDownload)
if /I "%Model%" EQU "B" (goto DoDownload)
if /I "%Model%" EQU "C" (goto DoDownload)
goto ChooseDev

::------------------------------------------------------------------
:DoDownload

set "SVNLoc=%~dp0\Files\DownloaderFiles\svn"
set "Aria2cLoc=%~dp0\Files\DownloaderFiles\aria2c"

cls
color 0f
if not exist Drivers\ md Drivers\

set "Tag=2209.36"
goto Models

echo Getting release tags ...
"%SVNLoc%" ls https://github.com/WOA-Project/Lumia-Drivers/tags/ >Drivers\Tags.txt || (
	del Drivers\Tags.txt
	goto DownloadFailed
)

:: The last line is the latest tag
for /f %%A in (Drivers\Tags.txt) do (
	set "Tag=%%A"
)

:: Remove / at the end
set "Tag=%Tag:~0,-1%"

del Drivers\Tags.txt

:Models

set "RepoSvnLink=https://github.com/WOA-Project/Lumia-Drivers/tags/%Tag%"
set "RepoRawLink=https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/%Tag%"

if "%Model%" EQU "1" (
	set "ModelDir=Lumia930"
	set "DefName=930.txt"
)
if "%Model%" EQU "2" (
	set "ModelDir=LumiaIcon"
	set "DefName=icon.txt"
)
if "%Model%" EQU "3" (
	set "ModelDir=Lumia1520"
	set "DefName=1520upsidedown.txt"
)
if "%Model%" EQU "4" (
	set "ModelDir=Lumia1520-AT&T"
	set "DefName=1520attupsidedown.txt"
)
if "%Model%" EQU "5" (
	set "ModelDir=Lumia830"
	set "DefName=830.txt"
)
if "%Model%" EQU "6" (
	set "ModelDir=Lumia735"
	set "DefName=735.txt"
)
if "%Model%" EQU "7" (
	set "ModelDir=Lumia650"
	set "DefName=650.txt"
)
if "%Model%" EQU "8" (
	set "ModelDir=Lumia640XL"
	set "DefName=640xl.txt"
)
if "%Model%" EQU "9" (
	set "ModelDir=Lumia640XL-AT&T"
	set "DefName=640xlatt.txt"
)
if /I "%Model%" EQU "A" (
	set "ModelDir=Lumia520"
	set "DefName=520.txt"
)
if /I "%Model%" EQU "B" (
	set "ModelDir=Lumia920"
	set "DefName=920.txt"
)
if /I "%Model%" EQU "C" (
	set "ModelDir=Lumia1020"
	set "DefName=1020.txt"
)
if /I "%Model%" EQU "D" (
	set "ModelDir=Lumia1020-AT&T"
	set "DefName=1020att.txt"
)

::------------------------------------------------------------------
:: Download

if exist Drivers\README.md del Drivers\README.md
echo Downloading README.md ...
"%Aria2cLoc%" -q -d Drivers\ "%RepoRawLink%/README.md"

if exist "Drivers\%ModelDir%\" (
	echo Removing old drivers ...
	rd /s /q "Drivers\%ModelDir%\"
)

md "Drivers\%ModelDir%"
echo Downloading definition file ...
"%Aria2cLoc%" -q -d "Drivers\%ModelDir%" "%RepoRawLink%/definitions/%DefName%" || goto DownloadFailed

:: Download each packages

for /f "tokens=* usebackq" %%A in ("Drivers\%ModelDir%\%DefName%") do (
	set "PkgPath=%%A"
	set "PkgLink=!PkgPath:\=/!"
	echo Downloading "!PkgPath!" package ...
	"%SVNLoc%" export "%RepoSvnLink%!PkgLink!" "Drivers\%ModelDir%\!PkgPath!" >nul || goto DownloadFailed
)

color 0a
echo.
echo Drivers have been downloaded successfully.
pause
goto ChooseDev

:DownloadFailed

color 0c
echo.
echo Failed to download drivers.
pause
goto ChooseDev

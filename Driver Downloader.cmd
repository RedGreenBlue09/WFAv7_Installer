:: This file is licensed under the Microsoft Reciprocal License (MS-RL).
:: A copy of this license is provided in the file LICENSE-SCRIPTS.txt.

@echo off
setlocal EnableDelayedExpansion
cd /D "%~dp0"

for /f "tokens=3" %%a in ('Reg Query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild ^| findstr /r /i "REG_SZ"') do set "WinBuild=%%a"
if %WinBuild% LSS 10586 (
	Files\ansicon_%PROCESSOR_ARCHITECTURE% -p
)

title WFAv7 Driver Downloader 4.0
set "ESC="

::------------------------------------------------------------------
:ChooseDev
set "Model="
cls
color 0f
echo  %ESC%[93m//////////////////////////////////////////////////////////////////////////////////////////////
echo  //                               %ESC%[97mWFAv7 Driver Downloader 4.0%ESC%[93m                                //
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
if /I "%Model%" EQU "D" (goto DoDownload)
goto ChooseDev

::------------------------------------------------------------------
:DoDownload

set "RepoLink=https://github.com/WOA-Project/Lumia-Drivers.git"

set "GitPath=%~dp0\Files\DownloaderFiles\Git\cmd\git"

cls
if not exist Drivers\ md Drivers\
if not exist Temp\ md Temp\

echo Fetching latest release tag ...
"%GitPath%" ls-remote --tags "%RepoLink%" >Temp\Tags.txt || (
	del Temp\Tags.txt
	goto DownloadFailed
)

:: The last line is the latest tag
for /f "tokens=2 delims=	" %%A in (Temp\Tags.txt) do (
	set "Tag=%%A"
)
del Temp\Tags.txt

:: Remove refs/tags/
set "Tag=%Tag:~10%"

:: Models

if "%Model%" EQU "1" (
	set "ModelDir=Lumia930"
	set "DefName=930.xml"
)
if "%Model%" EQU "2" (
	set "ModelDir=LumiaIcon"
	set "DefName=icon.xml"
)
if "%Model%" EQU "3" (
	set "ModelDir=Lumia1520"
	set "DefName=1520upsidedown.xml"
)
if "%Model%" EQU "4" (
	set "ModelDir=Lumia1520-AT&T"
	set "DefName=1520attupsidedown.xml"
)
if "%Model%" EQU "5" (
	set "ModelDir=Lumia830"
	set "DefName=830.xml"
)
if "%Model%" EQU "6" (
	set "ModelDir=Lumia735"
	set "DefName=735.xml"
)
if "%Model%" EQU "7" (
	set "ModelDir=Lumia650"
	set "DefName=650.xml"
)
if "%Model%" EQU "8" (
	set "ModelDir=Lumia640XL"
	set "DefName=640xl.xml"
)
if "%Model%" EQU "9" (
	set "ModelDir=Lumia640XL-AT&T"
	set "DefName=640xlatt.xml"
)
if /I "%Model%" EQU "A" (
	set "ModelDir=Lumia520"
	set "DefName=520.xml"
)
if /I "%Model%" EQU "B" (
	set "ModelDir=Lumia920"
	set "DefName=920.xml"
)
if /I "%Model%" EQU "C" (
	set "ModelDir=Lumia1020"
	set "DefName=1020.xml"
)
if /I "%Model%" EQU "D" (
	set "ModelDir=Lumia1020-AT&T"
	set "DefName=1020att.xml"
)

goto Download

::------------------------------------------------------------------
:FilePathOnly
set "MyPath2=%MyPath:/=\%"
set "MyPath2=%MyPath2: =/%"
set "MyPath2="%MyPath2:\=" "%""
set "Output="
set "Output2="
for %%A in (%MyPath2%) do (
	set "Line=%%~A"
	if "!Line!" NEQ "" (
		set "Output=!Output2!"
		set "Output2=!Output2!!Line:/= !\"
	)
)
:: Edge case: trailing slash
if "%Line%" EQU "" set "Output=%Output2%"
goto :EOF

::------------------------------------------------------------------
:Download

if exist "Drivers\%ModelDir%\" (
	echo Removing old drivers ...
	rd /s /q "Drivers\%ModelDir%\"
)

echo.
echo Setting up the repository...
echo.
set "InstallerDir=%~dp0"
set "RepoDir=Drivers\%ModelDir%"
md "%RepoDir%"
"%GitPath%" clone --filter=tree:0 --no-checkout --depth 1 --branch %Tag% "%RepoLink%" "%RepoDir%" || goto DownloadFailed

cd "%RepoDir%"
"%GitPath%" sparse-checkout set --no-cone
"%GitPath%" config core.ignorecase true
"%GitPath%" config core.autocrlf false
cd "%InstallerDir%"

echo.
echo Downloading definition file ...
echo.
cd "%RepoDir%"
echo>".git\info\sparse-checkout" definitions/%DefName% || goto DownloadFailed
"%GitPath%" checkout || goto DownloadFailed
cd "%InstallerDir%"

echo.
echo Enumerating INF files ...
echo.
Files\DownloaderFiles\DriverDefPaths "%RepoDir%\definitions\%DefName%" >Temp\InfList.txt || (
	del Temp\InfList.txt
	goto DownloadFailed
)
for /f "usebackq delims=" %%A in ("Temp\InfList.txt") do (
	set "InfPath=%%A"
	set "InfPath=!InfPath:\=/!"
	echo>>"%RepoDir%\.git\info\sparse-checkout" !InfPath!
)

echo.
echo Downloading INF files ...
echo.
cd "%RepoDir%"
"%GitPath%" checkout || goto DownloadFailed
cd "%InstallerDir%"

echo.
echo Enumerating driver source files ...
echo.
for /f "usebackq delims=" %%A in ("Temp\InfList.txt") do (
	set "MyPath=%%A"
	call :FilePathOnly
	set "InfPathOnly=!Output!"
	
	Files\DownloaderFiles\GetDriverFiles ".\Drivers\%ModelDir%\%%A" >"Temp\DriverSourceList.txt" || (
		del Temp\DriverSourceList.txt
		del Temp\InfList.txt
		goto DownloadFailed
	)
	for /f "usebackq delims=" %%B in ("Temp\DriverSourceList.txt") do (
		set "SourcePath=!InfPathOnly!%%B"
		set "SourcePath=!SourcePath:\=/!"
		echo>>"%RepoDir%\.git\info\sparse-checkout" !SourcePath!
	)
)

if exist "Temp\DriverSourceList.txt" del "Temp\DriverSourceList.txt"
del "Temp\InfList.txt"

echo.
echo Downloading driver source files ...
echo.
cd "%RepoDir%"
"%GitPath%" checkout || goto DownloadFailed
cd "%InstallerDir%"

::------------------------------------------------------------------
rd /s /q "%RepoDir%\.git\"
echo.
echo Drivers have been downloaded successfully.
pause
goto ChooseDev

:DownloadFailed
echo.
echo Failed to download drivers.
pause
goto ChooseDev

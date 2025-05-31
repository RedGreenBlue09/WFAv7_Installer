:: This file is licensed under the Microsoft Reciprocal License (MS-RL).
:: A copy of this license is provided in the file LICENSE-SCRIPTS.txt.

@echo off

set "CurrentDir=%~dp0"
if "%CurrentDir:!=%" NEQ "%CurrentDir%" (
	echo Please remove exclamation marks ^(^!^) from the current path.
	pause
	exit /B
)

setlocal EnableDelayedExpansion
cd /D "%~dp0"

for /f "tokens=3" %%a in ('Reg Query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild ^| findstr /r /i "REG_SZ"') do set "WinBuild=%%a"
if %WinBuild% LSS 10586 (
	Files\ansicon_%PROCESSOR_ARCHITECTURE% -p
)

title WFAv7 Driver Downloader 4.3
color 0f
set "ESC="
goto ChooseDev

::---------------------------------------------------------------
:PrintLabel
echo  %ESC%[93m//////////////////////////////////////////////////////////////////////////////////////////////
echo  //                               %ESC%[97mWFAv7 Driver Downloader 4.3%ESC%[93m                                //
echo  //                                   %ESC%[97mby RedGreenBlue123%ESC%[93m                                     //
echo  //////////////////////////////////////////////////////////////////////////////////////////////%ESC%[92m
echo.
goto :EOF

::------------------------------------------------------------------
:ChooseDev
set "Model="
set "Generic="
cls
call :PrintLabel
echo %ESC%[92mChoose your device model below:
echo  %ESC%[36m1) %ESC%[97mLumia 1520
echo  %ESC%[36m2) %ESC%[97mLumia 930
echo  %ESC%[36m3) %ESC%[97mLumia 929 (Icon)
echo  %ESC%[36m4) %ESC%[97mLumia 830 Global
echo  %ESC%[36m5) %ESC%[97mLumia 735 Global
echo  %ESC%[36m6) %ESC%[97mLumia 650
echo  %ESC%[36m7) %ESC%[97mLumia 640 / 640 XL
echo  %ESC%[36m8) %ESC%[97mLumia 550
echo  %ESC%[36m9) %ESC%[97mLumia 1020
echo  %ESC%[36mA) %ESC%[97mLumia 920
echo  %ESC%[36mB) %ESC%[97mLumia 520
echo  %ESC%[36mC) %ESC%[97mGeneric INF
set /p "Model=%ESC%[92mDevice:%ESC%[0m "
if not defined Model goto ChooseDev
set "Model=%Model:"=%"

if "%Model%" EQU "1" (goto ChooseDev1520)
if "%Model%" EQU "2" (set "ModelDir=Lumia930"  & set "DefName=930.xml"  & goto DoDownload)
if "%Model%" EQU "3" (set "ModelDir=LumiaIcon" & set "DefName=icon.xml" & goto DoDownload)
if "%Model%" EQU "4" (set "ModelDir=Lumia830"  & set "DefName=830.xml"  & goto DoDownload)
if "%Model%" EQU "5" (set "ModelDir=Lumia735"  & set "DefName=735.xml"  & goto DoDownload)
if "%Model%" EQU "6" (set "ModelDir=Lumia650"  & set "DefName=650.xml"  & goto DoDownload)
if "%Model%" EQU "7" (goto ChooseDev640)
if "%Model%" EQU "8" (set "ModelDir=Lumia550"  & set "DefName=550.xml"  & goto DoDownload)
if "%Model%" EQU "9" (goto ChooseDev1020)
if /i "%Model%" EQU "A" (set "ModelDir=Lumia920"  & set "DefName=920.xml"  & goto DoDownload)
if /i "%Model%" EQU "B" (set "ModelDir=Lumia520" & set "DefName=520.xml" & goto DoDownload)
if /i "%Model%" EQU "C" (goto ChooseDevGenericINF)
goto ChooseDev

:ChooseDev1520
set "Model="
cls
call :PrintLabel
echo %ESC%[92mChoose your device variant below:
echo  %ESC%[36m1) %ESC%[97mLumia 1520 Global
echo  %ESC%[36m2) %ESC%[97mLumia 1520 AT^&T
set /p "Model=%ESC%[92mDevice:%ESC%[0m "
if not defined Model goto ChooseDev1520
set "Model=%Model:"=%"

if "%Model%" EQU "1" (set "ModelDir=Lumia1520"      & set "DefName=1520upsidedown.xml"    & goto DoDownload)
if "%Model%" EQU "2" (set "ModelDir=Lumia1520-AT&T" & set "DefName=1520attupsidedown.xml" & goto DoDownload)
goto ChooseDev1520


:ChooseDev640
set "Model="
cls
call :PrintLabel
echo %ESC%[92mChoose your device variant below:
echo  %ESC%[36m1) %ESC%[97mLumia 640 3G
echo  %ESC%[36m2) %ESC%[97mLumia 640 LTE
echo  %ESC%[36m3) %ESC%[97mLumia 640 XL 3G
echo  %ESC%[36m4) %ESC%[97mLumia 640 XL LTE Global
echo  %ESC%[36m5) %ESC%[97mLumia 640 XL LTE AT^&T
set /p "Model=%ESC%[92mDevice:%ESC%[0m "
if not defined Model goto ChooseDev640
set "Model=%Model:"=%"

if "%Model%" EQU "1" (set "ModelDir=Lumia640-3G"     & set "DefName=640ds.xml"    & goto DoDownload)
if "%Model%" EQU "2" (set "ModelDir=Lumia640-LTE"    & set "DefName=640lte.xml"   & goto DoDownload)
if "%Model%" EQU "3" (set "ModelDir=Lumia640XL-3G"   & set "DefName=640xlds.xml"  & goto DoDownload)
if "%Model%" EQU "4" (set "ModelDir=Lumia640XL-LTE"  & set "DefName=640xl.xml"    & goto DoDownload)
if "%Model%" EQU "5" (set "ModelDir=Lumia640XL-AT&T" & set "DefName=640xlatt.xml" & goto DoDownload)
goto ChooseDev640

:ChooseDev1020
set "Model="
cls
call :PrintLabel
echo %ESC%[92mChoose your device variant below:
echo  %ESC%[36m1) %ESC%[97mLumia 1020 Global
echo  %ESC%[36m2) %ESC%[97mLumia 1020 AT^&T
set /p "Model=%ESC%[92mDevice:%ESC%[0m "
if not defined Model goto ChooseDev1020
set "Model=%Model:"=%"

if "%Model%" EQU "1" (set "ModelDir=Lumia1020"       & set "DefName=1020.xml"     & goto DoDownload)
if "%Model%" EQU "2" (set "ModelDir=Lumia1020-AT&T"  & set "DefName=1020att.xml"  & goto DoDownload)
goto ChooseDev1020

:ChooseDevGenericInf
set "Model="
cls
call :PrintLabel
echo %ESC%[92mChoose your device variant below (you need at least 8 GB of internal storage):
echo  %ESC%[36m1) %ESC%[97mLumia 635, 636, 638
echo  %ESC%[36m2) %ESC%[97mLumia 630, 730
echo  %ESC%[36m3) %ESC%[97mLumia 435, 532, 540
echo  %ESC%[36m4) %ESC%[97mLumia 820, 822, 925
echo  %ESC%[36m5) %ESC%[97mLumia 521, 525, 526, 620, 625, 720, 1320
set /p "Model=%ESC%[92mDevice:%ESC%[0m "
if not defined Model goto ChooseDevGenericInf
set "Model=%Model:"=%"

set "Generic=1"
if "%Model%" EQU "1" (set "ModelDir=Generic8926" & set "DefName=generic8926.xml" & goto DoDownload)
if "%Model%" EQU "2" (set "ModelDir=Generic8226" & set "DefName=generic8226.xml" & goto DoDownload)
if "%Model%" EQU "3" (set "ModelDir=Generic8212" & set "DefName=generic8212.xml" & goto DoDownload)
if "%Model%" EQU "4" (set "ModelDir=Generic8960" & set "DefName=generic8960.xml" & goto DoDownload)
if "%Model%" EQU "5" (set "ModelDir=Generic8930" & set "DefName=generic8930.xml" & goto DoDownload)
goto ChooseDevGenericInf

::------------------------------------------------------------------
:DoDownload

:: set "RepoLink=https://github.com/WOA-Project/Lumia-Drivers.git"
if defined Generic (
	set "RepoLink=https://github.com/RedGreenBlue09/LumiaGenericDrivers.git"
) else (
	set "RepoLink=https://github.com/bibarub/Lumia-Drivers.git"
)

set "GitPath=%~dp0\Files\DriverDownloader\Git\cmd\git"

cls
if not exist Drivers\ md Drivers\
if not exist Temp\ md Temp\

:: TEMP
if not defined Generic (
	set "Tag=test"
	goto DoDownload2
)

echo Fetching latest release tag ...
"%GitPath%" ls-remote --tags "%RepoLink%" > Temp\Tags.txt || (
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

::------------------------------------------------------------------
:DoDownload2
set "InstallerDir=%~dp0"
set "RepoDir=%InstallerDir%\Drivers\%ModelDir%"

if exist "%RepoDir%\" (
	echo Removing old drivers ...
	rd /s /q "%RepoDir%"
)

echo.
echo Setting up the repository...
echo.
md "%RepoDir%"
"%GitPath%" clone --filter=tree:0 --no-checkout --depth 1 --branch %Tag% "%RepoLink%" "%RepoDir%" || goto DownloadFailed

"%GitPath%" -C "%RepoDir%" sparse-checkout set --no-cone
"%GitPath%" -C "%RepoDir%" config core.ignorecase true
"%GitPath%" -C "%RepoDir%" config core.autocrlf false

::------------------------------------------------------------------
echo.
echo Downloading definition file ...
echo.
echo definitions/%DefName% > "%RepoDir%\.git\info\sparse-checkout" || goto DownloadFailed
"%GitPath%" -C "%RepoDir%" checkout || goto DownloadFailed

echo.
echo Enumerating INF files ...
echo.
Files\DriverDownloader\DriverDefPaths "%RepoDir%\definitions\%DefName%" > Temp\InfList.txt || (
	del Temp\InfList.txt
	goto DownloadFailed
)
for /f "usebackq delims=" %%A in ("Temp\InfList.txt") do (
	set "InfPath=%%A"
	set "InfPath=!InfPath:\=/!"
	echo !InfPath! >> "%RepoDir%\.git\info\sparse-checkout"
)

echo.
echo Downloading INF files ...
echo.
"%GitPath%" -C "%RepoDir%" checkout || goto DownloadFailed

::------------------------------------------------------------------
echo.
echo Enumerating driver source files ...
echo.
for /f "usebackq delims=" %%A in ("Temp\InfList.txt") do (
	set "MyPath=%%A"
	call :FilePathOnly
	set "InfPathOnly=!Output!"
	
	Files\DriverDownloader\GetDriverFiles ".\Drivers\%ModelDir%\%%A" > "Temp\DriverSourceList.txt" || (
		del Temp\DriverSourceList.txt
		del Temp\InfList.txt
		goto DownloadFailed
	)
	for /f "usebackq delims=" %%B in ("Temp\DriverSourceList.txt") do (
		set "SourcePath=!InfPathOnly!%%B"
		set "SourcePath=!SourcePath:\=/!"
		echo !SourcePath! >> "%RepoDir%\.git\info\sparse-checkout"
	)
)

if exist "Temp\DriverSourceList.txt" del "Temp\DriverSourceList.txt"
del "Temp\InfList.txt"

echo.
echo Downloading driver source files ...
echo.
"%GitPath%" -C "%RepoDir%" checkout || goto DownloadFailed

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

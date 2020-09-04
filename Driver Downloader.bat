@echo off
cd /D "%~dp0"
for /f "tokens=3" %%a in ('Reg Query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild ^| findstr /ri "REG_SZ"') do set WinBuild=%%a
if %WinBuild% LSS 9600 (
	title ERROR!
	color 0c
	echo ----------------------------------------------------------------
	echo   This Windows version is not supported by WFAv7 Installer.
	echo   Please use Windows 8.1 Pro+ ^(Build 9600+^) 
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
:ChooseDev
cd /D "%~dp0"
set Model=
cls
color 0f
echo  %ESC%[93m//////////////////////////////////////////////////////////////////////////////////////////////
echo  //                               %ESC%[97mWFAv7 Driver Downloader 2.4%ESC%[93m                                //
echo  //                                   %ESC%[97mby RedGreenBlue123%ESC%[93m                                     //
echo  //////////////////////////////////////////////////////////////////////////////////////////////%ESC%[92m
echo.
echo Choose your Device Model below%ESC%[32m:
echo  %ESC%[36m1)%ESC%[97m Lumia 930
echo  %ESC%[36m2)%ESC%[97m Lumia 929 (Icon)                %ESC%[91m+---------------------------------------------------+%ESC%[97m
echo  %ESC%[36m3)%ESC%[97m Lumia 1520                      %ESC%[91m^| - Move old drivers before downloading new one     ^|%ESC%[97m
echo  %ESC%[36m4)%ESC%[97m Lumia 1520 AT^&T                %ESC%[91m ^|  Because driver structures will be updated weekly ^|%ESC%[97m
echo  %ESC%[36m5)%ESC%[97m Lumia 830 Global                %ESC%[91m+---------------------------------------------------+%ESC%[97m
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
set SVNLoc="%~dp0\Files\DownloaderFiles\svn"
set WGETLoc="%~dp0\Files\DownloaderFiles\wget"
set SzLoc="%~dp0\Files\DownloaderFiles\7za"
set COMLoc=https://github.com/WOA-Project/Lumia-Drivers/trunk
set ReleaseLoc=https://github.com/WOA-Project/Lumia-Drivers/releases/download/2006/
cls
color 0b
setlocal EnableDelayedExpansion
title Downloading Drivers ...
if not exist Drivers\ mkdir Drivers
cd Drivers\
if not exist README.md %WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/README.md --no-check-certificate
title Downloading Drivers ...
if "%Model%" EQU "1" (
	if exist Lumia930\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/930.txt --no-check-certificate
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (930.txt) do (
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		%SVNLoc% export %COMLoc%!DrvUrl! Lumia930!Drv!
	)
	del 930.txt
)
if "%Model%" EQU "2" (
	if exist LumiaIcon\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/icon.txt --no-check-certificate
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (icon.txt) do (
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		%SVNLoc% export %COMLoc%!DrvUrl! LumiaIcon!Drv!
	)
	del icon.txt
)
if "%Model%" EQU "3" (
	if exist Lumia1520\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/1520upsidedown.txt --no-check-certificate
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (1520upsidedown.txt) do (
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		%SVNLoc% export %COMLoc%!DrvUrl! Lumia1520!Drv!
	)
	del 1520upsidedown.txt
)
if "%Model%" EQU "4" (
	if exist Lumia1520-AT^&T\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/1520attupsidedown.txt --no-check-certificate
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (1520attupsidedown.txt) do (
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		%SVNLoc% export %COMLoc%!DrvUrl! Lumia1520-AT^&T!Drv!
	)
	del 1520attupsidedown.txt
)
if "%Model%" EQU "5" (
	if exist Lumia830\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/830.txt --no-check-certificate
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (830.txt) do (
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		%SVNLoc% export %COMLoc%!DrvUrl! Lumia830!Drv!
	)
	del 830.txt
)
if "%Model%" EQU "6" (
	if exist Lumia735\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/735.txt --no-check-certificate
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (735.txt) do (
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		%SVNLoc% export %COMLoc%!DrvUrl! Lumia735!Drv!
	)
	del 735.txt
)
if "%Model%" EQU "7" (
	if exist Lumia640XL\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/640xl.txt --no-check-certificate
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (640xl.txt) do (
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		%SVNLoc% export %COMLoc%!DrvUrl! Lumia640XL!Drv!
	)
	del 640xl.txt
)
if "%Model%" EQU "8" (
	if exist Lumia640XL-AT^&T\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/640xlatt.txt --no-check-certificate
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (640xlatt.txt) do (
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		%SVNLoc% export %COMLoc%!DrvUrl! Lumia640XL-AT^&T!Drv!
	)
	del 640xlatt.txt
)
if /I "%Model%" EQU "A" (
	if exist Lumia920\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/920.txt --no-check-certificate
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (920.txt) do (
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		%SVNLoc% export %COMLoc%!DrvUrl! Lumia920!Drv!
	)
	del 920.txt
)
if /I "%Model%" EQU "B" (
	if exist Lumia1020\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/1020.txt --no-check-certificate
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (1020.txt) do (
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		%SVNLoc% export %COMLoc%!DrvUrl! Lumia1020!Drv!
	)
	del 1020.txt
)
if /I "%Model%" EQU "C" (
	if exist Lumia1020-AT^&T\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/1020att.txt --no-check-certificate
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (1020att.txt) do (
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		%SVNLoc% export %COMLoc%!DrvUrl! Lumia1020-AT^&T!Drv!
	)
	del 1020att.txt
)
if /I "%Model%" EQU "D" (
	if not exist Lumia950 mkdir Lumia950
	if not exist Lumia950\components\ mkdir Lumia950\components\
	cd Lumia950\components\
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4_F12_10\ %WGETLoc% %ReleaseLoc%DEVICE.INPUT.SYNAPTICS_RMI4_F12_10.zip --no-check-certificate
	if not exist DEVICE.SOC_QC8994.TALKMAN\ %WGETLoc% %ReleaseLoc%DEVICE.SOC_QC8994.TALKMAN.zip --no-check-certificate
	if not exist DEVICE.USB.MMO_USBC\ %WGETLoc% %ReleaseLoc%DEVICE.USB.MMO_USBC.zip --no-check-certificate
	if not exist OEM.SOC_QC8994.MMO\ %WGETLoc% %ReleaseLoc%OEM.SOC_QC8994.MMO.zip --no-check-certificate
	if not exist OEM.SOC_QC8994.MMO_SOC8992\ %WGETLoc% %ReleaseLoc%OEM.SOC_QC8994.MMO_SOC8992.zip --no-check-certificate
	if not exist PLATFORM.SOC_QC8994.BASE\ %WGETLoc% %ReleaseLoc%PLATFORM.SOC_QC8994.BASE.zip --no-check-certificate
	if not exist PLATFORM.SOC_QC8994.MMO\ %WGETLoc% %ReleaseLoc%PLATFORM.SOC_QC8994.MMO.zip --no-check-certificate
	if not exist PLATFORM.SOC_QC8994.SOC8992\ %WGETLoc% %ReleaseLoc%PLATFORM.SOC_QC8994.SOC8992.zip --no-check-certificate
	if not exist PLATFORM.SOC_QC8994.SOC8994AB\ %WGETLoc% %ReleaseLoc%PLATFORM.SOC_QC8994.SOC8994AB.zip --no-check-certificate
	if not exist SUPPORT.DESKTOP.BASE\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.BASE.zip --no-check-certificate
	if not exist SUPPORT.DESKTOP.EXTRAS\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.EXTRAS.zip --no-check-certificate
	if not exist SUPPORT.DESKTOP.MMO_EXTRAS\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.MMO_EXTRAS.zip --no-check-certificate
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.MOBILE_BRIDGE.zip --no-check-certificate
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.MOBILE_COMPONENTS.zip --no-check-certificate
	if exist DEVICE.INPUT.SYNAPTICS_RMI4_F12_10.zip %SzLoc% x DEVICE.INPUT.SYNAPTICS_RMI4_F12_10.zip DEVICE.INPUT.SYNAPTICS_RMI4_F12_10
	if exist DEVICE.SOC_QC8994.TALKMAN.zip %SzLoc% x DEVICE.SOC_QC8994.TALKMAN.zip DEVICE.SOC_QC8994.TALKMAN
	if exist DEVICE.USB.MMO_USBC.zip %SzLoc% x DEVICE.USB.MMO_USBC.zip DEVICE.USB.MMO_USBC
	if exist OEM.SOC_QC8994.MMO.zip %SzLoc% x OEM.SOC_QC8994.MMO.zip OEM.SOC_QC8994.MMO
	if exist OEM.SOC_QC8994.MMO_SOC8992.zip %SzLoc% x OEM.SOC_QC8994.MMO_SOC8992.zip OEM.SOC_QC8994.MMO_SOC8992
	if exist PLATFORM.SOC_QC8994.BASE.zip %SzLoc% x PLATFORM.SOC_QC8994.BASE.zip PLATFORM.SOC_QC8994.BASE
	if exist PLATFORM.SOC_QC8994.MMO.zip %SzLoc% x PLATFORM.SOC_QC8994.MMO.zip PLATFORM.SOC_QC8994.MMO
	if exist PLATFORM.SOC_QC8994.SOC8992.zip %SzLoc% x PLATFORM.SOC_QC8994.SOC8992.zip PLATFORM.SOC_QC8994.SOC8992
	if exist PLATFORM.SOC_QC8994.SOC8994AB.zip %SzLoc% x PLATFORM.SOC_QC8994.SOC8994AB.zip PLATFORM.SOC_QC8994.SOC8994AB
	if exist SUPPORT.DESKTOP.BASE.zip %SzLoc% x SUPPORT.DESKTOP.BASE.zip SUPPORT.DESKTOP.BASE
	if exist SUPPORT.DESKTOP.EXTRAS.zip %SzLoc% x SUPPORT.DESKTOP.EXTRAS.zip SUPPORT.DESKTOP.EXTRAS
	if exist SUPPORT.DESKTOP.MMO_EXTRAS.zip %SzLoc% x SUPPORT.DESKTOP.MMO_EXTRAS.zip SUPPORT.DESKTOP.MMO_EXTRAS
	if exist SUPPORT.DESKTOP.MOBILE_BRIDGE.zip %SzLoc% x SUPPORT.DESKTOP.MOBILE_BRIDGE.zip SUPPORT.DESKTOP.MOBILE_BRIDGE
	if exist SUPPORT.DESKTOP.MOBILE_COMPONENTS.zip %SzLoc% x SUPPORT.DESKTOP.MOBILE_COMPONENTS.zip SUPPORT.DESKTOP.MOBILE_COMPONENTS
	del *.zip 2>NUL
)
if /I "%Model%" EQU "E" (
	if not exist Lumia950XL mkdir Lumia950XL
	if not exist Lumia950XL\components\ mkdir Lumia950XL\components\
	cd Lumia950XL\components\
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4_F12_10\ %WGETLoc% %ReleaseLoc%DEVICE.INPUT.SYNAPTICS_RMI4_F12_10.zip --no-check-certificate
	if not exist DEVICE.SOC_QC8994.CITYMAN\ %WGETLoc% %ReleaseLoc%DEVICE.SOC_QC8994.CITYMAN.zip --no-check-certificate
	if not exist DEVICE.USB.MMO_USBC\ %WGETLoc% %ReleaseLoc%DEVICE.USB.MMO_USBC.zip --no-check-certificate
	if not exist OEM.SOC_QC8994.MMO\ %WGETLoc% %ReleaseLoc%OEM.SOC_QC8994.MMO.zip --no-check-certificate
	if not exist OEM.SOC_QC8994.MMO_SOC8994\ %WGETLoc% %ReleaseLoc%OEM.SOC_QC8994.MMO_SOC8994.zip --no-check-certificate
	if not exist PLATFORM.SOC_QC8994.BASE\ %WGETLoc% %ReleaseLoc%PLATFORM.SOC_QC8994.BASE.zip --no-check-certificate
	if not exist PLATFORM.SOC_QC8994.MMO\ %WGETLoc% %ReleaseLoc%PLATFORM.SOC_QC8994.MMO.zip --no-check-certificate
	if not exist PLATFORM.SOC_QC8994.SOC8994\ %WGETLoc% %ReleaseLoc%PLATFORM.SOC_QC8994.SOC8994.zip --no-check-certificate
	if not exist PLATFORM.SOC_QC8994.SOC8994AB\ %WGETLoc% %ReleaseLoc%PLATFORM.SOC_QC8994.SOC8994AB.zip --no-check-certificate
	if not exist SUPPORT.DESKTOP.BASE\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.BASE.zip --no-check-certificate
	if not exist SUPPORT.DESKTOP.EXTRAS\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.EXTRAS.zip --no-check-certificate
	if not exist SUPPORT.DESKTOP.MMO_EXTRAS\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.MMO_EXTRAS.zip --no-check-certificate
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.MOBILE_BRIDGE.zip --no-check-certificate
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.MOBILE_COMPONENTS.zip --no-check-certificate
	if exist DEVICE.INPUT.SYNAPTICS_RMI4_F12_10.zip %SzLoc% x DEVICE.INPUT.SYNAPTICS_RMI4_F12_10.zip DEVICE.INPUT.SYNAPTICS_RMI4_F12_10
	if exist DEVICE.SOC_QC8994.CITYMAN.zip %SzLoc% x DEVICE.SOC_QC8994.CITYMAN.zip DEVICE.SOC_QC8994.CITYMAN
	if exist DEVICE.USB.MMO_USBC.zip %SzLoc% x DEVICE.USB.MMO_USBC.zip DEVICE.USB.MMO_USBC
	if exist OEM.SOC_QC8994.MMO.zip %SzLoc% x OEM.SOC_QC8994.MMO.zip OEM.SOC_QC8994.MMO
	if exist OEM.SOC_QC8994.MMO_SOC8994.zip %SzLoc% x OEM.SOC_QC8994.MMO_SOC8994.zip OEM.SOC_QC8994.MMO_SOC8994
	if exist PLATFORM.SOC_QC8994.BASE.zip %SzLoc% x PLATFORM.SOC_QC8994.BASE.zip PLATFORM.SOC_QC8994.BASE
	if exist PLATFORM.SOC_QC8994.MMO.zip %SzLoc% x PLATFORM.SOC_QC8994.MMO.zip PLATFORM.SOC_QC8994.MMO
	if exist PLATFORM.SOC_QC8994.SOC8994.zip %SzLoc% x PLATFORM.SOC_QC8994.SOC8994.zip PLATFORM.SOC_QC8994.SOC8994
	if exist PLATFORM.SOC_QC8994.SOC8994AB.zip %SzLoc% x PLATFORM.SOC_QC8994.SOC8994AB.zip PLATFORM.SOC_QC8994.SOC8994AB
	if exist SUPPORT.DESKTOP.BASE.zip %SzLoc% x SUPPORT.DESKTOP.BASE.zip SUPPORT.DESKTOP.BASE
	if exist SUPPORT.DESKTOP.EXTRAS.zip %SzLoc% x SUPPORT.DESKTOP.EXTRAS.zip SUPPORT.DESKTOP.EXTRAS
	if exist SUPPORT.DESKTOP.MMO_EXTRAS.zip %SzLoc% x SUPPORT.DESKTOP.MMO_EXTRAS.zip SUPPORT.DESKTOP.MMO_EXTRAS
	if exist SUPPORT.DESKTOP.MOBILE_BRIDGE.zip %SzLoc% x SUPPORT.DESKTOP.MOBILE_BRIDGE.zip SUPPORT.DESKTOP.MOBILE_BRIDGE
	if exist SUPPORT.DESKTOP.MOBILE_COMPONENTS.zip %SzLoc% x SUPPORT.DESKTOP.MOBILE_COMPONENTS.zip SUPPORT.DESKTOP.MOBILE_COMPONENTS
	del *.zip 2>NUL
)
echo.
color 0a
echo Downloading Drivers Done^^!
pause
goto ChooseDev
:OldExist
color 0c
title Old Drivers Exist.
cls
echo.
echo Old Drivers Exist.
echo Please delete or move it to another place
pause
goto ChooseDev

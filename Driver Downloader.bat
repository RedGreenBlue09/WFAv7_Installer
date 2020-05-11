@echo off
title WFAv7 Driver Downloader 2.0
mode 96,2400
powershell -command "&{(get-host).ui.rawui.windowsize=@{width=96;height=24};}"
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set ESC=%%b
:ChooseDev
cd /D "%~dp0"
set Model=
cls
color 0f
echo  %ESC%[93m//////////////////////////////////////////////////////////////////////////////////////////////
echo  //                               %ESC%[97mWFAv7 Driver Downloader 2.0%ESC%[93m                                //
echo  //                                   %ESC%[97mby RedGreenBlue123%ESC%[93m                                     //
echo  //////////////////////////////////////////////////////////////////////////////////////////////%ESC%[92m
echo.
echo Choose your Device Model below%ESC%[32m:
echo  %ESC%[0m1)%ESC%[97m Lumia 930
echo  %ESC%[0m2)%ESC%[97m Lumia Icon                      %ESC%[91m+---------------------------------------------------+%ESC%[97m
echo  %ESC%[0m3)%ESC%[97m Lumia 1520                      %ESC%[91m^| - Move old drivers before downloading new one     ^|%ESC%[97m
echo  %ESC%[0m4)%ESC%[97m Lumia 1520 AT^&T                %ESC%[91m ^|  Because driver structures will be updated weekly ^|%ESC%[97m
echo  %ESC%[0m5)%ESC%[97m Lumia 830 Global                %ESC%[91m+---------------------------------------------------+%ESC%[97m
echo  %ESC%[0m6)%ESC%[97m Lumia 735 Global
echo  %ESC%[0m7)%ESC%[97m Lumia 640 XL LTE Global
echo  %ESC%[0m8)%ESC%[97m Lumia 640 XL LTE AT^&T
echo  %ESC%[0mA)%ESC%[97m Lumia 920 %ESC%[0m[Will not be used in the Installer]
echo  %ESC%[0mB)%ESC%[97m Lumia 1020 %ESC%[0m[Will not be used in the Installer]
echo  %ESC%[0mC)%ESC%[97m Lumia 1020 AT^&T %ESC%[0m[Will not be used in the Installer]
echo  %ESC%[0mD)%ESC%[97m Lumia 950
echo  %ESC%[0mE)%ESC%[97m Lumia 950 XL
set /p Model=%ESC%[92mDevice%ESC%[92m: %ESC%[0m
if "%model%"=="" goto ChooseDev
::------------------------------------------------------------------
set SVNLoc="%~dp0\Files\DownloaderFiles\svn"
set WGETLoc="%~dp0\Files\DownloaderFiles\wget"
set SzLoc="%~dp0\Files\DownloaderFiles\7za"
set COMLoc=https://github.com/WOA-Project/Lumia-Drivers/trunk
set ReleaseLoc=https://github.com/WOA-Project/Lumia-Drivers/releases/download/2003.2.2/
cls
color 0b
title Downloading Drivers ...
if not exist Drivers\ mkdir Drivers
cd Drivers\
if not exist README.md %WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/README.md
title Downloading Drivers ...
if %Model%==1 (
	if exist Lumia930\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/930.txt
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (930.txt) do (
		setlocal EnableDelayedExpansion
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		if not exist Lumia930!Drv! %SVNLoc% checkout %COMLoc%!DrvUrl! Lumia930!Drv!
	)
	del 930.txt
)
if %Model%==2 (
	if exist LumiaIcon\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/icon.txt
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (icon.txt) do (
		setlocal EnableDelayedExpansion
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		if not exist LumiaIcon!Drv! %SVNLoc% checkout %COMLoc%!DrvUrl! LumiaIcon!Drv!
	)
	del icon.txt
)
if %Model%==3 (
	if exist Lumia1520\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/1520upsidedown.txt
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (1520upsidedown.txt) do (
		setlocal EnableDelayedExpansion
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		if not exist Lumia1520!Drv! %SVNLoc% checkout %COMLoc%!DrvUrl! Lumia1520!Drv!
	)
	del 1520upsidedown.txt
)
if %Model%==4 (
	if exist Lumia1520-AT^&T\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/1520attupsidedown.txt
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (1520attupsidedown.txt) do (
		setlocal EnableDelayedExpansion
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		if not exist Lumia1520-AT^&T!Drv! %SVNLoc% checkout %COMLoc%!DrvUrl! Lumia1520AT^&T!Drv!
	)
	del 1520attupsidedown.txt
)
if %Model%==5 (
	if exist Lumia830\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/830.txt
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (830.txt) do (
		setlocal EnableDelayedExpansion
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		if not exist Lumia830!Drv! %SVNLoc% checkout %COMLoc%!DrvUrl! Lumia830!Drv!
	)
	del 830.txt
)
if %Model%==6 (
	if exist Lumia735\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/735.txt
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (735.txt) do (
		setlocal EnableDelayedExpansion
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		if not exist Lumia735!Drv! %SVNLoc% checkout %COMLoc%!DrvUrl! Lumia735!Drv!
	)
	del 735.txt
)
if %Model%==7 (
	if exist Lumia640XL\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/640xl.txt
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (640xl.txt) do (
		setlocal EnableDelayedExpansion
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		if not exist Lumia640XL!Drv! %SVNLoc% checkout %COMLoc%!DrvUrl! Lumia640XL!Drv!
	)
	del 640xl.txt
)
if %Model%==8 (
	if exist Lumia640XL-AT^&T\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/640xlatt.txt
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (640xlatt.txt) do (
		setlocal EnableDelayedExpansion
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		if not exist Lumia640XL-AT^&T!Drv! %SVNLoc% checkout %COMLoc%!DrvUrl! Lumia640XL-AT^&T!Drv!
	)
	del 640xlatt.txt
)
if %Model%==A (
	if exist Lumia920\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/920.txt
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (920.txt) do (
		setlocal EnableDelayedExpansion
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		if not exist Lumia920!Drv! %SVNLoc% checkout %COMLoc%!DrvUrl! Lumia920!Drv!
	)
	del 920.txt
)
if %Model%==B (
	if exist Lumia1020\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/1020.txt
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (1020.txt) do (
		setlocal EnableDelayedExpansion
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		if not exist Lumia1020!Drv! %SVNLoc% checkout %COMLoc%!DrvUrl! Lumia1020!Drv!
	)
	del 1020.txt
)
if %Model%==C (
	if exist Lumia1020-AT^&T\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/1020att.txt
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (1020att.txt) do (
		setlocal EnableDelayedExpansion
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		if not exist Lumia1020-AT^&T!Drv! %SVNLoc% checkout %COMLoc%!DrvUrl! Lumia1020-AT^&T!Drv!
	)
	del 1020att.txt
)
if %Model%==a (
	if exist Lumia920\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/920.txt
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (920.txt) do (
		setlocal EnableDelayedExpansion
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		if not exist Lumia920!Drv! %SVNLoc% checkout %COMLoc%!DrvUrl! Lumia920!Drv!
	)
	del 920.txt
)
if %Model%==b (
	if exist Lumia1020\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/1020.txt
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (1020.txt) do (
		setlocal EnableDelayedExpansion
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		if not exist Lumia1020!Drv! %SVNLoc% checkout %COMLoc%!DrvUrl! Lumia1020!Drv!
	)
	del 1020.txt
)
if %Model%==c (
	if exist Lumia1020-AT^&T\ goto OldExist
	%WGETLoc% https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/definitions/1020att.txt
	title Downloading Drivers ...
	for /F "tokens=*" %%A IN (1020att.txt) do (
		setlocal EnableDelayedExpansion
		set Drv=%%A
		set DrvUrl=!Drv:\=/!
		if not exist Lumia1020-AT^&T!Drv! %SVNLoc% checkout %COMLoc%!DrvUrl! Lumia1020-AT^&T!Drv!
	)
	del 1020att.txt
)
if %Model%==D (
	if not exist Lumia950 mkdir Lumia950
	if not exist Lumia950\components\ mkdir Lumia950\components\
	cd Lumia950\components\
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4_F12_10\ %WGETLoc% %ReleaseLoc%DEVICE.INPUT.SYNAPTICS_RMI4_F12_10.zip
	if not exist DEVICE.SOC_QC8994.TALKMAN\ %WGETLoc% %ReleaseLoc%DEVICE.SOC_QC8994.TALKMAN.zip
	if not exist DEVICE.USB.MMO_USBC\ %WGETLoc% %ReleaseLoc%DEVICE.USB.MMO_USBC.zip
	if not exist OEM.SOC_QC8994.MMO\ %WGETLoc% %ReleaseLoc%OEM.SOC_QC8994.MMO.zip
	if not exist OEM.SOC_QC8994.MMO_SOC8992\ %WGETLoc% %ReleaseLoc%OEM.SOC_QC8994.MMO_SOC8992.zip
	if not exist PLATFORM.SOC_QC8994.BASE\ %WGETLoc% %ReleaseLoc%PLATFORM.SOC_QC8994.BASE.zip
	if not exist PLATFORM.SOC_QC8994.MMO\ %WGETLoc% %ReleaseLoc%PLATFORM.SOC_QC8994.MMO.zip
	if not exist PLATFORM.SOC_QC8994.SOC8992\ %WGETLoc% %ReleaseLoc%PLATFORM.SOC_QC8994.SOC8992.zip
	if not exist PLATFORM.SOC_QC8994.SOC8994AB\ %WGETLoc% %ReleaseLoc%PLATFORM.SOC_QC8994.SOC8994AB.zip
	if not exist SUPPORT.DESKTOP.BASE\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.BASE.zip
	if not exist SUPPORT.DESKTOP.EXTRAS\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.EXTRAS.zip
	if not exist SUPPORT.DESKTOP.MMO_EXTRAS\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.MMO_EXTRAS.zip
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.MOBILE_BRIDGE.zip
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.MOBILE_COMPONENTS.zip
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
if %Model%==E (
	if not exist Lumia950XL mkdir Lumia950XL
	if not exist Lumia950XL\components\ mkdir Lumia950XL\components\
	cd Lumia950XL\components\
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4_F12_10\ %WGETLoc% %ReleaseLoc%DEVICE.INPUT.SYNAPTICS_RMI4_F12_10.zip
	if not exist DEVICE.SOC_QC8994.CITYMAN\ %WGETLoc% %ReleaseLoc%DEVICE.SOC_QC8994.CITYMAN.zip
	if not exist DEVICE.USB.MMO_USBC\ %WGETLoc% %ReleaseLoc%DEVICE.USB.MMO_USBC.zip
	if not exist OEM.SOC_QC8994.MMO\ %WGETLoc% %ReleaseLoc%OEM.SOC_QC8994.MMO.zip
	if not exist OEM.SOC_QC8994.MMO_SOC8994\ %WGETLoc% %ReleaseLoc%OEM.SOC_QC8994.MMO_SOC8994.zip
	if not exist PLATFORM.SOC_QC8994.BASE\ %WGETLoc% %ReleaseLoc%PLATFORM.SOC_QC8994.BASE.zip
	if not exist PLATFORM.SOC_QC8994.MMO\ %WGETLoc% %ReleaseLoc%PLATFORM.SOC_QC8994.MMO.zip
	if not exist PLATFORM.SOC_QC8994.SOC8994\ %WGETLoc% %ReleaseLoc%PLATFORM.SOC_QC8994.SOC8994.zip
	if not exist PLATFORM.SOC_QC8994.SOC8994AB\ %WGETLoc% %ReleaseLoc%PLATFORM.SOC_QC8994.SOC8994AB.zip
	if not exist SUPPORT.DESKTOP.BASE\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.BASE.zip
	if not exist SUPPORT.DESKTOP.EXTRAS\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.EXTRAS.zip
	if not exist SUPPORT.DESKTOP.MMO_EXTRAS\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.MMO_EXTRAS.zip
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.MOBILE_BRIDGE.zip
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.MOBILE_COMPONENTS.zip
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
if %Model%==d (
	if not exist Lumia950 mkdir Lumia950
	if not exist Lumia950\components\ mkdir Lumia950\components\
	cd Lumia950\components\
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4_F12_10\ %WGETLoc% %ReleaseLoc%DEVICE.INPUT.SYNAPTICS_RMI4_F12_10.zip
	if not exist DEVICE.SOC_QC8994.TALKMAN\ %WGETLoc% %ReleaseLoc%DEVICE.SOC_QC8994.TALKMAN.zip
	if not exist DEVICE.USB.MMO_USBC\ %WGETLoc% %ReleaseLoc%DEVICE.USB.MMO_USBC.zip
	if not exist OEM.SOC_QC8994.MMO\ %WGETLoc% %ReleaseLoc%OEM.SOC_QC8994.MMO.zip
	if not exist OEM.SOC_QC8994.MMO_SOC8992\ %WGETLoc% %ReleaseLoc%OEM.SOC_QC8994.MMO_SOC8992.zip
	if not exist PLATFORM.SOC_QC8994.BASE\ %WGETLoc% %ReleaseLoc%PLATFORM.SOC_QC8994.BASE.zip
	if not exist PLATFORM.SOC_QC8994.MMO\ %WGETLoc% %ReleaseLoc%PLATFORM.SOC_QC8994.MMO.zip
	if not exist PLATFORM.SOC_QC8994.SOC8992\ %WGETLoc% %ReleaseLoc%PLATFORM.SOC_QC8994.SOC8992.zip
	if not exist PLATFORM.SOC_QC8994.SOC8994AB\ %WGETLoc% %ReleaseLoc%PLATFORM.SOC_QC8994.SOC8994AB.zip
	if not exist SUPPORT.DESKTOP.BASE\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.BASE.zip
	if not exist SUPPORT.DESKTOP.EXTRAS\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.EXTRAS.zip
	if not exist SUPPORT.DESKTOP.MMO_EXTRAS\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.MMO_EXTRAS.zip
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.MOBILE_BRIDGE.zip
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.MOBILE_COMPONENTS.zip
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
if %Model%==e (
	if not exist Lumia950XL mkdir Lumia950XL
	if not exist Lumia950XL\components\ mkdir Lumia950XL\components\
	cd Lumia950XL\components\
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4_F12_10\ %WGETLoc% %ReleaseLoc%DEVICE.INPUT.SYNAPTICS_RMI4_F12_10.zip
	if not exist DEVICE.SOC_QC8994.CITYMAN\ %WGETLoc% %ReleaseLoc%DEVICE.SOC_QC8994.CITYMAN.zip
	if not exist DEVICE.USB.MMO_USBC\ %WGETLoc% %ReleaseLoc%DEVICE.USB.MMO_USBC.zip
	if not exist OEM.SOC_QC8994.MMO\ %WGETLoc% %ReleaseLoc%OEM.SOC_QC8994.MMO.zip
	if not exist OEM.SOC_QC8994.MMO_SOC8994\ %WGETLoc% %ReleaseLoc%OEM.SOC_QC8994.MMO_SOC8994.zip
	if not exist PLATFORM.SOC_QC8994.BASE\ %WGETLoc% %ReleaseLoc%PLATFORM.SOC_QC8994.BASE.zip
	if not exist PLATFORM.SOC_QC8994.MMO\ %WGETLoc% %ReleaseLoc%PLATFORM.SOC_QC8994.MMO.zip
	if not exist PLATFORM.SOC_QC8994.SOC8994\ %WGETLoc% %ReleaseLoc%PLATFORM.SOC_QC8994.SOC8994.zip
	if not exist PLATFORM.SOC_QC8994.SOC8994AB\ %WGETLoc% %ReleaseLoc%PLATFORM.SOC_QC8994.SOC8994AB.zip
	if not exist SUPPORT.DESKTOP.BASE\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.BASE.zip
	if not exist SUPPORT.DESKTOP.EXTRAS\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.EXTRAS.zip
	if not exist SUPPORT.DESKTOP.MMO_EXTRAS\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.MMO_EXTRAS.zip
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.MOBILE_BRIDGE.zip
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ %WGETLoc% %ReleaseLoc%SUPPORT.DESKTOP.MOBILE_COMPONENTS.zip
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
echo Downloading Drivers Done!
pause
if not %model%==1 goto ChooseDev
if not %model%==2 goto ChooseDev
if not %model%==3 goto ChooseDev
if not %model%==4 goto ChooseDev
if not %model%==5 goto ChooseDev
if not %model%==6 goto ChooseDev
if not %model%==7 goto ChooseDev
if not %model%==8 goto ChooseDev
if not %model%==A goto ChooseDev
if not %model%==B goto ChooseDev
if not %model%==C goto ChooseDev
if not %model%==D goto ChooseDev
if not %model%==E goto ChooseDev
if not %model%==a goto ChooseDev
if not %model%==b goto ChooseDev
if not %model%==c goto ChooseDev
if not %model%==d goto ChooseDev
if not %model%==e goto ChooseDev
goto ChooseDev
:OldExist
color 0c
title Old Drivers Exist!
cls
echo.
echo Old Drivers Exist
echo Please delete or move it to another place
pause
goto ChooseDev

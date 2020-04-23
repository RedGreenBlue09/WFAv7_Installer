@echo off
mode 96,2400
powershell -command "&{(get-host).ui.rawui.windowsize=@{width=96;height=24};}"
call :setESC
:ChooseDev
cd /D "%~dp0"
set Model=
cls
color 0f
echo  %ESC%[93m//////////////////////////////////////////////////////////////////////////////////////////////
echo  //                               %ESC%[97mWFAv7 Driver Downloader 1.7%ESC%[93m                                //
echo  //                                   %ESC%[97mby RedGreenBlue123%ESC%[93m                                     //
echo  //////////////////////////////////////////////////////////////////////////////////////////////%ESC%[97m
echo.
echo Choose your Device Model below:
echo  %ESC%[0m1)%ESC%[97m Lumia 930
echo  %ESC%[0m2)%ESC%[97m Lumia Icon                        %ESC%[91m+-------------------------------------------------+%ESC%[97m
echo  %ESC%[0m3)%ESC%[97m Lumia 1520                        %ESC%[91m^| - Detele old drivers before downloading 950/XL  ^|%ESC%[97m
echo  %ESC%[0m4)%ESC%[97m Lumia 1520 AT^&T                  %ESC%[91m ^|   If you downloaded All Drivers.                ^|%ESC%[97m
echo  %ESC%[0m5)%ESC%[97m Lumia 830 Global                  %ESC%[91m^| - If you didn't delete,                         ^|%ESC%[97m
echo  %ESC%[0m6)%ESC%[97m Lumia 735 Global                  %ESC%[91m^|   That may causes install errors or BSOD.       ^|%ESC%[97m
echo  %ESC%[0m7)%ESC%[97m Lumia 640 XL LTE Global           %ESC%[91m+-------------------------------------------------+%ESC%[97m
echo  %ESC%[0m8)%ESC%[97m Lumia 640 XL LTE AT^&T
echo  %ESC%[0mA)%ESC%[97m Lumia 650 %ESC%[0m[experimental only]
echo  %ESC%[0mB)%ESC%[97m Lumia 920 %ESC%[0m[Will not be used in the Installer]
echo  %ESC%[0mC)%ESC%[97m Lumia 1020 %ESC%[0m[Will not be used in the Installer]
echo  %ESC%[0mD)%ESC%[97m Lumia 1020 AT^&T
echo  %ESC%[0mE)%ESC%[97m Lumia 950
echo  %ESC%[0mF)%ESC%[97m Lumia 950 XL
echo  %ESC%[0mG)%ESC%[97m All Drivers (Not for 950 and 950 XL)
set /p Model=%ESC%[92mDevice%ESC%[92m: %ESC%[0m
if "%model%"=="" goto ChooseDev
::------------------------------------------------------------------
set SVNLoc="%~dp0\Files\DownloaderFiles\svn"
set WGETLoc="%~dp0\Files\DownloaderFiles\wget"
set SzLoc="%~dp0\Files\DownloaderFiles\7za"
set COMLoc=https://github.com/WOA-Project/Lumia-Drivers/trunk/components/
set READMELoc=https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/README.md
set ReleaseLoc=https://github.com/WOA-Project/Lumia-Drivers/releases/download/2003.2.2/
if %model%==1 (
	cls
	color 0b
	title Downloading Drivers ...
	if not exist Drivers\ mkdir Drivers
	if not exist Drivers\components\ mkdir Drivers\components
	cd Drivers\
	if not exist README.md %WGETLoc% %READMELoc%
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8974.MARTINI\ %SVNLoc% checkout %COMLoc%DEVICE.SOC_QC8974.MARTINI
	if not exist OEM.SOC_QC8974.NMO\ %SVNLoc% checkout %COMLoc%OEM.SOC_QC8974.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ %SVNLoc% checkout %COMLoc%DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8974.BASE\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8974.BASE
	if not exist SUPPORT.DESKTOP.BASE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_COMPONENTS
	echo.
	color 0a
	echo Downloading Drivers Done!
	pause
)
if %model%==2 (
	cls
	color 0b
	title Downloading Drivers ...
	if not exist Drivers\ mkdir Drivers
	if not exist Drivers\components\ mkdir Drivers\components
	cd Drivers\
	if not exist README.md %WGETLoc% %READMELoc%
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8974.VANQUISH\ %SVNLoc% checkout %COMLoc%DEVICE.SOC_QC8974.VANQUISH
	if not exist OEM.SOC_QC8974.NMO\ %SVNLoc% checkout %COMLoc%OEM.SOC_QC8974.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ %SVNLoc% checkout %COMLoc%DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8974.BASE\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8974.BASE
	if not exist SUPPORT.DESKTOP.BASE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_COMPONENTS
	echo.
	color 0a
	echo Downloading Drivers Done!
	pause
) 
if %model%==3 (
	cls
	color 0b
	title Downloading Drivers ...
	if not exist Drivers\ mkdir Drivers
	if not exist Drivers\components\ mkdir Drivers\components
	cd Drivers\
	if not exist README.md %WGETLoc% %READMELoc%
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8974.BANDIT\ %SVNLoc% checkout %COMLoc%DEVICE.SOC_QC8974.BANDIT
	if not exist OEM.SOC_QC8974.NMO\ %SVNLoc% checkout %COMLoc%OEM.SOC_QC8974.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ %SVNLoc% checkout %COMLoc%DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8974.BASE\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8974.BASE
	if not exist SUPPORT.DESKTOP.BASE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_COMPONENTS
	echo.
	color 0a
	echo Downloading Drivers Done!
	pause
)
if %model%==4 (
	cls
	color 0b
	title Downloading Drivers ...
	if not exist Drivers\ mkdir Drivers
	if not exist Drivers\components\ mkdir Drivers\components
	cd Drivers\
	if not exist README.md %WGETLoc% %READMELoc%
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8974.BANDITATT\ %SVNLoc% checkout %COMLoc%DEVICE.SOC_QC8974.BANDITATT
	if not exist OEM.SOC_QC8974.NMO\ %SVNLoc% checkout %COMLoc%OEM.SOC_QC8974.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ %SVNLoc% checkout %COMLoc%DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8974.BASE\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8974.BASE
	if not exist SUPPORT.DESKTOP.BASE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_COMPONENTS
	echo.
	color 0a
	echo Downloading Drivers Done!
	pause
)
if %model%==5 (
	cls
	color 0b
	title Downloading Drivers ...
	if not exist Drivers\ mkdir Drivers
	if not exist Drivers\components\ mkdir Drivers\components
	cd Drivers\
	if not exist README.md %WGETLoc% %READMELoc%
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8X26.TESLA\ %SVNLoc% checkout %COMLoc%DEVICE.SOC_QC8X26.TESLA
	if not exist OEM.SOC_QC8X26.NMO\ %SVNLoc% checkout %COMLoc%OEM.SOC_QC8X26.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ %SVNLoc% checkout %COMLoc%DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8X26.BASE\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8X26.BASE
	if not exist SUPPORT.DESKTOP.BASE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_COMPONENTS
	echo.
	color 0a
	echo Downloading Drivers Done!
	pause
)
if %model%==6 (
	cls
	color 0b
	title Downloading Drivers ...
	if not exist Drivers\ mkdir Drivers
	if not exist Drivers\components\ mkdir Drivers\components
	cd Drivers\
	if not exist README.md %WGETLoc% %READMELoc%
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8X26.SUPERMAN\ %SVNLoc% checkout %COMLoc%DEVICE.SOC_QC8X26.SUPERMAN
	if not exist OEM.SOC_QC8X26.NMO\ %SVNLoc% checkout %COMLoc%OEM.SOC_QC8X26.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ %SVNLoc% checkout %COMLoc%DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8X26.BASE\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8X26.BASE
	if not exist SUPPORT.DESKTOP.BASE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_COMPONENTS
	echo.
	color 0a
	echo Downloading Drivers Done!
	pause
)
if %model%==7 (
	cls
	color 0b
	title Downloading Drivers ...
	if not exist Drivers\ mkdir Drivers
	if not exist Drivers\components\ mkdir Drivers\components
	cd Drivers\
	if not exist README.md %WGETLoc% %READMELoc%
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8X26.MAKEPEACE\ %SVNLoc% checkout %COMLoc%DEVICE.SOC_QC8X26.MAKEPEACE
	if not exist OEM.SOC_QC8X26.NMO\ %SVNLoc% checkout %COMLoc%OEM.SOC_QC8X26.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ %SVNLoc% checkout %COMLoc%DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8X26.BASE\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8X26.BASE
	if not exist SUPPORT.DESKTOP.BASE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_COMPONENTS
	echo.
	color 0a
	echo Downloading Drivers Done!
	pause
)
if %model%==8 (
	cls
	color 0b
	title Downloading Drivers ...
	if not exist Drivers\ mkdir Drivers
	if not exist Drivers\components\ mkdir Drivers\components
	cd Drivers\
	if not exist README.md %WGETLoc% %READMELoc%
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8X26.MAKEPEACEATT\ %SVNLoc% checkout %COMLoc%DEVICE.SOC_QC8X26.MAKEPEACEATT
	if not exist OEM.SOC_QC8X26.NMO\ %SVNLoc% checkout %COMLoc%OEM.SOC_QC8X26.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ %SVNLoc% checkout %COMLoc%DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8X26.BASE\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8X26.BASE
	if not exist SUPPORT.DESKTOP.BASE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_COMPONENTS
	echo.
	color 0a
	echo Downloading Drivers Done!
	pause
)
if %model%==A (
	cls
	color 0b
	title Downloading Drivers ...
	if not exist Drivers\ mkdir Drivers
	if not exist Drivers\components\ mkdir Drivers\components
	cd Drivers\
	if not exist README.md %WGETLoc% %READMELoc%
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8909.SAANA\ %SVNLoc% checkout %COMLoc%DEVICE.SOC_QC8909.SAANA
	if not exist OEM.SOC_QC8909.MMO\ %SVNLoc% checkout %COMLoc%OEM.SOC_QC8909.MMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ %SVNLoc% checkout %COMLoc%DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8909.BASE\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8909.BASE
	if not exist PLATFORM.SOC_QC8909.MMO\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8909.MMO
	if not exist PLATFORM.SOC_QC8909.MMO_OTHERS\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8909.MMO_OTHERS
	if not exist SUPPORT.DESKTOP.BASE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MMO_EXTRAS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MMO_EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_COMPONENTS
	echo.
	color 0a
	echo Downloading Drivers Done!
	pause
)
if %model%==B (
	cls
	color 0b
	title Downloading Drivers ...
	if not exist Drivers\ mkdir Drivers
	if not exist Drivers\components\ mkdir Drivers\components
	cd Drivers\
	if not exist README.md %WGETLoc% %READMELoc%
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8960.PHI\ %SVNLoc% checkout %COMLoc%DEVICE.SOC_QC8960.PHI
	if not exist OEM.SOC_QC8960.NMO\ %SVNLoc% checkout %COMLoc%OEM.SOC_QC8960.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ %SVNLoc% checkout %COMLoc%DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8960.BASE\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8960.BASE
	if not exist PLATFORM.SOC_QC8960.SOC8960AA\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8960.SOC8960AA
	if not exist SUPPORT.DESKTOP.BASE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_COMPONENTS
	echo.
	color 0a
	echo Downloading Drivers Done!
	pause
)
if %model%==C (
	cls
	color 0b
	title Downloading Drivers ...
	if not exist Drivers\ mkdir Drivers
	if not exist Drivers\components\ mkdir Drivers\components
	cd Drivers\
	if not exist README.md %WGETLoc% %READMELoc%
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8960.EOS\ %SVNLoc% checkout %COMLoc%DEVICE.SOC_QC8960.EOS
	if not exist OEM.SOC_QC8960.NMO\ %SVNLoc% checkout %COMLoc%OEM.SOC_QC8960.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ %SVNLoc% checkout %COMLoc%DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8960.BASE\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8960.BASE
	if not exist PLATFORM.SOC_QC8960.SOC8960AA\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8960.SOC8960AA
	if not exist SUPPORT.DESKTOP.BASE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_COMPONENTS
	echo.
	color 0a
	echo Downloading Drivers Done!
	pause
)
if %model%==D (
	cls
	color 0b
	title Downloading Drivers ...
	if not exist Drivers\ mkdir Drivers
	if not exist Drivers\components\ mkdir Drivers\components
	cd Drivers\
	if not exist README.md %WGETLoc% %READMELoc%
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8960.EOSATT\ %SVNLoc% checkout %COMLoc%DEVICE.SOC_QC8960.EOSATT
	if not exist OEM.SOC_QC8960.NMO\ %SVNLoc% checkout %COMLoc%OEM.SOC_QC8960.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ %SVNLoc% checkout %COMLoc%DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8960.BASE\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8960.BASE
	if not exist PLATFORM.SOC_QC8960.SOC8960AA\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8960.SOC8960AA
	if not exist SUPPORT.DESKTOP.BASE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_COMPONENTS
	echo.
	color 0a
	echo Downloading Drivers Done!
	pause
)
if %model%==E (
	cls
	color 0b
	title Downloading Drivers ...
	if not exist Drivers\ mkdir Drivers
	if not exist Drivers\components\ mkdir Drivers\components
	cd Drivers\
	if not exist README.md %WGETLoc% %READMELoc%
	cd components\
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
	echo.
	color 0a
	echo Downloading Drivers Done!
	pause
)
if %model%==F (
	cls
	color 0b
	title Downloading Drivers ...
	if not exist Drivers\ mkdir Drivers
	if not exist Drivers\components\ mkdir Drivers\components
	cd Drivers\
	if not exist README.md %WGETLoc% %READMELoc%
	cd components\
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
	echo.
	color 0a
	echo Downloading Drivers Done!
	pause
)
if %model%==G (
	cls
	if exist Drivers\ (
		title ERROR!
		color 0c
		echo Please delete or move previous drivers when downloading all drivers.
		pause
		goto ChooseDev
	)
	color 0b
	title Downloading Drivers ...
	%WGETLoc% https://github.com/WOA-Project/Lumia-Drivers/archive/master.zip
	title Extracting Drivers ...
	%SzLoc% x master.zip Lumia-Drivers-master
	ren Lumia-Drivers-master Drivers
	del master.zip
	echo.
	color 0a
	echo Downloading Drivers Done!
	pause
)
if %model%==a (
	cls
	color 0b
	title Downloading Drivers ...
	if not exist Drivers\ mkdir Drivers
	if not exist Drivers\components\ mkdir Drivers\components
	cd Drivers\
	if not exist README.md %WGETLoc% %READMELoc%
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8909.SAANA\ %SVNLoc% checkout %COMLoc%DEVICE.SOC_QC8909.SAANA
	if not exist OEM.SOC_QC8909.MMO\ %SVNLoc% checkout %COMLoc%OEM.SOC_QC8909.MMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ %SVNLoc% checkout %COMLoc%DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8909.BASE\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8909.BASE
	if not exist PLATFORM.SOC_QC8909.MMO\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8909.MMO
	if not exist PLATFORM.SOC_QC8909.MMO_OTHERS\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8909.MMO_OTHERS
	if not exist SUPPORT.DESKTOP.BASE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MMO_EXTRAS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MMO_EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_COMPONENTS
	echo.
	color 0a
	echo Downloading Drivers Done!
	pause
)
if %model%==b (
	cls
	color 0b
	title Downloading Drivers ...
	if not exist Drivers\ mkdir Drivers
	if not exist Drivers\components\ mkdir Drivers\components
	cd Drivers\
	if not exist README.md %WGETLoc% %READMELoc%
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8960.PHI\ %SVNLoc% checkout %COMLoc%DEVICE.SOC_QC8960.PHI
	if not exist OEM.SOC_QC8960.NMO\ %SVNLoc% checkout %COMLoc%OEM.SOC_QC8960.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ %SVNLoc% checkout %COMLoc%DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8960.BASE\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8960.BASE
	if not exist PLATFORM.SOC_QC8960.SOC8960AA\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8960.SOC8960AA
	if not exist SUPPORT.DESKTOP.BASE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_COMPONENTS
	echo.
	color 0a
	echo Downloading Drivers Done!
	pause
)
if %model%==c (
	cls
	color 0b
	title Downloading Drivers ...
	if not exist Drivers\ mkdir Drivers
	if not exist Drivers\components\ mkdir Drivers\components
	cd Drivers\
	if not exist README.md %WGETLoc% %READMELoc%
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8960.EOS\ %SVNLoc% checkout %COMLoc%DEVICE.SOC_QC8960.EOS
	if not exist OEM.SOC_QC8960.NMO\ %SVNLoc% checkout %COMLoc%OEM.SOC_QC8960.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ %SVNLoc% checkout %COMLoc%DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8960.BASE\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8960.BASE
	if not exist PLATFORM.SOC_QC8960.SOC8960AA\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8960.SOC8960AA
	if not exist SUPPORT.DESKTOP.BASE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_COMPONENTS
	echo.
	color 0a
	echo Downloading Drivers Done!
	pause
)
if %model%==d (
	cls
	color 0b
	title Downloading Drivers ...
	if not exist Drivers\ mkdir Drivers
	if not exist Drivers\components\ mkdir Drivers\components
	cd Drivers\
	if not exist README.md %WGETLoc% %READMELoc%
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8960.EOSATT\ %SVNLoc% checkout %COMLoc%DEVICE.SOC_QC8960.EOSATT
	if not exist OEM.SOC_QC8960.NMO\ %SVNLoc% checkout %COMLoc%OEM.SOC_QC8960.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ %SVNLoc% checkout %COMLoc%DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8960.BASE\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8960.BASE
	if not exist PLATFORM.SOC_QC8960.SOC8960AA\ %SVNLoc% checkout %COMLoc%PLATFORM.SOC_QC8960.SOC8960AA
	if not exist SUPPORT.DESKTOP.BASE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ %SVNLoc% checkout %COMLoc%SUPPORT.DESKTOP.MOBILE_COMPONENTS
	echo.
	color 0a
	echo Downloading Drivers Done!
	pause
)
if %model%==e (
	cls
	color 0b
	title Downloading Drivers ...
	if not exist Drivers\ mkdir Drivers
	if not exist Drivers\components\ mkdir Drivers\components
	cd Drivers\
	if not exist README.md %WGETLoc% %READMELoc%
	cd components\
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
	echo.
	color 0a
	echo Downloading Drivers Done!
	pause
)
if %model%==f (
	cls
	color 0b
	title Downloading Drivers ...
	if not exist Drivers\ mkdir Drivers
	if not exist Drivers\components\ mkdir Drivers\components
	cd Drivers\
	if not exist README.md %WGETLoc% %READMELoc%
	cd components\
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
	echo.
	color 0a
	echo Downloading Drivers Done!
	pause
)
if %model%==g (
	cls
	if exist Drivers\ (
		title ERROR!
		color 0c
		echo Please delete or move previous drivers when downloading all drivers.
		pause
		goto ChooseDev
	)
	color 0b
	title Downloading Drivers ...
	%WGETLoc% https://github.com/WOA-Project/Lumia-Drivers/archive/master.zip
	title Extracting Drivers ...
	%SzLoc% x master.zip Lumia-Drivers-master
	ren Lumia-Drivers-master Drivers
	del master.zip
	echo.
	color 0a
	echo Downloading Drivers Done!
	pause
)
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

:setESC
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set ESC=%%b
)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
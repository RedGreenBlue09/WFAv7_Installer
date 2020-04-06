@echo off
:ChooseDev
cd /D "%~dp0"
set Model=
mode con: cols=96 lines=24
cls
color 0f
echo ////////////////////////////////////////////////////////////////////////////////////////////////
echo //                                WFAv7 Driver Downloader 1.5                                 //
echo //                                    by RedGreenBlue123                                      //
echo ////////////////////////////////////////////////////////////////////////////////////////////////
echo.
echo Choose your Device Model below:
echo  1) Lumia 930
echo  2) Lumia Icon
echo  3) Lumia 1520
echo  4) Lumia 1520 AT^&T
echo  5) Lumia 830 Global
echo  6) Lumia 735 Global
echo  7) Lumia 640 XL LTE Global
echo  8) Lumia 640 XL LTE AT^&T
echo  A) Lumia 650 [experimental only]
echo  B) Lumia 920 [Will be used in the Installer]
echo  C) Lumia 1020 [Will be used in the Installer]
echo  D) Lumia 1020 AT^&T
echo  E) All Drivers
set /p Model=Device: 
if "%model%"=="" goto ChooseDev
if %model%==1 (
	cls
	color 0b
	title Downloading Drivers ...
	if not exist Drivers\ mkdir Drivers
	if not exist Drivers\components\ mkdir Drivers\components
	cd Drivers\
	if not exist README.md ..\Files\DownloaderFiles\wget https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/README.md
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8974.MARTINI\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.SOC_QC8974.MARTINI
	if not exist OEM.SOC_QC8974.NMO\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/OEM.SOC_QC8974.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8974.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8974.BASE
	if not exist SUPPORT.DESKTOP.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_COMPONENTS
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
	if not exist README.md ..\Files\DownloaderFiles\wget https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/README.md
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8974.VANQUISH\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.SOC_QC8974.VANQUISH
	if not exist OEM.SOC_QC8974.NMO\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/OEM.SOC_QC8974.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8974.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8974.BASE
	if not exist SUPPORT.DESKTOP.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_COMPONENTS
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
	if not exist README.md ..\Files\DownloaderFiles\wget https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/README.md
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8974.BANDIT\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.SOC_QC8974.BANDIT
	if not exist OEM.SOC_QC8974.NMO\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/OEM.SOC_QC8974.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8974.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8974.BASE
	if not exist SUPPORT.DESKTOP.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_COMPONENTS
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
	if not exist README.md ..\Files\DownloaderFiles\wget https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/README.md
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8974.BANDITATT\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.SOC_QC8974.BANDITATT
	if not exist OEM.SOC_QC8974.NMO\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/OEM.SOC_QC8974.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8974.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8974.BASE
	if not exist SUPPORT.DESKTOP.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_COMPONENTS
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
	if not exist README.md ..\Files\DownloaderFiles\wget https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/README.md
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8X26.TESLA\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.SOC_QC8X26.TESLA
	if not exist OEM.SOC_QC8X26.NMO\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/OEM.SOC_QC8X26.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8X26.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8X26.BASE
	if not exist SUPPORT.DESKTOP.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_COMPONENTS
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
	if not exist README.md ..\Files\DownloaderFiles\wget https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/README.md
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8X26.SUPERMAN\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.SOC_QC8X26.SUPERMAN
	if not exist OEM.SOC_QC8X26.NMO\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/OEM.SOC_QC8X26.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8X26.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8X26.BASE
	if not exist SUPPORT.DESKTOP.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_COMPONENTS
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
	if not exist README.md ..\Files\DownloaderFiles\wget https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/README.md
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8X26.MAKEPEACE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.SOC_QC8X26.MAKEPEACE
	if not exist OEM.SOC_QC8X26.NMO\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/OEM.SOC_QC8X26.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8X26.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8X26.BASE
	if not exist SUPPORT.DESKTOP.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_COMPONENTS
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
	if not exist README.md ..\Files\DownloaderFiles\wget https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/README.md
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8X26.MAKEPEACEATT\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.SOC_QC8X26.MAKEPEACEATT
	if not exist OEM.SOC_QC8X26.NMO\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/OEM.SOC_QC8X26.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8X26.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8X26.BASE
	if not exist SUPPORT.DESKTOP.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_COMPONENTS
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
	if not exist README.md ..\Files\DownloaderFiles\wget https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/README.md
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8909.SAANA\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.SOC_QC8909.SAANA
	if not exist OEM.SOC_QC8909.MMO\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/OEM.SOC_QC8909.MMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8909.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8909.BASE
	if not exist PLATFORM.SOC_QC8909.MMO\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8909.MMO
	if not exist PLATFORM.SOC_QC8909.MMO_OTHERS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8909.MMO_OTHERS
	if not exist SUPPORT.DESKTOP.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MMO_EXTRAS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MMO_EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_COMPONENTS
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
	if not exist README.md ..\Files\DownloaderFiles\wget https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/README.md
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8960.PHI\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.SOC_QC8960.PHI
	if not exist OEM.SOC_QC8960.NMO\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/OEM.SOC_QC8960.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8960.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8960.BASE
	if not exist PLATFORM.SOC_QC8960.SOC8960AA\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8960.SOC8960AA
	if not exist SUPPORT.DESKTOP.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_COMPONENTS
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
	if not exist README.md ..\Files\DownloaderFiles\wget https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/README.md
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8960.EOS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.SOC_QC8960.EOS
	if not exist OEM.SOC_QC8960.NMO\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/OEM.SOC_QC8960.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8960.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8960.BASE
	if not exist PLATFORM.SOC_QC8960.SOC8960AA\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8960.SOC8960AA
	if not exist SUPPORT.DESKTOP.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_COMPONENTS
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
	if not exist README.md ..\Files\DownloaderFiles\wget https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/README.md
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8960.EOSATT\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.SOC_QC8960.EOSATT
	if not exist OEM.SOC_QC8960.NMO\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/OEM.SOC_QC8960.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8960.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8960.BASE
	if not exist PLATFORM.SOC_QC8960.SOC8960AA\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8960.SOC8960AA
	if not exist SUPPORT.DESKTOP.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_COMPONENTS
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
	if not exist README.md ..\Files\DownloaderFiles\wget https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/README.md
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8909.SAANA\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.SOC_QC8909.SAANA
	if not exist OEM.SOC_QC8909.MMO\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/OEM.SOC_QC8909.MMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8909.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8909.BASE
	if not exist PLATFORM.SOC_QC8909.MMO\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8909.MMO
	if not exist PLATFORM.SOC_QC8909.MMO_OTHERS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8909.MMO_OTHERS
	if not exist SUPPORT.DESKTOP.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MMO_EXTRAS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MMO_EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_COMPONENTS
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
	if not exist README.md ..\Files\DownloaderFiles\wget https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/README.md
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8960.PHI\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.SOC_QC8960.PHI
	if not exist OEM.SOC_QC8960.NMO\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/OEM.SOC_QC8960.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8960.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8960.BASE
	if not exist PLATFORM.SOC_QC8960.SOC8960AA\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8960.SOC8960AA
	if not exist SUPPORT.DESKTOP.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_COMPONENTS
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
	if not exist README.md ..\Files\DownloaderFiles\wget https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/README.md
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8960.EOS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.SOC_QC8960.EOS
	if not exist OEM.SOC_QC8960.NMO\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/OEM.SOC_QC8960.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8960.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8960.BASE
	if not exist PLATFORM.SOC_QC8960.SOC8960AA\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8960.SOC8960AA
	if not exist SUPPORT.DESKTOP.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_COMPONENTS
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
	if not exist README.md ..\Files\DownloaderFiles\wget https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/README.md
	cd components\
	title Downloading Drivers ...
	if not exist DEVICE.SOC_QC8960.EOSATT\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.SOC_QC8960.EOSATT
	if not exist OEM.SOC_QC8960.NMO\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/OEM.SOC_QC8960.NMO
	if not exist DEVICE.INPUT.SYNAPTICS_RMI4\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.INPUT.SYNAPTICS_RMI4
	if not exist PLATFORM.SOC_QC8960.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8960.BASE
	if not exist PLATFORM.SOC_QC8960.SOC8960AA\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8960.SOC8960AA
	if not exist SUPPORT.DESKTOP.BASE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.BASE
	if not exist SUPPORT.DESKTOP.EXTRAS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.EXTRAS
	if not exist SUPPORT.DESKTOP.MOBILE_BRIDGE\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_BRIDGE
	if not exist SUPPORT.DESKTOP.MOBILE_COMPONENTS\ ..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_COMPONENTS
	echo.
	color 0a
	echo Downloading Drivers Done!
	pause
)
if %model%==e (
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
	Files\DownloaderFiles\wget https://github.com/WOA-Project/Lumia-Drivers/archive/master.zip
	title Extracting Drivers ...
	Files\DownloaderFiles\7za x master.zip Lumia-Drivers-master
	ren Lumia-Drivers-master Drivers
	del master.zip
	echo.
	color 0a
	echo Downloading Drivers Done!
	pause
)
if %model%==E (
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
	Files\DownloaderFiles\wget https://github.com/WOA-Project/Lumia-Drivers/archive/master.zip
	title Extracting Drivers ...
	Files\DownloaderFiles\7za x master.zip Lumia-Drivers-master
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

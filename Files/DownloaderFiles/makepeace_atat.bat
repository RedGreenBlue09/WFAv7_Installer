@echo off
cls
mkdir Drivers
mkdir Drivers\components
cd Drivers\
..\DownloaderFiles\wget https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/README.md
cd components\
..\..\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.SOC_QC8X26.MAKEPEACEATT
..\..\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/OEM.SOC_QC8X26.NMO
..\..\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.INPUT.SYNAPTICS_RMI4
..\..\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8X26.BASE
..\..\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.BASE
..\..\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.EXTRAS
..\..\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_BRIDGE
..\..\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_COMPONENTS


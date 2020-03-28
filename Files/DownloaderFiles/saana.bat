@echo off
cls
mkdir Drivers
mkdir Drivers\components
cd Drivers\
..\Files\DownloaderFiles\wget https://raw.githubusercontent.com/WOA-Project/Lumia-Drivers/master/README.md
cd components\
..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.SOC_QC8909.SAANA
..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/OEM.SOC_QC8909.MMO
..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/DEVICE.INPUT.SYNAPTICS_RMI4
..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8909.BASE
..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/PLATFORM.SOC_QC8909.MMO
..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.BASE
..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.EXTRAS
..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MMO_EXTRAS
..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_BRIDGE
..\..\Files\DownloaderFiles\svn checkout https://github.com/WOA-Project/Lumia-Drivers/trunk/components/SUPPORT.DESKTOP.MOBILE_COMPONENTS


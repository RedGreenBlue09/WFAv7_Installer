@echo off
title Starting Installer ...

WHERE powershell >nul
IF %ERRORLEVEL% NEQ 0 (
	TITLE ERROR!
	ECHO.
	ECHO   Powershell wasn't found.
	ECHO   Please enable Powershell and continue.
	PAUSE
	EXIT
)
cls
echo Installer is loading ... [4%%]

WHERE DISM >nul
IF %ERRORLEVEL% NEQ 0 (
	TITLE ERROR!
	ECHO.
	ECHO   DISM wasn't found.
	PAUSE
	EXIT
)

cls
if exist "%~dp0\drivers\README.md" (
	cls
	echo Installer is loading ... [7%%]
)
if not exist "%~dp0\drivers\README.md" (
	TITLE ERROR!
	echo.
	echo  Extract Drivers to Drivers folder and try again.
	echo  Remember NEVER creates Subfolders or extract subfolders.
	pause
	exit
)

echo   - Checking install.wim ...
if exist "%~dp0\install.wim" (
	cls
	echo Installer is loading ... [10%%]
)
if not exist "%~dp0\install.wim" (
	TITLE ERROR!
	echo.
	echo  Place install.wim in the Installer folder and try again.
	pause
	exit
)

IF NOT EXIST M:\ (
	cls
	ECHO Installer is loading ... [12%%]
)
IF EXIST M:\ (
	TITLE ERROR!
	ECHO.
	ECHO   Please Unmount Drive [M:]
	PAUSE
	EXIT
)

IF NOT EXIST N:\ (
	cls
	ECHO Installer is loading ... [15%%]
)
IF EXIST N:\ (
	TITLE ERROR!
	ECHO.
	ECHO   Please Unmount Drive [N:]
	PAUSE
	EXIT
)

IF NOT EXIST Q:\ (
	cls
	ECHO Installer is loading ... [18%%]
)
IF EXIST Q:\ (
	TITLE ERROR!
	ECHO.
	ECHO   Please Unmount Drive [Q:]
	PAUSE
	EXIT
)

cls
echo Installer is loading ... [20%%]

WHERE BCDEDIT >nul
IF %ERRORLEVEL% NEQ 0 (
	TITLE ERROR!
	ECHO.
	ECHO   BCDEDIT wasn't found.
	PAUSE
	EXIT
)
cls
echo Installer is loading ... [25%%]

powershell -Command "(Get-Module -ListAvailable -All).name -Contains 'Volume'" | find "True"
	cls
	echo Installer is loading ... [40%%]
if errorlevel 1 (
	TITLE ERROR!
	echo.
	echo  Please Install Windows PowerShell Modules.
	PAUSE
	EXIT
)

powershell -Command "(Get-Module -ListAvailable -All).name -Contains 'Disk'" | find "True"
	cls
	echo Installer is loading ... [60%%]
if errorlevel 1 (
	TITLE ERROR!
	echo.
	echo  Please Install Windows PowerShell Modules.
	PAUSE
	EXIT
)

powershell -Command "(Get-Module -ListAvailable -All).name -Contains 'Storage'" | find "True"
	cls
	echo Installer is loading ... [80%%]
if errorlevel 1 (
	TITLE ERROR!
	echo.
	echo  Please Install Windows PowerShell Modules.
	PAUSE
	EXIT
)

powershell -Command "(Get-Module -ListAvailable -All).name -Contains 'Hyper-V'" | find "True"
	cls
	echo Installer is loading ... [100%%]
if errorlevel 1 (
	TITLE ERROR!
	echo.
	echo  Please enable Hyper-V in Windows Features. [VT-x is not needed]
	PAUSE
	EXIT
)

cls
mode con: cols=96 lines=24
title Windows 10 for ARMv7 Installer (VHDX) Alpla 2
echo ///////////////////////////////////////////////////////////////////////////////////////////////
echo //                         Windows 10 for ARMv7 Installer (VHDX) A2                          //
echo //                                    by RedGreenBlue123                                     //
echo //               Thanks to @Heathcliff74, @driver1998, @Gus33000, @Fadil Fadz                //
echo ///////////////////////////////////////////////////////////////////////////////////////////////
echo.
echo DISCLAIMER:
echo     * I'm not responsible for bricked devices, dead SD cards,
echo       thermonuclear war, or you getting fired because the alarm app failed.
echo     * YOU are choosing to make these modifications,
echo       and if you point the finger at me for messing up your device, I will laugh at you.
echo     * Your warranty will be void if you tamper with any part of your device / software.
echo.
echo PREPARATION:
echo     * Make sure your phone is fully charged and it's battery is not wear too much.
echo     * Unlocked bootloader and boot into Mass Storage Mode.
pause
:ChooseDev
cls
echo ///////////////////////////////////////////////////////////////////////////////////////////////
echo //                         Windows 10 for ARMv7 Installer (VHDX) A2                          //
echo //                                    by RedGreenBlue123                                     //
echo //               Thanks to @Heathcliff74, @driver1998, @Gus33000, @Fadil Fadz                //
echo ///////////////////////////////////////////////////////////////////////////////////////////////
echo.
echo Choose your Device Model below:
echo 1) Lumia 930 / Icon
echo 2) Lumia 1520
echo 3) Lumia 1520 (16GB)
echo 4) Lumia 1520 AT^&T
echo 5) Lumia 1520 AT^&T (16GB)
echo 6) Lumia 830 Global
echo 7) Lumia 735 Global
echo 8) Lumia 640 XL LTE Global
echo 9) Lumia 640 XL AT^&T
set /p Model=Device: 
if %model%==1 "%~dp0\files\martini_icon.bat"
if %model%==2 "%~dp0\files\bandit.bat"
if %model%==3 "%~dp0\files\bandit_16g.bat"
if %model%==4 "%~dp0\files\bandit_atat.bat"
if %model%==5 "%~dp0\files\bandit_atat_16g.bat"
if %model%==6 "%~dp0\files\tesla.bat"
if %model%==7 "%~dp0\files\superman.bat"
if %model%==8 "%~dp0\files\makepeace.bat"
if %model%==9 "%~dp0\files\makepeace_atat.bat"
if not %model%==1 goto ChooseDev
if not %model%==2 goto ChooseDev
if not %model%==3 goto ChooseDev
if not %model%==4 goto ChooseDev
if not %model%==5 goto ChooseDev
if not %model%==6 goto ChooseDev
if not %model%==7 goto ChooseDev
if not %model%==8 goto ChooseDev
if not %model%==9 goto ChooseDev

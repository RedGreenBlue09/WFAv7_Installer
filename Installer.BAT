@echo off
title Starting Installer ...

POWERSHELL -? >nul
SET PLV=%ERRORLEVEL%
IF %PLV% NEQ 0 (
	TITLE ERROR!
	COLOR 0C
	ECHO.
	ECHO   Powershell wasn't found or it have problem.
	ECHO   Please enable Powershell and continue.
	ECHO   Error code: %PLV%
	PAUSE
	EXIT
)
cls
echo Installer is loading ... [4%%]

WHERE DISM >nul
IF %ERRORLEVEL% NEQ 0 (
	TITLE ERROR!
	COLOR 0C
	ECHO.
	ECHO   DISM wasn't found or it has problem.
	PAUSE
	EXIT
)

cls
if exist "%~dp0\drivers\README.md" (
	cls
	echo Installer is loading ... [8%%]
)
if not exist "%~dp0\drivers\README.md" (
	TITLE ERROR!
	COLOR 0C
	echo.
	echo  Extract Drivers to Drivers folder and try again.
	echo  Remember NEVER creates Subfolders or extract subfolders.
	pause
	exit
)

echo   - Checking install.wim ...
if exist "%~dp0\install.wim" (
	cls
	echo Installer is loading ... [12%%]
)
if not exist "%~dp0\install.wim" (
	TITLE ERROR!
	COLOR 0C
	echo.
	echo  Place install.wim in the Installer folder and try again.
	pause
	exit
)

IF NOT EXIST M:\ (
	cls
	ECHO Installer is loading ... [15%%]
)
IF EXIST M:\ (
	TITLE ERROR!
	COLOR 0C
	ECHO.
	ECHO   Please Unmount Drive [M:]
	PAUSE
	EXIT
)

IF NOT EXIST N:\ (
	cls
	ECHO Installer is loading ... [18%%]
)
IF EXIST N:\ (
	TITLE ERROR!
	COLOR 0C
	ECHO.
	ECHO   Please Unmount Drive [N:]
	PAUSE
	EXIT
)

cls
echo Installer is loading ... [20%%]

WHERE bcdedit >nul
IF %ERRORLEVEL% NEQ 0 (
	TITLE ERROR!
	COLOR 0C
	ECHO.
	ECHO   BCDEDIT wasn't found or it has problem.
	PAUSE
	EXIT
)
cls
echo Installer is loading ... [25%%]

powershell -Command "(Get-WindowsOptionalFeature -FeatureName Microsoft-Hyper-V -Online).State" | findstr /I "Enabled"
if errorlevel 0 (
	cls
	echo Installer is loading ... [30%%]
) else (
	TITLE ERROR!
	COLOR 0C
	echo.
	echo  Please enable Hyper-V in Windows Features. [VT-x is not needed]
	PAUSE
	EXIT
)

powershell -Command "(Get-Module -ListAvailable -All).name -Contains 'Volume'" | find "True"
	cls
	echo Installer is loading ... [45%%]
if errorlevel 1 (
	TITLE ERROR!
	COLOR 0C
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
	COLOR 0C
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
	COLOR 0C
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
	COLOR 0C
	echo.
	echo  Please enable Hyper-V in Windows Features. [VT-x is not needed]
	PAUSE
	EXIT
)

cls
mode con: cols=96 lines=24
title Windows 10 for ARMv7 Installer (VHDX) Beta 1
echo ////////////////////////////////////////////////////////////////////////////////////////////////
echo //                         Windows 10 for ARMv7 Installer (VHDX) B1                           //
echo //                                    by RedGreenBlue123                                      //
echo //                Thanks to @Heathcliff74, @driver1998, @Gus33000, @Fadil Fadz                //
echo ////////////////////////////////////////////////////////////////////////////////////////////////
echo.
echo DISCLAIMER:
echo     * I'm not responsible for bricked devices, dead SD cards,
echo       thermonuclear war, or you getting fired because the alarm app failed.
echo     * YOU are choosing to make these modifications,
echo       and if you point the finger at me for messing up your device, I will laugh at you.
echo     * Your warranty will be void if you tamper with any part of your device / software.
echo PREPARATION:
echo     * Read README.TXT before use this Installer.
echo     * Make sure your phone is fully charged and it's battery is not wear too much.
echo     * Unlocked bootloader and boot into Mass Storage Mode.
pause
:ChooseDev
cls
echo ////////////////////////////////////////////////////////////////////////////////////////////////
echo //                         Windows 10 for ARMv7 Installer (VHDX) B1                           //
echo //                                    by RedGreenBlue123                                      //
echo //                Thanks to @Heathcliff74, @driver1998, @Gus33000, @Fadil Fadz                //
echo ////////////////////////////////////////////////////////////////////////////////////////////////
echo.
echo Choose your Device Model below:
echo  1) Lumia 930
echo  2) Lumia Icon
echo  3) Lumia 1520
echo  4) Lumia 1520 (16GB)
echo  5) Lumia 1520 AT^&T
echo  6) Lumia 1520 AT^&T (16GB)
echo  7) Lumia 830 Global
echo  8) Lumia 735 Global
echo  A) Lumia 640 XL LTE Global
echo  B) Lumia 640 XL LTE AT^&T
echo  C) Lumia 650 [experimental only]
set /p Model=Device: 
if "%model%"=="" goto ChooseDev
if %model%==1 "%~dp0\files\martini.bat"
if %model%==2 "%~dp0\files\vanquish.bat"
if %model%==3 "%~dp0\files\bandit.bat"
if %model%==4 "%~dp0\files\bandit_16g.bat"
if %model%==5 "%~dp0\files\bandit_atat.bat"
if %model%==6 "%~dp0\files\bandit_atat_16g.bat"
if %model%==7 "%~dp0\files\tesla.bat"
if %model%==8 "%~dp0\files\superman.bat"
if %model%==A "%~dp0\files\makepeace.bat"
if %model%==B "%~dp0\files\makepeace_atat.bat"
if %model%==C "%~dp0\files\saana.bat"
if %model%==a "%~dp0\files\makepeace.bat"
if %model%==b "%~dp0\files\makepeace_atat.bat"
if %model%==c "%~dp0\files\saana.bat"
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
if not %model%==a goto ChooseDev
if not %model%==b goto ChooseDev
if not %model%==c goto ChooseDev

@echo off
:Check1
IF EXIST M:\ (
	TITLE ERROR!
	COLOR 0C
	ECHO.
	ECHO   Please Unmount Drive [M:]
	PAUSE
	EXIT
)
IF EXIST N:\ (
	TITLE ERROR!
	COLOR 0C
	ECHO.
	ECHO   Please Unmount Drive [N:]
	PAUSE
	EXIT
)
::---------------------------------------------------------------
:GetAdministrator
REM  --> Requesting administrative privilege...
    IF "%PROCESSOR_ARCHITECTURE%" EQU "AMD64" ( >nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system" )
    IF "%PROCESSOR_ARCHITECTURE%" EQU "ARM64" ( >nul 2>&1 "%SYSTEMROOT%\SysArm32\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system" )
    IF "%PROCESSOR_ARCHITECTURE%" EQU "X86" (
	>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
) else ( >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" )


REM --> Please run as Administrator.
if '%errorlevel%' NEQ '0' (
	echo Requesting administrative privileges...
	goto UserAccountControl
) else ( goto GotAdministrator )

:UserAccountControl
	echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
	set params= %*
	echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"
	"%temp%\getadmin.vbs"
	del "%temp%\getadmin.vbs"
	exit /B

:GotAdministrator
	pushd "%CD%"
	CD /D "%~dp0"
	goto Check2
::---------------------------------------------------------------
:Check2
title Starting Installer ...

POWERSHELL /? >nul
SET PLV=%ERRORLEVEL%
IF %PLV% NEQ 0 (
	TITLE ERROR!
	COLOR 0C
	ECHO.
	ECHO   Powershell isn't found or it have problem.
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
	ECHO   DISM isn't found or it has problem.
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
	COLOR 0C
	echo.
	echo  Extract Drivers to Drivers folder and try again.
	echo  Remember NEVER creates Subfolders or extract subfolders.
	pause
	exit
)

if exist "%~dp0\install.wim" (
	cls
	echo Installer is loading ... [9%%]
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
	ECHO Installer is loading ... [12%%]
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
	ECHO Installer is loading ... [15%%]
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
echo Installer is loading ... [18%%]

WHERE bcdedit >nul
IF %ERRORLEVEL% NEQ 0 (
	TITLE ERROR!
	COLOR 0C
	ECHO.
	ECHO   BCDEDIT isn't found or it has problem.
	PAUSE
	EXIT
)
cls
echo Installer is loading ... [20%%]

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
if errorlevel 1 (
	TITLE ERROR!
	COLOR 0C
	echo.
	echo  You used Windows 7 / Windows Home edition / Customized Windows.
	echo  Please use Official Windows 8.1 Pro or Windows 10 Pro
	PAUSE
	EXIT
)
cls
echo Installer is loading ... [45%%]

powershell -Command "(Get-Module -ListAvailable -All).name -Contains 'Disk'" | find "True"
if errorlevel 1 (
	TITLE ERROR!
	COLOR 0C
	echo.
	echo  You used Windows 7 / Windows Home edition / Customized Windows.
	echo  Please use Official Windows 8.1 Pro or Windows 10 Pro
	PAUSE
	EXIT
)
cls
echo Installer is loading ... [60%%]

powershell -Command "(Get-Module -ListAvailable -All).name -Contains 'Storage'" | find "True"
if errorlevel 1 (
	TITLE ERROR!
	COLOR 0C
	echo.
	echo  You used Windows 7 / Windows Home edition / Customized Windows.
	echo  Please use Official Windows 8.1 Pro or Windows 10 Pro
	PAUSE
	EXIT
)
cls
echo Installer is loading ... [80%%]

powershell -Command "(Get-Module -ListAvailable -All).name -Contains 'Hyper-V'" | find "True"
if errorlevel 1 (
	TITLE ERROR!
	COLOR 0C
	echo.
	echo  Hyper-V is not fully enabled.
	PAUSE
	EXIT
)
cls
echo Installer is loading ... [100%%]
::---------------------------------------------------------------
cls
mode 96,2400
powershell -command "&{(get-host).ui.rawui.windowsize=@{width=96;height=24};}"
title Windows 10 for ARMv7 Installer (VHDX) Proximal Release 3
echo  //////////////////////////////////////////////////////////////////////////////////////////////
echo  //                        Windows 10 for ARMv7 Installer (VHDX) PR3                         //
echo  //                                   by RedGreenBlue123                                     //
echo  //                      Thanks to: @Gus33000, @FadilFadz01, @demonttl                       //
echo  //////////////////////////////////////////////////////////////////////////////////////////////
echo.
echo DISCLAIMER:
echo     * I'm not responsible for bricked devices, dead SD cards,
echo       thermonuclear war, or you getting fired because the alarm app failed.
echo     * YOU are choosing to make these modifications,
echo       and if you point the finger at me for messing up your device, I will laugh at you.
echo     * Your warranty will be void if you tamper with any part of your device / software.
echo PREPARATION:
echo     - Read README.TXT before use this Installer.
echo     - Make sure your phone is fully charged and it's battery is not wear too much.
echo     - Make sure no drives mounted in M and N.
echo     - Unlocked bootloader and booted into Mass Storage Mode.
echo.
pause
::---------------------------------------------------------------
:ChooseDev
cls
echo  //////////////////////////////////////////////////////////////////////////////////////////////
echo  //                        Windows 10 for ARMv7 Installer (VHDX) PR3                         //
echo  //                                   by RedGreenBlue123                                     //
echo  //                      Thanks to: @Gus33000, @FadilFadz01, @demonttl                       //
echo  //////////////////////////////////////////////////////////////////////////////////////////////
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
echo  C) Lumia 950
echo  D) Lumia 950 XL
set /p Model=Device: 
if "%model%"=="" goto ChooseDev
if %model%==1 set Storage=32 & goto ToBeContinued1
if %model%==2 set Storage=32 & goto ToBeContinued1
if %model%==3 set Storage=32 & goto ToBeContinued1
if %model%==4 set Storage=16 & goto ToBeContinued1
if %model%==5 set Storage=32 & goto ToBeContinued1
if %model%==6 set Storage=16 & goto ToBeContinued1
if %model%==7 set Storage=16 & goto ToBeContinued1
if %model%==8 set Storage=8 & goto ToBeContinued1
if %model%==A set Storage=8 & goto ToBeContinued1
if %model%==B set Storage=8 & goto ToBeContinued1
if %model%==C set Storage=32 & goto ToBeContinued1
if %model%==D set Storage=32 & goto ToBeContinued1
if %model%==a set Storage=8 & goto ToBeContinued1
if %model%==b set Storage=8 & goto ToBeContinued1
if %model%==c set Storage=32 & goto ToBeContinued1
if %model%==d set Storage=32 & goto ToBeContinued1
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
if not %model%==a goto ChooseDev
if not %model%==b goto ChooseDev
if not %model%==c goto ChooseDev
if not %model%==d goto ChooseDev
::---------------------------------------------------------------
:ToBeContinued1
cls
echo  //////////////////////////////////////////////////////////////////////////////////////////////
echo  //                        Windows 10 for ARMv7 Installer (VHDX) PR3                         //
echo  //                                   by RedGreenBlue123                                     //
echo  //                      Thanks to: @Gus33000, @FadilFadz01, @demonttl                       //
echo  //////////////////////////////////////////////////////////////////////////////////////////////
echo.
if %Storage%==8 echo  - You need at least ^> 4.0 GB of Phone Storage to continue.
if %Storage%==16 echo  - You need at least ^> 8.0 GB of Phone Storage to continue.
if %Storage%==32 echo  - You need at least ^> 16.0 GB of Phone Storage to continue.
echo.
pause
goto MOSPath
:MOSPath
set MainOS=
echo.
set /p MainOS=Enter MainOS Path: 
for /f %%m in ('powershell -C "(echo %MainOS%).length -eq 2"') do set Lenght2=%%m
if %Lenght2%==False (
	ECHO  Not a valid MainOS partition!
	GOTO MOSPath
)
if not exist "%MainOS%\EFIESP" (
	ECHO  Not a valid MainOS partition!
	GOTO MOSPath
)
if not exist "%MainOS%\Data" (
	ECHO  Not a valid MainOS partition!
	GOTO MOSPath
)
::---------------------------------------------------------------
:ToBeContinued2
color 0b
echo.
if %Storage%==8 (
	echo Creating 4 GB VHDX image ...
	powershell New-VHD -Path %MainOS%\Data\windows10arm.vhdx -Fixed -SizeBytes 4096MB
)
if %Storage%==16 (
	echo Creating 8 GB VHDX image ...
	powershell New-VHD -Path %MainOS%\Data\windows10arm.vhdx -Fixed -SizeBytes 8192MB
)
if %Storage%==32 (
	echo Creating 16 GB VHDX image ...
	powershell New-VHD -Path %MainOS%\Data\windows10arm.vhdx -Fixed -SizeBytes 16384MB
)
echo.
echo Creating Partitions ...
powershell Mount-VHD -Path %MainOS%\Data\windows10arm.vhdx
powershell Initialize-Disk -Number (Get-VHD -Path %MainOS%\Data\windows10arm.vhdx).DiskNumber -PartitionStyle GPT -confirm:$false
:: Create ESP
powershell New-Partition -DiskNumber (Get-VHD -Path %MainOS%\Data\windows10arm.vhdx).DiskNumber -GptType '{c12a7328-f81f-11d2-ba4b-00a0c93ec93b}' -Size 100MB -DriveLetter M
powershell Format-Volume -DriveLetter M -FileSystem Fat32 -NewFileSystemLabel "ESP" -confirm:$false
:: Create MSR
powershell New-Partition -DiskNumber (Get-VHD -Path %MainOS%\Data\windows10arm.vhdx).DiskNumber -GptType '{e3c9e316-0b5c-4db8-817d-f92df00215ae}' -Size 128MB
:: Create Win10 Partition
powershell New-Partition -DiskNumber (Get-VHD -Path %MainOS%\Data\windows10arm.vhdx).DiskNumber -GptType '{ebd0a0a2-b9e5-4433-87c0-68b6b72699c7}' -UseMaximumSize -DriveLetter N
if %Storage%==8 ( format N: /FS:NTFS /V:Windows10 /Q /C /Y )
if %Storage%==16 ( format N: /FS:NTFS /V:Windows10 /Q /Y  )
if %Storage%==32 ( format N: /FS:NTFS /V:Windows10 /Q /Y  )
::---------------------------------------------------------------
echo.
echo Installing Windows 10 for ARMv7 ...
if %Storage%==8 DISM /Apply-Image /imagefile:".\install.wim" /Index:1 /ApplyDir:N:\ /compact
if %Storage%==16 DISM /Apply-Image /imagefile:".\install.wim" /Index:1 /ApplyDir:N:\
if %Storage%==32 DISM /Apply-Image /imagefile:".\install.wim" /Index:1 /ApplyDir:N:\
::---------------------------------------------------------------
echo.
echo Installing Drivers ...
if %model%==1 (
	:: Device's Driver
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8974.MARTINI" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse
	:: MSM8974's Driver
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8974.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8974.NMO" /Recurse
	:: Windows 10 For ARMv7 Drivers
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse
)
if %model%==2 (
	:: Device's Driver
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8974.VANQUISH" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse
	:: MSM8974's Driver
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8974.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8974.NMO" /Recurse
	:: Windows 10 For ARMv7 Drivers
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse
)
if %model%==3 (
	:: Device's Driver
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8974.BANDIT" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse
	:: MSM8974's Driver
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8974.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8974.NMO" /Recurse
	:: Windows 10 For ARMv7 Drivers
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse
)
if %model%==4 (
	:: Device's Driver
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8974.BANDIT" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse
	:: MSM8974's Driver
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8974.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8974.NMO" /Recurse
	:: Windows 10 For ARMv7 Drivers
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse
)
if %model%==5 (
	:: Device's Driver
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8974.BANDITATT" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse
	:: MSM8974's Driver
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8974.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8974.NMO" /Recurse
	:: Windows 10 For ARMv7 Drivers
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse
)
if %model%==6 (
	:: Device's Driver
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8974.BANDITATT" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse
	:: MSM8974's Driver
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8974.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8974.NMO" /Recurse
	:: Windows 10 For ARMv7 Drivers
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse
)
if %model%==7 (
	:: Device's Driver
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8X26.TESLA" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse
	:: MSM8X26's Driver
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8X26.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8X26.NMO" /Recurse
	:: Windows 10 For ARMv7 Drivers
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse
)
if %model%==8 (
	:: Device's Driver
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8X26.SUPERMAN" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse
	:: MSM8X26's Driver
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8X26.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8X26.NMO" /Recurse
	:: Windows 10 For ARMv7 Drivers
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse
)
if %model%==a (
	:: Device's Driver
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8X26.MAKEPEACE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse
	:: MSM8X26's Driver
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8X26.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8X26.NMO" /Recurse
	:: Windows 10 For ARMv7 Drivers
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse
)
if %model%==b (
	:: Device's Driver
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8X26.MAKEPEACEATT" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse
	:: MSM8X26's Driver
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8X26.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8X26.NMO" /Recurse
	:: Windows 10 For ARMv7 Drivers
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse
)
if %model%==c (
	:: Device's Drivers
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8994.TALKMAN" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4_F12_10" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.USB.MMO_USBC" /Recurse2
	:: MSM8992's Drivers
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.MMO" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.SOC8992" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.SOC8994AB" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8994.MMO" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8994.MMO_SOC8992" /Recurse
	:: Windows 10 For ARMv7 Drivers
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MMO_EXTRAS" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse
)
if %model%==d (
	:: Device's Drivers
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8994.CITYMAN" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4_F12_10" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.USB.MMO_USBC" /Recurse
	:: MSM8994's Drivers
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.MMO" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.SOC8994" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.SOC8994AB" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8994.MMO" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8994.MMO_SOC8994" /Recurse
	:: Windows 10 For ARMv7 Drivers
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MMO_EXTRAS" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse
)
if %model%==A (
	:: Device's Driver
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8X26.MAKEPEACE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse
	:: MSM8X26's Driver
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8X26.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8X26.NMO" /Recurse
	:: Windows 10 For ARMv7 Drivers
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse
)
if %model%==B (
	:: Device's Driver
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8X26.MAKEPEACEATT" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse
	:: MSM8X26's Driver
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8X26.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8X26.NMO" /Recurse
	:: Windows 10 For ARMv7 Drivers
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse
)
if %model%==C (
	:: Device's Drivers
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8994.TALKMAN" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4_F12_10" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.USB.MMO_USBC" /Recurse2
	:: MSM8992's Drivers
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.MMO" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.SOC8992" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.SOC8994AB" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8994.MMO" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8994.MMO_SOC8992" /Recurse
	:: Windows 10 For ARMv7 Drivers
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MMO_EXTRAS" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse
)
if %model%==D (
	:: Device's Drivers
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8994.CITYMAN" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4_F12_10" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.USB.MMO_USBC" /Recurse
	:: MSM8994's Drivers
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.MMO" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.SOC8994" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.SOC8994AB" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8994.MMO" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8994.MMO_SOC8994" /Recurse
	:: Windows 10 For ARMv7 Drivers
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MMO_EXTRAS" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse
)
::---------------------------------------------------------------
echo.
echo Copying EFI to VHDX image ...
xcopy .\Files\MassStorage %MainOS%\EFIESP\Windows\System32\Boot\ui /E /H /I /Y
echo.
echo Setting Up BCD ...
bcdboot N:\Windows /s M: /l en-us /f UEFI
::---------------------------------------------------------------
echo.
echo Patching BCD ...
SET bcdLoc="%MainOS%\EFIESP\efi\Microsoft\Boot\BCD"
SET id="{703c511b-98f3-4630-b752-6d177cbfb89c}"
bcdedit /store %bcdLoc% /create %id% /d "Windows 10 for ARMv7" /application "osloader"
bcdedit /store %bcdLoc% /set %id% "device" "vhd=[%MainOS%\Data]\windows10arm.vhdx"
bcdedit /store %bcdLoc% /set %id% "osdevice" "vhd=[%MainOS%\Data]\windows10arm.vhdx"
bcdedit /store %bcdLoc% /set %id% "path" "\windows\system32\winload.efi"
bcdedit /store %bcdLoc% /set %id% "locale" "en-US"
bcdedit /store %bcdLoc% /set %id% "testsigning" yes
bcdedit /store %bcdLoc% /set %id% "inherit" "{bootloadersettings}"
bcdedit /store %bcdLoc% /set %id% "systemroot" "\Windows"
bcdedit /store %bcdLoc% /set %id% "bootmenupolicy" "Standard"
bcdedit /store %bcdLoc% /set %id% "detecthal" Yes
bcdedit /store %bcdLoc% /set %id% "winpe" No
bcdedit /store %bcdLoc% /set %id% "ems" No
bcdedit /store %bcdLoc% /set %id% "bootdebug" No
bcdedit /store %bcdLoc% /set "{bootmgr}" "nointegritychecks" Yes
bcdedit /store %bcdLoc% /set "{bootmgr}" "testsigning" yes
bcdedit /store %bcdLoc% /set "{bootmgr}" "flightsigning" yes
bcdedit /store %bcdLoc% /set "{bootmgr}" "timeout" 5
bcdedit /store %bcdLoc% /set "{bootmgr}" "displaybootmenu" yes
bcdedit /store %bcdLoc% /set "{bootmgr}" "custom:54000001" %id%
ECHO.
ECHO BCD Patching Done!
::---------------------------------------------------------------
echo.
echo Setting up ESP ...
mkdir %MainOS%\EFIESP\EFI\Microsoft\Recovery\
copy M:\EFI\Microsoft\Recovery\BCD %MainOS%\EFIESP\EFI\Microsoft\Recovery\BCD /Y
set BCDRec=%MainOS%\EFIESP\EFI\Microsoft\Recovery\BCD 
bcdedit /store %BCDRec% /set {bootmgr} "device" "partition=%MainOS%\EFIESP"
bcdedit /store %BCDRec% /set {bootmgr} "path" "\EFI\Boot\Bootarm.efi"
bcdedit /store %BCDRec% /set {bootmgr} "timeout" "3"
set DLMOS=%MainOS:~0,-1%
for /f %%i in ('powershell -C "(Get-Partition | ? { $_.AccessPaths -eq '%MainOS%\EFIESP\' }).PartitionNumber"') do set PartitionNumber=%%i
for /f %%f in ('powershell -C "(Get-Partition -DriveLetter %DLMOS%).DiskNumber"') do set DiskNumber=%%f
echo>>diskpart.txt sel dis %DiskNumber%
echo>>diskpart.txt sel par %PartitionNumber%
echo>>diskpart.txt set id=c12a7328-f81f-11d2-ba4b-00a0c93ec93b
attrib +h diskpart.txt
diskpart /s diskpart.txt
del /A:H diskpart.txt
::---------------------------------------------------------------
echo.
echo Unmounting VHDX Image ...
powershell Dismount-VHD -Path "%MainOS%\Data\windows10arm.vhdx"
::---------------------------------------------------------------
color 0a
echo.
echo ================================================================================================
echo  - Done. Now, reboot your phone.
echo  - After the boot menu appears, press power up to boot Windows 10 for ARMv7.
echo  - Boot and setup Windows 10 for the first time. Then reboot the phone to mass storage mode.
echo  - Run PostInstall.bat.
echo ================================================================================================
pause

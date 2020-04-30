@echo off
:Check1
cd ..
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
	echo.
	echo   Powershell isn't found or it have problem.
	echo   Please enable Powershell and continue.
	echo   Error code: %PLV%
	PAUSE
	EXIT
)
cls
echo Installer is loading ... [4%%]

WHERE DISM >nul
IF %ERRORLEVEL% NEQ 0 (
	TITLE ERROR!
	COLOR 0C
	echo.
	echo   DISM isn't found or it has problem.
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
	echo Installer is loading ... [12%%]
)
IF EXIST M:\ (
	TITLE ERROR!
	COLOR 0C
	echo.
	echo   Please Unmount Drive [M:]
	PAUSE
	EXIT
)

IF NOT EXIST N:\ (
	cls
	echo Installer is loading ... [15%%]
)
IF EXIST N:\ (
	TITLE ERROR!
	COLOR 0C
	echo.
	echo   Please Unmount Drive [N:]
	PAUSE
	EXIT
)

cls
echo Installer is loading ... [18%%]

WHERE bcdedit >nul
IF %ERRORLEVEL% NEQ 0 (
	TITLE ERROR!
	COLOR 0C
	echo.
	echo   BCDEDIT isn't found or it has problem.
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
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set ESC=%%b
::---------------------------------------------------------------
cls
mode 96,2400
powershell -command "&{(get-host).ui.rawui.windowsize=@{width=96;height=24};}"
title Windows 10 for ARMv7 Installer (VHDX) Proximal Release 3
echo  %ESC%[93m//////////////////////////////////////////////////////////////////////////////////////////////
echo  //                        %ESC%[97mWindows 10 for ARMv7 Installer (VHDX) PR3%ESC%[93m                         //
echo  //                                   %ESC%[97mby RedGreenBlue123%ESC%[93m                                     //
echo  //                      %ESC%[97mThanks to: @Gus33000, @FadilFadz01, @demonttl%ESC%[93m                       //
echo  //////////////////////////////////////////////////////////////////////////////////////////////%ESC%[0m
echo.
echo %ESC%[95mDISCLAIMER:
echo     * I'm not responsible for bricked devices, dead SD cards,
echo       thermonuclear war, or you getting fired because the alarm app failed.
echo     * YOU are choosing to make these modifications,
echo       and if you point the finger at me for messing up your device, I will laugh at you.
echo     * Your warranty will be void if you tamper with any part of your device / software.
echo %ESC%[36mPREPARATION:
echo     - Read README.TXT before use this Installer.
echo     - Make sure your phone is fully charged and it's battery is not wear too much.
echo     - Make sure no drives mounted in M and N.
echo     - Unlocked bootloader and booted into Mass Storage Mode.%ESC%[0m
echo.
pause
::---------------------------------------------------------------
:ChooseDev
set Model=
cls
echo  %ESC%[93m//////////////////////////////////////////////////////////////////////////////////////////////
echo  //                        %ESC%[97mWindows 10 for ARMv7 Installer (VHDX) PR3%ESC%[93m                         //
echo  //                                   %ESC%[97mby RedGreenBlue123%ESC%[93m                                     //
echo  //                      %ESC%[97mThanks to: @Gus33000, @FadilFadz01, @demonttl%ESC%[93m                       //
echo  //////////////////////////////////////////////////////////////////////////////////////////////%ESC%[97m
echo.
echo %ESC%[92mChoose your Device Model below:
echo  %ESC%[36m1) %ESC%[97mLumia 930
echo  %ESC%[36m2) %ESC%[97mLumia 929 (Icon)
echo  %ESC%[36m3) %ESC%[97mLumia 1520
echo  %ESC%[36m4) %ESC%[97mLumia 1520 (16GB)
echo  %ESC%[36m5) %ESC%[97mLumia 1520 AT^&T
echo  %ESC%[36m6) %ESC%[97mLumia 1520 AT^&T (16GB)
echo  %ESC%[36m7) %ESC%[97mLumia 830 Global
echo  %ESC%[36m8) %ESC%[97mLumia 730 / 735 Global
echo  %ESC%[36mA) %ESC%[97mLumia 640 XL LTE Global
echo  %ESC%[36mB) %ESC%[97mLumia 640 XL LTE AT^&T
echo  %ESC%[36mC) %ESC%[97mLumia 950
echo  %ESC%[36mD) %ESC%[97mLumia 950 XL%ESC%[0m
set /p Model=%ESC%[92mDevice%ESC%[32m: %ESC%[0m
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
echo  %ESC%[93m//////////////////////////////////////////////////////////////////////////////////////////////
echo  //                        %ESC%[97mWindows 10 for ARMv7 Installer (VHDX) PR3%ESC%[93m                         //
echo  //                                   %ESC%[97mby RedGreenBlue123%ESC%[93m                                     //
echo  //                      %ESC%[97mThanks to: @Gus33000, @FadilFadz01, @demonttl%ESC%[93m                       //
echo  //////////////////////////////////////////////////////////////////////////////////////////////%ESC%[97m
echo.
if %Storage%==8 echo  - You need at least ^> %ESC%[4m4.0 GB%ESC%[0m%ESC%[97m of Phone Storage to continue.
if %Storage%==16 echo  - You need at least ^> %ESC%[4m8.0 GB%ESC%[0m%ESC%[97m of Phone Storage to continue.
if %Storage%==32 echo  - You need at least ^> %ESC%[4m16.0 GB%ESC%[0m%ESC%[97m of Phone Storage to continue.
echo.
pause
:MOSPath
set MainOS=
echo.
set /p MainOS=%ESC%[92mEnter MainOS Path: %ESC%[0m
if not defined MainOS (
	echo  %ESC%[91mNot a valid MainOS partition.
	GOTO MOSPath
)
for /f %%m in ('powershell -C "(echo %MainOS%).length -eq 2"') do set Lenght2=%%m
if %Lenght2%==False (
	echo  %ESC%[91mNot a valid MainOS partition.
	GOTO MOSPath
)
if not exist "%MainOS%\EFIESP" (
	echo  %ESC%[91mNot a valid MainOS partition.
	GOTO MOSPath
)
if not exist "%MainOS%\Data" (
	echo  %ESC%[91mNot a valid MainOS partition.
	GOTO MOSPath
)
if exist "%MainOS%\Data\windows10arm.vhdx" (
	echo  %ESC%[91mWindows 10 for ARMv7 is installed. Please uninstall it first.
	Pause
	Exit
)
::---------------------------------------------------------------
:LogNameInit
if not exist Logs\NUL del Logs /Q 2>nul
if not exist Logs\ mkdir Logs
cd Logs
FOR /F "tokens=* USEBACKQ" %%F IN (`powershell Get-Date -format "dd-MMM-yy"`) DO SET Date1=%%F
if not exist %Date1%.log set LogName=Logs\%Date1%.log & goto ToBeContinued2
if not exist %Date1%-1.log set LogName=Logs\%Date1%-1.log & goto ToBeContinued2
set LogNum=1
:LogName
if exist %Date1%-*.log (
    if exist %Date1%-%LogNum%.log (
        set /A LogNum=LogNum+1
        goto LogName
    ) else (
        set LogName=Logs\%Date1%-%LogNum%.log
    )
)
:ToBeContinued2
cd ..
echo.
echo #### INSTALLATION STARTED #### >>%LogName%
echo ======================================== >>%LogName%
echo ## Device is %Model%  ## >>%LogName%
echo ## MainOS is %MainOS% ## >>%LogName%
echo. >>%LogName%
set Logger=2^>CurrentError.log ^>^>%LogName% ^& type CurrentError.log ^& type CurrentError.log ^>^>%LogName%
if %Storage%==8 (
	echo %ESC%[93mCreating 4 GB VHDX image ...%ESC%[91m
	powershell New-VHD -Path %MainOS%\Data\windows10arm.vhdx -Fixed -SizeBytes 4096MB %Logger%
)
if %Storage%==16 (
	echo %ESC%[93mCreating 8 GB VHDX image ...%ESC%[91m
	powershell New-VHD -Path %MainOS%\Data\windows10arm.vhdx -Fixed -SizeBytes 8192MB %Logger%
)
if %Storage%==32 (
	echo %ESC%[93mCreating 16 GB VHDX image ...%ESC%[91m
	powershell New-VHD -Path %MainOS%\Data\windows10arm.vhdx -Fixed -SizeBytes 16384MB %Logger%
)
echo.
echo %ESC%[93mCreating Partitions ...%ESC%[91m
powershell Mount-VHD -Path %MainOS%\Data\windows10arm.vhdx  %Logger%
powershell Initialize-Disk -Number (Get-VHD -Path %MainOS%\Data\windows10arm.vhdx).DiskNumber -PartitionStyle GPT -confirm:$false %Logger%
:: Create ESP
echo.
echo %ESC%[96m - EFI System Partition%ESC%[91m
powershell New-Partition -DiskNumber (Get-VHD -Path %MainOS%\Data\windows10arm.vhdx).DiskNumber -GptType '{c12a7328-f81f-11d2-ba4b-00a0c93ec93b}' -Size 100MB -DriveLetter M %Logger%
powershell Format-Volume -DriveLetter M -FileSystem Fat32 -NewFileSystemLabel "ESP" -confirm:$false %Logger%
:: Create MSR
echo %ESC%[96m - Microsoft Reserved Partition %ESC%[91m
powershell New-Partition -DiskNumber (Get-VHD -Path %MainOS%\Data\windows10arm.vhdx).DiskNumber -GptType '{e3c9e316-0b5c-4db8-817d-f92df00215ae}' -Size 128MB %Logger%
:: Create Win10 Partition
echo %ESC%[96m - Windows Partition %ESC%[91m
powershell New-Partition -DiskNumber (Get-VHD -Path %MainOS%\Data\windows10arm.vhdx).DiskNumber -GptType '{ebd0a0a2-b9e5-4433-87c0-68b6b72699c7}' -UseMaximumSize -DriveLetter N %Logger%
if %Storage%==8 ( format N: /FS:NTFS /V:Windows10 /Q /C /Y %Logger% )
if %Storage%==16 ( format N: /FS:NTFS /V:Windows10 /Q /Y %Logger% )
if %Storage%==32 ( format N: /FS:NTFS /V:Windows10 /Q /Y %Logger% )
::---------------------------------------------------------------
echo ======================================== >>%LogName%
echo.
echo %ESC%[93mInstalling Windows 10 for ARMv7 ...%ESC%[96m
if %Storage%==8 DISM /Apply-Image /imagefile:".\install.wim" /Index:1 /ApplyDir:N:\ /compact & echo. >>%LogName% & echo DISM Apply Exit Code: %errorlevel% >>%LogName%
if %Storage%==16 DISM /Apply-Image /imagefile:".\install.wim" /Index:1 /ApplyDir:N:\ & echo. >>%LogName% & echo DISM Apply Exit Code: %errorlevel% >>%LogName%
if %Storage%==32 DISM /Apply-Image /imagefile:".\install.wim" /Index:1 /ApplyDir:N:\ & echo. >>%LogName% & echo DISM Apply Exit Code: %errorlevel% >>%LogName%
::---------------------------------------------------------------
echo.
echo %ESC%[93mInstalling Drivers ...%ESC%[91m
echo.
if %model%==1 (
	echo %ESC%[96m - Device Specific Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8974.MARTINI" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse %Logger%
	echo %ESC%[96m - Snapdragon 800 Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8974.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8974.NMO" /Recurse %Logger%
	echo %ESC%[96m - Windows 10 For ARMv7 Support Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse %Logger%
)
if %model%==2 (
	echo %ESC%[96m - Device Specific Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8974.VANQUISH" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse %Logger%
	echo %ESC%[96m - Snapdragon 800 Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8974.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8974.NMO" /Recurse %Logger%
	echo %ESC%[96m - Windows 10 For ARMv7 Support Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse %Logger%
)
if %model%==3 (
	echo %ESC%[96m - Device Specific Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8974.BANDIT" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse %Logger%
	echo %ESC%[96m - Snapdragon 800 Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8974.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8974.NMO" /Recurse %Logger%
	echo %ESC%[96m - Windows 10 For ARMv7 Support Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse %Logger%
)
if %model%==4 (
	echo %ESC%[96m - Device Specific Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8974.BANDIT" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse %Logger%
	echo %ESC%[96m - Snapdragon 800 Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8974.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8974.NMO" /Recurse %Logger%
	echo %ESC%[96m - Windows 10 For ARMv7 Support Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse %Logger%
)
if %model%==5 (
	echo %ESC%[96m - Device Specific Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8974.BANDITATT" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse %Logger%
	echo %ESC%[96m - Snapdragon 800 Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8974.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8974.NMO" /Recurse %Logger%
	echo %ESC%[96m - Windows 10 For ARMv7 Support Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse %Logger%
)
if %model%==6 (
	echo %ESC%[96m - Device Specific Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8974.BANDITATT" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse %Logger%
	echo %ESC%[96m - Snapdragon 800 Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8974.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8974.NMO" /Recurse %Logger%
	echo %ESC%[96m - Windows 10 For ARMv7 Support Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse %Logger%
)
if %model%==7 (
	echo %ESC%[96m - Device Specific Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8X26.TESLA" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse %Logger%
	echo %ESC%[96m - Snapdragon 400 Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8X26.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8X26.NMO" /Recurse %Logger%
	echo %ESC%[96m - Windows 10 For ARMv7 Support Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse %Logger%
)
if %model%==8 (
	echo %ESC%[96m - Device Specific Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8X26.SUPERMAN" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse %Logger%
	echo %ESC%[96m - Snapdragon 400 Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8X26.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8X26.NMO" /Recurse %Logger%
	echo %ESC%[96m - Windows 10 For ARMv7 Support Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse %Logger%
)
if %model%==A (
	echo %ESC%[96m - Device Specific Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8X26.MAKEPEACE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse %Logger%
	echo %ESC%[96m - Snapdragon 400 Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8X26.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8X26.NMO" /Recurse %Logger%
	echo %ESC%[96m - Windows 10 For ARMv7 Support Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse %Logger%
)
if %model%==B (
	echo %ESC%[96m - Device Specific Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8X26.MAKEPEACEATT" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse %Logger%
	echo %ESC%[96m - Snapdragon 400 Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8X26.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8X26.NMO" /Recurse %Logger%
	echo %ESC%[96m - Windows 10 For ARMv7 Support Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse %Logger%
)
if %model%==C (
	echo %ESC%[96m - Device Specific Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8994.TALKMAN" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4_F12_10" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.USB.MMO_USBC" /Recurse2 %Logger%
	echo %ESC%[96m - Snapdragon 808 Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.MMO" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.SOC8992" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.SOC8994AB" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8994.MMO" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8994.MMO_SOC8992" /Recurse %Logger%
	echo %ESC%[96m - Windows 10 For ARMv7 Support Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MMO_EXTRAS" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse %Logger%
)
if %model%==D (
	echo %ESC%[96m - Device Specific Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8994.CITYMAN" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4_F12_10" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.USB.MMO_USBC" /Recurse %Logger%
	echo %ESC%[96m - Snapdragon 810 Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.MMO" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.SOC8994" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.SOC8994AB" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8994.MMO" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8994.MMO_SOC8994" /Recurse %Logger%
	echo %ESC%[96m - Windows 10 For ARMv7 Support Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MMO_EXTRAS" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse %Logger%
)
if %model%==a (
	echo %ESC%[96m - Device Specific Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8X26.MAKEPEACE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse %Logger%
	echo %ESC%[96m - Snapdragon 400 Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8X26.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8X26.NMO" /Recurse %Logger%
	echo %ESC%[96m - Windows 10 For ARMv7 Support Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse %Logger%
)
if %model%==b (
	echo %ESC%[96m - Device Specific Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8X26.MAKEPEACEATT" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse %Logger%
	echo %ESC%[96m - Snapdragon 400 Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8X26.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8X26.NMO" /Recurse %Logger%
	echo %ESC%[96m - Windows 10 For ARMv7 Support Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse %Logger%
)
if %model%==c (
	echo %ESC%[96m - Device Specific Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8994.TALKMAN" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4_F12_10" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.USB.MMO_USBC" /Recurse2 %Logger%
	echo %ESC%[96m - Snapdragon 808 Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.MMO" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.SOC8992" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.SOC8994AB" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8994.MMO" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8994.MMO_SOC8992" /Recurse %Logger%
	echo %ESC%[96m - Windows 10 For ARMv7 Support Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MMO_EXTRAS" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse %Logger%
)
if %model%==d (
	echo %ESC%[96m - Device Specific Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8994.CITYMAN" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4_F12_10" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.USB.MMO_USBC" /Recurse %Logger%
	echo %ESC%[96m - Snapdragon 810 Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.MMO" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.SOC8994" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8994.SOC8994AB" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8994.MMO" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8994.MMO_SOC8994" /Recurse %Logger%
	echo %ESC%[96m - Windows 10 For ARMv7 Support Drivers%ESC%[91m
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MMO_EXTRAS" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse %Logger%
	Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse %Logger%
)
::---------------------------------------------------------------
echo ======================================== >>%LogName%
echo.
echo %ESC%[93mInstalling Mass Storage Mode UI ...%ESC%[91m
xcopy .\Files\MassStorage %MainOS%\EFIESP\Windows\System32\Boot\ui /E /H /I /Y %Logger%
echo.
echo %ESC%[93mSetting Up BCD ...%ESC%[91m
bcdboot N:\Windows /s M: /l en-us /f UEFI %Logger%
::---------------------------------------------------------------
echo ======================================== >>%LogName%
echo.
echo %ESC%[93mPatching BCD ...%ESC%[91m
SET bcdLoc="%MainOS%\EFIESP\efi\Microsoft\Boot\BCD"
echo ## BCD Path is %bcdLoc% ## >>%LogName% 
SET id="{703c511b-98f3-4630-b752-6d177cbfb89c}"
bcdedit /store %bcdLoc% /create %id% /d "Windows 10 for ARMv7" /application "osloader" %Logger%
bcdedit /store %bcdLoc% /set %id% "device" "vhd=[%MainOS%\Data]\windows10arm.vhdx" %Logger%
bcdedit /store %bcdLoc% /set %id% "osdevice" "vhd=[%MainOS%\Data]\windows10arm.vhdx" %Logger%
bcdedit /store %bcdLoc% /set %id% "path" "\windows\system32\winload.efi" %Logger%
bcdedit /store %bcdLoc% /set %id% "locale" "en-US" %Logger%
bcdedit /store %bcdLoc% /set %id% "testsigning" yes %Logger%
bcdedit /store %bcdLoc% /set %id% "inherit" "{bootloadersettings}" %Logger%
bcdedit /store %bcdLoc% /set %id% "systemroot" "\Windows" %Logger%
bcdedit /store %bcdLoc% /set %id% "bootmenupolicy" "Standard" %Logger%
bcdedit /store %bcdLoc% /set %id% "detecthal" Yes %Logger%
bcdedit /store %bcdLoc% /set %id% "winpe" No %Logger%
bcdedit /store %bcdLoc% /set %id% "ems" No %Logger%
bcdedit /store %bcdLoc% /set %id% "bootdebug" No %Logger%
bcdedit /store %bcdLoc% /set "{bootmgr}" "nointegritychecks" Yes %Logger%
bcdedit /store %bcdLoc% /set "{bootmgr}" "testsigning" yes %Logger%
bcdedit /store %bcdLoc% /set "{bootmgr}" "timeout" 5 %Logger%
bcdedit /store %bcdLoc% /set "{bootmgr}" "displaybootmenu" yes %Logger%
bcdedit /store %bcdLoc% /set "{bootmgr}" "custom:54000001" %id% %Logger%
echo.
::---------------------------------------------------------------
echo ======================================== >>%LogName%
echo %ESC%[93mSetting up ESP ...%ESC%[91m
mkdir %MainOS%\EFIESP\EFI\Microsoft\Recovery\ %Logger%
copy M:\EFI\Microsoft\Recovery\BCD %MainOS%\EFIESP\EFI\Microsoft\Recovery\BCD /Y %Logger%
set BCDRec=%MainOS%\EFIESP\EFI\Microsoft\Recovery\BCD >>%LogName%
bcdedit /store %BCDRec% /set {bootmgr} "device" "partition=%MainOS%\EFIESP" %Logger%
bcdedit /store %BCDRec% /set {bootmgr} "path" "\EFI\Boot\Bootarm.efi" %Logger%
bcdedit /store %BCDRec% /set {bootmgr} "timeout" "5" %Logger%
set DLMOS=%MainOS:~0,-1%
echo. >>%LogName%
for /f %%i in ('powershell -C "(Get-Partition | ? { $_.AccessPaths -eq '%MainOS%\EFIESP\' }).PartitionNumber"') do set PartitionNumber=%%i
echo ## PartitionNumber is %PartitionNumber% ## >>%LogName%
for /f %%f in ('powershell -C "(Get-Partition -DriveLetter %DLMOS%).DiskNumber"') do set DiskNumber=%%f
echo ## DiskNumber is %DiskNumber% ## >>%LogName%
echo>>diskpart.txt sel dis %DiskNumber%
echo>>diskpart.txt sel par %PartitionNumber%
echo>>diskpart.txt set id=c12a7328-f81f-11d2-ba4b-00a0c93ec93b
attrib +h diskpart.txt %Logger%
diskpart /s diskpart.txt %Logger%
del /A:H diskpart.txt %Logger%
::---------------------------------------------------------------
echo ======================================== >>%LogName%
echo.
echo %ESC%[93mUnmounting VHDX Image ...%ESC%[91m
powershell Dismount-VHD -Path "%MainOS%\Data\windows10arm.vhdx" %Logger%
echo #### INSTALLATION COMPLETED #### >>%LogName%
del CurrentError.log
::---------------------------------------------------------------
echo.
echo %ESC%[92m================================================================================================
echo  - Done. Now, reboot your phone.
echo  - After the boot menu appears, press power up to boot Windows 10 for ARMv7.
echo  - Boot and setup Windows 10 for the first time. Then reboot the phone to mass storage mode.
echo  - Run PostInstall.bat.
echo ================================================================================================%ESC%[0m
pause
exit

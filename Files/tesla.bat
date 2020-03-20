@echo off

:: GetAdministrator
:---------------------------------------------------------------
REM  --> Requesting administrative privilege...
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

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
:---------------------------------------------------------------
@echo off
mode con: cols=96 lines=24
cd /D %~dp0\..\
cls
title Windows 10 Installer for Lumia 640 XL
echo ---------------------- Windows 10 for ARMv7 Installer by RedGreenBlue123 ----------------------
echo.
echo  - For Lumia 640XL
echo  - You need at least ^> 4.0 GB of Phone Storage to continue.
echo.
pause
cls
:MOSPath
set /p MainOS=Enter MainOS Path: 
if not exist "%MainOS%/EFIESP" (
	ECHO  Not a valid MainOS partition!
	GOTO MOSPath
)
if not exist "%MainOS%/Data" (
	ECHO  Not a valid MainOS partition!
	GOTO MOSPath
)
::---------------------------------------------------------------
:ToBeContinued
color 0b
echo Creating 4 GB VHDX image ...
powershell New-VHD -Path %MainOS%\Data\windows10arm.vhdx -Fixed -SizeBytes 4096MB
echo.
echo Creating Partitions ...
powershell Mount-VHD -Path %MainOS%\Data\windows10arm.vhdx
powershell Initialize-Disk -Number ($disknumber=Get-VHD -Path %MainOS%\Data\windows10arm.vhdx).DiskNumber -PartitionStyle GPT -confirm:$false
:: Create ESP
powershell New-Partition -DiskNumber ($disknumber=Get-VHD -Path %MainOS%\Data\windows10arm.vhdx).DiskNumber -GptType '{c12a7328-f81f-11d2-ba4b-00a0c93ec93b}' -Size 100MB -DriveLetter M
powershell Format-Volume -DriveLetter M -FileSystem Fat32 -NewFileSystemLabel "ESP" -confirm:$false
:: Create MSR
powershell New-Partition -DiskNumber ($disknumber=Get-VHD -Path %MainOS%\Data\windows10arm.vhdx).DiskNumber -GptType '{e3c9e316-0b5c-4db8-817d-f92df00215ae}' -Size 128MB
:: Create Win10 Disk
powershell New-Partition -DiskNumber ($disknumber=Get-VHD -Path %MainOS%\Data\windows10arm.vhdx).DiskNumber -GptType '{ebd0a0a2-b9e5-4433-87c0-68b6b72699c7}' -UseMaximumSize -DriveLetter N
powershell Format-Volume -DriveLetter N -FileSystem NTFS -NewFileSystemLabel "Windows10" -confirm:$false
::---------------------------------------------------------------
echo.
echo Installing Windows 10 for ARMv7 ...
DISM /Apply-Image /imagefile:".\install.wim" /Index:1 /ApplyDir:N:\
::---------------------------------------------------------------
echo.
echo Installing Drivers ...
:: Device's Driver
Dism /Image:N:\ /Add-Driver /Driver:".\drivers\configurations\devices\specifics-tesla" /Recurse
:: MSM8974's Driver
Dism /Image:N:\ /Add-Driver /Driver:".\drivers\configurations\oems" /Recurse
Dism /Image:N:\ /Add-Driver /Driver:".\drivers\msm8x26" /Recurse
Dism /Image:N:\ /Add-Driver /Driver:".\drivers\support-desktop" /Recurse
Dism /Image:N:\ /Add-Driver /Driver:".\drivers\support-15035" /Recurse
::---------------------------------------------------------------
echo.
echo Copying EFI to VHDX image ...
xcopy .\files\efi M:\efi /E /H /I /Y
xcopy .\files\ui %MainOS%\EFIESP\Windows\System32\Boot\ui /E /H /I /Y
echo.
echo Setting Up BCD ...
call .\files\setupbcd.bat
::---------------------------------------------------------------
echo.
echo Patching BCD ...
copy .\files\patchbcd.bat %mainos%\patchbcd.bat /Y
call %mainos%\patchbcd.bat
del %mainos%\patchbcd.bat >nul
::---------------------------------------------------------------
echo.
echo Unmounting VHDX Image ...
powershell Dismount-VHD -Path "%MainOS%\Data\windows10arm.vhdx"
:---------------------------------------------------------------
color 0a
echo.
echo ==============================================================================
echo  - Done. Now, reboot your phone.
echo  - After the boot menu appears, press power up to boot Windows 10 for ARMv7,
echo    Do nothing to boot Windows 10 Mobile or Windows Phone 8.x
echo  - Don't use Vol Down button at the boot menu because it will boot Reset My Phone.
echo    And an exclamation mark will apears. This will not cause damage to your phone.
echo ==============================================================================
pause

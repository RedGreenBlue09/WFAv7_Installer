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
cd %~dp0\..\
cls
title Windows 10 Installer for Lumia Icon / 930
echo ---------------------- Windows 10 for ARMv7 Installer by RedGreenBlue123 ----------------------
echo.
echo  - For Lumia Icon / 930
echo  - You need at least ^> 16.0 GB of Phone Storage to continue.
echo.
pause
cls
set /p MainOS=Enter MainOS Path: 
:---------------------------------------------------------------
echo Creating 16 GB VHDX image ...
powershell New-VHD -Path %MainOS%\Data\windows10arm.vhdx -Fixed -SizeBytes 16384MB
echo.
echo Creating Partitions ...
powershell Mount-VHD -Path %MainOS%\Data\windows10arm.vhdx
powershell Initialize-Disk -Number ($disknumber=Get-VHD -Path %MainOS%\Data\windows10arm.vhdx).DiskNumber -PartitionStyle GPT -confirm:$false
: Create ESP
powershell New-Partition -DiskNumber ($disknumber=Get-VHD -Path %MainOS%\Data\windows10arm.vhdx).DiskNumber -GptType '{c12a7328-f81f-11d2-ba4b-00a0c93ec93b}' -Size 100MB -DriveLetter M
powershell Format-Volume -DriveLetter M -FileSystem Fat32 -NewFileSystemLabel "ESP" -confirm:$false
: Create MSR
powershell New-Partition -DiskNumber ($disknumber=Get-VHD -Path %MainOS%\Data\windows10arm.vhdx).DiskNumber -GptType '{e3c9e316-0b5c-4db8-817d-f92df00215ae}' -Size 128MB
: Create Win10 Disk
powershell New-Partition -DiskNumber ($disknumber=Get-VHD -Path %MainOS%\Data\windows10arm.vhdx).DiskNumber -GptType '{ebd0a0a2-b9e5-4433-87c0-68b6b72699c7}' -UseMaximumSize -DriveLetter N
powershell Format-Volume -DriveLetter N -FileSystem NTFS -NewFileSystemLabel "Windows10" -confirm:$false
:---------------------------------------------------------------
echo.
echo Installing Windows 10 for ARMv7 ...
DISM /Apply-Image /imagefile:".\install.wim" /Index:1 /ApplyDir:N:\
:---------------------------------------------------------------
echo.
echo Installing Drivers ...
: Device's Driver
Dism /Image:N:\ /Add-Driver /Driver:".\drivers\configurations\devices\specifics-martini" /Recurse
: MSM8974's Driver
Dism /Image:N:\ /Add-Driver /Driver:".\drivers\configurations\oems" /Recurse
Dism /Image:N:\ /Add-Driver /Driver:".\drivers\msm8974" /Recurse
Dism /Image:N:\ /Add-Driver /Driver:".\drivers\support-desktop" /Recurse
Dism /Image:N:\ /Add-Driver /Driver:".\drivers\support-15035" /Recurse
:---------------------------------------------------------------
echo.
echo Copying EFI to VHDX image ...
xcopy .\files\efi M:\efi /E /H /I /Y
echo.
echo Setting Up BCD ...
SET bcdVHD="M:\efi\Microsoft\Boot\BCD"
SET idVHD="{f409bbec-62ab-11ea-bc55-0242ac130003}"
bcdedit /store %bcdVHD% /create %idVHD% /d "Windows 10" /application "osloader"
bcdedit /store %bcdVHD% /set %idVHD% "device" partition=N:
bcdedit /store %bcdVHD% /set %idVHD% "osdevice"  partition=N:
bcdedit /store %bcdVHD% /set %idVHD% "path" "\windows\system32\winload.efi"
bcdedit /store %bcdVHD% /set %idVHD% "locale" "en-US"
bcdedit /store %bcdVHD% /set %idVHD% "testsigning" yes
bcdedit /store %bcdVHD% /set %idVHD% "inherit" "{bootloadersettings}"
bcdedit /store %bcdVHD% /set %idVHD% "systemroot" "\Windows"
bcdedit /store %bcdVHD% /set %idVHD% "bootmenupolicy" Standard
bcdedit /store %bcdVHD% /set %idVHD% "detecthal" Yes
bcdedit /store %bcdVHD% /set %idVHD% "nx" OptIn
bcdedit /store %bcdVHD% /default %idVHD%
:---------------------------------------------------------------
echo.
echo Patching BCD ...
copy .\files\patchbcd.bat %mainos%\patchbcd.bat /Y
call %mainos%\patchbcd.bat
del %mainos%\patchbcd.bat >nul
:---------------------------------------------------------------
echo.
echo Unmounting VHDX Image ...
powershell Dismount-VHD -Path "%MainOS%\Data\windows10arm.vhdx"
:---------------------------------------------------------------
echo.
echo ==============================================================================
echo  - Done. Now, reboot your phone.
echo  - After the boot menu appears, press power up to boot Windows 10 for ARMv7,
echo    Do nothing to boot Windows 10 Mobile or Windows Phone 8.x
echo ==============================================================================
pause

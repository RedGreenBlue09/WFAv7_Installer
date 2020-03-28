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
title Windows 10 Installer for Lumia 930
echo ---------------------- Windows 10 for ARMv7 Installer by RedGreenBlue123 ----------------------
echo.
echo  - For Lumia 930
echo  - You need at least ^> 16.0 GB of Phone Storage to continue.
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
echo Creating 16 GB VHDX image ...
powershell New-VHD -Path %MainOS%\Data\windows10arm.vhdx -Fixed -SizeBytes 16384MB
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
Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.SOC_QC8974.MARTINI" /Recurse
Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\OEM.SOC_QC8974.NMO" /Recurse
Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\DEVICE.INPUT.SYNAPTICS_RMI4" /Recurse
:: MSM8974's Driver
Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\PLATFORM.SOC_QC8974.BASE" /Recurse
Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.BASE" /Recurse
Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.EXTRAS" /Recurse
Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_BRIDGE" /Recurse
Dism /Image:N:\ /Add-Driver /Driver:".\drivers\components\SUPPORT.DESKTOP.MOBILE_COMPONENTS" /Recurse
::---------------------------------------------------------------
echo.
echo Copying EFI to VHDX image ...
xcopy .\files\ui %MainOS%\EFIESP\Windows\System32\Boot\ui /E /H /I /Y
echo.
echo Setting Up BCD ...
bcdboot N:\windows /s M: /l en-us /f UEFI
::---------------------------------------------------------------
echo.
echo Patching BCD ...
copy .\files\patchbcd.bat %mainos%\patchbcd.bat /Y
call %mainos%\patchbcd.bat
del %mainos%\patchbcd.bat >nul
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

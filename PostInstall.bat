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
@Echo Off
mode 96,2400
powershell -command "&{(get-host).ui.rawui.windowsize=@{width=96;height=24};}"
cd /D "%~dp0"
echo.
echo  Connect your phone in mass storage mode to the computer and press enter to continue ...
echo.
pause
echo.
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
if not exist %MainOS%\Data\windows10arm.vhdx echo WFAv7 is not installed. & pause & exit
echo.
echo Mounting Windows 10 for ARMv7 ...
powershell Mount-VHD -Path %MainOS%\Data\windows10arm.vhdx
:WinPath
echo.
set /p WinDir=Enter Windows 10 for ARMv7 Path: 
if not exist "%WinDir%\Windows" (
	ECHO  Not a valid Windows partition!
	GOTO WinPath
)
:ToBeContinued
echo.
echo Getting partitions info ...
set DLMOS=%MainOS:~0,-1%
for /f %%i in ('powershell -C "(Get-Partition | ? { $_.AccessPaths -eq '%MainOS%\EFIESP\' }).PartitionNumber"') do set PartitionNumber=%%i
for /f %%f in ('powershell -C "(Get-Partition -DriveLetter %DLMOS%).DiskNumber"') do set DiskNumber=%%f
echo>>diskpart1.txt sel dis %DiskNumber%
echo>>diskpart1.txt sel par %PartitionNumber%
echo>>diskpart1.txt set id=ebd0a0a2-b9e5-4433-87c0-68b6b72699c7
echo>>diskpart1.txt assign mount=%WinDir%\EFIESP
attrib +h diskpart1.txt
mkdir "%WinDir%\EFIESP"
echo Enabling Dual Boot ...
diskpart /s diskpart1.txt
del /A:H diskpart1.txt
bcdedit /store "%MainOS%\EFIESP\EFI\Microsoft\Boot\BCD" /set "{bootmgr}" "timeout" "5"
echo =====================================================================================
echo  - Done. Now, you have Windows 10 for ARMv7 Dualboot with Windows Phone.
echo  - After the boot menu appears, press power up to boot Windows 10 for ARMv7,
echo    Do nothing to boot Windows 10 Mobile or Windows Phone 8.x
echo  - Don't use Vol Down button at the boot menu because it will boot Reset My Phone.
echo    And an exclamation mark will apears. This will not cause damage to your phone.
echo =====================================================================================
pause

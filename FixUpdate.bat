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
cd /D "%~dp0"
:MOSPath
set /p MainOS=Enter MainOS Path: 
if not exist "%MainOS%/EFIESP" (
	ECHO  Not a valid MainOS partition!
	GOTO MOSPath
)
echo Fixing BCD ...
@ECHO OFF
SET bcdLoc="%MainOS%\EFIESP\efi\Microsoft\Boot\BCD"
SET id="{703c511b-98f3-4630-b752-6d177cbfb89c}"
bcdedit /store %bcdLoc% /delete %id% >nul
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
bcdedit /store %bcdLoc% /set "{bootmgr}" "timeout" 3
bcdedit /store %bcdLoc% /set "{bootmgr}" "displaybootmenu" yes
bcdedit /store %bcdLoc% /set "{bootmgr}" "custom:54000001" %id%
bcdedit /store %bcdLoc% /set "{globalsettings}" "nobootuxtext" no
bcdedit /store %bcdLoc% /set "{globalsettings}" "nobootuxprogress" no
ECHO.
ECHO BCD has been fixed!
pause

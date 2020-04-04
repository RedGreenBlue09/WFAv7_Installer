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
echo ////////////////////////////////////////////////////////////////////////////////////////////////
echo //                          Windows 10 for ARMv7 unInstaller (VHDX)                           //
echo //                                     by RedGreenBlue123                                     //
echo ////////////////////////////////////////////////////////////////////////////////////////////////
echo.
echo  Connect your phone in mass storage mode to the computer and press enter to continue ...
echo.
pause
echo.
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
del %MainOS%\Data\windows10arm.vhdx
bcdedit /store %MainOS%\EFIESP\efi\Microsoft\Boot\BCD /delete {703c511b-98f3-4630-b752-6d177cbfb89c}
bcdedit /store %MainOS%\EFIESP\efi\Microsoft\Boot\BCD /set "{bootmgr}" "displaybootmenu" no
echo.
echo Done!
pause

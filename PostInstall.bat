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
cd /D "%~dp0"
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
echo.
set /p WinDir=Enter Windows 10 for ARMv7 Path: 
:ToBeContinued
powershell -Command "(gc diskpart.txt) -replace 'c12a7328-f81f-11d2-ba4b-00a0c93ec93b', 'ebd0a0a2-b9e5-4433-87c0-68b6b72699c7' | Out-File -encoding ASCII diskpart1.txt"
powershell -Command "(gc diskpart.txt) -replace 'set id=c12a7328-f81f-11d2-ba4b-00a0c93ec93b', 'assign mount=%WinDir%\EFIESP' | Out-File -encoding ASCII diskpart2.txt"
attrib +h diskpart1.txt
attrib +h diskpart2.txt
diskpart /s diskpart1.txt
diskpart /s diskpart2.txt
del /A:H diskpart1.txt
del /A:H diskpart2.txt
del /A:H diskpart.txt
bcdedit /store "%MainOS%\EFIESP\EFI\Microsoft\Boot\BCD" /set "{bootmgr}" "timeout" "5"
echo =====================================================================================
echo  - Done. Now, you have Windows 10 for ARMv7 Dualboot with Windows Phone.
echo  - After the boot menu appears, press power up to boot Windows 10 for ARMv7,
echo    Do nothing to boot Windows 10 Mobile or Windows Phone 8.x
echo  - Don't use Vol Down button at the boot menu because it will boot Reset My Phone.
echo    And an exclamation mark will apears. This will not cause damage to your phone.
echo =====================================================================================
pause

@echo off

:: GetAdministrator
:---------------------------------------------------------------
:GetAdministrator
    IF "%PROCESSOR_ARCHITECTURE%" EQU "AMD64" ( >nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system" )
    IF "%PROCESSOR_ARCHITECTURE%" EQU "ARM64" ( >nul 2>&1 "%SYSTEMROOT%\SysArm32\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system" )
    IF "%PROCESSOR_ARCHITECTURE%" EQU "x86" (
	>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
) else ( >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" )

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
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set ESC=%%b
mode 96,2000
powershell -command "&{(get-host).ui.rawui.windowsize=@{width=96;height=24};}"
cd /D "%~dp0"
echo.
echo  %ESC%[93mConnect your phone in mass storage mode to the computer. %ESC%[0m
echo.
pause
echo.
:MOSPath
set MainOS=
set /p MainOS=%ESC%[92mEnter MainOS Path: %ESC%[0m
if not defined MainOS (
	ECHO  %ESC%[91mNot a valid MainOS partition!
	GOTO MOSPath
)
for /f %%m in ('powershell -C "(echo %MainOS%).length -eq 2"') do set Lenght2=%%m
if %Lenght2%==False (
	ECHO  %ESC%[91mNot a valid MainOS partition!
	GOTO MOSPath
)
if not exist "%MainOS%\EFIESP" (
	ECHO  %ESC%[91mNot a valid MainOS partition!
	GOTO MOSPath
)
if not exist "%MainOS%\Data" (
	ECHO  %ESC%[91mNot a valid MainOS partition!
	GOTO MOSPath
)
if not exist %MainOS%\Data\windows10arm.vhdx echo %ESC%[41mWFAv7 is not installed. & pause & exit
echo.
:WinPath
echo.
set /p WFAv7Dir=%ESC%[92mEnter Windows 10 for ARMv7 Path: %ESC%[0m
if not exist "%WinDir%\Windows" (
	ECHO  %ESC%[91mNot a valid Windows partition!
	GOTO WinPath
)
:ToBeContinued
echo.
echo %ESC%[93mGetting partitions info ...%ESC%[96m
set DLMOS=%MainOS:~0,-1%
for /f %%i in ('powershell -C "(Get-Partition | ? { $_.AccessPaths -eq '%MainOS%\EFIESP\' }).PartitionNumber"') do set PartitionNumber=%%i
for /f %%f in ('powershell -C "(Get-Partition -DriveLetter %DLMOS%).DiskNumber"') do set DiskNumber=%%f
echo>>diskpart1.txt sel dis %DiskNumber%
echo>>diskpart1.txt sel par %PartitionNumber%
echo>>diskpart1.txt set id=ebd0a0a2-b9e5-4433-87c0-68b6b72699c7
if not exist %WFAv7Dir%\EFIESP echo>>diskpart1.txt assign mount=%WFAv7Dir%\EFIESP
attrib +h diskpart1.txt
mkdir "%WinDir%\EFIESP"
echo.
echo %ESC%[93mEnabling Dual Boot ...%ESC%[96m
diskpart /s diskpart1.txt
del /A:H diskpart1.txt
bcdedit /store "%MainOS%\EFIESP\EFI\Microsoft\Boot\BCD" /set "{bootmgr}" "timeout" "5"
echo.
echo %ESC%[93mUnmounting VHDX Image ...%ESC%[91m
powershell Dismount-VHD -Path "%MainOS%\Data\windows10arm.vhdx"
echo.
echo %ESC%[92m=====================================================================================
echo  - Done. Now, you have Windows 10 for ARMv7 Dualboot with Windows Phone.
echo  - After the boot menu appears, press power up to boot Windows 10 for ARMv7,
echo    Do nothing to boot Windows 10 Mobile or Windows Phone 8.x
echo  - Don't use Vol Down button at the boot menu because it will boot Reset My Phone.
echo    And an exclamation mark will apears. This will not cause damage to your phone.
echo =====================================================================================%ESC%[0m
pause
exit

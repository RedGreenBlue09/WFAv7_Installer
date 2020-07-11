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
if not exist %MainOS%\Windows\WFAv7Storage.txt (
	echo.
	echo %ESC%[91m - Windows 10 for ARMv7 is not installed.%ESC%[0m
	echo.
	pause
	endlocal
	goto ChooseTool
)
for /f %%i in (%MainOS%\Windows\WFAv7Storage.txt) do (set Storage=%%i)
echo.
if %Storage%==8 (set WFAv7Dir=%MainOS%& goto ToBeContinued)
if %Storage%==16 (goto WinPath)
if %Storage%==32 (goto WinPath)
if %Storage%==32A (set WFAv7Dir=%MainOS%\Data\Windows10Arm& goto ToBeContinued)

:WinPath
set /p WFAv7Dir=%ESC%[92mEnter Windows 10 for ARMv7 Path: %ESC%[0m
if not exist "%WFAv7Dir%\Windows" (
	ECHO  %ESC%[91mNot a valid Windows partition!
	GOTO WinPath
)
:ToBeContinued
echo.
md Temp\
echo %ESC%[96mGetting partitions info ...%ESC%[0m
set DLMOS=%MainOS:~0,-1%
for /f %%i in ('powershell -C "(Get-Partition | ? { $_.AccessPaths -eq '%MainOS%\EFIESP\' }).PartitionNumber"') do set PartitionNumber=%%i
for /f %%f in ('powershell -C "(Get-Partition -DriveLetter %DLMOS%).DiskNumber"') do set DiskNumber=%%f
echo>>Temp\diskpart1.txt sel dis %DiskNumber%
echo>>Temp\diskpart1.txt sel par %PartitionNumber%
echo>>Temp\diskpart1.txt set id=ebd0a0a2-b9e5-4433-87c0-68b6b72699c7
if not exist %WFAv7Dir%\EFIESP md %WFAv7Dir%\EFIESP & echo>>Temp\diskpart1.txt assign mount=%WFAv7Dir%\EFIESP
echo.
echo %ESC%[96mEnabling Dual Boot ...%ESC%[0m
diskpart /s Temp\diskpart1.txt
bcdedit /store "%MainOS%\EFIESP\EFI\Microsoft\Boot\BCD" /set "{bootmgr}" "timeout" "5"
rd /s /q Temp\
echo.
echo %ESC%[92m=====================================================================================
echo  - Done. Now, you have Windows 10 for ARMv7 Dualboot with Windows Phone.
echo  - After the boot menu appears, press power up to boot Windows 10 for ARMv7,
echo    Do nothing to boot Windows 10 Mobile or Windows Phone 8.x
echo  - Don't use Vol Down button at the boot menu because it will boot Reset My Phone.
echo    And an exclamation mark will apears. This will not cause damage to your phone.
echo =====================================================================================%ESC%[0m
pause
exit /b

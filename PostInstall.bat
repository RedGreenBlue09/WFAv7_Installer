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
@echo off
for /f "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set ESC=%%b
mode 96,2000
powershell -command "&{(get-host).ui.rawui.windowsize=@{width=96;height=24};}"
cd /d "%~dp0"
echo.
echo  %ESC%[93mConnect your phone in mass storage mode to the computer. %ESC%[0m
echo.
pause
echo.
goto MOSAutoDetect
:MOSAutoDetectFail
echo %ESC%[93mFailed to auto detect MainOS.%ESC%[0m
if exist Temp\GPT del Temp\GPT
if exist Temp\GPT* del Temp\GPT*
set "Skip="
goto MOSPath

:MOSAutoDetect
setlocal EnableDelayedExpansion
echo %ESC%[97mTrying to detect MainOS ...%ESC%[0m
:: DiskNumber
for /f %%i in ('Powershell -C "(Get-WmiObject Win32_DiskDrive | ? {$_.PNPDeviceID -Match 'VEN_MSFT&PROD_PHONE_MMC_STOR'}).Index"') do set "DiskNumber=%%i"
if "%DiskNumber%"=="" (for /f %%i in ('Powershell -C "(Get-WmiObject Win32_DiskDrive | ? {$_.PNPDeviceID -Match 'VEN_QUALCOMM&PROD_MMC_STORAGE'}).Index"') do set "DiskNumber=%%i")
if "%DiskNumber%"=="" goto MOSAutoDetectFail
if not exist Temp\ md Temp
Files\dd if=\\?\Device\Harddisk%DiskNumber%\Partition0 of=Temp\GPT bs=512 skip=1 count=32 2>nul
set "Skip=512"
for /l %%i in (1,1,48) do (
	Files\dsfo Temp\GPT !Skip! 128 Temp\GPT%%i >nul
	set /a "Skip+=128"
)
for /l %%i in (1,1,48) do (
	Files\grep -P "M\x00a\x00i\x00n\x00O\x00S" Temp\GPT%%i >nul
	if !Errorlevel!==0 set MOSGPT=%%i& goto PartitionNumber
)
goto MOSAutoDetectFail
:PartitionNumber
Files\dd if=Temp\GPT%MOSGPT% of=Temp\GPT%MOSGPT%-UUID bs=1 skip=16 count=16 2>nul
for /f "usebackq delims=" %%g in (`Powershell -C "([System.IO.File]::ReadAllBytes('Temp\GPT%MOSGPT%-UUID') | ForEach-Object { '{0:x2}' -f $_ }) -join ' '"`) do set "UuidHex=%%g"
for /f "tokens=1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" %%a in ("%UuidHex%") do (
	set "Uuid=%%d%%c%%b%%a-%%f%%e-%%h%%g-%%i%%j-%%k%%l%%m%%n%%o%%p"
)
for /f %%p in ('Powershell -C "(Get-Partition | ? { $_.Guid -eq '{%Uuid%}'}).PartitionNumber"') do set "PartitionNumber=%%p"
for /f %%d in ('Powershell -C "(Get-Partition | ? { $_.Guid -eq '{%Uuid%}'}).DriveLetter"') do set "DriveLetter=%%d"
if not exist %DriveLetter%:\EFIESP goto MOSAutoDetectFail
if not exist %DriveLetter%:\Data goto MOSAutoDetectFail
set "DLMOS=%DriveLetter%"
set "MainOS=%DriveLetter%:"
del Temp\GPT
del Temp\GPT*
set "Skip="
echo %ESC%[96mDetected MainOS at %DriveLetter%%ESC%[0m
goto ToBeContinued

:MOSPath
set "MainOS="
echo.
set /p MainOS=%ESC%[92mEnter MainOS Path: %ESC%[93m
if not defined MainOS (
	echo  %ESC%[91mNot a valid MainOS partition.
	goto MOSPath
)
echo %MainOS%| Files\grep -Pi "^[A-Z]\x3A$" >nul
if %errorlevel% NEQ 0 (
	echo  %ESC%[91mNot a valid MainOS partition.
	goto MOSPath
)
if not exist "%MainOS%\EFIESP" (
	echo  %ESC%[91mNot a valid MainOS partition.
	goto MOSPath
)
if not exist "%MainOS%\Data" (
	echo  %ESC%[91mNot a valid MainOS partition.
	goto MOSPath
)
set "DLMOS=%MainOS:~0,-1%"
for /f %%i in ('Powershell -C "(Get-Partition -DriveLetter %DLMOS%).DiskNumber"') do set "DiskNumber=%%i"
for /f %%i in ('Powershell -C "(Get-Partition -DriveLetter %DLMOS%).PartitionNumber"') do set "PartitionNumber=%%i"

:ToBeContinued
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
echo.
md Temp\
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

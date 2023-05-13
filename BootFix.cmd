@echo off
setlocal EnableDelayedExpansion
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
	pushd "%cd%"
	CD /D "%~dp0"
:---------------------------------------------------------------
@echo off
Files\cmdresize 96 24 96 2000
for /f "tokens=3" %%a in ('Reg Query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild ^| findstr /r /i "REG_SZ"') do set WinBuild=%%a
if %WinBuild% LSS 10586 (
	if /i %PROCESSOR_ARCHITECTURE% EQU X86 Files\ansicon32 -p
	if /i %PROCESSOR_ARCHITECTURE% EQU AMD64 Files\ansicon64 -p
)

set "ESC="
cd /d "%~dp0"
echo.
echo  %ESC%[93mConnect your phone in mass storage mode to the computer. %ESC%[0m
echo.
pause
echo.

goto MOSAutoDetect

:MOSAutoDetectFail
del Temp\GPT*
echo %ESC%[93mUnable to auto detect MainOS.%ESC%[0m
goto MOSPath

:MOSAutoDetect
echo %ESC%[97mTrying to detect MainOS ...%ESC%[0m
:: DiskNumber
for /f %%i in ('Powershell -C "(Get-WmiObject Win32_DiskDrive | ? {$_.PNPDeviceID -Match 'VEN_MSFT&PROD_PHONE_MMC_STOR'}).Index"') do set "DiskNumber=%%i"
if "%DiskNumber%" EQU "" (for /f %%i in ('Powershell -C "(Get-WmiObject Win32_DiskDrive | ? {$_.PNPDeviceID -Match 'VEN_QUALCOMM&PROD_MMC_STORAGE'}).Index"') do set "DiskNumber=%%i")
if "%DiskNumber%" EQU "" goto MOSAutoDetectFail

Files\dsfo \\.\PHYSICALDRIVE%DiskNumber% 1024 16384 Temp\GPT >nul

for /l %%i in (0,1,47) do (
	set /a "Offset=128*%%i"

	Files\dsfo Temp\GPT !Offset! 128 Temp\GPT-PartEntry >nul
	Files\dsfo Temp\GPT-PartEntry 56 72 Temp\GPT-PartName >nul
	
	Files\grep -P "M\x00a\x00i\x00n\x00O\x00S\x00" Temp\GPT-PartName >nul
	if !Errorlevel! EQU 0 goto PartitionNumber
	
	del Temp\GPT-PartName
	del Temp\GPT-PartEntry
)
goto MOSAutoDetectFail

:PartitionNumber
Files\dsfo Temp\GPT-PartEntry 16 16 Temp\GPT-PartUUID >nul
for /f "usebackq delims=" %%g in (`Powershell -C "([System.IO.File]::ReadAllBytes('Temp\GPT-PartUUID') | ForEach-Object { '{0:x2}' -f $_ }) -join ' '"`) do set "UuidHex=%%g"
for /f "tokens=1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" %%a in ("%UuidHex%") do (
	set "Uuid=%%d%%c%%b%%a-%%f%%e-%%h%%g-%%i%%j-%%k%%l%%m%%n%%o%%p"
)
for /f %%p in ('Powershell -C "(Get-Partition | ? { $_.Guid -eq '{%Uuid%}'}).PartitionNumber"') do set "PartitionNumber=%%p"
for /f %%d in ('Powershell -C "(Get-Partition | ? { $_.Guid -eq '{%Uuid%}'}).DriveLetter"') do set "DriveLetter=%%d"
if not exist %DriveLetter%:\EFIESP goto MOSAutoDetectFail
if not exist %DriveLetter%:\Data goto MOSAutoDetectFail
del Temp\GPT*
set "DLMOS=%DriveLetter%"
set "MainOS=%DriveLetter%:"
echo %ESC%[96mDetected MainOS at %DriveLetter%:%ESC%[0m
for /f %%i in ('Powershell -C "(Get-Partition | ? { $_.AccessPaths -eq '%MainOS%\EFIESP\' }).PartitionNumber"') do set "PartitionNumber=%%i"
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
set "DLMOS=%MainOS:~0,-1%"

:ToBeContinued
bcdedit /store "%MainOS%\EFIESP\EFI\Microsoft\Boot\BCD" /set "{bootmgr}" "customactions" 0x1000048000001 0x54000001 0x1000050000001 0x54000002
rd /s /q Temp\

echo %ESC%[92m - Done!%ESC%[0m
pause
exit /b

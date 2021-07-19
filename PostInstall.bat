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
if "%DiskNumber%" EQU "" (for /f %%i in ('Powershell -C "(Get-WmiObject Win32_DiskDrive | ? {$_.PNPDeviceID -Match 'VEN_QUALCOMM&PROD_MMC_STORAGE'}).Index"') do set "DiskNumber=%%i")
if "%DiskNumber%" EQU "" goto MOSAutoDetectFail
if not exist Temp\ md Temp
Files\dd if=\\?\Device\Harddisk%DiskNumber%\Partition0 of=Temp\GPT bs=512 skip=1 count=32 2>nul
set "Skip=512"
for /l %%i in (1,1,48) do (
	Files\dsfo Temp\GPT !Skip! 128 Temp\GPT%%i >nul
	set /a "Skip+=128"
)
for /l %%i in (1,1,48) do (
	Files\grep -P "M\x00a\x00i\x00n\x00O\x00S" Temp\GPT%%i >nul
	if !Errorlevel! EQU 0 set MOSGPT=%%i& goto PartitionNumber
)
goto MOSAutoDetectFail

:PartitionNumber
Files\dd if=Temp\GPT%MOSGPT% of=Temp\GPT%MOSGPT%-UUID bs=1 skip=16 count=16 2>nul
for /f "usebackq delims=" %%g in (`Powershell -C "([System.IO.File]::ReadAllBytes('Temp\GPT%MOSGPT%-UUID') | ForEach-Object { '{0:x2}' -f $_ }) -join ' '"`) do set "UuidHex=%%g"
for /f "tokens=1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" %%a in ("%UuidHex%") do (
	set "Uuid=%%d%%c%%b%%a-%%f%%e-%%h%%g-%%i%%j-%%k%%l%%m%%n%%o%%p"
)
for /f %%d in ('Powershell -C "(Get-Partition | ? { $_.Guid -eq '{%Uuid%}'}).DriveLetter"') do set "DriveLetter=%%d"
if not exist %DriveLetter%:\EFIESP goto MOSAutoDetectFail
if not exist %DriveLetter%:\Data goto MOSAutoDetectFail
set "DLMOS=%DriveLetter%"
set "MainOS=%DriveLetter%:"
del Temp\GPT
del Temp\GPT*
set "Skip="
echo %ESC%[96mDetected MainOS at %DriveLetter%%ESC%[0m
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
if not exist "%MainOS%\Data" (
	echo  %ESC%[91mNot a valid MainOS partition.
	goto MOSPath
)
set "DLMOS=%MainOS:~0,-1%"
for /f %%i in ('Powershell -C "(Get-Partition -DriveLetter %DLMOS%).DiskNumber"') do set "DiskNumber=%%i"
for /f %%i in ('Powershell -C "(Get-Partition | ? { $_.AccessPaths -eq '%MainOS%\EFIESP\' }).PartitionNumber"') do set "PartitionNumber=%%i"

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
if %Storage% EQU 8 (set WFAv7Dir=%MainOS%& goto DualBoot)
if %Storage% EQU 16 (goto WinPath)
if %Storage% EQU 32 (goto WinPath)
if %Storage% EQU 32A (set WFAv7Dir=%MainOS%\Data\Windows10Arm& goto DualBoot)

:WinPath
set /p WFAv7Dir=%ESC%[92mEnter Windows 10 for ARMv7 Path: %ESC%[0m
if not exist "%WFAv7Dir%\Windows" (
	ECHO  %ESC%[91mNot a valid Windows partition!
	GOTO WinPath
)

::DualBoot
echo.
md Temp\
echo>>Temp\diskpart1.txt sel dis %DiskNumber%
echo>>Temp\diskpart1.txt sel par %PartitionNumber%
echo>>Temp\diskpart1.txt set id=ebd0a0a2-b9e5-4433-87c0-68b6b72699c7
if not exist %WFAv7Dir%\EFIESP md %WFAv7Dir%\EFIESP & echo>>Temp\diskpart1.txt assign mount=%WFAv7Dir%\EFIESP
diskpart /s Temp\diskpart1.txt

bcdedit /store "%MainOS%\EFIESP\EFI\Microsoft\Boot\BCD" /set "{bootmgr}" "timeout" "5"
rd /s /q Temp\
echo.
echo %ESC%[92m - Done!
pause
exit /b

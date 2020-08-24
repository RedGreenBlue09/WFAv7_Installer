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
	pushd "%CD%"
	CD /D "%~dp0"
:---------------------------------------------------------------
cd /D "%~dp0"
for /f "tokens=3" %%a in ('Reg Query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild ^| findstr /ri "REG_SZ"') do set WinBuild=%%a
if %WinBuild% LSS 9600 (
	title ERROR!
	color 0c
	echo ----------------------------------------------------------------
	echo   This Windows version is not supported by WFAv7 Installer.
	echo   Please use Windows 8.1 Pro+ ^(Build 9600+^) 
	echo   Current OS build: %WinBuild%
	pause
	exit
)
echo Installer is loading ... [100%%]
if %WinBuild% LSS 10586 (
	if %PROCESSOR_ARCHITECTURE%==x86 Files\ansicon32 -p
	if %PROCESSOR_ARCHITECTURE%==AMD64 Files\ansicon64 -p
)
@echo off
title WFAv7 Tools by RedGreenBlue123
mode 96,2000
powershell -command "&{(get-host).ui.rawui.windowsize=@{width=96;height=24};}"
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set ESC=%%b
:ChooseTool
set Tool=
cls
echo %ESC%[93m-----------------------------------------%ESC%[97m
echo  %ESC%[92mChoose tool you want to use below:
echo   %ESC%[0m1)%ESC%[97m Driver Downloader
echo   %ESC%[0m2)%ESC%[97m Clean Installer folder
echo   %ESC%[0m3)%ESC%[97m Uninstall Windows 10 for ARMv7
echo   %ESC%[0m4)%ESC%[97m Enable Safe Mode of Windows 10 for ARMv7
echo   %ESC%[0m5)%ESC%[97m Run Installer without compatibility check (NOT RECOMMENDED)
echo %ESC%[93m-----------------------------------------%ESC%[97m
set /p Tool=%ESC%[92mTool%ESC%[32m: %ESC%[0m
if not defined Tool goto ChooseTool
if %Tool%==1 call "Driver Downloader.bat"
if %Tool%==2 goto Tool2
if %Tool%==3 goto Tool3
if %Tool%==4 goto Tool4
if %Tool%==5 call Installer.cmd Start
:Tool2
setlocal
echo.
if exist Temp\ rd /s /q Temp
if exist Logs\ rd /s /q Logs
:Choice1
if exist Drivers\ (
	set /p CYN=%ESC%[97mDo you want to delete Drivers folder? %ESC%[93m[%ESC%[92mY%ESC%[93m/%ESC%[91mN%ESC%[93m] %ESC%[0m
	if "!CYN!"=="" goto Choice
	if !CYN!==Y rd /s /q Drivers\ & set Completed=1
	if !CYN!==y rd /s /q Drivers\ & set Completed=1
	if !CYN!==N set Completed=1
	if !CYN!==n set Completed=1
) else (set Completed=1)
if not !Completed!==1 goto Choice1
if !Completed!==1 echo. & echo %ESC%[92mDone^^!%ESC%[0m & echo. & pause
endlocal
goto ChooseTool

:Tool3
setlocal
cls
echo.
echo %ESC%[93m - Connect your phone in mass storage mode to the computer.%ESC%[0m
echo.
pause
echo.
set "TID=3"
goto MOSAutoDetect
:ToBeContinued3
for /f %%i in (%MainOS%\Windows\WFAv7Storage.txt) do (set Storage=%%i)
if %Storage%==8 (
	echo.
	echo - Windows 10 for ARMv7 cannot be uninstalled on 8 GB devices
	echo   because Windows Phone is removed by the Installer.
	echo - Reflash your phone's original FFU.
	echo.
	pause
	endlocal
	endlocal
	goto ChooseTool
)
if %Storage%==16 (
	:WinPath1
	set /p WFADir=%ESC%[92mEnter Windows 10 for ARMv7 Path: %ESC%[0m
	if not exist "!WFADir!\Windows" (
		echo  %ESC%[91mNot a valid Windows partition!
		goto WinPath1
	)
	echo %ESC%[96mDeleting Windows 10 for ARMv7 Partition ...%ESC%[0m
	for /f %%i in (!WFADir!\Windows\UUID.txt) do (set UUID=%%i)
	echo Y >Y
	Powershell -C "Get-Partition | ? { $_.Guid -eq '!UUID!'} | Remove-Partition" < Y
	del Y
	set DLMOS=%MainOS:~0,-1%
	echo %ESC%[96mExtending Data Partition ...%ESC%[0m
	for /f %%i in ('Powershell -C "(Get-Partition -DriveLetter !DLMOS!).DiskNumber"') do set DiskNumber=%%i
	for /f %%i in ('Powershell -C "(Get-Partition | ? { $_.AccessPaths -eq '%MainOS%\Data\' }).PartitionNumber"') do set PartitionNumberData=%%i
	Powershell -C "Resize-Partition -DiskNumber !DiskNumber! -PartitionNumber !PartitionNumberData! -Size (Get-PartitionSupportedSize -DiskNumber !DiskNumber! -PartitionNumber !PartitionNumberData!).sizeMax"
	echo.
	echo %ESC%[93mRemoving BCD entry ...%ESC%[96m
	bcdedit /store !MainOS!\EFIESP\efi\Microsoft\Boot\BCD /delete {703c511b-98f3-4630-b752-6d177cbfb89c}
	bcdedit /store !MainOS!\EFIESP\efi\Microsoft\Boot\BCD /set "{bootmgr}" "displaybootmenu" no
	del !MainOS!\EFIESP\efi\Microsoft\Recovery\BCD !MainOS!\Windows\WFAv7Storage.txt
	echo.
	echo %ESC%[92mUninstallation Done.%ESC%[0m
	echo.
	pause
	endlocal
	endlocal
	goto ChooseTool
)
if %Storage%==32 (
	:WinPath2
	set /p WFADir=%ESC%[92mEnter Windows 10 for ARMv7 Path: %ESC%[0m
	if not exist "!WFADir!\Windows" (
		echo  %ESC%[91mNot a valid Windows partition!
		goto WinPath2
	)
	echo %ESC%[96mDeleting Windows 10 for ARMv7 Partition ...%ESC%[0m
	for /f %%i in (!WFADir!\Windows\UUID.txt) do (set UUID=%%i)
	echo Y >Y
	Powershell -C "Get-Partition | ? { $_.Guid -eq '!UUID!'} | Remove-Partition" < Y
	del Y
	set DLMOS=%MainOS:~0,-1%
	echo %ESC%[96mExtending Data Partition ...%ESC%[0m
	for /f %%i in ('Powershell -C "(Get-Partition -DriveLetter !DLMOS!).DiskNumber"') do set DiskNumber=%%i
	for /f %%i in ('Powershell -C "(Get-Partition | ? { $_.AccessPaths -eq '%MainOS%\Data\' }).PartitionNumber"') do set PartitionNumberData=%%i
	Powershell -C "Resize-Partition -DiskNumber !DiskNumber! -PartitionNumber !PartitionNumberData! -Size (Get-PartitionSupportedSize -DiskNumber !DiskNumber! -PartitionNumber !PartitionNumberData!).sizeMax"
	echo.
	echo %ESC%[93mRemoving BCD entry ...%ESC%[96m
	bcdedit /store !MainOS!\EFIESP\efi\Microsoft\Boot\BCD /delete {703c511b-98f3-4630-b752-6d177cbfb89c}
	bcdedit /store !MainOS!\EFIESP\efi\Microsoft\Boot\BCD /set "{bootmgr}" "displaybootmenu" no
	del !MainOS!\EFIESP\efi\Microsoft\Recovery\BCD !MainOS!\Windows\WFAv7Storage.txt
	echo.
	echo %ESC%[92mUninstallation Done.%ESC%[0m
	echo.
	pause
	endlocal
	endlocal
	goto ChooseTool
)
if %Storage%==32A (
	if not exist %MainOS%\Data\Windows10Arm\ (
		echo.
		echo %ESC%[91m - Windows 10 for ARMv7 is not installed.%ESC%[0m
		echo.
		pause
		endlocal
		endlocal
		goto ChooseTool
	)
	echo %ESC%[96mGranting Permissions ...%ESC%[0m
	takeown /F %MainOS%\Data\Windows10Arm /A
	takeown /F %MainOS%\Data\Windows10Arm /R /D Y /A
	icacls %MainOS%\Data\Windows10Arm /grant Administrators:F /C /Q
	icacls %MainOS%\Data\Windows10Arm /grant Administrators:F /T /C /Q
	echo %ESC%[96mRemoving Windows 10 for ARMv7 ...%ESC%[0m
	rd /s /q %MainOS%\Data\Windows10Arm
	echo.
	echo %ESC%[93mRemoving BCD entry ...%ESC%[96m
	bcdedit /store !MainOS!\EFIESP\efi\Microsoft\Boot\BCD /delete {703c511b-98f3-4630-b752-6d177cbfb89c}
	bcdedit /store !MainOS!\EFIESP\efi\Microsoft\Boot\BCD /set "{bootmgr}" "displaybootmenu" no
	del !MainOS!\EFIESP\efi\Microsoft\Recovery\BCD
	echo.
	echo %ESC%[92mUninstallation Done.%ESC%[0m
	echo.
	del !MainOS!\Windows\WFAv7Storage.txt !WFADir!\Windows\UUID.txt
	pause
	endlocal
	endlocal
	goto ChooseTool
)
endlocal
endlocal
goto ChooseTool

:Tool4
setlocal
:ChooseOperation2
set Operation=
cls
echo.
echo %ESC%[92mChoose operation below:
echo %ESC%[0m1^)%ESC%[97m Enable Safe Mode for WFAv7
echo %ESC%[0m2^)%ESC%[97m Disable Safe Mode for WFAv7
set /p Operation=%ESC%[93mOperation: %ESC%[0m
if not defined Operation goto ChooseOperation2
set "TID=4"
goto MOSAutoDetect

:ToBeContinued4
if %Operation%==1 (bcdedit /store "!MainOS!\EFIESP\efi\Microsoft\Boot\BCD" /set {703c511b-98f3-4630-b752-6d177cbfb89c} SafeBoot minimal & set Completed=1)
if %Operation%==2 (bcdedit /store "!MainOS!\EFIESP\efi\Microsoft\Boot\BCD" /deletevalue {703c511b-98f3-4630-b752-6d177cbfb89c} SafeBoot & set Completed=1)
if !Completed!==1 (
	echo %ESC%[92mDone^^!%ESC%[0m
	pause
)
if not !Completed!==1 goto ChooseOperation2
endlocal
endlocal
goto ChooseTool

:MOSAutoDetectFail
endlocal
echo %ESC%[93mFailed to auto detect MainOS.%ESC%[0m
if exist Temp\GPT del Temp\GPT
if exist Temp\GPT* del Temp\GPT*
set "Skip="
goto MOSPath
:MOSAutoDetect
setlocal
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
goto ToBeContinued%TID%

:MOSPath
setlocal
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
goto ToBeContinued%TID%

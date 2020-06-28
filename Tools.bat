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
set /p CYN=%ESC%[97mDo you want to delete Drivers folder? %ESC%[93m[%ESC%[92mY%ESC%[93m/%ESC%[91mN%ESC%[93m] %ESC%[0m
if "!CYN!"=="" goto Choice
if !CYN!==Y rd /s /q Drivers\ & set Completed=1
if !CYN!==y rd /s /q Drivers\ & set Completed=1
if !CYN!==N set Completed=1
if !CYN!==n set Completed=1
if not !Completed!==1 goto Choice1
if !Completed!==1 echo. & echo Done. & echo. & pause
endlocal
goto ChooseTool

:Tool3
setlocal
:ChooseDev
cls
echo.
echo %ESC%[92mChoose your device model below:
echo  %ESC%[36m1) %ESC%[97mLumia 930
echo  %ESC%[36m2) %ESC%[97mLumia 929 (Icon)
echo  %ESC%[36m3) %ESC%[97mLumia 1520
echo  %ESC%[36m4) %ESC%[97mLumia 1520 (16GB)
echo  %ESC%[36m5) %ESC%[97mLumia 1520 AT^&T
echo  %ESC%[36m6) %ESC%[97mLumia 1520 AT^&T (16GB)
echo  %ESC%[36m7) %ESC%[97mLumia 830 Global
echo  %ESC%[36m8) %ESC%[97mLumia 735 Global
echo  %ESC%[36mA) %ESC%[97mLumia 640 XL LTE Global
echo  %ESC%[36mB) %ESC%[97mLumia 640 XL LTE AT^&T
echo  %ESC%[36mC) %ESC%[97mLumia 950
echo  %ESC%[36mD) %ESC%[97mLumia 950 XL
echo  %ESC%[36mE) %ESC%[97mLumia 1020
echo  %ESC%[36mF) %ESC%[97mLumia 1020 AT^&T
echo  %ESC%[36mG) %ESC%[97mLumia 920
set /p Model=%ESC%[92mDevice%ESC%[32m: %ESC%[0m
if "%Model%"=="" goto ChooseDev
if "%Model%"=="1" set Storage=32 & goto ToBeContinued1
if "%Model%"=="2" set Storage=32 & goto ToBeContinued1
if "%Model%"=="3" set Storage=32 & goto ToBeContinued1
if "%Model%"=="4" set Storage=16 & goto ToBeContinued1
if "%Model%"=="5" set Storage=32 & goto ToBeContinued1
if "%Model%"=="6" set Storage=16 & goto ToBeContinued1
if "%Model%"=="7" set Storage=16 & goto ToBeContinued1
if "%Model%"=="8" set Storage=8 & goto ToBeContinued1
if /i "%Model%"=="A" set Storage=8 & goto ToBeContinued1
if /i "%Model%"=="B" set Storage=8 & goto ToBeContinued1
if /i "%Model%"=="C" set Storage=32 & goto ToBeContinued1
if /i "%Model%"=="D" set Storage=32 & goto ToBeContinued1
if /i "%Model%"=="E" set Storage=32A & goto ToBeContinued1
if /i "%Model%"=="F" set Storage=32A & goto ToBeContinued1
if /i "%Model%"=="G" set Storage=32A & goto ToBeContinued1
:ToBeContinued1
cls
echo.
echo %ESC%[93m - Connect your phone in mass storage mode to the computer.%ESC%[0m
echo.
pause
echo.
:MOSPath2
set /p MainOS=%ESC%[92mEnter MainOS Path: %ESC%[0m
if not exist "%MainOS%\EFIESP" (
	ECHO  %ESC%[91mNot a valid MainOS partition^^!
	GOTO MOSPath2
)
if not exist "%MainOS%\Data" (
	ECHO  %ESC%[91mNot a valid MainOS partition^^!
	GOTO MOSPath2
)
if not exist %MainOS%\Windows\WFAv7Storage.txt (
	echo.
	echo %ESC%[91m - Windows 10 for ARMv7 is not installed.%ESC%[0m
	echo.
	pause
	endlocal
	goto ChooseTool
)
endlocal
goto ChooseTool
for /f %%i in (%MainOS%\Windows\WFAv7Storage.txt) do (set Storage=%%i)
if %Storage%==8 (
	echo.
	echo - Windows 10 for ARMv7 cannot be uninstalled on 8 GB devices
	echo   because Windows Phone is removed by the Installer.
	echo.
	pause
	endlocal
	goto ChooseTool
)
if %Storage%==16 (
	:WinPath1
	set /p WFAv7Dir=%ESC%[92mEnter Windows 10 for ARMv7 Path: %ESC%[0m
	if not exist "%WFAv7Dir%\Windows" (
		ECHO  %ESC%[91mNot a valid Windows partition!
		GOTO WinPath1
	)
	echo %ESC%[96mDeleting Windows 10 for ARMv7 Partition ...%ESC%[0m
	for /f %%i in (%WFAv7Dir%\Windows\UUID.txt) do (set UUID=%%i)
	echo Y >Y
	Powershell -C "Get-Partition | ? { $_.Guid -eq '%UUID%'} | Remove-Partition" < Y
	del Y
	set DLMOS=%MainOS:~0,-1%
	echo %ESC%[96mExtending Data Partition ...%ESC%[0m
	for /f %%i in ('Powershell -C "(Get-Partition -DriveLetter %DLMOS%).DiskNumber"') do set DiskNumber=%%i
	for /f %%i in ('Powershell -C "(Get-Partition | ? { $_.AccessPaths -eq '%MainOS%\Data\' }).PartitionNumber"') do set PartitionNumberData=%%i
	Powershell -C "Resize-Partition -DiskNumber %DiskNumber% -PartitionNumber %PartitionNumberData% -Size (Get-PartitionSupportedSize -DiskNumber %DiskNumber% -PartitionNumber %PartitionNumberData%).sizeMax"
	echo Done^^!
	echo.
	pause
	endlocal
	goto ChooseTool
)
if %Storage%==32 (
	:WinPath2
	set /p WFAv7Dir=%ESC%[92mEnter Windows 10 for ARMv7 Path: %ESC%[0m
	if not exist "%WFAv7Dir%\Windows" (
		ECHO  %ESC%[91mNot a valid Windows partition!
		GOTO WinPath2
	)
	echo %ESC%[96mDeleting Windows 10 for ARMv7 Partition ...%ESC%[0m
	for /f %%i in (%WFAv7Dir%\Windows\UUID.txt) do (set UUID=%%i)
	echo Y >Y
	Powershell -C "Get-Partition | ? { $_.Guid -eq '%UUID%'} | Remove-Partition" < Y
	del Y
	set DLMOS=%MainOS:~0,-1%
	echo %ESC%[96mExtending Data Partition ...%ESC%[0m
	for /f %%i in ('Powershell -C "(Get-Partition -DriveLetter %DLMOS%).DiskNumber"') do set DiskNumber=%%i
	for /f %%i in ('Powershell -C "(Get-Partition | ? { $_.AccessPaths -eq '%MainOS%\Data\' }).PartitionNumber"') do set PartitionNumberData=%%i
	Powershell -C "Resize-Partition -DiskNumber %DiskNumber% -PartitionNumber %PartitionNumberData% -Size (Get-PartitionSupportedSize -DiskNumber %DiskNumber% -PartitionNumber %PartitionNumberData%).sizeMax"
	echo Done^^!
	echo.
	pause
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
		goto ChooseTool
	)
	echo %ESC%[96mUninstalling Windows 10 for ARMv7 ...%ESC%[0m
	takeown /F %MainOS%\Data\Windows10Arm
	takeown /F %MainOS%\Data\Windows10Arm /R /D Y
	icacls %MainOS%\Data\Windows10Arm /grant Administrators:F /C /Q
	icacls %MainOS%\Data\Windows10Arm /grant Administrators:F /T /C /Q /Reset
	rd /s /q %MainOS%\Data\Windows10Arm
	echo %ESC%[92mDone^^!%ESC%[0m
	echo.
	pause
)

:Tool4
setlocal
:ChooseOperation2
set Operation=
cls
echo.
echo %ESC%[97mChoose operation below:
echo %ESC%[0m1^)%ESC%[97m Enable Safe Mode for WFAv7
echo %ESC%[0m2^)%ESC%[97m Disable Safe Mode for WFAv7
set /p Operation=%ESC%[93mOperation: %ESC%[0m
if not defined Operation goto ChooseOperation2
if !Operation!==1 (
	:MOSPath10
	set /p MainOS=%ESC%[92mEnter MainOS Path: 
	if not exist !MainOS!\EFIESP (
		ECHO  %ESC%[91mNot a valid MainOS partition!
		GOTO MOSPath10
	)
	if not exist !MainOS!\Data (
		ECHO  %ESC%[91mNot a valid MainOS partition!
		GOTO MOSPath10
	)
	bcdedit /store "!MainOS!\EFIESP\efi\Microsoft\Boot\BCD" /set {703c511b-98f3-4630-b752-6d177cbfb89c} SafeBoot minimal & set Completed=1
)
if !Operation!==2 (
	:MOSPath11
	set /p MainOS=%ESC%[92mEnter MainOS Path: 
	if not exist !MainOS!\EFIESP (
		ECHO  %ESC%[91mNot a valid MainOS partition!
		GOTO MOSPath10
	)
	if not exist !MainOS!\Data (
		ECHO  %ESC%[91mNot a valid MainOS partition!
		GOTO MOSPath10
	)
	bcdedit /store "!MainOS!\EFIESP\efi\Microsoft\Boot\BCD" /deletevalue {703c511b-98f3-4630-b752-6d177cbfb89c} SafeBoot & set Completed=1
)
if !Completed!==1 (
	echo %ESC%[92mDone^^!%ESC%[0m
	Pause
)
if not !Completed!==1 goto ChooseOperation2
endlocal
goto ChooseTool


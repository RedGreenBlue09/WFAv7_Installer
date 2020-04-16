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
title WFAv7 Tools by RedGreenBlue123
:ChooseTool
cd /D "%~dp0"
set Tool=
mode con: cols=96 lines=24
cls
color 0f
echo ----------------------------------------
echo Choose tool you want to use below:
echo  1) Driver Downloader
echo  2) Clean Installer folder
echo  3) Mount/Unmount Windows 10 for ARMv7
echo  4) Fix Windows Phone update
echo  5) Uninstall Windows 10 for ARMv7
echo ----------------------------------------
set /p Tool=Tool: 
if not defined Tool goto ChooseTool
if %Tool%==1 call "Driver Downloader.bat"
if %Tool%==2 (
	setlocal EnableDelayedExpansion
	echo.
	if exist diskpart.txt del /A:H diskpart.txt
	if exist diskpart1.txt del /A:H diskpart1.txt
	if exist diskpart2.txt del /A:H diskpart2.txt
	:Choice
	set /p CYN=Do you want to delete Drivers folder? [Y/N] 
	if "!CYN!"=="" goto Choice
	if !CYN!==Y rd /s /q Drivers\ & set Completed=1
	if !CYN!==y rd /s /q Drivers\ & set Completed=1
	if !CYN!==N set Completed=1
	if !CYN!==n set Completed=1
	if not !Completed!==1 goto Choice
	if !Completed!==1 echo Done! & pause
	endlocal
)
if %Tool%==3 (
	setlocal EnableDelayedExpansion
	:ChooseOperation
	set Operation=
	cls
	echo.
	echo Choose operation below:
	echo 1^) Mount Windows 10 for ARMv7
	echo 2^) Unmount Windows 10 for ARMv7
	set /p Operation=Operation: 
	if not defined Operation goto ChooseOperation
	if !Operation!==1 (
		:MOSPath1
		set /p MainOS=Enter MainOS Path: 
		if not exist !MainOS!\EFIESP (
			ECHO  Not a valid MainOS partition!
			GOTO MOSPath1
		)
		if not exist !MainOS!\Data (
			ECHO  Not a valid MainOS partition!
			GOTO MOSPath1
		)
		if not exist !MainOS!\Data\windows10arm.vhdx (
			ECHO  Windows 10 for ARMv7 is not installed.
			PAUSE
		) else (
			Mounting VHDX ...
			powershell Mount-VHD -Path !MainOS!\Data\windows10arm.vhdx
			set Completed=1
		)
	)
	if !Operation!==2 (
		set /p MainOS=Enter MainOS Path: 
		if not exist !MainOS!\EFIESP (
			ECHO  Not a valid MainOS partition!
			GOTO MOSPath
		)
		if not exist !MainOS!\Data (
			ECHO  Not a valid MainOS partition!
			GOTO MOSPath
		)
		if not exist !MainOS!\Data\windows10arm.vhdx (
			ECHO  Windows 10 for ARMv7 is not installed.
			PAUSE
		) else (
			Unmounting VHDX ...
			powershell Dismount-VHD -Path !MainOS!\Data\windows10arm.vhdx
			set Completed=1
		)
	)
	if !Completed!==1 (
		Done!
		Pause
	)
	if not !Completed!==1 goto ChooseOperation
	endlocal
)
if %Tool%==4 (
	setlocal EnableDelayedExpansion
	echo.
	echo  Connect your phone in mass storage mode to the computer and press enter to continue ...
	echo.
	pause
	echo.
	:MOSPath
	set /p MainOS=Enter MainOS Path: 
	if not exist !MainOS!\EFIESP (
		ECHO  Not a valid MainOS partition!
		GOTO MOSPath
	)
	echo Fixing BCD ...
	@ECHO OFF
	SET bcdLoc="!MainOS!\EFIESP\efi\Microsoft\Boot\BCD"
	SET id="{703c511b-98f3-4630-b752-6d177cbfb89c}"
	bcdedit /store %bcdLoc% /delete %id% >nul
	bcdedit /store %bcdLoc% /create %id% /d "Windows 10 for ARMv7" /application "osloader"
	bcdedit /store %bcdLoc% /set %id% "device" "vhd=[!MainOS!\Data]\windows10arm.vhdx"
	bcdedit /store %bcdLoc% /set %id% "osdevice" "vhd=[!MainOS!\Data]\windows10arm.vhdx"
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
	endlocal
)
if %Tool%==5 (
	setlocal EnableDelayedExpansion
	echo.
	echo  Connect your phone in mass storage mode to the computer and press enter to continue ...
	echo.
	pause
	echo.
	:MOSPath2
	set /p MainOS=Enter MainOS Path: 
	if not exist "!MainOS!\EFIESP" (
		ECHO  Not a valid MainOS partition!
		GOTO MOSPath2
	)
	if not exist "!MainOS!\Data" (
		ECHO  Not a valid MainOS partition!
		GOTO MOSPath2
	)
	echo Deleting Windows 10 for ARMv7 VHDX ...
	del !MainOS!\Data\windows10arm.vhdx
	echo Removing BCD entry ...
	bcdedit /store !MainOS!\EFIESP\efi\Microsoft\Boot\BCD /delete {703c511b-98f3-4630-b752-6d177cbfb89c}
	bcdedit /store !MainOS!\EFIESP\efi\Microsoft\Boot\BCD /set "{bootmgr}" "displaybootmenu" no
	echo.
	echo Done!
	pause
	endlocal
)
if not %Tool%==1 goto ChooseTool
if not %Tool%==2 goto ChooseTool
if not %Tool%==3 goto ChooseTool
if not %Tool%==4 goto ChooseTool
if not %Tool%==5 goto ChooseTool
goto ChooseTool

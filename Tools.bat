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
mode 96,2000
powershell -command "&{(get-host).ui.rawui.windowsize=@{width=96;height=24};}"
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set ESC=%%b
:ChooseTool
cd /D "%~dp0"
set Tool=
cls
echo %ESC%[93m-----------------------------------------%ESC%[97m
echo  Choose tool you want to use below:
echo   %ESC%[0m1)%ESC%[97m Driver Downloader
echo   %ESC%[0m2)%ESC%[97m Clean Installer folder
echo   %ESC%[0m3)%ESC%[97m Mount/Unmount Windows 10 for ARMv7
echo   %ESC%[0m4)%ESC%[97m Fix Windows Phone update
echo   %ESC%[0m5)%ESC%[97m Uninstall Windows 10 for ARMv7
echo %ESC%[93m-----------------------------------------%ESC%[97m
set /p Tool=%ESC%[92mTool%ESC%[32m: %ESC%[0m
if not defined Tool goto ChooseTool
if %Tool%==1 call "Driver Downloader.bat"
if %Tool%==2 (
	setlocal EnableDelayedExpansion
	echo.
	if exist diskpart.txt del /A:H diskpart.txt
	if exist diskpart1.txt del /A:H diskpart1.txt
	if exist diskpart2.txt del /A:H diskpart2.txt
	:Choice
	set /p CYN=%ESC%[97mDo you want to delete Drivers folder? %ESC%[93m[%ESC%[92mY%ESC%[93m/%ESC%[91mN%ESC%[93m] %ESC%[0m
	if "!CYN!"=="" goto Choice
	if !CYN!==Y rd /s /q Drivers\ & set Completed=1
	if !CYN!==y rd /s /q Drivers\ & set Completed=1
	if !CYN!==N set Completed=1
	if !CYN!==n set Completed=1
	if not !Completed!==1 goto Choice
	if !Completed!==1 echo. & echo Done. & echo. & pause
	endlocal
)
if %Tool%==3 (
	setlocal EnableDelayedExpansion
	:ChooseOperation
	set Operation=
	cls
	echo.
	echo %ESC%[97mChoose operation below:
	echo %ESC%[0m1^)%ESC%[97m Mount Windows 10 for ARMv7
	echo %ESC%[0m2^)%ESC%[97m Unmount Windows 10 for ARMv7
	set /p Operation=%ESC%[93mOperation: %ESC%[0m
	if not defined Operation goto ChooseOperation
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
		if not exist !MainOS!\Data\windows10arm.vhdx (
			ECHO  %ESC%[91mWindows 10 for ARMv7 is not installed.%ESC%[0m
			PAUSE
		) else (
			%ESC%[93mMounting VHDX ...%ESC%[96m
			powershell Mount-VHD -Path !MainOS!\Data\windows10arm.vhdx
			set Completed=1
		)
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
		if not exist !MainOS!\Data\windows10arm.vhdx (
			ECHO  %ESC%[91mWindows 10 for ARMv7 is not installed.%ESC%[0m
			PAUSE
		) else (
			%ESC%[93mUnmounting VHDX ...%ESC%[96m
			powershell Dismount-VHD -Path !MainOS!\Data\windows10arm.vhdx
			set Completed=1
		)
	)
	if !Completed!==1 (
		echo %ESC%[92mDone!%ESC%[0m
		Pause
	)
	if not !Completed!==1 goto ChooseOperation
	endlocal
)
if %Tool%==4 (
	setlocal EnableDelayedExpansion
	echo.
	echo  %ESC%[93mConnect your phone in mass storage mode to the computer.%ESC%[0m
	echo.
	pause
	echo.
	:MOSPath
	set /p MainOS=%ESC%[92mEnter MainOS Path%ESC%[32m: 
	if not exist !MainOS!\EFIESP (
		ECHO  %ESC%[91mNot a valid MainOS partition!
		GOTO MOSPath
	)
	echo %ESC%[93mFixing BCD ...%ESC%[96m
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
	ECHO %ESC%[92mBCD has been fixed%ESC%[0m
	pause
	endlocal
)
if %Tool%==5 (
	setlocal EnableDelayedExpansion
	echo.
	echo  %ESC%[93mConnect your phone in mass storage mode to the computer.%ESC%[0m
	echo.
	pause
	echo.
	:MOSPath2
	set /p MainOS=%ESC%[92mEnter MainOS Path: %ESC%[0m
	if not exist "!MainOS!\EFIESP" (
		ECHO  %ESC%[91mNot a valid MainOS partition!
		GOTO MOSPath2
	)
	if not exist "!MainOS!\Data" (
		ECHO  %ESC%[91mNot a valid MainOS partition!
		GOTO MOSPath2
	)
	
	if not exist !MainOS!\Data\windows10arm.vhdx (
		ECHO  Windows 10 for ARMv7 is not installed.
		PAUSE
	) else (
		echo %ESC%[93mDeleting Windows 10 for ARMv7 VHDX ...%ESC%[96m
		del !MainOS!\Data\windows10arm.vhdx
		echo %ESC%[93mRemoving BCD entry ...%ESC%[96m
		bcdedit /store !MainOS!\EFIESP\efi\Microsoft\Boot\BCD /delete {703c511b-98f3-4630-b752-6d177cbfb89c}
		bcdedit /store !MainOS!\EFIESP\efi\Microsoft\Boot\BCD /set "{bootmgr}" "displaybootmenu" no
		del MainOS!\EFIESP\efi\Microsoft\Recovery\BCD
		echo.
		echo %ESC%[93mDone%ESC%[0m
		pause
	)
	endlocal
)
if not %Tool%==1 goto ChooseTool
if not %Tool%==2 goto ChooseTool
if not %Tool%==3 goto ChooseTool
if not %Tool%==4 goto ChooseTool
if not %Tool%==5 goto ChooseTool
goto ChooseTool

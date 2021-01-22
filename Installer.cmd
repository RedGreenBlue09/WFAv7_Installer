@echo off
setlocal EnableExtensions
setlocal
if not "%~1" EQU "" call :%~1
if %Errorlevel% NEQ 0 goto :EOF
:Check1
cd ..
echo Checking compatibility ...
echo  - Checking Drive [N:] ...
if EXIST N:\ (
	title ERROR!
	color 0C
	echo ----------------------------------------------------------------
	echo   Please Unmount Drive [N:]
	pause
	exit /B
)
::---------------------------------------------------------------
:GetAdministrator
    if "%PROCESSOR_ARCHITECTURE%" EQU "AMD64" ( >nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system" )
    if "%PROCESSOR_ARCHITECTURE%" EQU "ARM64" ( >nul 2>&1 "%SYSTEMROOT%\SysArm32\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system" )
    if "%PROCESSOR_ARCHITECTURE%" EQU "x86" (
	"%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" >nul 2>&1
) else ("%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" >nul 2>&1)

if %errorlevel% NEQ 0 (
	echo Requesting administrative privileges...
	goto UserAccountControl
) else (goto GotAdministrator)

:UserAccountControl
	echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
	set params= %*
	echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"
	"%temp%\getadmin.vbs"
	del "%temp%\getadmin.vbs"
	exit /B

:GotAdministrator
	pushd "%cd%"
	cd /D "%~dp0"
	if exist "%~dp0Temp\" rd /s /q "%~dp0Temp\"
	if not exist "%~dp0Temp\" md "%~dp0Temp"
::---------------------------------------------------------------
:Check2
title Checking compatibility ...
echo  - Checking Windows Build ...
for /f "tokens=3" %%a in ('Reg Query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild ^| findstr /r /i "REG_SZ"') do set WinBuild=%%a
if %WinBuild% LSS 9600 (
	title ERROR!
	color 0C
	echo ----------------------------------------------------------------
	echo   This Windows version is not supported by WFAv7 Installer.
	echo   Please use Windows 8.1+ ^(Build 9600+^) 
	echo   Current OS build: %WinBuild%
	pause
	exit /B
)

echo  - Checking Windows Powershell ...
Powershell /? >nul 2>&1
set "PLV=%errorlevel%"
if %PLV% NEQ 0 (
	title ERROR!
	color 0C
	echo ----------------------------------------------------------------
	echo   Powershell wasn't found or it have problem.
	echo   Please enable Powershell and continue.
	echo   Error code: %PLV%
	pause
	exit /B
)

echo  - Getting CmdLets ...
Powershell -C "(Get-Command).name" >> Temp\Commands.txt
echo  - Checking Get-Date ...
findstr /X /C:"Get-Date" Temp\Commands.txt >nul || goto MissingCommand
echo  - Checking New-Partition ...
findstr /X /C:"New-Partition" Temp\Commands.txt >nul || goto MissingCommand
echo  - Checking Get-Partition ...
findstr /X /C:"Get-Partition" Temp\Commands.txt >nul || goto MissingCommand
echo  - Checking Get-WmiObject ...
findstr /X /C:"Get-WmiObject" Temp\Commands.txt >nul || goto MissingCommand
echo  - Checking Get-PartitionSupportedSize ...
findstr /X /C:"Get-PartitionSupportedSize" Temp\Commands.txt >nul || goto MissingCommand
del Temp\Commands.txt
goto ToBeContinued0
:MissingCommand
del Temp\Commands.txt
title ERROR!
color 0C
echo ----------------------------------------------------------------
echo  You used Windows 7 / Windows Home edition / Customized Windows.
echo  Please use Official Windows 8.1 or Windows 10.
pause
exit /B

:ToBeContinued0
cls
echo Installer is loading ... [100%%]
:Start
if %WinBuild% LSS 10586 (
	if /i %PROCESSOR_ARCHITECTURE% EQU X86 Files\ansicon32 -p
	if /i %PROCESSOR_ARCHITECTURE% EQU AMD64 Files\ansicon64 -p
)
set "ESC="
::---------------------------------------------------------------
cls
Files\cmdresize 96 2000 96 24
:Disclaimer
cls
title Windows 10 for ARMv7 Installer 2.0
echo.
echo.
echo                            %ESC%[97m%ESC%[1mWelcome to Windows 10 for ARMv7 Installer%ESC%[0m
echo.
echo                     %ESC%[93m=======================================================
echo.
echo                                           %ESC%[91mDISCLAIMER:
echo %ESC%[95m
echo    %ESC%[36m+----------------------------------------------------------------------------------------+
echo    ^|                                                                                        ^|
echo    ^|%ESC%[95m  * I'm not responsible for bricked devices, dead SD cards,                             %ESC%[36m^|
echo    ^|%ESC%[95m    thermonuclear war, or you getting fired because the alarm app failed.               %ESC%[36m^|
echo    ^|                                                                                        ^|
echo    ^|%ESC%[95m  * YOU are choosing to make these modifications,                                       %ESC%[36m^|
echo    ^|%ESC%[95m    and if you point the finger at me for messing up your device, I will laugh at you.  %ESC%[36m^|
echo    ^|                                                                                        ^|
echo    ^|%ESC%[95m  * Your warranty will be void if you tamper with any part of your device / software.   %ESC%[36m^|
echo    ^|                                                                                        ^|
echo    +----------------------------------------------------------------------------------------+%ESC%[0m
echo.
set /p Disclaimer="%ESC%[97m   Are you agree with the DISCLAIMER? %ESC%[93m[%ESC%[92mY%ESC%[93m/%ESC%[91mN%ESC%[93m]%ESC%[0m "
if /i "%Disclaimer%" EQU "N" (
	cls
	echo  %ESC%[93m//////////////////////////////////////////////////////////////////////////////////////////////
	echo  //                           %ESC%[97mWindows 10 for ARMv7 Installer 2.0%ESC%[93m                             //
	echo  //                                   %ESC%[97mby RedGreenBlue123%ESC%[93m                                     //
	echo  //                    %ESC%[97mThanks to: @Gus33000, @FadilFadz01, @Heathcliff74%ESC%[93m                     //
	echo  //////////////////////////////////////////////////////////////////////////////////////////////%ESC%[0m
	echo.
	echo  %ESC%[91mYou MUST agree with the DISCLAIMER to use WFAv7 Installer.%ESC%[0m
	echo.
	pause
	exit /b
)
if /i "%Disclaimer%" NEQ "Y" goto Disclaimer
::---------------------------------------------------------------
:ChooseDev
set "Model="
cls
echo  %ESC%[93m//////////////////////////////////////////////////////////////////////////////////////////////
echo  //                           %ESC%[97mWindows 10 for ARMv7 Installer 2.0%ESC%[93m                             //
echo  //                                   %ESC%[97mby RedGreenBlue123%ESC%[93m                                     //
echo  //                    %ESC%[97mThanks to: @Gus33000, @FadilFadz01, @Heathcliff74%ESC%[93m                     //
echo  //////////////////////////////////////////////////////////////////////////////////////////////%ESC%[0m
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
echo  %ESC%[36mE) %ESC%[97mLumia 1020 [BLUE SCREEN]
echo  %ESC%[36mF) %ESC%[97mLumia 1020 AT^&T
echo  %ESC%[36mG) %ESC%[97mLumia 920
echo  %ESC%[36mH) %ESC%[97mBSP Method (More devices) [COMMING SOON]%ESC%[0m
set /p Model=%ESC%[92mDevice%ESC%[32m: %ESC%[0m
if "%Model%" EQU "" goto ChooseDev
if "%Model%" EQU "1" set "Storage=32" & goto ToBeContinued1
if "%Model%" EQU "2" set "Storage=32" & goto ToBeContinued1
if "%Model%" EQU "3" set "Storage=32" & goto ToBeContinued1
if "%Model%" EQU "4" set "Storage=16" & goto ToBeContinued1
if "%Model%" EQU "5" set "Storage=32" & goto ToBeContinued1
if "%Model%" EQU "6" set "Storage=16" & goto ToBeContinued1
if "%Model%" EQU "7" set "Storage=16" & goto ToBeContinued1
if "%Model%" EQU "8" set "Storage=8" & goto ToBeContinued1
if /i "%Model%" EQU "A" set "Storage=8" & goto ToBeContinued1
if /i "%Model%" EQU "B" set "Storage=8" & goto ToBeContinued1
if /i "%Model%" EQU "C" set "Storage=32" & goto ToBeContinued1
if /i "%Model%" EQU "D" set "Storage=32" & goto ToBeContinued1
if /i "%Model%" EQU "E" set "Storage=32A" & goto ToBeContinued1
if /i "%Model%" EQU "F" set "Storage=32A" & goto ToBeContinued1
if /i "%Model%" EQU "G" set "Storage=32A" & goto ToBeContinued1
:: if /i "%Model%" EQU "H" goto BSP
goto ChooseDev
::---------------------------------------------------------------
:ToBeContinued1
cls
echo  %ESC%[93m//////////////////////////////////////////////////////////////////////////////////////////////
echo  //                           %ESC%[97mWindows 10 for ARMv7 Installer 2.0%ESC%[93m                             //
echo  //                                   %ESC%[97mby RedGreenBlue123%ESC%[93m                                     //
echo  //                    %ESC%[97mThanks to: @Gus33000, @FadilFadz01, @Heathcliff74%ESC%[93m                     //
echo  //////////////////////////////////////////////////////////////////////////////////////////////%ESC%[0m
echo.
echo %ESC%[92m PREPARATION:
echo   - Read README.TXT and instruction before using this Installer.
echo   - Make sure your phone is fully charged and it's battery is not wear too much.
echo   - Make sure no drives mounted with letter N.
echo   - Closed all programs during installation.
echo   * Highly recommend you to flash the original FFU of your phone.
echo     before installing Windows 10 ARMv7.
if %Storage% EQU 8 echo   * This will remove Windows Phone to get more space for WFAv7.%ESC%[0m
if %Storage% EQU 16 echo   * You need at least ^> %ESC%[4m8.0 GB%ESC%[0m%ESC%[92m of empty phone storage to continue.%ESC%[0m
if %Storage% EQU 32 echo   * You need at least ^> %ESC%[4m16.0 GB%ESC%[0m%ESC%[92m of empty phone storage to continue.%ESC%[0m
if %Storage% EQU 32A echo   * You need at least ^> %ESC%[4m8.0 GB%ESC%[0m%ESC%[92m of empty phone storage to continue.%ESC%[0m
echo.
echo %ESC%[95m WARNING:
echo   * After pressing any key, the Installation will begin. As a batch script,
echo     Installation cannot be cancelled correctly without any damage to your device.
echo   * If you want to cancel the installation, close this console RIGHT NOW.
echo   * You can partially pause the installation by clicking any where on the console.%ESC%[0m
echo.
pause
goto MOSAutoDetect
:MOSAutoDetectFail
echo %ESC%[93mFailed to auto detect MainOS.%ESC%[0m
if exist Temp\GPT del Temp\GPT
if exist Temp\GPT* del Temp\GPT*
set "Skip="
goto MOSPath
:MOSAutoDetect
setlocal EnableDelayedExpansion
cls
echo  %ESC%[93m//////////////////////////////////////////////////////////////////////////////////////////////
echo  //                           %ESC%[97mWindows 10 for ARMv7 Installer 2.0%ESC%[93m                             //
echo  //                                   %ESC%[97mby RedGreenBlue123%ESC%[93m                                     //
echo  //                    %ESC%[97mThanks to: @Gus33000, @FadilFadz01, @Heathcliff74%ESC%[93m                     //
echo  //////////////////////////////////////////////////////////////////////////////////////////////%ESC%[0m
echo.
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
goto CheckReqFiles
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
set /a "Temp=%DiskNumber%%%1" >nul
if %Errorlevel% NEQ 0 {
	echo  %ESC%[91mFailed to get phone's disk number.
	goto MOSPath
}
for /f %%i in ('Powershell -C "(Get-Partition -DriveLetter %DLMOS%).PartitionNumber"') do set "PartitionNumber=%%i"
set /a "Temp=%PartitionNumber%%%1" >nul
if %Errorlevel% NEQ 0 {
	echo  %ESC%[91mFailed to get MainOS partition number.
	goto MOSPath
}
set "Temp="
::---------------------------------------------------------------
:CheckReqFiles
if %Model% EQU 1 (if not exist Drivers\Lumia930 goto MissingDrivers)
if %Model% EQU 2 (if not exist Drivers\LumiaIcon goto MissingDrivers)
if %Model% EQU 3 (if not exist Drivers\Lumia1520 goto MissingDrivers)
if %Model% EQU 4 (if not exist Drivers\Lumia1520 goto MissingDrivers)
if %Model% EQU 5 (if not exist Drivers\Lumia1520-AT^&T goto MissingDrivers)
if %Model% EQU 6 (if not exist Drivers\Lumia1520-AT^&T goto MissingDrivers)
if %Model% EQU 7 (if not exist Drivers\Lumia830 goto MissingDrivers)
if %Model% EQU 8 (if not exist Drivers\Lumia735 goto MissingDrivers)
if /I %Model% EQU A (if not exist Drivers\Lumia640XL goto MissingDrivers)
if /I %Model% EQU B (if not exist Drivers\Lumia640XL-AT^&T goto MissingDrivers)
if /I %Model% EQU C (if not exist Drivers\Lumia950 goto MissingDrivers)
if /I %Model% EQU D (if not exist Drivers\Lumia950XL goto MissingDrivers)
if /I %Model% EQU E (if not exist Drivers\Lumia1020 goto MissingDrivers)
if /I %Model% EQU F (if not exist Drivers\Lumia1020_AT^&T goto MissingDrivers)
if /I %Model% EQU G (if not exist Drivers\Lumia920 goto MissingDrivers)
if not exist "%~dp0\install.wim" (
	echo ----------------------------------------------------------------
	echo  %ESC%[91mPlace install.wim in the Installer folder and try again.%ESC%[0m
	pause
	goto ChooseDev
)
Goto LogNameInit
:MissingDrivers
echo ----------------------------------------------------------------
echo  %ESC%[91mDrivers not found.
echo  Download drivers for your device using Driver Downloader.%ESC%[0m
pause
goto ChooseDev
::---------------------------------------------------------------
:LogNameInit
if not exist Logs\NUL del Logs /Q 2>nul
if not exist Logs\ md Logs
cd Logs
for /f %%d in ('Powershell Get-Date -format "dd-MMM-yy"') do set "Date1=%%d"
if not exist %Date1%.log set LogName=Logs\%Date1%.log & goto LoggerInit
if not exist %Date1%-1.log set LogName=Logs\%Date1%-1.log & goto LoggerInit
set "LogNum=1"
:LogName
if exist %Date1%-*.log (
    if exist %Date1%-%LogNum%.log (
        set /a "LogNum+=1"
        goto LogName
    ) else (
        set "LogName=Logs\%Date1%-%LogNum%.log"
    )
)
:LoggerInit
cd ..
set "ErrNum=0"
set Logger=2^>Temp\CurrentError.log ^>^> "%LogName%" ^&^
 set "Err=^!Errorlevel^!" ^&^
 (for /f "tokens=*" %%a in (Temp\CurrentError.log) do echo [EROR] %%a) ^>^> Temp\ErrorConsole.log ^&^
 (if exist Temp\ErrorConsole.log type Temp\ErrorConsole.log) ^&^
 type Temp\CurrentError.log ^>^> "%LogName%" ^&^
 (if exist Temp\ErrorConsole.log del Temp\ErrorConsole.log) ^&^
 (if ^^!Err^^! NEQ 0 set /a "ErrNum+=1" ^& echo %ESC%[93m[WARN] An error has occurred, installation will continue.%ESC%[91m)
set SevLogger=2^>Temp\CurrentError.log ^>^> "%LogName%" ^&^
 set "SevErr=^!Errorlevel^!" ^&^
 (for /f "tokens=*" %%a in (Temp\CurrentError.log) do echo [EROR] %%a) ^>^> Temp\ErrorConsole.log ^&^
 (if exist Temp\ErrorConsole.log type Temp\ErrorConsole.log) ^&^
 type Temp\CurrentError.log ^>^> "%LogName%" ^&^
 (if exist Temp\ErrorConsole.log del Temp\ErrorConsole.log) ^&^
 (if ^^!SevErr^^! NEQ 0 set /a "ErrNum+=1" ^>nul ^& goto SevErrFound)
:ToBeContinued2
set "StartTime=%Time%"
echo.
echo %ESC%[96m[INFO] Installation was started at %StartTime%
echo #### INSTALLATION WAS STARTED AT %StartTime% #### >>%LogName%
echo ========================================================= >>%LogName%
echo ## Device is %Model%  ## >>%LogName%
echo ## MainOS is %MainOS% ## >>%LogName%
echo. >>%LogName%
if not exist Temp\ md Temp\
echo %ESC%[96m[INFO] Getting Partition Infos ...%ESC%[91m
for /f %%i in ('Powershell -C "(Get-Partition | ? { $_.AccessPaths -eq '%MainOS%\EFIESP\' }).PartitionNumber"') do set "PartitionNumberEFIESP=%%i"
set /a "Temp=%PartitionNumberEFIESP%%%1" >nul
if %Errorlevel% NEQ 0 {
	echo %ESC%[91m[EROR] Failed to get EFIESP partition number.
	set /a "ErrNum+=1" >nul
	goto SevErrFound
}
for /f %%i in ('Powershell -C "(Get-Partition | ? { $_.AccessPaths -eq '%MainOS%\Data\' }).PartitionNumber"') do set "PartitionNumberData=%%i"
set /a "Temp=%PartitionNumberData%%%1" >nul
if %Errorlevel% NEQ 0 {
	echo %ESC%[91m[EROR] Failed to get Data partition number.
	set /a "ErrNum+=1" >nul
	goto SevErrFound
}
echo ## EFIESP PN is %PartitionNumberEFIESP% ## >>%LogName%
echo ## Data PN is %PartitionNumberData% ## >>%LogName%
if %Storage% NEQ 32A echo %ESC%[96m[INFO] Resizing MainOS Partition ...%ESC%[91m
if %Storage% EQU 8 (
	Powershell -C "Remove-Partition -DiskNumber %DiskNumber% -PartitionNumber %PartitionNumberData% -confirm:$false; exit $Error.count" %SevLogger%
	Powershell -C "Resize-Partition -DriveLetter %DLMOS% -Size (Get-PartitionSupportedSize -DriveLetter %DLMOS%).sizeMax; exit $Error.count" %SevLogger%
	echo %ESC%[96m[INFO] Formatting MainOS for Windows 10 for ARMv7 ...%ESC%[91m
	rd %MainOS%\Data
)
if %Storage% EQU 16 (
	Powershell -C "Resize-Partition -DiskNumber %DiskNumber% -PartitionNumber %PartitionNumberData% -Size 6144MB; exit $Error.count" %Logger%
	if %errorlevel% NEQ 0 (
		echo %ESC%[96m[WARN] Shrink partition error occurred. Trying to solve the problem ...%ESC%[91m
		chkdsk /f %MainOS%\Data %Logger%
		Powershell -C "Resize-Partition -DiskNumber %DiskNumber% -PartitionNumber %PartitionNumberData% -Size 6144MB; exit $Error.count" %SevLogger%
	)
	echo %ESC%[96m[INFO] Creating Windows 10 for ARMv7 Partition ...%ESC%[91m
	Powershell -C "New-Partition -DiskNumber %DiskNumber% -UseMaximumSize -DriveLetter N; exit $Error.count" %SevLogger%
	for /f %%i in ('Powershell -C "(Get-Partition -DriveLetter N).Guid"') do set "WUuid=%%i"
)
if %Storage% EQU 32 (
	Powershell -C "Resize-Partition -DiskNumber %DiskNumber% -PartitionNumber %PartitionNumberData% -Size 16384MB; exit $Error.count" %SevLogger%
	if %errorlevel% NEQ 0 (
		echo %ESC%[96m[WARN] Shrink partition error occurred. Trying to solve the problem ...%ESC%[91m
		chkdsk /f %MainOS%\Data %Logger%
		Powershell -C "Resize-Partition -DiskNumber %DiskNumber% -PartitionNumber %PartitionNumberData% -Size 16384MB; exit $Error.count" %SevLogger%
	)
	echo %ESC%[96m[INFO] Creating Windows 10 for ARMv7 Partition ...%ESC%[91m
	Powershell -C "New-Partition -DiskNumber %DiskNumber% -UseMaximumSize -DriveLetter N; exit $Error.count" %SevLogger%
	for /f %%i in ('Powershell -C "(Get-Partition -DriveLetter N).Guid"') do set "WUuid=%%i"
)
if %Storage% EQU 8 (format %MainOS% /FS:NTFS /V:Windows10 /Q /C /Y %SevLogger%)
if %Storage% EQU 16 (format N: /FS:NTFS /V:Windows10 /Q /Y %SevLogger%)
if %Storage% EQU 32 (format N: /FS:NTFS /V:Windows10 /Q /Y %SevLogger%)
::---------------------------------------------------------------
echo ========================================================= >>%LogName%
echo %ESC%[96m[INFO] Installing Windows 10 for ARMv7 ...%ESC%[91m
if %Storage% EQU 8 (
	if %WinBuild% LSS 10240 (
		Files\wimlib apply install.wim 1 %MainOS%\ --compact=lzx %SevLogger%
	) else (
		Files\DISM\dism /Apply-Image /ImageFile:".\install.wim" /Index:1 /ApplyDir:%MainOS%\ /Compact %SevLogger%
	)
	copy nul %MainOS%\Windows\UUID.txt
)
if %Storage% EQU 16 (
	if %WinBuild% LSS 10240 (
		Files\wimlib apply install.wim 1 N:\ --compact=lzx %SevLogger%
	) else (
		Files\DISM\dism /Apply-Image /ImageFile:".\install.wim" /Index:1 /ApplyDir:N:\ /Compact %SevLogger%
	)
	echo %WUuid%> N:\Windows\UUID.txt
)
if %Storage% EQU 32 (
	Files\DISM\dism /Apply-Image /ImageFile:".\install.wim" /Index:1 /ApplyDir:N:\ %SevLogger%
	echo %WUuid%> N:\Windows\UUID.txt
)
if %Storage% EQU 32A (
	md %MainOS%\Data\Windows10Arm
	Files\DISM\dism /Apply-Image /ImageFile:".\install.wim" /Index:1 /ApplyDir:%MainOS%\Data\Windows10Arm\ %SevLogger%
	copy nul %MainOS%\Windows\UUID.txt
)
::---------------------------------------------------------------
echo %ESC%[96m[INFO] Installing Drivers ...%ESC%[91m
echo %ESC%[93m[WARN] Error outputs will not be showed here.%ESC%[91m
if %Model% EQU 1 Files\DISM\dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia930" /Recurse %Logger%
if %Model% EQU 2 Files\DISM\dism /Image:N:\ /Add-Driver /Driver:".\Drivers\LumiaIcon" /Recurse %Logger%
if %Model% EQU 3 Files\DISM\dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia1520" /Recurse %Logger%
if %Model% EQU 4 Files\DISM\dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia1520" /Recurse %Logger%
if %Model% EQU 5 Files\DISM\dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia1520-AT^&T" /Recurse %Logger%
if %Model% EQU 6 Files\DISM\dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia1520-AT^&T" /Recurse %Logger%
if %Model% EQU 7 Files\DISM\dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia830" /Recurse %Logger%
if %Model% EQU 8 Files\DISM\dism /Image:%MainOS%\ /Add-Driver /Driver:".\Drivers\Lumia735" /Recurse %Logger%
if /i %Model% EQU A Files\DISM\dism /Image:%MainOS%\ /Add-Driver /Driver:".\Drivers\Lumia640XL" /Recurse %Logger%
if /i %Model% EQU B Files\DISM\dism /Image:%MainOS%\ /Add-Driver /Driver:".\Drivers\Lumia640XL-AT^&T" /Recurse %Logger%
if /i %Model% EQU C Files\DISM\dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia950" /Recurse %Logger%
if /i %Model% EQU D Files\DISM\dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia950XL" /Recurse %Logger%
if /i %Model% EQU E Files\DISM\dism /Image:%MainOS%\Data\Windows10Arm\ /Add-Driver /Driver:".\Drivers\Lumia1020" /Recurse %Logger%
if /i %Model% EQU F Files\DISM\dism /Image:%MainOS%\Data\Windows10Arm\ /Add-Driver /Driver:".\Drivers\Lumia1020-AT^&T" /Recurse %Logger%
if /i %Model% EQU G Files\DISM\dism /Image:%MainOS%\Data\Windows10Arm\ /Add-Driver /Driver:".\Drivers\Lumia920" /Recurse %Logger%
::---------------------------------------------------------------
echo ========================================================= >>%LogName%
if %Storage% EQU 8 (
	echo sel dis %DiskNumber%>>Temp\diskpart1.txt
	echo sel par %PartitionNumberEFIESP%>>Temp\diskpart1.txt
	echo assign mount=%MainOS%\EFIESP>>Temp\diskpart1.txt
	md %MainOS%\EFIESP
	diskpart /s Temp\diskpart1.txt %Logger%
)
echo %ESC%[96m[INFO] Installing Mass Storage Mode UI ...%ESC%[91m
xcopy .\Files\MassStorage %MainOS%\EFIESP\Windows\System32\Boot\ui /E /H /I /Y %Logger%

echo %ESC%[96m[INFO] Adding BCD Entry ...
echo %ESC%[93m[WARN] Error outputs will not be showed here.%ESC%[91m
set "bcdLoc=%MainOS%\EFIESP\efi\Microsoft\Boot\BCD"
echo ## BCD Path is %bcdLoc% ## >>%LogName% 
set "id={703c511b-98f3-4630-b752-6d177cbfb89c}"
Files\bcdedit /store %bcdLoc% /create %id% /d "Windows 10 for ARMv7" /application "osloader" %SevLogger%
if %Storage% EQU 8 (
	Files\bcdedit /store %bcdLoc% /set %id% "device" "partition=%MainOS%" %SevLogger%
	Files\bcdedit /store %bcdLoc% /set %id% "osdevice" "partition=%MainOS%" %SevLogger%
	Files\bcdedit /store %bcdLoc% /set "{default}" description "Ignore This" %Logger%
	Files\bcdedit /store %bcdLoc% /default %id% %Logger%
) else (
	if %Storage% NEQ 32A (
		Files\bcdedit /store %bcdLoc% /set %id% "device" "partition=N:" %SevLogger%
		Files\bcdedit /store %bcdLoc% /set %id% "osdevice" "partition=N:" %SevLogger%
		Files\bcdedit /store %bcdLoc% /set "{default}" description "Windows Phone" %Logger%
	) else (
		Files\bcdedit /store %bcdLoc% /set %id% "device" "partition=%MainOS%\Data" %SevLogger%
		Files\bcdedit /store %bcdLoc% /set %id% "osdevice" "partition=%MainOS%\Data" %SevLogger%
		Files\bcdedit /store %bcdLoc% /set "{default}" description "Windows Phone" %Logger%
)
if %Storage% EQU 32A (
	Files\bcdedit /store %bcdLoc% /set %id% "path" "\Windows10Arm\Windows\System32\winload.efi" %SevLogger%
) else (
	Files\bcdedit /store %bcdLoc% /set %id% "path" "\Windows\System32\winload.efi" %SevLogger%
)
Files\bcdedit /store %bcdLoc% /set %id% "locale" "en-US" %Logger%
Files\bcdedit /store %bcdLoc% /set %id% "testsigning" Yes %Logger%
Files\bcdedit /store %bcdLoc% /set %id% "inherit" "{bootloadersettings}" %Logger%
if %Storage% EQU 32A (
	Files\bcdedit /store %bcdLoc% /set %id% "systemroot" "\Windows10Arm\Windows" %SevLogger%
) else (
	Files\bcdedit /store %bcdLoc% /set %id% "systemroot" "\Windows" %SevLogger%
)
Files\bcdedit /store %bcdLoc% /set %id% "bootmenupolicy" "Standard" %Logger%
Files\bcdedit /store %bcdLoc% /set %id% "detecthal" Yes %Logger%
Files\bcdedit /store %bcdLoc% /set %id% "winpe" No %Logger%
Files\bcdedit /store %bcdLoc% /set %id% "ems" No %Logger%
Files\bcdedit /store %bcdLoc% /set %id% "bootdebug" No %Logger%
Files\bcdedit /store %bcdLoc% /set "{bootmgr}" "nointegritychecks" Yes %Logger%
Files\bcdedit /store %bcdLoc% /set "{bootmgr}" "testsigning" Yes %Logger%
Files\bcdedit /store %bcdLoc% /set "{bootmgr}" "timeout" 5 %Logger%
Files\bcdedit /store %bcdLoc% /set "{bootmgr}" "displaybootmenu" Yes %SevLogger%
Files\bcdedit /store %bcdLoc% /set "{bootmgr}" "custom:54000001" %id% %SevLogger%
::---------------------------------------------------------------
echo ========================================================= >>%LogName%
echo %ESC%[96m[INFO] Setting up ESP ...%ESC%[91m
md %MainOS%\EFIESP\EFI\Microsoft\Recovery\ %Logger%
Files\bcdedit /createstore %MainOS%\EFIESP\EFI\Microsoft\Recovery\BCD %SevLogger%
set "DLMOS=%MainOS:~0,-1%"
echo sel dis %DiskNumber%>Temp\diskpart.txt
echo sel par %PartitionNumberEFIESP%>>Temp\diskpart.txt
echo set id=c12a7328-f81f-11d2-ba4b-00a0c93ec93b>>Temp\diskpart.txt
diskpart /s Temp\diskpart.txt %Logger%
rd /s /q Temp\
echo %Storage%>%MainOS%\Windows\WFAv7Storage.txt
goto MissionCompleted
::---------------------------------------------------------------
:SevErrFound
echo ========================================================= >>%LogName%
echo.
echo #### INSTALLATION CANCELED ####>>%LogName%
rd /s /q Temp\
echo %ESC%[96m[INFO] Installation is cancelled because a%ESC%[91m severe error %ESC%[96moccurred.
echo %ESC%[93m[WARN] Please check installation log in Logs folder.%ESC%[0m
echo.
pause
exit /B

:MissionCompleted
if %ErrNum% GTR 0 (
	echo #### INSTALLATION COMPLETED WITH ERROR^(S^) #### >>%LogName%
	echo %ESC%[96m[INFO] Installation is completed with%ESC%[91m %ErrNum% error^(s^)%ESC%[96m!
	echo %ESC%[93m[WARN] Please check installation log in Logs folder.%ESC%[0m
	echo.
	pause
)
if %ErrNum% EQU 0 echo #### INSTALLATION COMPLETED SUCCESSFULLY #### >>%LogName%
if %ErrNum% EQU 0 echo. & echo %ESC%[96m[INFO] Installation completed successfully!
echo.
pause
cls
echo  %ESC%[93m//////////////////////////////////////////////////////////////////////////////////////////////
echo  //                           %ESC%[97mWindows 10 for ARMv7 Installer 2.0%ESC%[93m                             //
echo  //                                   %ESC%[97mby RedGreenBlue123%ESC%[93m                                     //
echo  //                    %ESC%[97mThanks to: @Gus33000, @FadilFadz01, @Heathcliff74%ESC%[93m                     //
echo  //////////////////////////////////////////////////////////////////////////////////////////////%ESC%[0m
echo.
echo  %ESC%[92mWindows 10 for ARMv7 has been installed on your phone.
echo  %ESC%[97m- Now, reboot your phone.
echo  - After the boot menu appears, press power up to boot Windows 10 for ARMv7.
echo  - Boot and setup Windows 10 for the first time. Then reboot the phone to Mass Storage Mode.
echo  - Run PostInstall.bat.%ESC%[0m
pause
exit /b

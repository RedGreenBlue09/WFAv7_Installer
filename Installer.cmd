@echo off
setlocal EnableDelayedExpansion
cd %~dp0
if not "%~1" EQU "" call :%~1
if %Errorlevel% NEQ 0 goto :EOF
::---------------------------------------------------------------
:GetAdministrator
icacls "%SYSTEMROOT%\System32\config\SYSTEM" >nul 2>&1
if %errorlevel% NEQ 0 (
	echo Requesting administrative privileges...
	Files\elevate "Installer.cmd"
	exit /B
)

::GotAdministrator

::---------------------------------------------------------------
if exist "Temp\" rd /s /q "Temp\"
md "Temp"

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

echo  - Checking Cmdlets ...
Powershell -C "(Get-Command).name" > Temp\Commands.txt
findstr /X /C:"Get-Date" Temp\Commands.txt >nul || goto MissingCommand
findstr /X /C:"Get-Partition" Temp\Commands.txt >nul || goto MissingCommand
findstr /X /C:"New-Partition" Temp\Commands.txt >nul || goto MissingCommand
findstr /X /C:"Resize-Partition" Temp\Commands.txt >nul || goto MissingCommand
findstr /X /C:"Remove-Partition" Temp\Commands.txt >nul || goto MissingCommand
findstr /X /C:"Get-WmiObject" Temp\Commands.txt >nul || goto MissingCommand
findstr /X /C:"Get-PartitionSupportedSize" Temp\Commands.txt >nul || goto MissingCommand
findstr /X /C:"Add-PartitionAccessPath" Temp\Commands.txt >nul || goto MissingCommand

del Temp\Commands.txt
goto ToBeContinued0
:MissingCommand
del Temp\Commands.txt
title ERROR!
color 0C
echo ----------------------------------------------------------------
echo  Required powershell cmdlets are not found.
echo  Please use Official Windows 8.1 or Windows 10.
pause
exit /B

:ToBeContinued0
cls
echo Installer is loading ...
:Start
if %WinBuild% LSS 10586 (
	if /i %PROCESSOR_ARCHITECTURE% EQU X86 Files\ansicon32 -p
	if /i %PROCESSOR_ARCHITECTURE% EQU AMD64 Files\ansicon64 -p
)
set "ESC="

::---------------------------------------------------------------
:Disclaimer
cls
title Windows 10 for ARMv7 Installer 3.0
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
echo  //                           %ESC%[97mWindows 10 for ARMv7 Installer 3.0%ESC%[93m                             //
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
echo  %ESC%[36mC) %ESC%[97mLumia 1020 [BLUE SCREEN]
echo  %ESC%[36mD) %ESC%[97mLumia 1020 AT^&T
echo  %ESC%[36mE) %ESC%[97mLumia 920

set /p Model=%ESC%[92mDevice%ESC%[32m: %ESC%[0m

if "%Model%" EQU "" goto ChooseDev
if "%Model%" EQU "1" set "Storage=32" & goto DualBoot
if "%Model%" EQU "2" set "Storage=32" & goto DualBoot
if "%Model%" EQU "3" set "Storage=32" & goto DualBoot
if "%Model%" EQU "4" set "Storage=16" & goto DualBoot
if "%Model%" EQU "5" set "Storage=32" & goto DualBoot
if "%Model%" EQU "6" set "Storage=16" & goto DualBoot
if "%Model%" EQU "7" set "Storage=16" & goto DualBoot
if "%Model%" EQU "8" set "Storage=8" & goto DualBoot
if /i "%Model%" EQU "A" set "Storage=8" & goto DualBoot
if /i "%Model%" EQU "B" set "Storage=8" & goto DualBoot
if /i "%Model%" EQU "C" set "Storage=32A" & goto DualBoot
if /i "%Model%" EQU "D" set "Storage=32A" & goto DualBoot
if /i "%Model%" EQU "E" set "Storage=32A" & goto DualBoot
goto ChooseDev

::---------------------------------------------------------------
:DualBoot
if %Storage% EQU 8 (
	set "Dualboot=N"
	goto ToBeContinued1
)
cls
echo  %ESC%[93m//////////////////////////////////////////////////////////////////////////////////////////////
echo  //                           %ESC%[97mWindows 10 for ARMv7 Installer 3.0%ESC%[93m                             //
echo  //                                   %ESC%[97mby RedGreenBlue123%ESC%[93m                                     //
echo  //                    %ESC%[97mThanks to: @Gus33000, @FadilFadz01, @Heathcliff74%ESC%[93m                     //
echo  //////////////////////////////////////////////////////////////////////////////////////////////%ESC%[0m
echo.
set /p DualBoot="%ESC%[97m Use dualboot? %ESC%[93m[%ESC%[92mY%ESC%[93m/%ESC%[91mN%ESC%[93m]%ESC%[0m "
if /i "%DualBoot%" NEQ "Y" if /i "%DualBoot%" NEQ "N" goto Dualboot

::---------------------------------------------------------------
:ToBeContinued1
cls
echo  %ESC%[93m//////////////////////////////////////////////////////////////////////////////////////////////
echo  //                           %ESC%[97mWindows 10 for ARMv7 Installer 3.0%ESC%[93m                             //
echo  //                                   %ESC%[97mby RedGreenBlue123%ESC%[93m                                     //
echo  //                    %ESC%[97mThanks to: @Gus33000, @FadilFadz01, @Heathcliff74%ESC%[93m                     //
echo  //////////////////////////////////////////////////////////////////////////////////////////////%ESC%[0m
echo.
echo %ESC%[92m PREPARATION:
echo   - Read README.TXT and instruction before using this Installer.
echo   - Close all programs during installation.
echo   - Make sure your phone have enough battery for this installation.
echo   - Windows Phone 8.1 or Windows 10 Mobile (1607 or older) installed.
echo   * Highly recommend you to flash the original FFU.
if /i "%Dualboot%" EQU "N" (
	echo   * This will permanently remove Windows Phone.%ESC%[0m
) else (
	if "%Storage%" EQU "16" echo   * %ESC%[4m8.0 GB%ESC%[0m%ESC%[92m of empty phone storage is required.
	if "%Storage%" EQU "32" echo   * %ESC%[4m16.0 GB%ESC%[0m%ESC%[92m of empty phone storage is required.
	if "%Storage%" EQU "32A" echo   * %ESC%[4m16.0 GB%ESC%[0m%ESC%[92m of empty phone storage is required.
)
echo %ESC%[0m
echo %ESC%[95m WARNING:
echo   * After pressing any key, the installation process will begin.
echo     This cannot be cancelled properly which may cause damage to your device.
echo   * If you want to cancel the installation, close this console RIGHT NOW.
echo %ESC%[0m
pause
goto MOSAutoDetect

:MOSAutoDetectFail
echo %ESC%[93mUnable to auto detect MainOS.%ESC%[0m
if exist Temp\GPT del Temp\GPT
if exist Temp\GPT* del Temp\GPT*
set "Skip="
goto MOSPath

:MOSAutoDetect
cls
echo  %ESC%[93m//////////////////////////////////////////////////////////////////////////////////////////////
echo  //                           %ESC%[97mWindows 10 for ARMv7 Installer 3.0%ESC%[93m                             //
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
	Files\grep -P "M\x00a\x00i\x00n\x00O\x00S\x00" Temp\GPT%%i >nul
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
echo %ESC%[96mDetected MainOS at %DriveLetter%:%ESC%[0m
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
for /f %%i in ('Powershell -C "(Get-Partition -DriveLetter %DLMOS%).PartitionNumber"') do set "PartitionNumber=%%i"
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
if /I %Model% EQU C (if not exist Drivers\Lumia1020 goto MissingDrivers)
if /I %Model% EQU D (if not exist Drivers\Lumia1020_AT^&T goto MissingDrivers)
if /I %Model% EQU E (if not exist Drivers\Lumia920 goto MissingDrivers)
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
for /f %%i in ('Powershell -C "(Get-Partition | ? { $_.AccessPaths -eq '%MainOS%\DPP\' }).PartitionNumber"') do set "PartitionNumberDPP=%%i"
for /f %%i in ('Powershell -C "(Get-Partition | ? { $_.AccessPaths -eq '%MainOS%\EFIESP\' }).PartitionNumber"') do set "PartitionNumberEFIESP=%%i"
for /f %%i in ('Powershell -C "(Get-Partition | ? { $_.AccessPaths -eq '%MainOS%\Data\' }).PartitionNumber"') do set "PartitionNumberData=%%i"
echo ## DPP PN is %PartitionNumberDPP% ## >>%LogName%
echo ## EFIESP PN is %PartitionNumberEFIESP% ## >>%LogName%
echo ## Data PN is %PartitionNumberData% ## >>%LogName%

echo %ESC%[96m[INFO] Checking Data partition ...%ESC%[91m
chkdsk /f %MainOS%\Data %Logger%

if /i "%Dualboot%" EQU "Y" (
			
	:: A bit dangerous
	if exist %MainOS%\Windows10\ rd /s /q %MainOS%\Windows10\ %Logger%
	md %MainOS%\Windows10\ %Logger%
	
	if "%Storage%" EQU "32A" (
		
		:: Unfortunately New-VHD requires Hyper-V to be enabled
		echo>Temp\diskpart.txt create vdisk file=%MainOS%\Data\Windows10.vhdx maximum=16384 type=fixed
		echo>>Temp\diskpart.txt attach vdisk
		echo>>Temp\diskpart.txt convert gpt
		echo>>Temp\diskpart.txt create par pri
		echo>>Temp\diskpart.txt format quick fs=ntfs
		echo>>Temp\diskpart.txt assign mount=%MainOS%\Windows10\
		diskpart /s Temp\diskpart.txt %SevLogger%
		rm Temp/diskpart.txt

	) else (
		
		echo %ESC%[96m[INFO] Creating Windows 10 ARM Partition ...%ESC%[91m
		if "%Storage%" EQU "16" Powershell -C "Resize-Partition -DiskNumber %DiskNumber% -PartitionNumber %PartitionNumberData% -Size 6144MB; exit $Error.count" %SevLogger%
		if "%Storage%" EQU "32" Powershell -C "Resize-Partition -DiskNumber %DiskNumber% -PartitionNumber %PartitionNumberData% -Size 16384MB; exit $Error.count" %SevLogger%
		
		powershell -C "New-Partition -DiskNumber %DiskNumber% -UseMaximumSize | Add-PartitionAccessPath -AccessPath "%MainOS%\Windows10\"; exit $Error.count" %SevLogger%
		
	)
	set "Win10Drive=%MainOS%\Windows10"
	
) else (

	echo %ESC%[96m[INFO] Resizing MainOS Partition ...%ESC%[91m
	Powershell -C "Remove-Partition -DiskNumber %DiskNumber% -PartitionNumber %PartitionNumberData% -confirm:$false; exit $Error.count" %SevLogger%
	Powershell -C "Resize-Partition -DriveLetter %DLMOS% -Size (Get-PartitionSupportedSize -DriveLetter %DLMOS%).sizeMax; exit $Error.count" %SevLogger%
	set "Win10Drive=%MainOS%"

)
echo %ESC%[96m[INFO] Formatting Windows 10 ARM partition ...%ESC%[91m
format !Win10Drive! /FS:NTFS /V:Windows10 /Q /C /Y %SevLogger%

::---------------------------------------------------------------
echo ========================================================= >>%LogName%
echo %ESC%[96m[INFO] Installing Windows 10 ARM ...%ESC%[91m
if %WinBuild% LSS 10240 (
	Files\wimlib apply install.wim 1 !Win10Drive!\ --compact=lzx %SevLogger%
) else (
	Files\DISM\dism /Apply-Image /ImageFile:".\install.wim" /Index:1 /ApplyDir:!Win10Drive!\ /Compact %SevLogger%
)

::---------------------------------------------------------------
echo %ESC%[96m[INFO] Installing Drivers ...%ESC%[91m
echo %ESC%[93m[WARN] Error outputs will not be showed here.%ESC%[91m
if %Model% EQU 1 Files\DISM\dism /Image:!Win10Drive!\ /Add-Driver /Driver:".\Drivers\Lumia930" /Recurse %Logger%
if %Model% EQU 2 Files\DISM\dism /Image:!Win10Drive!\ /Add-Driver /Driver:".\Drivers\LumiaIcon" /Recurse %Logger%
if %Model% EQU 3 Files\DISM\dism /Image:!Win10Drive!\ /Add-Driver /Driver:".\Drivers\Lumia1520" /Recurse %Logger%
if %Model% EQU 4 Files\DISM\dism /Image:!Win10Drive!\ /Add-Driver /Driver:".\Drivers\Lumia1520" /Recurse %Logger%
if %Model% EQU 5 Files\DISM\dism /Image:!Win10Drive!\ /Add-Driver /Driver:".\Drivers\Lumia1520-AT^&T" /Recurse %Logger%
if %Model% EQU 6 Files\DISM\dism /Image:!Win10Drive!\ /Add-Driver /Driver:".\Drivers\Lumia1520-AT^&T" /Recurse %Logger%
if %Model% EQU 7 Files\DISM\dism /Image:!Win10Drive!\ /Add-Driver /Driver:".\Drivers\Lumia830" /Recurse %Logger%
if %Model% EQU 8 Files\DISM\dism /Image:!Win10Drive!\ /Add-Driver /Driver:".\Drivers\Lumia735" /Recurse %Logger%
if /i %Model% EQU A Files\DISM\dism /Image:!Win10Drive!\ /Add-Driver /Driver:".\Drivers\Lumia640XL" /Recurse %Logger%
if /i %Model% EQU B Files\DISM\dism /Image:!Win10Drive!\ /Add-Driver /Driver:".\Drivers\Lumia640XL-AT^&T" /Recurse %Logger%
if /i %Model% EQU C Files\DISM\dism /Image:!Win10Drive!\ /Add-Driver /Driver:".\Drivers\Lumia1020" /Recurse %Logger%
if /i %Model% EQU D Files\DISM\dism /Image:!Win10Drive!\ /Add-Driver /Driver:".\Drivers\Lumia1020-AT^&T" /Recurse %Logger%
if /i %Model% EQU E Files\DISM\dism /Image:!Win10Drive!\ /Add-Driver /Driver:".\Drivers\Lumia920" /Recurse %Logger%

::---------------------------------------------------------------
echo ========================================================= >>%LogName%
echo %ESC%[96m[INFO] Mounting EFIESP and DPP ...%ESC%[91m
md !Win10Drive!\EFIESP
md !Win10Drive!\DPP
echo>Temp\diskpart1.txt sel dis %DiskNumber%
echo>>Temp\diskpart1.txt sel par %PartitionNumberEFIESP%
echo>>Temp\diskpart1.txt assign mount=!Win10Drive!\EFIESP
echo>>Temp\diskpart1.txt sel par %PartitionNumberDPP%
echo>>Temp\diskpart1.txt assign mount=!Win10Drive!\DPP
diskpart /s Temp\diskpart1.txt %Logger%
rd Temp\diskpart1.txt

echo %ESC%[96m[INFO] Installing Mass Storage Mode UI ...%ESC%[91m
xcopy .\Files\MassStorage %MainOS%\EFIESP\Windows\System32\Boot\ui /E /H /I /Y %Logger%

echo %ESC%[96m[INFO] Adding BCD Entry ...
echo %ESC%[93m[WARN] Error outputs will not be showed here.%ESC%[91m
set "bcdLoc=%MainOS%\EFIESP\EFI\Microsoft\Boot\BCD"
echo ## BCD Path is %bcdLoc% ## >>%LogName% 
set "id={703c511b-98f3-4630-b752-6d177cbfb89c}"

Files\bcdedit /store "%bcdLoc%" /create %id% /d "Windows 10 ARM" /application "osloader" %SevLogger%

if "%Storage%" EQU "32A" (
	if /i "%Dualboot%" EQU "Y" (
		Files\bcdedit /store "%bcdLoc%" /set %id% "device" "vhd=[%MainOS%\Data]\Windows10.vhdx" %SevLogger%
		Files\bcdedit /store "%bcdLoc%" /set %id% "osdevice" "vhd=[%MainOS%\Data]\Windows10.vhdx" %SevLogger%
	) else (
		Files\bcdedit /store "%bcdLoc%" /set %id% "device" "partition=!Win10Drive!" %SevLogger%
		Files\bcdedit /store "%bcdLoc%" /set %id% "osdevice" "partition=!Win10Drive!" %SevLogger%
	)
) else (
	Files\bcdedit /store "%bcdLoc%" /set %id% "device" "partition=!Win10Drive!" %SevLogger%
	Files\bcdedit /store "%bcdLoc%" /set %id% "osdevice" "partition=!Win10Drive!" %SevLogger%
)

Files\bcdedit /store "%bcdLoc%" /set %id% "path" "\Windows\System32\winload.efi" %SevLogger%
Files\bcdedit /store "%bcdLoc%" /set %id% "systemroot" "\Windows" %SevLogger%
Files\bcdedit /store "%bcdLoc%" /set %id% "locale" "en-US" %Logger%
Files\bcdedit /store "%bcdLoc%" /set %id% "testsigning" Yes %SevLogger%
Files\bcdedit /store "%bcdLoc%" /set %id% "inherit" "{bootloadersettings}" %Logger%
Files\bcdedit /store "%bcdLoc%" /set %id% "bootmenupolicy" "Legacy" %Logger%
Files\bcdedit /store "%bcdLoc%" /set %id% "detecthal" Yes %Logger%
Files\bcdedit /store "%bcdLoc%" /set %id% "winpe" No %Logger%
Files\bcdedit /store "%bcdLoc%" /set %id% "ems" No %Logger%
Files\bcdedit /store "%bcdLoc%" /set %id% "bootdebug" No %Logger%

:: Boot entry display
if /i "%Dualboot%" EQU "N" (
	Files\bcdedit /store "%bcdLoc%" /default %id% %Logger%
	Files\bcdedit /store "%bcdLoc%" /displayorder %id% %Logger%
) else (
	Files\bcdedit /store "%bcdLoc%" /set "{default}" description "Windows Phone" %Logger%
	Files\bcdedit /store "%bcdLoc%" /set "{bootmgr}" custom:0x54000001 %id% %SevLogger%
	Files\bcdedit /store "%bcdLoc%" /displayorder %id% {default} %Logger%
)

Files\bcdedit /store "%bcdLoc%" /set "{bootmgr}" "nointegritychecks" Yes %Logger%
Files\bcdedit /store "%bcdLoc%" /set "{bootmgr}" "testsigning" Yes %Logger%
Files\bcdedit /store "%bcdLoc%" /set "{bootmgr}" "timeout" 5 %Logger%
Files\bcdedit /store "%bcdLoc%" /set "{bootmgr}" "displaybootmenu" Yes %SevLogger%

::---------------------------------------------------------------
echo ========================================================= >>%LogName%
echo %ESC%[96m[INFO] Setting up ESP ...%ESC%[91m
md %MainOS%\EFIESP\EFI\Microsoft\Recovery\ %Logger%
Files\bcdedit /createstore %MainOS%\EFIESP\EFI\Microsoft\Recovery\BCD %SevLogger%

echo>Temp\diskpart.txt sel dis %DiskNumber%
echo>>Temp\diskpart.txt sel par %PartitionNumberEFIESP%
echo>>Temp\diskpart.txt set id=c12a7328-f81f-11d2-ba4b-00a0c93ec93b
diskpart /s Temp\diskpart.txt %Logger%
rm Temp/diskpart.txt

if /i "%Dualboot%" EQU "Y" copy "Files\PostInstall\Dualboot.cmd" "!Win10Drive!\Dualboot.cmd" %Logger%

:: Unmount VHDX
if "%Storage%" EQU "32A" (
	if /i "%Dualboot%" EQU "Y" (
		echo %ESC%[96m[INFO] Unmounting VHDX ...%ESC%[91m
		echo>Temp\diskpart.txt sel vdisk file=%MainOS%\Data\Windows10.vhdx
		echo>Temp\diskpart.txt detach vdisk
		diskpart /s Temp\diskpart.txt %Logger%
		rm Temp/diskpart.txt
	)
)

rd /s /q Temp\
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
echo  //                           %ESC%[97mWindows 10 for ARMv7 Installer 3.0%ESC%[93m                             //
echo  //                                   %ESC%[97mby RedGreenBlue123%ESC%[93m                                     //
echo  //                    %ESC%[97mThanks to: @Gus33000, @FadilFadz01, @Heathcliff74%ESC%[93m                     //
echo  //////////////////////////////////////////////////////////////////////////////////////////////%ESC%[0m
echo.
echo  %ESC%[92mWindows 10 ARM has been installed on your phone.
echo  %ESC%[97m- Now, reboot your phone.
echo  - At the boot menu, press volume up to boot Windows 10 ARM.
echo  - Boot and setup Windows 10 (may reboot several times).
echo    If you are unable to boot Windows 10 after 2nd boot, use "BootFix".
if /i "%Dualboot%" EQU "Y" echo  - After getting to the desktop, run "Dualboot" in Windows 10 ARM drive
if /i "%Dualboot%" EQU "Y" echo    as administrator to finish installation.%ESC%[0m
pause
exit /b

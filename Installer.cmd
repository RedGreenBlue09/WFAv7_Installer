@echo off
setlocal EnableExtensions
setlocal
if not "%~1"=="" call :%~1
if %Errorlevel% NEQ 0 goto :EOF
:Check1
cd ..
echo Checking compatibility ...
echo  - Checking Drive [M:] ...
if EXIST M:\ (
	title ERROR!
	color 0C
	echo ----------------------------------------------------------------
	echo   Please Unmount Drive [M:]
	pause
	exit /B
)
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
    IF "%PROCESSOR_ARCHITECTURE%" EQU "AMD64" ( >nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system" )
    IF "%PROCESSOR_ARCHITECTURE%" EQU "ARM64" ( >nul 2>&1 "%SYSTEMROOT%\SysArm32\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system" )
    IF "%PROCESSOR_ARCHITECTURE%" EQU "x86" (
	>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
) else ( >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" )

if %errorlevel% NEQ 0 (
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
	cd /D "%~dp0"
	if exist "%~dp0Temp\" rd /s /q "%~dp0Temp\"
	if not exist "%~dp0Temp\" md "%~dp0Temp"
::---------------------------------------------------------------
:Check2
title Checking compatibility ...
echo  - Checking Windows Build ...
for /f "tokens=3" %%a in ('Reg Query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild ^| findstr /ri "REG_SZ"') do set WinBuild=%%a
if %WinBuild% LSS 9600 (
	title ERROR!
	color 0C
	echo ----------------------------------------------------------------
	echo   This Windows version is not supported by WFAv7 Installer.
	echo   Please use Windows 8.1+ Pro or Enterprise ^(Build 9600+^) 
	echo   Current OS build: %WinBuild%
	pause
	exit /B
)

echo  - Checking Windows Powershell ...
Powershell /? >nul 2>&1
set PLV=%errorlevel%
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
echo  - Checking Dism ...
where DISM >nul 2>&1
if %errorlevel% NEQ 0 (
	title ERROR!
	color 0C
	echo ----------------------------------------------------------------
	echo   DISM isn't found or it has problem.
	pause
	exit /B
)
echo  - Checking Bcdedit ...
where bcdedit >nul 2>&1
if %errorlevel% NEQ 0 (
	TITLE ERROR!
	COLOR 0C
	echo ----------------------------------------------------------------
	echo   BCDEDIT wasn't found or it has problem.
	PAUSE
	exit /B
)

echo  - Checking Hyper-V ...
(Powershell -Command "(Get-WindowsOptionalFeature -FeatureName Microsoft-Hyper-V-Management-Powershell -Online).State" | findstr /I "Enabled") >nul 2>&1
if %errorlevel% NEQ 0 (
	title ERROR!
	color 0C
	echo ----------------------------------------------------------------
	echo  Please enable Hyper-V in Windows Features.
	pause
	exit /B
)
echo  - Getting CmdLets ...
Powershell -C "(Get-Command).name" >> Temp\Commands.txt
echo  - Checking New-Partition ...
FindStr /X /C:"New-Partition" Temp\Commands.txt >nul || goto MissingCommand
echo  - Checking Format-Volume ...
FindStr /X /C:"Format-Volume" Temp\Commands.txt >nul || goto MissingCommand
echo  - Checking Expand-WindowsImage ...
FindStr /X /C:"Expand-WindowsImage" Temp\Commands.txt >nul || goto MissingCommand
echo  - Checking Get-Partition ...
FindStr /X /C:"Get-Partition" Temp\Commands.txt >nul || goto MissingCommand
echo  - Checking Get-WmiObject ...
FindStr /X /C:"Get-WmiObject" Temp\Commands.txt >nul || goto MissingCommand
del Temp\Commands.txt
goto ToBeContinued0
:MissingCommand
del Temp\Commands.txt
title ERROR!
color 0C
echo ----------------------------------------------------------------
echo  You used Windows 7 / Windows Home edition / Customized Windows.
echo  Please use Official Windows 8.1 Pro or Windows 10 Pro
pause
exit /B
:MissingCommandHyperV
del Commands.txt
title ERROR!
color 0C
echo ----------------------------------------------------------------
echo  Hyper-V is not fully enabled or not enabled correctly.
pause
exit /B


:ToBeContinued0
cls
echo Installer is loading ... [100%%]
:Start
if %WinBuild% LSS 10586 (
	if /i %PROCESSOR_ARCHITECTURE%==X86 Files\ansicon32 -p
	if /i %PROCESSOR_ARCHITECTURE%==AMD64 Files\ansicon64 -p
)
::for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set ESC=%%b
set ESC=
::---------------------------------------------------------------
cls
mode 96,1200
echo Initializing ...
Powershell -C "&{(get-host).ui.rawui.windowsize=@{width=96;height=24};}"
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
set /p Disclaimer="%ESC%[97mDo you agree with the DISCLAIMER? %ESC%[93m[%ESC%[92mY%ESC%[93m/%ESC%[91mN%ESC%[93m]%ESC%[0m "
if /i "%Disclaimer%"=="N" (
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
set Model=
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
echo  %ESC%[36mE) %ESC%[97mLumia 1020
echo  %ESC%[36mF) %ESC%[97mLumia 1020 AT^&T
echo  %ESC%[36mG) %ESC%[97mLumia 920
echo  %ESC%[36mH) %ESC%[97mBSP Method (All devices) [COMMING SOON]%ESC%[0m
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
:: if /i "%Model%"=="H" goto BSP
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
echo   * Highly recommend you to flash the original FFU of your phone
echo     before installing Windows 10 ARMv7.
if %Storage%==8 echo   * You need at least ^> %ESC%[4m4.0 GB%ESC%[0m%ESC%[92m of Phone Storage to continue.%ESC%[0m
if %Storage%==16 echo   * You need at least ^> %ESC%[4m8.0 GB%ESC%[0m%ESC%[92m of Phone Storage to continue.%ESC%[0m
if %Storage%==32 echo   * You need at least ^> %ESC%[4m16.0 GB%ESC%[0m%ESC%[92m of Phone Storage to continue.%ESC%[0m
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
set Skip=
goto MOSPath
:MOSAutoDetect
cls
echo  %ESC%[93m//////////////////////////////////////////////////////////////////////////////////////////////
echo  //                           %ESC%[97mWindows 10 for ARMv7 Installer 2.0%ESC%[93m                             //
echo  //                                   %ESC%[97mby RedGreenBlue123%ESC%[93m                                     //
echo  //                    %ESC%[97mThanks to: @Gus33000, @FadilFadz01, @Heathcliff74%ESC%[93m                     //
echo  //////////////////////////////////////////////////////////////////////////////////////////////%ESC%[0m
echo.
echo %ESC%[96mTrying to detect MainOS ...%ESC%[0m
:: DiskNumber
for /f %%i in ('Powershell -C "(Get-WmiObject Win32_DiskDrive | ? {$_.PNPDeviceID -Match 'VEN_MSFT&PROD_PHONE_MMC_STOR'}).Index"') do set DiskNumber=%%i
if "%DiskNumber%"=="" (for /f %%i in ('Powershell -C "(Get-WmiObject Win32_DiskDrive | ? {$_.PNPDeviceID -Match 'VEN_QUALCOMM&PROD_MMC_STORAGE'}).Index"') do set DiskNumber=%%i)
if "%DiskNumber%"=="" goto MOSAutoDetectFail
if not exist Temp\ md Temp
Files\dd if=\\?\Device\Harddisk%DiskNumber%\Partition0 of=Temp\GPT bs=512 skip=1 count=32 2>nul
set Skip=512
for /l %%i in (1,1,48) do (
	Files\dd if=Temp\GPT of=Temp\GPT%%i bs=1 skip=!Skip! count=128 2>nul
	set /A Skip+=128
)
for /l %%i in (1,1,48) do (
	Files\grep -P "M\x00a\x00i\x00n\x00O\x00S" Temp\GPT%%i >nul
	if !Errorlevel!==0 set MOSGPT=%%i& goto PartitionNumber
)
goto MOSAutoDetectFail

:PartitionNumber
Files\dd if=Temp\GPT%MOSGPT% of=Temp\GPT%MOSGPT%-UUID bs=1 skip=16 count=16 2>nul
For /f "usebackq delims=" %%g in (`Powershell -C "([System.IO.File]::ReadAllBytes('Temp\GPT%MOSGPT%-UUID') | ForEach-Object { '{0:x2}' -f $_ }) -join ' '"`) do set "UuidHex=%%g"
for /f "tokens=1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" %%a in ("%UuidHex%") do (
	set Uuid=%%d%%c%%b%%a-%%f%%e-%%h%%g-%%i%%j-%%k%%l%%m%%n%%o%%p
)
For /f %%p in ('Powershell -C "(Get-Partition | ? { $_.Guid -eq '{%Uuid%}'}).PartitionNumber"') do set PartitionNumber=%%p
For /f %%d in ('Powershell -C "(Get-Partition | ? { $_.Guid -eq '{%Uuid%}'}).DriveLetter"') do set DriveLetter=%%d
if not exist %DriveLetter%:\EFIESP goto MOSAutoDetectFail
if not exist %DriveLetter%:\Data goto MOSAutoDetectFail
if not exist %DriveLetter%:\DPP goto MOSAutoDetectFail
set DLMOS=%DriveLetter%
set MainOS=%DriveLetter%:
del Temp\GPT
del Temp\GPT*
set Skip=
echo %ESC%[96mDetected MainOS at %DriveLetter%%ESC%[0m
goto CheckReqFiles
:MOSPath
set MainOS=
echo.
set /p MainOS=%ESC%[92mEnter MainOS Path: %ESC%[93m
if not defined MainOS (
	echo  %ESC%[91mNot a valid MainOS partition.
	goto MOSPath
)
for /f %%m in ('Powershell -C "(echo %MainOS%).length -eq 2"') do set Lenght2=%%m
if %Lenght2%==False (
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
if not exist "%MainOS%\DPP" (
	echo  %ESC%[91mNot a valid MainOS partition.
	goto MOSPath
)
set DLMOS=%MainOS:~0,-1%
for /f %%i in ('Powershell -C "(Get-Partition -DriveLetter %DLMOS%).DiskNumber"') do set DiskNumber=%%i
for /f %%i in ('Powershell -C "(Get-Partition -DriveLetter %DLMOS%).PartitionNumber"') do set PartitionNumber=%%i
::---------------------------------------------------------------
:CheckReqFiles
if %Model%==1 (if not exist Drivers\Lumia930 goto MissingDrivers)
if %Model%==2 (if not exist Drivers\LumiaIcon goto MissingDrivers)
if %Model%==3 (if not exist Drivers\Lumia1520 goto MissingDrivers)
if %Model%==4 (if not exist Drivers\Lumia1520 goto MissingDrivers)
if %Model%==5 (if not exist Drivers\Lumia1520-AT^&T goto MissingDrivers)
if %Model%==6 (if not exist Drivers\Lumia1520-AT^&T goto MissingDrivers)
if %Model%==7 (if not exist Drivers\Lumia830 goto MissingDrivers)
if %Model%==8 (if not exist Drivers\Lumia735 goto MissingDrivers)
if /I %Model%==A (if not exist Drivers\Lumia640XL goto MissingDrivers)
if /I %Model%==B (if not exist Drivers\Lumia640XL-AT^&T goto MissingDrivers)
if /I %Model%==C (if not exist Drivers\Lumia950 goto MissingDrivers)
if /I %Model%==d (if not exist Drivers\Lumia950XL goto MissingDrivers)
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
if not exist Logs\ mkdir Logs
cd Logs
for /f %%d in ('Powershell Get-Date -format "dd-MMM-yy"') do set Date1=%%d
if not exist %Date1%.log set LogName=Logs\%Date1%.log & goto LoggerInit
if not exist %Date1%-1.log set LogName=Logs\%Date1%-1.log & goto LoggerInit
set LogNum=1
:LogName
if exist %Date1%-*.log (
    if exist %Date1%-%LogNum%.log (
        set /A "LogNum+=1"
        goto LogName
    ) else (
        set LogName=Logs\%Date1%-%LogNum%.log
    )
)
:LoggerInit
setlocal EnableDelayedExpansion
cd ..
set ErrNum=0
set Logger=2^>CurrentError.log ^>^> "%LogName%" ^&^
 set "Err=^!Errorlevel^!" ^&^
 (for /f "tokens=*" %%a in (CurrentError.log) do echo [EROR] %%a) ^>^> ErrorConsole.log ^&^
 (if exist ErrorConsole.log type ErrorConsole.log) ^&^
 type CurrentError.log ^>^> "%LogName%" ^&^
 (if exist ErrorConsole.log del ErrorConsole.log) ^&^
 (if ^^!Err^^! NEQ 0 set /a "ErrNum+=1" ^& echo %ESC%[93m[WARN] An error has occurred, installation will continue.%ESC%[91m)
set SevLogger=2^>CurrentError.log ^>^> "%LogName%" ^&^
 set "SevErr=^!Errorlevel^!" ^&^
 (for /f "tokens=*" %%a in (CurrentError.log) do echo [EROR] %%a) ^>^> ErrorConsole.log ^&^
 (if exist ErrorConsole.log type ErrorConsole.log) ^&^
 type CurrentError.log ^>^> "%LogName%" ^&^
 (if exist ErrorConsole.log del ErrorConsole.log) ^&^
 (if ^^!SevErr^^! NEQ 0 set /a "ErrNum+=1" ^>nul ^& goto SevErrFound)
:ToBeContinued2
set StartTime=%Time%
echo.
echo %ESC%[96m[INFO] Installation was started at %StartTime%
echo #### INSTALLATION WAS STARTED AT %StartTime% #### >>%LogName%
echo ========================================================= >>%LogName%
echo ## Device is %Model%  ## >>%LogName%
echo ## MainOS is %MainOS% ## >>%LogName%
echo. >>%LogName%
echo.
echo.
if not exist Temp\ mkdir Temp\
echo %ESC%[96m[INFO] Getting Partition Infos
for /f %%i in ('Powershell -C "(Get-Partition | ? { $_.AccessPaths -eq '%MainOS%\Data\' }).PartitionNumber"') do set PartitionNumberData=%%i
for /f %%i in ('Powershell -C "(Get-Partition | ? { $_.AccessPaths -eq '%MainOS%\EFIESP\' }).PartitionNumber"') do set PartitionNumberEFIESP=%%i
if %Storage% NEQ 32A echo %ESC%[96m[INFO] Resizing MainOS Partition ...%ESC%[91m
if %Storage%==8 (
	Powershell -C "Remove-Partition -DiskNumber %DiskNumber% -PartitionNumber %PartitionNumberData% -confirm:$false; exit $Error.count" %SevLogger%
	Powershell -C "Resize-Partition -DriveLetter %DLMOS% -Size (Get-PartitionSupportedSize -DriveLetter %DLMOS%).sizeMax; exit $Error.count" %SevLogger%
	echo %ESC%[96m[INFO] Formatting MainOS for Windows 10 for ARMv7 ...%ESC%[91m
	rd %MainOS%\Data 
)
if %Storage%==16 (
	Powershell -C "Resize-Partition -DiskNumber %DiskNumber% -PartitioNumber %PartitionNumberData% -Size 8192MB; exit $Error.count" %SevLogger%
	echo %ESC%[96m[INFO] Creating Windows 10 for ARMv7 Partition ...%ESC%[91m
	Powershell -C "New-Partition -DiskNumber %DiskNumber% -UseMaximumSize -DriveLetter N; exit $Error.count" %SevLogger%
)
if %Storage%==32 (
	Powershell -C "Resize-Partition -DiskNumber %DiskNumber% -PartitioNumber %PartitionNumberData% -Size 16384MB; exit $Error.count" %SevLogger%
	echo %ESC%[96m[INFO] Creating Windows 10 for ARMv7 Partition ...%ESC%[91m
	Powershell -C "New-Partition -DiskNumber %DiskNumber% -UseMaximumSize -DriveLetter N; exit $Error.count" %SevLogger%
)
if %Storage%==8 (format %MainOS% /FS:NTFS /V:Windows10 /Q /C /Y %SevLogger%)
if %Storage%==16 (format N: /FS:NTFS /V:Windows10 /Q /Y %SevLogger%)
if %Storage%==32 (format N: /FS:NTFS /V:Windows10 /Q /Y %SevLogger%)
::---------------------------------------------------------------
echo ========================================================= >>%LogName%
echo.
echo %ESC%[96m[INFO] Installing Windows 10 for ARMv7 ...%ESC%[91m
if %Storage%==8 Files\wimlib apply install.wim 1 %MainOS%\ --compact=xpress8k %SevLogger%
if %Storage%==16 Files\wimlib apply install.wim 1 %MainOS%\ --compact=xpress8k %SevLogger%
if %Storage%==32 Files\wimlib apply install.wim 1 %MainOS%\ %SevLogger%
::---------------------------------------------------------------
echo.
echo %ESC%[96m[INFO] Installing Drivers ...%ESC%[91m
echo %ESC%[93m[WARN] Error outputs will not be showed here.%ESC%[91m
if %Model%==1 Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia930" /Recurse %Logger%
if %Model%==2 Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\LumiaIcon" /Recurse %Logger%
if %Model%==3 Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia1520" /Recurse %Logger%
if %Model%==4 Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia1520" /Recurse %Logger%
if %Model%==5 Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia1520-AT^&T" /Recurse %Logger%
if %Model%==6 Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia1520-AT^&T" /Recurse %Logger%
if %Model%==7 Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia830" /Recurse %Logger%
if %Model%==8 Dism /Image:%MainOS%\ /Add-Driver /Driver:".\Drivers\Lumia735" /Recurse %Logger%
if /i %Model%==A Dism /Image:%MainOS%\ /Add-Driver /Driver:".\Drivers\Lumia640XL" /Recurse %Logger%
if /i %Model%==B Dism /Image:%MainOS%\ /Add-Driver /Driver:".\Drivers\Lumia640XL-AT^&T" /Recurse %Logger%
if /i %Model%==C Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia950" /Recurse %Logger%
if /i %Model%==D Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia950XL" /Recurse %Logger%
if /i %Model%==E Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia1020" /Recurse %Logger%
if /i %Model%==F Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia1020-AT^&T" /Recurse %Logger%
if /i %Model%==G Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia920" /Recurse %Logger%
::---------------------------------------------------------------
echo ========================================================= >>%LogName%
echo.
if %Storage% NEQ 8 (
	echo %ESC%[96m[INFO] Installing Mass Storage Mode UI ...%ESC%[91m
	xcopy .\Files\MassStorage %MainOS%\EFIESP\Windows\System32\Boot\ui /E /H /I /Y %Logger%
)
echo.
echo %ESC%[96m[INFO] Adding BCD Entry ...
echo %ESC%[93m[WARN] Error outputs will not be showed here.%ESC%[91m
SET bcdLoc="%MainOS%\EFIESP\efi\Microsoft\Boot\BCD"
echo ## BCD Path is %bcdLoc% ## >>%LogName% 
SET id="{703c511b-98f3-4630-b752-6d177cbfb89c}"
bcdedit /store %bcdLoc% /create %id% /d "Windows 10 for ARMv7" /application "osloader" %SevLogger%
if %Storage%==8 (
	bcdedit /store %bcdLoc% /set %id% "device" "partition=%MainOS%" %SevLogger%
	bcdedit /store %bcdLoc% /set %id% "osdevice" "partition=%MainOS%" %SevLogger%
	bcdedit /store %bcdLoc% /set "{default}" description "Ignore This" %Logger%
	bcdedit /store %bcdLoc% /default %id% %Logger%
) else (
	if %Storage% NEQ 32A (
		bcdedit /store %bcdLoc% /set %id% "device" "partition=N:" %SevLogger%
		bcdedit /store %bcdLoc% /set %id% "osdevice" "partition=N:" %SevLogger%
		bcdedit /store %bcdLoc% /set "{default}" description "Windows Phone" %Logger%
	)
)
if %Storage%==32A (
	bcdedit /store %bcdLoc% /set %id% "device" "partition=%MainOS%" %SevLogger%
	bcdedit /store %bcdLoc% /set %id% "osdevice" "partition=%MainOS%" %SevLogger%
	bcdedit /store %bcdLoc% /set "{default}" description "Windows Phone" %Logger%
)
if %Storage%==32A (
	bcdedit /store %bcdLoc% /set %id% "path" "\Windows10Arm\Windows\System32\winload.efi" %SevLogger%
) else (bcdedit /store %bcdLoc% /set %id% "path" "\Windows\System32\winload.efi" %SevLogger%)
bcdedit /store %bcdLoc% /set %id% "locale" "en-US" %Logger%
bcdedit /store %bcdLoc% /set %id% "testsigning" yes %Logger%
bcdedit /store %bcdLoc% /set %id% "inherit" "{bootloadersettings}" %Logger%
bcdedit /store %bcdLoc% /set %id% "systemroot" "\Windows" %SevLogger%
bcdedit /store %bcdLoc% /set %id% "bootmenupolicy" "Standard" %Logger%
bcdedit /store %bcdLoc% /set %id% "detecthal" Yes %Logger%
bcdedit /store %bcdLoc% /set %id% "winpe" No %Logger%
bcdedit /store %bcdLoc% /set %id% "ems" No %Logger%
bcdedit /store %bcdLoc% /set %id% "bootdebug" No %Logger%
bcdedit /store %bcdLoc% /set "{bootmgr}" "nointegritychecks" Yes %Logger%
bcdedit /store %bcdLoc% /set "{bootmgr}" "testsigning" yes %Logger%
bcdedit /store %bcdLoc% /set "{bootmgr}" "timeout" 5 %Logger%
bcdedit /store %bcdLoc% /set "{bootmgr}" "displaybootmenu" yes %SevLogger%
bcdedit /store %bcdLoc% /set "{bootmgr}" "custom:54000001" %id% %SevLogger%
echo.
::---------------------------------------------------------------
echo ========================================================= >>%LogName%
echo %ESC%[96m[INFO] Setting up ESP ...%ESC%[91m
mkdir %MainOS%\EFIESP\EFI\Microsoft\Recovery\ %Logger%
bcdedit /createstore %MainOS%\EFIESP\EFI\Microsoft\Recovery\BCD
set DLMOS=%MainOS:~0,-1%
echo. >>%LogName%
echo ## EfiespPartitionNumber is %PartitionNumber% ## >>%LogName%
if %Storage%==8 (
	echo>>Temp\diskpart1.txt sel dis %DiskNumber%
	echo>>Temp\diskpart1.txt sel par %PartitionNumberEFIESP%
	echo>>Temp\diskpart1.txt assign mount=%MainOS%\EFIESP
	mkdir %MainOS%\EFIESP
	diskpart /s Temp\diskpart1.txt %Logger%
)
echo>>Temp\diskpart.txt sel dis %DiskNumber%
echo>>Temp\diskpart.txt sel par %PartitionNumberEFIESP%
echo>>Temp\diskpart.txt set id=c12a7328-f81f-11d2-ba4b-00a0c93ec93b
diskpart /s Temp\diskpart.txt %Logger%
rd /s /q Temp\
::---------------------------------------------------------------
:SevErrFound
del CurrentError.log
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
	rd /s /q Temp\
	echo.
	echo #### INSTALLATION COMPLETED WITH ERROR^(S^) #### >>%LogName%
	echo %ESC%[96m[INFO] Installation is completed with%ESC%[91m %ErrNum% error^(s^)%ESC%[96m!
	echo %ESC%[93m[WARN] Please check installation log in Logs folder.%ESC%[0m
	echo.
	pause
)
if %ErrNum% EQU 0 echo #### INSTALLATION COMPLETED SUCCESSFULLY #### >>%LogName%
if %ErrNum% EQU 0 echo. & echo %ESC%[96m[INFO] Installation completed successfully!
echo.
echo %ESC%[92m================================================================================================
echo  - Now, reboot your phone.
echo  - After the boot menu appears, press power up to boot Windows 10 for ARMv7.
echo  - Boot and setup Windows 10 for the first time. Then reboot the phone to mass storage mode.
echo  - Run PostInstall.bat.
echo ================================================================================================%ESC%[0m
echo.
pause
exit /b

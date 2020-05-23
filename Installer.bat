@echo off
if not "%~1"=="" call :%~1
:Check1
cd ..
if EXIST M:\ (
	title ERROR!
	color 0C
	echo ----------------------------------------------------------------
	echo   Please Unmount Drive [M:]
	pause
	exit
)
if NOT EXIST M:\ (
	cls
	echo Checking compatibility ...
)

if EXIST N:\ (
	title ERROR!
	color 0C
	echo ----------------------------------------------------------------
	echo   Please Unmount Drive [N:]
	pause
	exit
)
if NOT EXIST N:\ (
	cls
	echo Checking compatibility ...
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
::---------------------------------------------------------------
:Check2
title Checking compatibility ...
for /f "tokens=3" %%a in ('Reg Query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild ^| findstr /ri "REG_SZ"') do set WinBuild=%%a
if %WinBuild% LSS 9600 (
	title ERROR!
	color 0C
	echo ----------------------------------------------------------------
	echo   This Windows version is not supported by WFAv7 Installer.
	echo   Please use Windows 8.1 Pro+ ^(Build 9600+^) 
	echo   Current OS build: %WinBuild%
	pause
	exit
)

Powershell /? >nul
set PLV=%errorlevel%
if %PLV% NEQ 0 (
	title ERROR!
	color 0C
	echo ----------------------------------------------------------------
	echo   Powershell wasn't found or it have problem.
	echo   Please enable Powershell and continue.
	echo   Error code: %PLV%
	pause
	exit
)
where DISM >nul
if %errorlevel% NEQ 0 (
	title ERROR!
	color 0C
	echo ----------------------------------------------------------------
	echo   DISM isn't found or it has problem.
	pause
	exit
)

where bcdedit >nul
if %errorlevel% NEQ 0 (
	TITLE ERROR!
	COLOR 0C
	echo ----------------------------------------------------------------
	echo   BCDEDIT wasn't found or it has problem.
	PAUSE
	EXIT
)

Powershell -Command "(Get-WindowsOptionalFeature -FeatureName Microsoft-Hyper-V -Online).State" | findstr /I "Enabled"
if %errorlevel% NEQ 0 (
	title ERROR!
	color 0C
	echo ----------------------------------------------------------------
	echo  Please enable Hyper-V in Windows Features.
	pause
	exit
)
cls
echo Checking compatibility ...
Powershell -C "(Get-Module -ListAvailable -All).name" >> Modules.txt
FindStr /X /C:"Volume" Modules.txt >nul
if %errorlevel% NEQ 0 goto MissingModule
FindStr /X /C:"Disk" Modules.txt >nul
if %errorlevel% NEQ 0 goto MissingModule
FindStr /X /C:"Storage" Modules.txt >nul
if %errorlevel% NEQ 0 goto MissingModule
FindStr /X /C:"Hyper-V" Modules.txt >nul
if %errorlevel% NEQ 0 (
	title ERROR!
	color 0C
	echo ----------------------------------------------------------------
	echo  Hyper-V is not fully enabled.
	pause
	exit
)
del Modules.txt
goto ToBeContinued0
:MissingModule
title ERROR!
color 0C
echo ----------------------------------------------------------------
echo  You used Windows 7 / Windows Home edition / Customized Windows.
echo  Please use Official Windows 8.1 Pro or Windows 10 Pro
pause
exit
:ToBeContinued0
cls
echo Installer is loading ... [100%%]
:Start
if %WinBuild% LSS 10586 (
	if %PROCESSOR_ARCHITECTURE%==x86 Files\ansicon32 -p
	if %PROCESSOR_ARCHITECTURE%==AMD64 Files\ansicon64 -p
)
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set ESC=%%b
::---------------------------------------------------------------
cls
mode 96,1200
Powershell -command "&{(get-host).ui.rawui.windowsize=@{width=96;height=24};}"
title Windows 10 for ARMv7 Installer (VHDX) Proximal Release 3
echo  %ESC%[93m//////////////////////////////////////////////////////////////////////////////////////////////
echo  //                        %ESC%[97mWindows 10 for ARMv7 Installer (VHDX) PR3%ESC%[93m                         //
echo  //                                   %ESC%[97mby RedGreenBlue123%ESC%[93m                                     //
echo  //                    %ESC%[97mThanks to: @Gus33000, @FadilFadz01, @Heathcliff74%ESC%[93m                     //
echo  //////////////////////////////////////////////////////////////////////////////////////////////%ESC%[0m
echo.
echo %ESC%[95mDISCLAIMER:
echo     * I'm not responsible for bricked devices, dead SD cards,
echo       thermonuclear war, or you getting fired because the alarm app failed.
echo     * YOU are choosing to make these modifications,
echo       and if you point the finger at me for messing up your device, I will laugh at you.
echo     * Your warranty will be void if you tamper with any part of your device / software.
echo %ESC%[36mPREPARATION:
echo     - Read README.TXT before use this Installer.
echo     - Make sure your phone is fully charged and it's battery is not wear too much.
echo     - Make sure no drives mounted in M and N.
echo     - Unlocked bootloader and booted into Mass Storage Mode.%ESC%[0m
echo.
pause
::---------------------------------------------------------------
:ChooseDev
set Model=
cls
echo  %ESC%[93m//////////////////////////////////////////////////////////////////////////////////////////////
echo  //                        %ESC%[97mWindows 10 for ARMv7 Installer (VHDX) PR3%ESC%[93m                         //
echo  //                                   %ESC%[97mby RedGreenBlue123%ESC%[93m                                     //
echo  //                    %ESC%[97mThanks to: @Gus33000, @FadilFadz01, @Heathcliff74%ESC%[93m                     //
echo  //////////////////////////////////////////////////////////////////////////////////////////////%ESC%[0m
echo.
echo %ESC%[92mChoose your Device Model below:
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
echo  %ESC%[36mD) %ESC%[97mLumia 950 XL%ESC%[0m
set /p Model=%ESC%[92mDevice%ESC%[32m: %ESC%[0m
if "%model%"=="" goto ChooseDev
if %model%==1 set Storage=32 & goto ToBeContinued1
if %model%==2 set Storage=32 & goto ToBeContinued1
if %model%==3 set Storage=32 & goto ToBeContinued1
if %model%==4 set Storage=16 & goto ToBeContinued1
if %model%==5 set Storage=32 & goto ToBeContinued1
if %model%==6 set Storage=16 & goto ToBeContinued1
if %model%==7 set Storage=16 & goto ToBeContinued1
if %model%==8 set Storage=8 & goto ToBeContinued1
if %model%==A set Storage=8 & goto ToBeContinued1
if %model%==B set Storage=8 & goto ToBeContinued1
if %model%==C set Storage=32 & goto ToBeContinued1
if %model%==D set Storage=32 & goto ToBeContinued1
if %model%==a set Storage=8 & goto ToBeContinued1
if %model%==b set Storage=8 & goto ToBeContinued1
if %model%==c set Storage=32 & goto ToBeContinued1
if %model%==d set Storage=32 & goto ToBeContinued1
if not %model%==1 goto ChooseDev
if not %model%==2 goto ChooseDev
if not %model%==3 goto ChooseDev
if not %model%==4 goto ChooseDev
if not %model%==5 goto ChooseDev
if not %model%==6 goto ChooseDev
if not %model%==7 goto ChooseDev
if not %model%==8 goto ChooseDev
if not %model%==A goto ChooseDev
if not %model%==B goto ChooseDev
if not %model%==C goto ChooseDev
if not %model%==D goto ChooseDev
if not %model%==a goto ChooseDev
if not %model%==b goto ChooseDev
if not %model%==c goto ChooseDev
if not %model%==d goto ChooseDev
::---------------------------------------------------------------
:ToBeContinued1
cls
echo  %ESC%[93m//////////////////////////////////////////////////////////////////////////////////////////////
echo  //                        %ESC%[97mWindows 10 for ARMv7 Installer (VHDX) PR3%ESC%[93m                         //
echo  //                                   %ESC%[97mby RedGreenBlue123%ESC%[93m                                     //
echo  //                    %ESC%[97mThanks to: @Gus33000, @FadilFadz01, @Heathcliff74%ESC%[93m                     //
echo  //////////////////////////////////////////////////////////////////////////////////////////////%ESC%[97m
echo.
if %WinBuild% LSS 10240 echo %ESC%[91m - Installing WFAv7 to 8 GB devices on Windows 8.1 is not supported.%ESC%[90m & pause & exit
if %Storage%==8 echo  - You need at least ^> %ESC%[4m4.0 GB%ESC%[0m%ESC%[97m of Phone Storage to continue.
if %Storage%==16 echo  - You need at least ^> %ESC%[4m8.0 GB%ESC%[0m%ESC%[97m of Phone Storage to continue.
if %Storage%==32 echo  - You need at least ^> %ESC%[4m16.0 GB%ESC%[0m%ESC%[97m of Phone Storage to continue.
echo.
pause
:MOSPath
set MainOS=
echo.
set /p MainOS=%ESC%[92mEnter MainOS Path: %ESC%[0m
if not defined MainOS (
	echo  %ESC%[91mNot a valid MainOS partition.
	GOTO MOSPath
)
for /f %%m in ('Powershell -C "(echo %MainOS%).length -eq 2"') do set Lenght2=%%m
if %Lenght2%==False (
	echo  %ESC%[91mNot a valid MainOS partition.
	GOTO MOSPath
)
if not exist "%MainOS%\EFIESP" (
	echo  %ESC%[91mNot a valid MainOS partition.
	GOTO MOSPath
)
if not exist "%MainOS%\Data" (
	echo  %ESC%[91mNot a valid MainOS partition.
	GOTO MOSPath
)
if exist "%MainOS%\Data\windows10arm.vhdx" (
	echo  %ESC%[91mWindows 10 for ARMv7 is installed. Please uninstall it first.
	Pause
	Exit
)
::---------------------------------------------------------------
:CheckReqFiles
if %Model%==1 (if not exist Drivers\Lumia930 goto DriverMissing)
if %Model%==2 (if not exist Drivers\LumiaIcon goto DriverMissing)
if %Model%==3 (if not exist Drivers\Lumia1520 goto DriverMissing)
if %Model%==4 (if not exist Drivers\Lumia1520 goto DriverMissing)
if %Model%==5 (if not exist Drivers\Lumia1520-AT^&T goto DriverMissing)
if %Model%==6 (if not exist Drivers\Lumia1520-AT^&T goto DriverMissing)
if %Model%==7 (if not exist Drivers\Lumia830 goto DriverMissing)
if %Model%==8 (if not exist Drivers\Lumia735 goto DriverMissing)
if %Model%==A (if not exist Drivers\Lumia640XL goto DriverMissing)
if %Model%==B (if not exist Drivers\Lumia640XL-AT^&T goto DriverMissing)
if %Model%==C (if not exist Drivers\Lumia950 goto DriverMissing)
if %Model%==d (if not exist Drivers\Lumia950XL goto DriverMissing)
if %Model%==a (if not exist Drivers\Lumia640XL goto DriverMissing)
if %Model%==b (if not exist Drivers\Lumia640XL-AT^&T goto DriverMissing)
if %Model%==c (if not exist Drivers\Lumia950 goto DriverMissing)
if %Model%==d (if not exist Drivers\Lumia950XL goto DriverMissing)
if not exist "%~dp0\install.wim" (
	echo ----------------------------------------------------------------
	echo  %ESC%[91mPlace install.wim in the Installer folder and try again.%ESC%[0m
	pause
	goto ChooseDev
)
Goto LogNameInit
:DriverMissing
echo ----------------------------------------------------------------
echo  %ESC%[91mExtract Drivers to Drivers folder and try again.
echo  Remember NEVER creates Subfolders or extract subfolders.%ESC%[0m
pause
goto ChooseDev
::---------------------------------------------------------------
:LogNameInit
if not exist Logs\NUL del Logs /Q 2>nul
if not exist Logs\ mkdir Logs
cd Logs
FOR /F "tokens=* USEBACKQ" %%F IN (`Powershell Get-Date -format "dd-MMM-yy"`) DO SET Date1=%%F
if not exist %Date1%.log set LogName=Logs\%Date1%.log & goto LoggerInit
if not exist %Date1%-1.log set LogName=Logs\%Date1%-1.log & goto LoggerInit
set LogNum=1
:LogName
if exist %Date1%-*.log (
    if exist %Date1%-%LogNum%.log (
        set /A LogNum=LogNum+1
        goto LogName
    ) else (
        set LogName=Logs\%Date1%-%LogNum%.log
    )
)
:LoggerInit
cd ..
set ErrNum=0
Set Logger=2^>CurrentError.log ^>^>%LogName% ^& set Err=%Errorlevel% ^& (for /f "tokens=*" %%a in (CurrentError.log) do (echo [EROR] %%a) ^>^> ErrorConsole.log) ^& (if exist ErrorConsole.log type ErrorConsole.log) ^& type CurrentError.log ^>^>%LogName% ^& (if exist ErrorConsole.log del ErrorConsole.log) ^& (if %Err% NEQ 0 set /a ErrNum=ErrNum+1 ^>nul ^& echo %ESC%[33m[WARN] An error has occurred, installation will continue.)
Set SevLogger=2^>CurrentError.log ^>^>%LogName% ^& set SevErr=%Errorlevel% ^& for /f "tokens=*" %%a in (CurrentError.log) do (echo [EROR] %%a) ^>^> ErrorConsole.log ^& (if exist ErrorConsole.log type ErrorConsole.log) ^& type CurrentError.log ^>^>%LogName% ^& (if exist ErrorConsole.log del ErrorConsole.log) ^& (if not SevErr==0 set /a ErrNum=ErrNum+1 ^>nul ^& goto SevErrFounded)
:ToBeContinued2
echo #### INSTALLATION STARTED #### >>%LogName%
echo ======================================== >>%LogName%
echo ## Device is %Model%  ## >>%LogName%
echo ## MainOS is %MainOS% ## >>%LogName%
echo. >>%LogName%
echo.
if %Storage%==8 (
	echo %ESC%[96m[INFO] Creating 4 GB VHDX image ...%ESC%[91m
	Powershell -C "New-VHD -Path %MainOS%\Data\windows10arm.vhdx -Fixed -SizeBytes 4096MB; exit $Error.count" %SevLogger%
)
if %Storage%==16 (
	echo %ESC%[96m[INFO] Creating 8 GB VHDX image ...%ESC%[91m
	Powershell -C "New-VHD -Path %MainOS%\Data\windows10arm.vhdx -Fixed -SizeBytes 8192MB; exit $Error.count" %SevLogger%
)
if %Storage%==32 (
	echo %ESC%[96m[INFO] Creating 16 GB VHDX image ...%ESC%[91m
	Powershell -C "New-VHD -Path %MainOS%\Data\windows10arm.vhdx -Fixed -SizeBytes 16384MB; exit $Error.count" %SevLogger%
)
echo.
echo %ESC%[96m[INFO] Creating Partition Table ...%ESC%[91m
Powershell -C "Mount-VHD -Path %MainOS%\Data\windows10arm.vhdx; exit $Error.count" %SevLogger%
Powershell -C "Initialize-Disk -Number (Get-VHD -Path %MainOS%\Data\windows10arm.vhdx).DiskNumber -PartitionStyle GPT -confirm:$false; exit $Error.count" %SevLogger%
:: Create ESP
echo.
echo %ESC%[96m[INFO] Creating EFI System Partition ...%ESC%[91m
Powershell -C "New-Partition -DiskNumber (Get-VHD -Path %MainOS%\Data\windows10arm.vhdx).DiskNumber -GptType '{c12a7328-f81f-11d2-ba4b-00a0c93ec93b}' -Size 100MB -DriveLetter M; exit $Error.count" %SevLogger%
Powershell -C "Format-Volume -DriveLetter M -FileSystem Fat32 -NewFileSystemLabel "ESP" -confirm:$false; exit $Error.count" %SevLogger%
:: Create MSR
echo.
echo %ESC%[96m[INFO] Creating Microsoft Reserved Partition ...%ESC%[91m
Powershell -C "New-Partition -DiskNumber (Get-VHD -Path %MainOS%\Data\windows10arm.vhdx).DiskNumber -GptType '{e3c9e316-0b5c-4db8-817d-f92df00215ae}' -Size 128MB; exit $Error.count" %SevLogger%
:: Create Win10 Partition
echo.
echo %ESC%[96m[INFO] Creating Windows 10 for ARMv7 Partition ...%ESC%[91m
Powershell -C "New-Partition -DiskNumber (Get-VHD -Path %MainOS%\Data\windows10arm.vhdx).DiskNumber -GptType '{ebd0a0a2-b9e5-4433-87c0-68b6b72699c7}' -UseMaximumSize -DriveLetter N; exit $Error.count" %SevLogger%
if %Storage%==8 ( format N: /FS:NTFS /V:Windows10 /Q /C /Y %SevLogger% )
if %Storage%==16 ( format N: /FS:NTFS /V:Windows10 /Q /Y %SevLogger% )
if %Storage%==32 ( format N: /FS:NTFS /V:Windows10 /Q /Y %SevLogger% )
::---------------------------------------------------------------
echo ======================================== >>%LogName%
echo.
echo %ESC%[96m[INFO] Installing Windows 10 for ARMv7 ...%ESC%[91m
if %Storage%==8 Powershell -C "Expand-WindowsImage -ImagePath install.wim -ApplyPath N:\ -Index 1 -Compact; exit $Error.count" %SevLogger%
if %Storage%==16 Powershell -C "Expand-WindowsImage -ImagePath install.wim -ApplyPath N:\ -Index 1; exit $Error.count" %SevLogger%
if %Storage%==32 Powershell -C "Expand-WindowsImage -ImagePath install.wim -ApplyPath N:\ -Index 1; exit $Error.count" %SevLogger%
::---------------------------------------------------------------
echo.
echo %ESC%[93m[INFO] Installing Drivers ...%ESC%[91m
echo %ESC%[33m[WARN] Error outputs will not show here.%ESC%[91m
if %model%==1 Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia930" /Recurse %Logger%
if %model%==2 Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\LumiaIcon" /Recurse %Logger%
if %model%==3 Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia1520" /Recurse %Logger%
if %model%==4 Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia1520" /Recurse %Logger%
if %model%==5 Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia1520-AT^&T" /Recurse %Logger%
if %model%==6 Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia1520-AT^&T" /Recurse %Logger%
if %model%==7 Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia830" /Recurse %Logger%
if %model%==8 Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia735" /Recurse %Logger%
if %model%==A Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia640XL" /Recurse %Logger%
if %model%==B Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia640XL-AT^&T" /Recurse %Logger%
if %model%==C Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia950" /Recurse %Logger%
if %model%==D Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia950XL" /Recurse %Logger%
if %model%==a Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia640XL" /Recurse %Logger%
if %model%==b Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia640XL-AT^&T" /Recurse %Logger%
if %model%==c Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia950" /Recurse %Logger%
if %model%==d Dism /Image:N:\ /Add-Driver /Driver:".\Drivers\Lumia950XL" /Recurse %Logger%
::---------------------------------------------------------------
echo ======================================== >>%LogName%
echo.
echo %ESC%[96m[INFO] Installing Mass Storage Mode UI ...%ESC%[91m
xcopy .\Files\MassStorage %MainOS%\EFIESP\Windows\System32\Boot\ui /E /H /I /Y %Logger%
echo.
echo %ESC%[96m[INFO] Setting Up BCD ...
echo %ESC%[33m[WARN] Error outputs will not show here.%ESC%[91m
bcdboot N:\Windows /s M: /l en-us /f UEFI %SevLogger%
::---------------------------------------------------------------
echo ======================================== >>%LogName%
echo.
echo %ESC%[96m[INFO] Adding BCD Entry ...
echo %ESC%[33m[WARN] Error outputs will not show here.%ESC%[91m
SET bcdLoc="%MainOS%\EFIESP\efi\Microsoft\Boot\BCD"
echo ## BCD Path is %bcdLoc% ## >>%LogName% 
SET id="{703c511b-98f3-4630-b752-6d177cbfb89c}"
bcdedit /store %bcdLoc% /create %id% /d "Windows 10 for ARMv7" /application "osloader" %SevLogger%
bcdedit /store %bcdLoc% /set %id% "device" "vhd=[%MainOS%\Data]\windows10arm.vhdx" %SevLogger%
bcdedit /store %bcdLoc% /set %id% "osdevice" "vhd=[%MainOS%\Data]\windows10arm.vhdx" %SevLogger%
bcdedit /store %bcdLoc% /set %id% "path" "\windows\system32\winload.efi" %SevLogger%
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
echo ======================================== >>%LogName%
echo %ESC%[96m[INFO] Setting up ESP ...%ESC%[91m
mkdir %MainOS%\EFIESP\EFI\Microsoft\Recovery\ %Logger%
copy M:\EFI\Microsoft\Recovery\BCD %MainOS%\EFIESP\EFI\Microsoft\Recovery\BCD /Y %Logger%
set BCDRec=%MainOS%\EFIESP\EFI\Microsoft\Recovery\BCD >>%LogName%
bcdedit /store %BCDRec% /set {bootmgr} "device" "partition=%MainOS%\EFIESP" %Logger%
bcdedit /store %BCDRec% /set {bootmgr} "path" "\EFI\Boot\Bootarm.efi" %Logger%
bcdedit /store %BCDRec% /set {bootmgr} "timeout" "5" %Logger%
set DLMOS=%MainOS:~0,-1%
echo. >>%LogName%
for /f %%i in ('Powershell -C "(Get-Partition | ? { $_.AccessPaths -eq '%MainOS%\EFIESP\' }).PartitionNumber"') do set PartitionNumber=%%i
echo ## PartitionNumber is %PartitionNumber% ## >>%LogName%
for /f %%f in ('Powershell -C "(Get-Partition -DriveLetter %DLMOS%).DiskNumber"') do set DiskNumber=%%f
echo ## DiskNumber is %DiskNumber% ## >>%LogName%
echo>>diskpart.txt sel dis %DiskNumber%
echo>>diskpart.txt sel par %PartitionNumber%
echo>>diskpart.txt set id=c12a7328-f81f-11d2-ba4b-00a0c93ec93b
attrib +h diskpart.txt %Logger%
diskpart /s diskpart.txt %Logger%
del /A:H diskpart.txt %Logger%
::---------------------------------------------------------------
echo.
echo %ESC%[96m[INFO] Unmounting VHDX Image ...%ESC%[91m
Powershell Dismount-VHD -Path "%MainOS%\Data\windows10arm.vhdx" %Logger%
del CurrentError.log
goto MissionCompleted
::---------------------------------------------------------------
:SevErrFounded
echo ======================================== >>%LogName%
echo.
echo #### INSTALLATION CANCELED #### >>%LogName%
if exist diskpart.txt del /A:H diskpart.txt
echo %ESC%[96m[INFO] Installation was cancelled due to a%ESC%[91m severe error %ESC%[96moccurred.
echo %ESC%[33m[WARN] Please check installation log in Logs folder.%ESC%[0m
echo.
pause
exit

:MissionCompleted
if InstallErr NEQ 0 (
	echo.
	echo #### INSTALLATION COMPLETED WITH ERROR(S) #### >>%LogName%
	echo %ESC%[96m[INFO] Installation completed with%ESC%[91m %ErrNum% error^(s^)%ESC%[96m!
	echo %ESC%[33m[WARN] Please check installation log in Logs folder.%ESC%[0m
	echo.
	pause
)
if InstallErr==0 echo #### INSTALLATION COMPLETED SUCCESSFULLY #### >>%LogName%
if InstallErr==0 echo. & echo %ESC%[96m[INFO] Installation completed successfully!
echo.
echo %ESC%[92m================================================================================================
echo  - Now, reboot your phone.
echo  - After the boot menu appears, press power up to boot Windows 10 for ARMv7.
echo  - Boot and setup Windows 10 for the first time. Then reboot the phone to mass storage mode.
echo  - Run PostInstall.bat.
echo ================================================================================================%ESC%[0m
echo.
pause
exit

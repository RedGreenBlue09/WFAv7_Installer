@echo off
setlocal EnableDelayedExpansion

:GetAdministrator
net session >nul 2>&1 || (
	echo Requesting administrative privileges...
	Powershell -C "Start-Process -FilePath '%0' -Verb RunAs; exit $Error.count" || (
		echo Unable to grant administrative privileges. Please run the file as administrator.
		echo.
		pause
	)
	exit /B
)

:: Get EFIESP infos

for /f "delims=" %%a in ('fsutil reparsepoint query %SYSTEMDRIVE%\EFIESP') do (
	echo %%a| find "Substitute Name:">nul
	if "!Errorlevel!" EQU "0" (
		for /f "tokens=2 delims=:" %%b in ("%%a") do (
			set "VolumeName=%%b"
			for /f %%p in ('Powershell -C "(Get-Partition | ? { '!VolumeName!' -Match $_.Guid }).DiskNumber 2>$null"') do set "DiskNumber=%%p"
			for /f %%p in ('Powershell -C "(Get-Partition | ? { '!VolumeName!' -Match $_.Guid }).PartitionNumber 2>$null"') do set "PartitionNumber=%%p"
			set "Uuid="
		)
	)
)

:: Dualboot

md Temp\
echo>Temp\diskpart1.txt sel dis %DiskNumber%
echo>>Temp\diskpart1.txt sel par %PartitionNumber%
echo>>Temp\diskpart1.txt set id=ebd0a0a2-b9e5-4433-87c0-68b6b72699c7
diskpart /s Temp\diskpart1.txt
rd /s /q Temp\

bcdedit /store "%SYSTEMDRIVE%\EFIESP\EFI\Microsoft\Boot\BCD" /set "{bootmgr}" "timeout" "5"

echo.
echo More functionalities has been enabled.
echo Reboot your device for it to take effect.
pause
exit /b

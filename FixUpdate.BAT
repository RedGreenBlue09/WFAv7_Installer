@ECHO OFF
cd /D "%~dp0"
set /p MainOS=Enter MainOS Path: 
echo Fixing BCD ...
copy .\files\fixbcd.bat %mainos%\fixbcd.bat /Y
call %mainos%\fixbcd.bat
del %mainos%\fixbcd.bat >nul
pause

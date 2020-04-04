@echo off
cd /D "%~dp0"
:CheckDrivers
IF EXIST .\Drivers\README.md (
	TITLE ERROR!
	COLOR 0C
	ECHO.
	ECHO  Please run Clean.bat to clean old drivers or move old drivers to other folder.
	PAUSE
	EXIT
)
:ChooseDev
mode con: cols=96 lines=24
cls
echo ////////////////////////////////////////////////////////////////////////////////////////////////
echo //                                WFAv7 Driver Downloader 1.2                                 //
echo //                                    by RedGreenBlue123                                      //
echo ////////////////////////////////////////////////////////////////////////////////////////////////
echo.
echo Choose your Device Model below:
echo  1) Lumia 930
echo  2) Lumia Icon
echo  3) Lumia 1520
echo  4) Lumia 1520 AT^&T
echo  5) Lumia 830 Global
echo  6) Lumia 735 Global
echo  7) Lumia 640 XL LTE Global
echo  8) Lumia 640 XL LTE AT^&T
echo  A) Lumia 650 [experimental only]
echo  B) Lumia 920 [experimental only]
echo  C) Lumia 1020 [experimental only]
set /p Model=Device: 
if "%model%"=="" goto ChooseDev
if %model%==1 "%~dp0\Files\DownloaderFiles\martini.bat"
if %model%==2 "%~dp0\Files\DownloaderFiles\vanquish.bat"
if %model%==3 "%~dp0\Files\DownloaderFiles\bandit.bat"
if %model%==4 "%~dp0\Files\DownloaderFiles\bandit_atat.bat"
if %model%==5 "%~dp0\Files\DownloaderFiles\tesla.bat"
if %model%==6 "%~dp0\Files\DownloaderFiles\superman.bat"
if %model%==7 "%~dp0\Files\DownloaderFiles\makepeace.bat"
if %model%==8 "%~dp0\Files\DownloaderFiles\makepeace_atat.bat"
if %model%==A "%~dp0\Files\DownloaderFiles\saana.bat"
if %model%==B "%~dp0\Files\DownloaderFiles\phi.bat"
if %model%==C "%~dp0\Files\DownloaderFiles\eos_atat.bat"
if %model%==a "%~dp0\Files\DownloaderFiles\saana.bat"
if %model%==b "%~dp0\Files\DownloaderFiles\phi.bat"
if %model%==c "%~dp0\Files\DownloaderFiles\eos_atat.bat"
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
if not %model%==a goto ChooseDev
if not %model%==b goto ChooseDev
if not %model%==c goto ChooseDev
echo Downloading Drivers Done!
pause

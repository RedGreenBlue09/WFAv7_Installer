
ABOUT THIS SOFTWARE:
 Windows 10 for ARMv7 Installer (VHDX)
 Type    : Batch script
 Made by : RedGreenBlue123
 Version : 2.0 (R2)

DISCLAIMER:
    * I'm not responsible for bricked devices, dead SD cards,
      thermonuclear war, or you getting fired because the alarm app failed (like it did for me...).
    * YOU are choosing to make these modifications,
      and if you point the finger at me for messing up your device, I will laugh at you.
    * Your warranty will be void if you tamper with any part of your device / software.

SUPPORTED DEVICES:
    - NOKIA Lumia 930
    - NOKIA Lumia Icon
    - NOKIA Lumia 1520 (Global, AT&T)
    - NOKIA Lumia 830 Global
    - NOKIA Lumia 735 Global
    - Microsoft Lumia 640 XL LTE (Global, AT&T)
    - Microsoft Lumia 950 & XL
    - NOKIA Lumia 640 [No Touch]
    - Microsoft Lumia 535 [No Touch]
    * You can use 735 Drivers for 730 but you will face a few problems.
REQUIREMENTS:
    - Full Windows 8.1+ Pro or Enterprise
    - Windows Powershell Enabled
    - Windows Powershell Modules Installed
      (Don't care about this if you have a full installation of Windows 10)
    - Microsoft Hyper-V Enabled (VT-x is not needed, just enable that feature)
    - 3 GB of storage
    - Windows Phone installed in your Lumia
    - A few brain cells (VERY IMPORTANT)

INSTRUCTION:
    1. Download Windows 10 for ARMv7 build 15035 to your Computer.
    2. Extract Win10.7z\sources\install.wim  to  Installer folder.
    3. Run Driver Downloader and download Drivers for your device.
    4. Run Installer.bat and follow the Instruction in the installer.
    5. After installation finished, boot and setup Windows 10.
       Don't connect to Wi-Fi on setup. It will makes the setup stuck.
    6. After setup complete (Desktop appears), reboot to mass storage mode.
    7. Run PostInstall.bat to fix Windows Phone crash.
    8. Now, you can dualboot Windows Phone and Windows 10.

NOTES:
    * This is not a software, this is a set of programs that combined to make the installation easier.
    * Editing the files or folders may cause damage to the intaller.
    * If you use Reset Phone feature on Windows Phone, it will delete Windows 10 for ARMv7.
    * UPDATE WINDOWS PHONE WILL BREAK WINDOWS 10'S BOOT OR IT MAY BRICK YOUR PHONE.
      If you accidentally updated, reboot to mass storage mode,
      run Tools.bat and choose Fix Update tool to fix BCD (not tested).

DOWNLOADS:
    - Windows 10 for ARMv7  : https://bit.ly/33ap8dq
      Thanks to @driver1998 (Image owner) and @FadilFadz (link).
    - Drivers: Run Driver Downloader to feltch drivers for your device automatically.
      Thanks to @Gus33000
    - To download Installer: go to Releases page, click assets, download latest build.

THANKS TO:
    - fadilfadz01 (Fadil Fadz)     : Helping me write the script
    - Gus33000 (Gustave Monce)     : Making Drivers & explain me Drivers
    - Heathcliff74 (Rene Lergner)  : WPinternals
    - driver1998                   : Windows 10 For ARMv7 Image
    - Windows ARM32 Telegram group : Testing my script
    - Stack Overflow Community     : Helping me write the script
    - Microsoft                    : Command Prompt, Windows, Dism, Bcdedit, PowerShell, ...
    - SmartSVN                     : SVN
    - Igor Pavlov                  : 7-Zip
    - GNU                          : WGET
    - RedGreenBlue123 (Me)         : Writing the script
    - Adoxa                        : Ansicon

CHANGELOGS:
 - Release 1.0 (R1)
   + Code optimization (Preview 1 & 2)
   + Correct some spelling mistakes & hard to understand sentences (Preview 1)
   + 2X Faster & More accurate Powershell cmdlets check (Preview 1)
   + Verbose compatibility check (Preview 1)
   + Fixed a lot of bugs in PR 3.9 (Preview 1)
   + Fixed Installer crashes at the end of installation. (Preview 2)
   + Fixed Installer & Driver Downloader crashes when user enters: & ; ^ > < , | (Preview 1 & 3)
   + Renamed Installer from Bat to Cmd for correct Errorlevel check (Preview 1)
   + Reduced Installer & Driver Downloader size (Preview 3)
   + Use exit from batch instead of exit cmd (Final)
   + Minor changes
  *KNOWN ISSUES:
   + Installer & Driver Downloader crashes when user enter "
   - Try and tell me :)
 - Proximal Release 3.8 & 3.9 (PR3.8 & 3.9)
   + Added Windows build check
   + Bring up colors for Windows 8.1 (Thanks to @adoxa for "ansicon")
   + Installer only has one version for both Windows 8.1 and 10 now
   + Installer now starts 5X faster than PR 3.7
   + Installation will be cancelled if a severe issue ocurred during installation
   + Improved UI a lot
   + Improved Logs
   + Powershell cmdlets now return errorlevel 1 if error occurred
   + Use Expand-WindowsImage instead of DISM for progress bar
   + Number of errors will be appears at the end of installation
   + Added Safe Mode enabler / disabler for WFAv7 (Tools)
   + Added option to run Installer without compatibility check (Tools)
   + Fixed SetLocal error when download too much drivers (Driver Downloader)
   + Use SVN Export instead of SVN Checkout (Driver Downloader)
   + PR 3.9 fixes "Installation always failed" in PR 3.8
   + Block 8.1 users from installing WFAv7 to 8 GB devices to fix compact errors.
   + Check for Drivers and install.wim after select model for more accurate result.
   + Minor Code cleanup
   + Misc improvements & fixes
 - Proximal Release 3.6 and 3.7 (PR3.6 & 3.7)
   + Better UI
   + Added Logging
   + Added Mount VHDX to PostInstall
   + Change some colors
   + Remove Lumia 650 in Driver Downloader
   + Updated DriverDownloader and Installer to use new driver repo structure
   + DriverDownloader now parse definition files provided every driver repo update
   + Fixed WFAv7 Uninstaller MainOS!\EFIESP\efi\Microsoft\Recovery\BCD not found
 - Proximal Release 3.5 (PR3.5)
   + Fixed could not find diskpart.txt
   + Fixed Powershell pattern... when press enter at MainOS partition
   + Fixed console size error if console width smaller than 96
   + Added support for Lumia 950 & XL
   + Added colors to Installer & Other scripts (Windows 10 Only)
   + Installer now has Windows 8.1 and 10 version
   + Misc changes
 - Proximal Release 3 (PR3)
   + Fixed PostInstall not enabling WP boot (PR2.1)
   + Fixed severe Installer exit issue from 2.1 (PR2.3)
   + Fixed choice in Tools.bat (PR2.3)
   + Fixed title shows Beta 3
   + Fixed Installer crashes when setting up ESP & in PostInstall.bat
   + Fixed console changed to Raster Font when run Powershell commands
   + Changed window resize method to Powershell: Enable scroll bar
   + Changed format method from Powershell & Diskpart to Format command (PR2.3)
   + Force MainOS must be 2 characters (Allow E:, F:, etc and error on E:\, etc)
   + Minimized Driver Downloader size & make it easy for edit
   + Restored CompactOS (PR2.3)
   + Check for drives mounted that only visible to normal user, not exist in Admin
   + Many more fixes ...
 - Proximal Release 2 (PR2)
   + Fixed severe Installer exit issues (PR1.2 & PR1.3)
   + Fixed severe Downloader crash issue (PR1.1)
   + Fixed Installer create 4 GB VHDX on Lumia 830
   + Fixed Clean.bat diskpart.txt errors
   + Fixed Clean.bat choice loop
   + Introduce VHDX Mounter and Unmounter
   + Use DiskPart method to format partition as compressed for 8 GB devices
   + Remove support for Lumia 650 until drivers completed
   + Auto mount EFIESP to Windows 10 for ARMv7 partition (PostInstall.bat)
   + Improved PostInstall.bat
   + Bundle Clean.bat, Uninstaller.bat, FixUpdate.bat, VHDX Mounter into Tools.bat
 - Proximal Release 1 (PR1)
   + Rewrite Installer to 1 file
   + Rewrite Downloader to 1 file
   + Fixed 2nd time downloading drivers without reopen downloader failed
   + Fixed "Parameter is incorrect" in PostInstall.bat
   + Added "All Drivers" option in Driver Downloader with auto extract
   + Added Title to Driver Downloader
   + Added Colors to Driver Downloader
   + Added Credits section in README.TXT
   + Minimize downloader binaries
   + A lot more ...
 - Beta 3 (B3)
   + Support for Spec A devices has dropped due to unsupported hardware.
   + Introduce Uninstaller
   + Minor fixes
 - Beta 2 (B2)
   + Added NTFS Compression and Compact OS for 8 GB devices.
   + Mount EFIESP to Windows 10 Partition to get battery percentage.
   + Introduce Driver Downloader.
   + Introduce Clean.bat.
   + Rename FixESP.bat to PostInstall.bat
   + Changed Changelogs section of README.TXT to have descending version order.
   + Fixed touch not working on 640 XL LTE.
 - Beta 1 (B1)
   * Gus33000 changed driver repos to the new repo that has different layout.
   + Update Installer to match the new repo.
   + Added support for Lumia 650 (experimental)
   + Added FixESP.bat
   + Fixed Installer crashes when you didn't choose any device and press enter.
   + Fixed BSOD on Lumia Icon.
   + Fixed Error on OOBE.
   + Changed BCD setting method.
 - Alpha 3 (A3)
   + Introduce FixUpdate script.
   + Improved requirements check at startup.
   + Loop when MainOS is not valid.
   + Added Mass Storage Mode UI (thanks to @Gus33000).
   + Added more notes.
 - Alpha 2 (A2)
   + Fixed Windows 10 does not boot.
   + Fixed Drivers not found error.
   + Fixed batch doesn't works in dir contains space.
   + Fixed Credit name.
   + Introduce CHANGELOG in README.TXT
   + Automatic Change CMD buffer.
   + Added Support for Lumia 1520 (16GB)
   + Added Support for Snapdragon 400 Spec B Devices.
 - Alpha 1 (A1)
   + Introduce Installer.bat.
   + Introduce README.TXT
   + Added support for Lumia 1520 & AT&T Variation.
   + Move Install scripts to Files folder.
   + Fixed Patch BCD error.
   + UI Update.
   + Added UEFI Mass Storage Mode status images.

    ////////////////////////////////////////////////////////////////////////////////////////////////
    //                         Windows 10 for ARMv7 Installer (VHDX) PR2                          //
    //                                    by RedGreenBlue123                                      //
    //                       Thanks to: @Gus33000, @FadilFadz01, @demonttl                        //
    ////////////////////////////////////////////////////////////////////////////////////////////////

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
    * No support for Lumia 2520 due to lack of drivers.
    * No support for Spec A devices because these devices don't support VHD boot.
    * Future: Add support for 950 and 950 XL.
    * For 8 GB devices, i recommended use it to test only. If you want Windows 10 for ARMv7,
      Use normal method is better than dual boot on a 8 GB storage.

REQUIREMENTS:
    - Full Windows 10 Pro or Enterprise (Windows 7 not working)
    - Windows Powershell Enabled
    - Windows Powershell Modules Installed
      (Don't care about this if you have a full installation of Windows 8.1+)
    - Microsoft Hyper-V Enabled (VT-x is not needed, just enable that feature)
    - 3 GB of storage
    - Windows Phone installed in your Lumia
    - A few brain cells (VERY IMPORTANT)

INSTRUCTION:
    - Download Windows 10 for ARMv7 build 15035 to your Computer.
    - Extract <ISOFILE>\sources\install.wim  to  Installer folder.
      You can mount it and copy install.wim to Installer folder.
    - Download Drivers for your device.
    - Extract Drivers to <InstallerFolder>\Drivers (NEVER create subfolders or Extract Subfolders)
    - Run Installer.bat and follow the Instruction in the installer.
    - After installation finished, boot and setup Windows 10.
      Don't connect to Wi-Fi on setup. It will makes the setup stuck.
    - After setup complete (Desktop appears), reboot to mass storage mode.
    - Double click MainOS\Data\windows10arm.vhdx
    - Run PostInstall.bat to fix Windows Phone crash.
    - Now, you can dualboot Windows Phone and Windows 10.

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
    - To download GitHub: Click "Clone or Download" button, select "Download ZIP"

CREDITS:
    - fadilfadz01 (Fadil Fadz)     : Helping me write the script
    - Gus33000 (Gustave Monce)     : Making Drivers & explain me Drivers
    - demonttl (John Anderson)     : Explaining WimBoot doesn't work in Windows 10
    - driver1998                   : Windows 10 For ARMv7 Image
    - Windows ARM32 Telegram group : Testing my script
    - Microsoft                    : Command Prompt, Windows, DISM, BCDEDIT, PowerShell, Notepad, ...
    - SmartSVN                     : SVN downloader
    - Igor Pavlov                  : 7-Zip extractor
    - GNU                          : WGET downloader
    - RedGreenBlue123 (Me)         : Writing the script

CHANGELOGS:
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
  *KNOWN ISSUES:
   - Installer crashes when user enter: & ; ^ > < , | " [enter] to the installer.
   - Try and tell me :)
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

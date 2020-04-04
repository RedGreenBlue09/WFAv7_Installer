    ////////////////////////////////////////////////////////////////////////////////////////////////
    //                         Windows 10 for ARMv7 Installer (VHDX) B3                           //
    //                                    by RedGreenBlue123                                      //
    //           Thanks to @Heathcliff74, @driver1998, @Gus33000, @FadilFadz, @Gus33000           //
    ////////////////////////////////////////////////////////////////////////////////////////////////

DISCLAIMER:
    * I'm not responsible for bricked devices, dead SD cards,
      thermonuclear war, or you getting fired because the alarm app failed (like it did for me...).
    * YOU are choosing to make these modifications,
      and if you point the finger at me for messing up your device, I will laugh at you.
    * Your warranty will be void if you tamper with any part of your device / software.

CURRENT SUPPORTED DEVICES:
    - NOKIA Lumia 930
    - NOKIA Lumia Icon
    - NOKIA Lumia 1520 (Global, AT&T)
    - NOKIA Lumia 830 Global
    - NOKIA Lumia 735 Global
    - Microsoft Lumia 640 XL LTE (Global, AT&T)
    * No support for Lumia 2520 due to lack of drivers.
    * No support for Spec A devices because these devices don't support VHD boot.
    * Future: Add support for other devices.
    * For 8 GB devices, i recommended use it to test only. If you want WOA,
      Use normal method is better than dual boot on a 8 GB storage.

REQUIREMENTS:
    - Full Windows 10 Pro or Enterprise
    - Windows Powershell Enabled
    - Windows Powershell Modules Installed 
      (Don't care about this if you have a full installation of Windows 10)
    - Microsoft Hyper-V Enabled (VT-x is not needed, just enable that feature)
    - 3 GB of storage
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
    * UPDATE WINDOWS PHONE WILL BREAK WINDOWS 10'S BOOT OR IT MAY BRICK YOUR PHONE.
      If you accidentally updated, reboot to mass storage mode,
      run FixUpdate.bat to fix BCD (not tested).
    * If you use Reset Phone feature on Windows Phone, it will delete Windows 10 for ARMv7.

DOWNLOADS:
    - Windows 10 for ARMv7  : https://bit.ly/33ap8dq
      Thanks to @driver1998 (Image owner) and @FadilFadz (link).
    - Drivers: Run Driver Downloader to feltch drivers for your device automatically.
      Or download it from here (Extra space and data): https://github.com/WOA-Project/Lumia-Drivers
      Thanks to @Gus33000
    - To download GitHub: Click "Clone or Download" button, select "Download ZIP"

CHANGELOGS:
 - Beta 3 (B3)
   + Support for Spec A devices has dropped due to unsupported hardware.
   + Introduce Uninstaller
   + Minor fixes
  *KNOWN ISSUES:
   - Installer crashes when user enter: & ; ^ > < , | " [enter] to the installer.
   - Try and tell me :)
 - Beta 2 (B2)
   + Added NTFS Compression and Compact OS for 8 GB devices.
   + Mount EFIESP to Windows 10 Partition to get battery percentage.
   + Introduce Driver Downloader.
   + Introduce Clean.bat.
   + Rename FixESP.bat to PostInstall.bat
   + Changed Changelogs section of README.TXT to have descending version order.
   + Fixed touch not working on 640 XL LTE.
 - Beta 1 (B1)
  *Gus33000 changed driver repos to the new repo that has different layout.
   + Update Installer to match the new repo.
   + Added support for Lumia 650 (experimental)
   + Added FixESP.bat
   + Fixed Installer crashes when you didn't choose any device and press enter.
   + Fixed BSOD on Lumia Icon.
   + Fixed Error on OOBE.
   + Changed BCD setting method.
  *KNOWN ISSUES:
   - Touch not working on 640 XL LTE.
 - Alpha 3 (A3)
   + Introduce FixUpdate script.
   + Improved requirements check at startup.
   + Loop when MainOS is not valid.
   + Added Mass Storage Mode UI (thanks to @Gus33000).
   + Added more notes.
  *KNOWN ISSUES:
   - Installer crashes when you didn't choose any device and press enter. (Stupid Fix)
   - BSOD on Lumia Icon.
   - Error on OOBE.
 - Alpha 2 (A2)
   + Fixed Windows 10 does not boot.
   + Fixed Drivers not found error.
   + Fixed batch doesn't works in dir contains space.
   + Fixed Credit name.
   + Introduce CHANGELOG in README.TXT
   + Automatic Change CMD buffer.
   + Added Support for Lumia 1520 (16GB)
   + Added Support for Snapdragon 400 Spec B Devices.
     Lumia 730 Dual SIM is not supported due to lack of drivers.
  *KNOWN ISSUES:
   - Installer crashes when you didn't choose any device and press enter.
   - BSOD on Lumia Icon.
 - Alpha 1 (A1)
   + Introduce Installer.bat.
   + Introduce README.TXT
   + Added support for Lumia 1520 & AT&T Variation.
   + Move Install scripts to Files folder.
   + Fixed Patch BCD error.
   + UI Update.
   + Added UEFI Mass Storage Mode status images.
  *KNOWN ISSUES:
   - Windows 10 does not boot when press power up.
   - Driver not found error.
   - Batch does not work in dir contains space.
   - BSOD on Lumia Icon.

    /////////////////////////////////////////////////////////////////////////
    //               Windows 10 for ARMv7 Installer (VHDX) B1              //
    //                         by RedGreenBlue123                          //
    //    Thanks to @Heathcliff74, @driver1998, @Gus33000, @Fadil Fadz     //
    /////////////////////////////////////////////////////////////////////////

DISCLAIMER:
    * I'm not responsible for bricked devices, dead SD cards,
      thermonuclear war, or you getting fired because the alarm app failed (like it did for me...).
    * YOU are choosing to make these modifications,
      and if you point the finger at me for messing up your device, I will laugh at you.
    * Your warranty will be void if you tamper with any part of your device / software.

CURRENT SUPPORTED DEVICES:
    * NOKIA Lumia 930
    * NOKIA Lumia Icon
    * NOKIA Lumia 1520 (Global, AT&T)
    * NOKIA Lumia 830 Global
    * NOKIA Lumia 735 Global
    * Microsoft Lumia 640 XL LTE (Global, AT&T)
    - No support for Lumia 2520 due to lack of drivers.
    - Future: Add support for other Bootloader Spec A Devices. (I don't have any)

REQUIREMENTS:
    * Windows 10 (Win 7 and 8.1 is not tested. Try and tell me)
    * Windows Powershell Enabled
    * Windows Powershell Modules Installed 
      (Don't care about this if you have a full installation of Windows 10)
    * Microsoft Hyper-V Enabled (VT-x is not needed, just enable that feature)
    * A few brain cells (VERY IMPORTANT)

INSTRUCTION:
    - Download Windows 10 for ARMv7 build 15035 to your Computer.
    - Extract <ISOFILE>\sources\install.wim  to  Installer folder.
      You can mount it and copy install.wim to Installer folder
    - Download Drivers for your device
    - Extract Drivers to <InstallerFolder>\Drivers (NEVER create subfolders or Extract Subfolders)
    - Run Installer.BAT and follow the Instruction in the installer.
    - After installation finished, boot and setup Windows 10.
    - After setup complete (Desktop appears), reboot to mass storage mode.
    - Run FixESP.BAT to fix Windows Phone crash.
    - Now, you can dualboot Windows Phone and Windows 10.
    * UPDATE YOUR PHONE WILL BREAK WINDOWS 10'S BOOT. Run FixUpdate to fix.
DOWNLOADS:
    - Windows 10 for ARMv7  : https://bit.ly/33ap8dq
      Thanks to @driver1998 (Image owner) and @Fadil Fadz (link).
    - Drivers               : https://github.com/WOA-Project/Lumia-Drivers
      Thanks to @Gus33000
    - To download GitHub: Click "Clone or Download" button, select "Download ZIP"
:===============[ Alpha (A) --> Beta (B) --> Proximal Release (PR) --> Release 1.0 ]===============:
CHANGELOG:
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
   - Try and tell me :)
 - Beta 1 (B1)
  *Gus33000 changed driver repos to the new repo that has different layout.
   + Update Installer to match the new repo.
   + Added support for Lumia 650 (experimental)
   + Fixed Installer crashes when you didn't choose any device and press enter.
   + Fixed BSOD on Lumia Icon.
   + Fixed Error on OOBE.
   + Changed BCD setting method.

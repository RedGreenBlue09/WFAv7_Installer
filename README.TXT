    /////////////////////////////////////////////////////////////////////////
    //               Windows 10 for ARMv7 Installer (VHDX) A2              //
    //                         by RedGreenBlue123                          //
    //    Thanks to @Heathcliff74, @driver1998, @Gus33000, @Fadil Fadz     //
    /////////////////////////////////////////////////////////////////////////

DISCLAIMER:
    * I'm not responsible for bricked devices, dead SD cards,
      thermonuclear war, or you getting fired because the alarm app failed (like it did for me...).
    * YOU are choosing to make these modifications,
      and if you point the finger at me for messing up your device, I will laugh at you.
    * Your warranty will be void if you tamper with any part of your device / software.

REQUIREMENTS:
    * Microsoft Windows 10 (Win 7 and 8.1 is not tested. Try and tell me)
    * Windows Powershell Enabled
    * Windows Powershell Modules Installed 
      (Don't care about this if you have a full installation of Windows 10)
    * Microsoft Hyper-V Enabled (VT-x is not needed, just enable that feature)

CURRENT SUPPORTED DEVICES:
    * NOKIA Lumia 930
    * NOKIA Lumia Icon (929)
    * NOKIA Lumia 1520
    * NOKIA Lumia 1520 AT&T
 - No support for Lumia 2520 due to lack of drivers.
 - Future: Add support for Lumia 640 and other Bootloader Spec B Devices.

INSTRUCTION:
 - Download Windows 10 for ARMv7 build 15035 to your Computer.
 - Extract <ISOFILE>\sources\install.wim  to  Installer folder.
   You can mount it and copy install.wim to Installer folder
 - Download Drivers for your device
 - Extract Drivers to <InstallerFolder>\Drivers (NEVER create subfolders or Extract Subfolders)
 - Run Installer.bat and follow the Instruction in the installer.

DOWNLOADS:
 - Windows 10 for ARMv7            : https://bit.ly/33ap8dq
   Thanks to @driver1998 (Image owner) and @Fadil Fadz (link).
 - Drivers:
   A)Lumia 929, 930 & 1520         : https://github.com/gus33000/Copper-Drivers
   B)Lumia 1020 & Lumia 920        : https://github.com/gus33000/MSM8x60-NT-ARM-Drivers
   C)Lumia 830, 735 & 640XL        : https://github.com/gus33000/MSM8x26-NT-ARM-Drivers
   Thanks to @Gus33000 for these drivers.
 - To download GitHub: Click "Clone or Download" button, select "Download ZIP"
:===============[ Alpla (A) --> Beta (B) --> Proximal Release (PR) --> Release 1.0 ]===============:
CHANGELOG:
 - Alpha 1 (A1):
   + Introduce Installer.bat.
   + Introduce README.TXT
   + Added support for Lumia 1520 & AT&T Variation.
   + Move Install script to Files folder.
   + Fixed Patch BCD error.
   + UI Update.
   + Added UEFI Mass Storage Mode status images.
  *KNOWN ISSUES:
   - Windows 10 does not boot when press power up.
   - Driver not found error.
   - Batch does not work in dir contains space.
 - Alpla 2 (A2)
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
   - Installer crashes when you didn't choose any device and press enter
   - Try and tell me :)

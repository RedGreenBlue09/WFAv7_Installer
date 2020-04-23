# Windows 10 for ARMv7 Installer (VHDX) PR3
![alt text](https://github.com/RedGreenBlue09/Assets/raw/master/WFAv7-1.JPG "WFAv7")
### Disclaimer
    * I'm not responsible for bricked devices, dead SD cards,
      thermonuclear war, or you getting fired because the alarm app failed (like it did for me...).
    * YOU are choosing to make these modifications,
      and if you point the finger at me for messing up your device, I will laugh at you.
    * Your warranty will be void if you tamper with any part of your device / software.
### Supported Devices
  - NOKIA Lumia 930
  - NOKIA Lumia Icon
  - NOKIA Lumia 1520 (Global, AT&T)
  - NOKIA Lumia 830 Global
  - NOKIA Lumia 735 Global
  - Microsoft Lumia 640 XL LTE (Global, AT&T)
  - Microsoft Lumia 950 & XL
  - Notes:
    * No support for Lumia 2520 due to lack of drivers.
    * No support for Spec A devices because these devices don't support VHD boot.
    * Future: Add support for 950 and 950 XL.
    * For 8 GB devices, i recommended use it to test only. If you want Windows 10 for ARMv7,
      Use normal method is better than dual boot on a 8 GB storage.
### Requirements
  - Full Windows 10 Pro or Enterprise (Windows 7 not working)
  - Windows Powershell Enabled
  - Windows Powershell Modules Installed
    (Don't care about this if you have a full installation of Windows 8.1+)
  - Microsoft Hyper-V Enabled (VT-x is not needed, just enable that feature)
  - 3 GB of storage
  - Windows Phone installed in your Lumia
  - A few brain cells (VERY IMPORTANT)
### Instruction
  1. Download Windows 10 for ARMv7 build 15035 to your Computer.
  2. Extract <ISOFILE>\sources\install.wim  to  Installer folder.
     You can mount it and copy install.wim to Installer folder.
  3. Download Drivers for your device.
  4. Extract Drivers to <InstallerFolder>\Drivers (NEVER create subfolders or Extract Subfolders)
  5. Run Installer.bat and follow the Instruction in the installer.
  6. After installation finished, boot and setup Windows 10.
     Don't connect to Wi-Fi on setup. It will makes the setup stuck.
  7. After setup complete (Desktop appears), reboot to mass storage mode.
  8. Double click MainOS\Data\windows10arm.vhdx
  9. Run PostInstall.bat to fix Windows Phone crash.
  10. Now, you can dualboot Windows Phone and Windows 10.
### Notes
  * This is not a software, this is a set of programs that combined to make the installation easier.
  * Editing the files or folders may cause damage to the intaller.
  * If you use Reset Phone feature on Windows Phone, it will delete Windows 10 for ARMv7.
  * UPDATE WINDOWS PHONE WILL BREAK WINDOWS 10'S BOOT OR IT MAY BRICK YOUR PHONE.
    If you accidentally updated, reboot to mass storage mode,
    run Tools.bat and choose Fix Update tool to fix BCD (not tested).
### Downloads
  - Windows 10 for ARMv7  : https://bit.ly/33ap8dq
    .Thanks to @driver1998 (Image owner) and @FadilFadz (link).
  - Drivers: Run Driver Downloader to feltch drivers for your device automatically.
    .Thanks to @Gus33000
  - To download GitHub: Click "Clone or Download" button, select "Download ZIP"
### Credits
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
### Screenshots
![alt text](https://github.com/RedGreenBlue09/Assets/raw/master/WFAv7-1.JPG "WFAv7-S1")
![alt text](https://github.com/RedGreenBlue09/Assets/raw/master/WFAv7-2.JPG "WFAv7-S2")
![alt text](https://github.com/RedGreenBlue09/Assets/raw/master/WFAv7-3.JPG "WFAv7-DD")
![alt text](https://github.com/RedGreenBlue09/Assets/raw/master/WFAv7-4.JPG "WFAv7-TL")
### Changelogs
  - Changelogs included in README.TXT

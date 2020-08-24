# Windows 10 for ARMv7 Installer 2.0
![alt text](https://github.com/RedGreenBlue09/Assets/raw/master/WFAv7-1.BMP "WFAv7")
### Disclaimer
    * I'm not responsible for bricked devices, dead SD cards,
      thermonuclear war, or you getting fired because the alarm app failed (like it did for me...).
    * YOU are choosing to make these modifications,
      and if you point the finger at me for messing up your device, I will laugh at you.
    * Your warranty will be void if you tamper with any part of your device / software.
### Supported Devices
  - Nokia Lumia 930
  - Nokia Lumia Icon
  - Nokia Lumia 1520 (Global, AT&T)
  - Nokia Lumia 830 Global
  - Nokia Lumia 735 Global
  - Microsoft Lumia 640 XL LTE (Global, AT&T)
  - Microsoft Lumia 950 & XL
  - Nokia Lumia 1020 (AT&T)
  - Nokia Lumia 920
  - Notes:
	* Drivers for Lumia 1020 have been known to be not working.
    * For 8 GB devices, i recommended use it to test only. If you want Windows 10 for ARMv7,
      Use normal method is better than dual boot on a 8 GB storage.
### Requirements
  - Windows 8.1+ (Non-customized)
  - Windows Powershell Enabled.
  - 3 GB of empty computer storage.
  - Windows Phone 8.1 or Windows 10 Mobile (1607 or older) installed in your Lumia.
  - 8 GB of empty phone storage for 16 GB Spec B Lumias.
  - 16 GB of empty phone storage for 32 GB Spec B Lumias.
  - 8 GB of empty phone storage for 920 and 1020.
  - A few brain cells (VERY IMPORTANT)
  * More information in the Installer.
### Instruction
  1. Download Windows 10 for ARMv7 build 15035 to your computer.
  2. Extract Win10.7z\sources\install.wim  to  Installer folder.
  3. Run Driver Downloader and download Drivers for your device.
  4. Unlock bootloader and boot into Mass Storage Mode (see WPinternals.net)
  5. Run Installer and follow the Instruction in the installer.
  6. After installation finished, boot and setup Windows 10.
     Don't connect to Wi-Fi on setup. It will makes the setup stuck.
  7. When setup completes (Desktop appears), reboot to Mass Storage Mode.
  8. Run PostInstall.bat to fix Windows Phone crash.
  9. Now, you can dualboot Windows Phone and Windows 10.
### Notes
  * This is not a software, this is a set of programs that combined to make the installation easier.
  * Editing the files or folders may cause damage to the intaller.
  * On Spec A devices, using Reset Phone feature on Windows Phone will delete Windows 10 for ARMv7.
  * UPDATING WINDOWS PHONE WILL BREAK WINDOWS 10'S BOOT OR IT MAY BRICK YOUR PHONE.
### Downloads
  - Windows 10 for ARMv7  : https://bit.ly/33ap8dq
    . Thanks to @driver1998 (Image owner) and @FadilFadz (link).
  - Drivers: Run Driver Downloader to feltch drivers for your device automatically
    . Thanks to @Gus33000
  - WFAv7 Installer: [GitHub Releases](https://github.com/RedGreenBlue09/WFAv7_Installer/releases)
  * Don't download using Download ZIP selection.
### Credits
  - fadilfadz01 (Fadil Fadz)     : Helping me write the script
  - Gus33000 (Gustave Monce)     : Making Drivers & explain me Drivers
  - Heathcliff74 (Rene Lergner)  : WPinternals
  - driver1998                   : Windows 10 For ARMv7 Image
  - Windows ARM32 Telegram group : Testing my script
  - Stack Overflow Community     : Helping me write the script
  - Microsoft                    : Command Prompt, Windows, Dism, Bcdedit, PowerShell, ...
  - SmartSVN                     : SVN
  - Igor Pavlov                  : 7-Zip
  - GNU                          : WGET, GREP
  - RedGreenBlue123 (Me)         : Writing the script
  - Adoxa                        : Ansicon
  - Wimlib                       : Wimlib-ImageX
  - Jnewbigin                    : RawWrite dd for Windows
  - Dariusz Stanislawek          : DSFO
### Screenshots
![alt text](https://github.com/RedGreenBlue09/Assets/raw/master/WFAv7-1.BMP "WFAv7-S1")
![alt text](https://github.com/RedGreenBlue09/Assets/raw/master/WFAv7-2.BMP "WFAv7-S2")
![alt text](https://github.com/RedGreenBlue09/Assets/raw/master/WFAv7-3.BMP "WFAv7-DD")
![alt text](https://github.com/RedGreenBlue09/Assets/raw/master/WFAv7-4.BMP "WFAv7-TL")
### Changelogs
  - Changelogs included in README.TXT

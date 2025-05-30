# Windows 10 for ARMv7 Installer
![1](https://github.com/RedGreenBlue09/WFAv7_Installer/assets/59783856/c22aa1d2-8790-4142-a018-c3eee25076d2 "Disclaimer screen")

## Disclaimer

	* I'm not responsible for bricked devices, dead SD cards,
	  thermonuclear war, or you getting fired because the alarm app failed (like it did for me...).
	* YOU are choosing to make these modifications,
	  and if you point the finger at me for messing up your device, I will laugh at you.
	* Your warranty will be void if you tamper with any part of your device / software.
	
	* This is not a software, this is a set of programs that combined to make the installation easier.
	* Editing the files or folders may cause damage to the intaller.
	
## Supported Devices

- Nokia Lumia 1520 (Global, AT&T)
- Nokia Lumia 930
- Nokia Lumia Icon
- Nokia Lumia 830 Global
- Nokia Lumia 735 Global
- Microsoft Lumia 650
- Microsoft Lumia 640 & 640 XL
- Microsoft Lumia 550 - [3.3 Beta 2](https://github.com/RedGreenBlue09/WFAv7_Installer/releases/tag/3.3-beta2)
- Nokia Lumia 1020 (Global, AT&T)
- Nokia Lumia 920
- ~~Nokia Lumia 520~~ (Have a major issue at the moment)
- Experimental support for other devices has been added in [3.3 Beta 1](https://github.com/RedGreenBlue09/WFAv7_Installer/releases/tag/3.3-beta1)

### Unsupported devices

- Nokia Lumia 2520 (can't unlock the bootloader)
- Nokia Lumia 928 (can't boot to mass storage mode)
- Nokia Lumia 810 (can't unlock the bootloader)
- Microsoft Lumia 535 (boots but touch driver doesn't work)
- Nokia Lumia 530 (4 GB of internal storage is too small)
- Nokia Lumia 430 (boots but touch driver doesn't work)
- Windows Phone 7 devices (incompatible bootloader)

**Windows 10 Mobile**: Builds newer than `14393.x` are not supported.

## Prerequisite (on your PC)

- Official Windows 8 (build 9200) or newer   
- Windows Powershell enabled
- WPinternals 2.9 or newer - [Download](https://github.com/ReneLergner/WPinternals/releases/latest)
- Win32 Disk Imager - [Download](https://sourceforge.net/projects/win32diskimager/)
- Microsoft Visual C++ Redistributable 2022 (x86) installed - [Download](https://aka.ms/vs/17/release/vc_redist.x86.exe)
- Windows 10 ARM build 15035 - [Download](https://bit.ly/33ap8dq)

## Download

For latest stable version, go to `Releases` section.  
For latest development version, use the green `Code` button, `Download ZIP`.
 
## Instruction

1. From the **Windows 10 ARM** 7z file:
   Extract `sources\install.wim` to the same folder as Installer.cmd.  
   Note: Just extract the file, not it's content.
2. Download drivers for your device with **Driver Downloader**.
3. Unlock bootloader and boot into Mass Storage Mode with **WPinternals**.
4. Backup the phone with **Win32 Disk Imager** (Only if not already did).
5. Run Installer and follow the instruction in the Installer.
6. Visit the [Wiki](https://github.com/RedGreenBlue09/WFAv7_Installer/wiki/Apps-on-Windows-10-ARM) for usage tips.

## Notes

- On Spec A devices, using Reset My Phone will remove Windows 10 ARM.
- **Updating Windows Phone with unlocked bootloader will break your installation.**
- Join the [Telegram group](https://t.me/lumiaarch32) for more support.

## Reporting issues

Go to [Issues page](https://github.com/RedGreenBlue09/WFAv7_Installer/issues), check if your issue is already reported.  
If not, open an issue ticket providing detailed information and logs.

## License

Some script files are licensed under the Microsoft Reciprocal License (MS-RL).  
If you wish to redistribute such files without `LICENSE-SCRIPTS.txt`, you should add the license's content into it.

## Thanks to
	
	RedGreenBlue09 (Me)          : Author of this script
	gus33000 (Gustave Monce)     : The main contributor to WOA-Project
    WOA-Project                  : Inf drivers
	Windows ARM32 Telegram group : Testing my script
	bibarub                      : Downstream driver repository
	fadilfadz01 (Fadil Fadz)     : Helping me write the script

## External softwares included

| Software       | Author                      | Version                   | Link |
|----------------|-----------------------------|---------------------------|------|
| ansicon        | adoxa (Jason Hood)          | 1.89                      | [GitHub](https://github.com/adoxa/ansicon/releases/tag/v1.89) |
| bcdedit        | Microsoft Corporation       | 10.0.18362.1              | from Windows 10 |
| busybox        | rmyorston (Ron Yorston)     | 1.37.0.5398               | [GitHub](https://github.com/rmyorston/busybox-w32/tree/FRP-5398-g89ae34445) |
| DISM           | Microsoft Corporation       | 10.0.19041.1              | from Windows ADK |
| DriverDefPaths | RedGreenBlue09              | 0.0.2                     | [Github](https://github.com/RedGreenBlue09/DriverDefPaths/releases/tag/0.0.2) |
| dsfo           | Dariusz Stanislawek         | 1.03-CLI                  | [Softpaz](https://www.softpaz.com/software/download-dsfok-windows-7269.htm) |
| Elevate        | RedGreenBlue09              |                           | [Github](https://gist.github.com/RedGreenBlue09/beb75798eac3f7883848dd0a54304a2e) |
| GetDriverFiles | RedGreenBlue09              | 0.2                       | [Github](https://github.com/RedGreenBlue09/GetDriverFiles/releases/tag/0.2) |
| Git            | *(Various)*                 | 2.46.2.2 (MinGit busybox) | [GitHub](https://github.com/git-for-windows/git/releases/tag/v2.46.2.windows.2) |
| VhdxTool       | Systola GmbH                | 2016.8.19                 | [Systola](https://systola.com/support/kb100005) |

## Screenshots

![1](https://github.com/RedGreenBlue09/WFAv7_Installer/assets/59783856/c22aa1d2-8790-4142-a018-c3eee25076d2 "Disclaimer screen")
![2](https://github.com/RedGreenBlue09/WFAv7_Installer/assets/59783856/c3280398-2fb1-4e76-a9f4-ff955f3888ea "Device selection screen")
![3](https://github.com/RedGreenBlue09/WFAv7_Installer/assets/59783856/d291ffc3-2e5a-4bf7-a6c2-1915c63a3941 "Driver Downloader")

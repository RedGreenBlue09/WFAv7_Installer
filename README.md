# Windows 10 for ARMv7 Installer 3.0
![alt text](https://github.com/RedGreenBlue09/Assets/raw/master/WFAv7-1.BMP "WFAv7 Installer")
## Disclaimer

	* I'm not responsible for bricked devices, dead SD cards,
	  thermonuclear war, or you getting fired because the alarm app failed (like it did for me...).
	* YOU are choosing to make these modifications,
	  and if you point the finger at me for messing up your device, I will laugh at you.
	* Your warranty will be void if you tamper with any part of your device / software.
	
	* This is not a software, this is a set of programs that combined to make the installation easier.
	* Editing the files or folders may cause damage to the intaller.
	
## Supported Devices

- Nokia Lumia 930
- Nokia Lumia Icon
- Nokia Lumia 1520 (Global, AT&T)
- Nokia Lumia 830 Global
- Nokia Lumia 735 Global
- Microsoft Lumia 640 XL LTE (Global, AT&T)
- Nokia Lumia 920
- Nokia Lumia 1020 (Global, AT&T)

## Requirements

- Official Windows 8.1 or newer   
- Microsoft Visual C++ Redistributable 2022 (x86) - [Download](https://aka.ms/vs/17/release/vc_redist.x86.exe)
- Windows Powershell enabled
- More requirements in the Installer

## Download

For latest stable version, go to `Releases` section.  
For latest development version, use the green `Code` button, `Download ZIP`.
 
## Instruction

1. Download Windows 10 ARM build 15035 - [Download](https://bit.ly/33ap8dq)
2. Extract `\sources\install.wim` to Installer folder.
3. Run Driver Downloader and download drivers for your device.
4. Unlock bootloader and boot into Mass Storage Mode. See [WPinternals](https://github.com/ReneLergner/WPinternals)
5. Run Installer and follow the instruction in the Installer.

## Notes

- On Spec A devices, using Reset My Phone will remove Windows 10 ARM.
- **Updating Windows Phone with unlocked bootloader will break your installation.**

## Credits

	fadilfadz01 (Fadil Fadz)     : Helping me write the script
	Gus33000 (Gustave Monce)     : Making drivers & lot more
	Heathcliff74 (Rene Lergner)  : WPinternals
	Windows ARM32 Telegram group : Testing my script
	Microsoft                    : Windows and other tools
	TortoiseSVN                  : SVN
	Igor Pavlov                  : 7-Zip
	cURL project                 : cURL
	Aria2 project                : aria2
	Adoxa                        : ansicon
	Wimlib                       : wimlib-imagex
	Dariusz Stanislawek          : dsfo
	Systola                      : VhdxTool
	RedGreenBlue123 (Me)         : Author of this script

## Changelogs

See GitHub commits.

## Screenshots

![alt text](https://github.com/RedGreenBlue09/Assets/raw/master/WFAv7-1.BMP "WFAv7-S1")
![alt text](https://github.com/RedGreenBlue09/Assets/raw/master/WFAv7-2.BMP "WFAv7-S2")
![alt text](https://github.com/RedGreenBlue09/Assets/raw/master/WFAv7-3.BMP "WFAv7-DD")
![alt text](https://github.com/RedGreenBlue09/Assets/raw/master/WFAv7-4.BMP "WFAv7-TL")

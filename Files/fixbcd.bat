@ECHO OFF
SET MainOS="%~d0"
SET bcdLoc="%MainOS%\EFIESP\efi\Microsoft\Boot\BCD"
SET id="{703c511b-98f3-4630-b752-6d177cbfb89c}"

bcdedit /store %bcdLoc% /delete %id% >nul
bcdedit /store %bcdLoc% /create %id% /d "Windows 10 for ARMv7" /application "osloader" >nul
bcdedit /store %bcdLoc% /set %id% "device" "vhd=[%~d0\Data]\windows10arm.vhdx"
bcdedit /store %bcdLoc% /set %id% "osdevice" "vhd=[%~d0\Data]\windows10arm.vhdx"
bcdedit /store %bcdLoc% /set %id% "path" "\windows\system32\winload.efi"
bcdedit /store %bcdLoc% /set %id% "locale" "en-US"
bcdedit /store %bcdLoc% /set %id% "testsigning" yes
bcdedit /store %bcdLoc% /set %id% "inherit" "{bootloadersettings}"
bcdedit /store %bcdLoc% /set %id% "systemroot" "\Windows"
bcdedit /store %bcdLoc% /set %id% "bootmenupolicy" "Standard"
bcdedit /store %bcdLoc% /set %id% "detecthal" Yes
bcdedit /store %bcdLoc% /set %id% "winpe" No
bcdedit /store %bcdLoc% /set %id% "ems" No
bcdedit /store %bcdLoc% /set %id% "bootdebug" No

bcdedit /store %bcdLoc% /set "{bootmgr}" "nointegritychecks" Yes
bcdedit /store %bcdLoc% /set "{bootmgr}" "testsigning" yes
bcdedit /store %bcdLoc% /set "{bootmgr}" "flightsigning" yes
bcdedit /store %bcdLoc% /set "{bootmgr}" "timeout" 3
bcdedit /store %bcdLoc% /set "{bootmgr}" "displaybootmenu" yes
bcdedit /store %bcdLoc% /set "{bootmgr}" "custom:54000001" %id%

bcdedit /store %bcdLoc% /set "{globalsettings}" "nobootuxtext" no
bcdedit /store %bcdLoc% /set "{globalsettings}" "nobootuxprogress" no

ECHO.
ECHO BCD has been fixed!


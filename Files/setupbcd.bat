@echo off
SET bcdVHD="M:\efi\Microsoft\Boot\BCD"
SET idVHD="{f409bbec-62ab-11ea-bc55-0242ac130003}"
bcdedit /store %bcdVHD% /create %idVHD% /d "Windows 10" /application "osloader"
bcdedit /store %bcdVHD% /set %idVHD% "device" partition=N:
bcdedit /store %bcdVHD% /set %idVHD% "osdevice"  partition=N:
bcdedit /store %bcdVHD% /set %idVHD% "path" "\windows\system32\winload.efi"
bcdedit /store %bcdVHD% /set %idVHD% "locale" "en-US"
bcdedit /store %bcdVHD% /set %idVHD% "testsigning" yes
bcdedit /store %bcdVHD% /set %idVHD% "inherit" "{bootloadersettings}"
bcdedit /store %bcdVHD% /set %idVHD% "systemroot" \Windows
bcdedit /store %bcdVHD% /set %idVHD% "bootmenupolicy" Standard
bcdedit /store %bcdVHD% /set %idVHD% "detecthal" Yes
bcdedit /store %bcdVHD% /set %idVHD% "nx" OptIn
bcdedit /store %bcdVHD% /set %idVHD% "bootlog" Yes
bcdedit /store %bcdVHD% /default %idVHD%

ECHO.
ECHO Done!

@echo off

cls
goto :device

######################################################################


:startup

cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo 1- Install         4- Full Unlock
echo 2- Backup          5- Shell
echo 3- Push and Pull   6- Settings
echo .
echo 0- Exit            00-About..
echo.
echo.
set /p S= ? :
if %S%==1 goto :install
if %S%==2 goto :backupc
if %S%==3 goto :sync
if %S%==4 goto :unlock1
if %S%==5 goto :terminal
if %S%==6 goto :setup
if %S%==0 exit
if %S%==0 goto :about
echo Invalid Input? Try again!...
pause
goto :startup


#############Install


:install
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo Installer
echo.
echo 1- Apk       3- Mod/Gapps
echo 2- Rom       4- Root
echo.
echo 0- Go back
echo.
set /p S= ? :
if %S%==1 goto :apk
if %S%==2 goto :rom
if %S%==3 goto :mod
if %S%==4 goto :root
if %S%==0 goto :startup
echo Invalid Input? Try again!...
pause
goto :install


:apk
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo Apk installer
echo.
SET /P APK= Drag your apk file here, then press Enter:
adb install %APK%
pause
goto :startup


:rom
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo Rom Installer
echo.
@adb reboot recovery
SET /P ROM= Drag your zip file here, then press Enter:
@adb reboot recovery
@adb wait-for-device
@adb shell rm -rf /cache/recovery
@adb shell mkdir /cache/recovery
@adb shell "echo -e '--wipe_data' > /cache/recovery/command"
@adb reboot recovery
echo "When screen becomes blank,"
pause
@adb wait-for-device
@adb shell rm -rf /cache/recovery
@adb shell mkdir /cache/recovery
@adb shell "echo -e '--sideload' > /cache/recovery/command"
@adb reboot recovery
@adb wait-for-device
adb sideload %ROM%
echo Phone will apply the update, do not reboot it untit it ends
pause
goto :startup


:mod
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo Mod Installer
echo.
SET /P MOD= Drag your zip file here, then press Enter:
@adb reboot recovery
@adb wait-for-device
@adb shell rm -rf /cache/recovery
@adb shell mkdir /cache/recovery
@adb shell "echo -e '--sideload' > /cache/recovery/command"
@adb reboot recovery
@adb wait-for-device
@adb sideload %MOD%
echo Phone will apply the update, do not reboot it untit it ends
pause
goto :startup

:root
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo Root enabler
echo.
pause
@adb reboot recovery
@adb wait-for-device
@adb shell rm -rf /cache/recovery
@adb shell mkdir /cache/recovery
adb shell "echo -e '--sideload' > /cache/recovery/command"
adb reboot recovery
adb wait-for-device
echo Wait until you will see an updating android picture on your phone, then
pause
adb sideload C:\Lg-Manager\res\root.zip
echo Phone will apply the update, do not reboot it untit it ends
pause
goto :startup

##########Settings

:device
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo Select your device
echo.
echo Lg L3 e400 = 1
echo Lg L5 e610 = 2
echo Lg L7 p700 = 3
echo Lg L3 II e430 = 4
echo Lg L4 II e445 = 5
echo Lg L5 II e450 = 6
echo Lg L7 II p710 = 7
echo Lg L9 II d605 = 8
set /p DEVICE= ?:
goto :startup



#############Backup

:backupc
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo 1- Backup       2- Restore
echo.
echo 0- Go back
echo.
set /p S= ? :
if %S%==1 goto :bak
if %S%==2 goto :rest
if %S%==0 goto :startup
echo Invalid Input? Try again!...
pause
goto :backupc

:bak
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo Backup
echo.
set /p BAK=Write here your backup name (NO spaces):
@adb backup -nosystem -noshared -apk -f C:\Lg-Manager\Backups\%BAK%.ab
echo Select your password (on phone) if you want, and wait untilt it works.
pause
goto :startup

:rest
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo Restore
echo.
set /p BAK=Write here your backup name (NO spaces):
@adb restore C:\Lg-Manager\Backups\%BAK%.ab
echo Type your password (on phone), and wait untilt it works.
pause
goto :startup


#############PushandPull
:sync
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo 1- Push a file   2- Import Photos
echo.
echo 0- Go back
echo.
set /p S= ? :
if %S%==1 goto :push
if %S%==2 goto :camera
if %S%==0 goto :startup
echo Invalid Input? Try again!...
pause
goto :sync

:push
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo Push
echo.
set /p PUSH=Drag and drop your file here (one only):
@adb push %PUSH& /sdcard/
pause
goto :starup

:camera
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo Import Photos and Videos
echo.
echo Files will be placed inside C:\Lg-Manager\Userfiles\Camera
pause
@adb pull /sdcard/DCIM/Camera C:\Lg-Manager\Userfiles
pause
goto :starup



#############Shell
:terminal
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo Shell
echo.
echo Press CTRL+C when you want to exit from shell
echo.
adb shell
pause
goto :startup


#############Unlock
:unlock1
if %DEVICE%==1 goto :unlock3
if %DEVICE%==2 goto :unlock5
if %DEVICE%==3 goto :unlock7
if %DEVICE%==4 goto :unlock32
if %DEVICE%==5 goto :unlock52
if %DEVICE%==6 goto :unlock52
if %DEVICE%==7 goto :unlock72
if %DEVICE%==8 goto :unlock92
echo Unsupported Device!
pause
goto :startup

:unlock3
#this is pretty easy, with an unlocked bootloader you can have fun
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo Full unlock - Lg l3 e400
echo.
echo Unlocker by linuxxxx
@adb reboot bootloader
@fastboot devices
@fastboot flash recovery C:\Lg-Manager\L3\recovery\recovery.img
@fastboot reboot
@adb wait-for-device
@adb reboot recovery
@adb wait-for-device
@adb push %ROOT% /sdcard/update.zip
@adb shell rm -rf /cache/recovery
@adb shell mkdir /cache/recovery
@adb shell "echo -e 'update_package' > /cache/recovery/command"
@adb reboot recovery
echo Now phone will complete unlock.
pause
echo Done! Succesfully unlocked!
goto :startup

:unlock5
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo Full unlock - Lg l5 e610
echo.
echo Unlocker by linuxxxx
@adb reboot bootloader
@fastboot devices
#dunno if it's possible to run fastboot boot with a locked bootloader, I own only factory unlocked devices so i cannot test. Theorically it should work, it's not a flash but just a boot.
@fastboot boot C:\Lg-Manager\L5\recovery\recovery.img
@adb wait-for-device
@adb push C:\Lg-Manager\L5\bootloader\emmc_appsboot.bin /sdcard/
@adb shell dd if=/sdcard/emmc_appsboot.bin of=/dev/block/mmcblk0p5
@adb reboot bootloader
@fastboot devices
#now i write recovery (classic way) and everything without root
@fastboot flash recovery C:\Lg-Manager\L5\recovery\recovery.img
#i used this because it's faster than fb reboot and adb reboot recovery eccc...
@fastboot boot C:\Lg-Manager\L5\recovery\recovery.img
@adb shell rm -rf /cache/recovery
@adb shell mkdir /cache/recovery
@adb shell "echo -e '--sideload' > /cache/recovery/command"
@adb reboot bootloader
@fastboot boot C:\Lg-Manager\L5\recovery\recovery.img
@adb wait-for-device
@adb sideload %ROOT%
echo Now phone will complete unlock.
pause
echo Done! Succesfully unlocked!
goto :startup


:unlock7
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo Full unlock - Lg l7 p700
echo.
echo Unlocker by linuxxxx
@adb reboot bootloader
@fastboot devices
@fastboot boot C:\Lg-Manager\L7\recovery\recovery.img
#this way i'll get root access so i can write bootloader
@adb wait-for-device
@adb push C:\Lg-Manager\L7\bootloader\emmc_appsboot.bin /sdcard/
@adb shell dd if=/sdcard/emmc_appsboot.bin of=/dev/block/mmcblk0p5 bs=4096
@adb reboot bootloader
@fastboot devices
#now i write recovery (classic way) and everything without root
@fastboot flash recovery C:\Lg-Manager\L7\recovery\recovery.img
#i used this because it's faster than fb reboot and adb reboot recovery eccc...
@fastboot boot C:\Lg-Manager\L7\recovery\recovery.img
#let's make a sideload
@adb shell rm -rf /cache/recovery
@adb shell mkdir /cache/recovery
@adb shell "echo -e '--sideload' > /cache/recovery/command"
@adb reboot bootloader
@fastboot boot C:\Lg-Manager\L5\recovery\recovery.img
@adb wait-for-device
@adb sideload %ROOT%
echo Now phone will complete unlock.
pause
echo Done! Succesfully unlocked!
goto :startup


:unlock32
# apparently this device has no bootloader mode...
# maybe adb reboot oem-unlock may boot into a fastboot mode like other lg devices...
# until i'll find out a way to boot into fastboot mode there's no way to run the unlocker
# adb reboot-bootloader boots into a "strange" interface for a few secs, but neither adb and fb doesn't recongise it...
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo Full unlock - Lg l3 II e430
echo.
echo Unlocker by linuxxxx
# > Now this currently need that the phone is rooted, waiting for a way to get a fastboot interface
@adb push C:\Lg-Manager\L32\bootloader\lock.bin /sdcard
@adb push C:\Lg-Manager\L32\bootloader\boot.img /sdcard
@adb push C:\Lg-Manager\L32\recovery\recovery.img /sdcard
@adb shell su -c 'dd if=/sdcard/lock.bin of=/dev/block/platform/msm_sdcc.3/mmcblk0p5'
@adb shell su -c 'dd if=/sdcard/boot.img of=/dev/block/platform/msm_sdcc.3/mmcblk0p9'
@adb shell su -c 'dd if=/sdcard/recovery.img of=/dev/block/platform/msm_sdcc.3/mmcblk0p17'
@adb shell su -c 'rm -rf /cache/recovery'
@adb shell su -c' mkdir /cache/recovery'
@adb shell su -c '"echo -e '--sideload' > /cache/recovery/command"'
@adb reboot recovery
@adb wait-for-device
@adb sideload %ROOT%
echo Now phone will complete unlock.
pause
echo Done! Succesfully unlocked!
goto :startup

:unlock52
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo Full unlock - Lg l4 II and Lg l5 II
echo.
echo Unlocker by linuxxxx
# > Now this currently need that the phone is rooted, waiting for a way to get a fastboot interface
# > There's no way to unlock bootloader yet
@adb push C:\Lg-Manager\L52\unlock\system /sdcard/system
@adb push C:\Lg-Manager\L52\unlock\Unlock.sh /sdcard
@adb shell su -c 'sh /sdcard/Unlock.sh'
@adb shell su -c 'rm -rf /sdcard/system /sdcard/Unlock.sh'
@adb shell su -c 'rm -rf /cache/recovery'
@adb shell su -c 'mkdir /cache/recovery'
@adb shell su -c '"echo -e '--sideload' > /cache/recovery/command"'
@adb reboot recovery
@adb wait-for-device
@adb sideload %ROOT%
echo Now phone will complete unlock.
pause
echo Done! Succesfully unlocked!
goto :startup


:unlock72
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo Full unlock - Lg l7 II p710
echo.
echo Unlocker by linuxxxx
# > Now this currently need that the phone is rooted, waiting for a way to get a fastboot interface
@adb push C:\Lg-Manager\L72\bootloader\APPSSBL.bin /sdcard
@adb push C:\Lg-Manager\L72\bootloader\recovery.img /sdcard
@adb shell su -c 'dd if=/sdcard/APPSSBL.bin of=/dev/block/mmcblk0p5'
@adb shell su -c 'dd if=/sdcard/recovery.img of=/dev/block/mmcblk0p17'
@adb shell rm /sdcard/APPSSBL.bin
@adb shell rm /sdcard/recovery.img
@adb shell su -c 'rm -rf /cache/recovery'
@adb shell su -c 'mkdir /cache/recovery'
@adb shell su -c '"echo -e '--sideload' > /cache/recovery/command"'
@adb reboot recovery
@adb wait-for-device
@adb sideload %ROOT%
echo Now phone will complete unlock.
pause
echo Done! Succesfully unlocked!
goto :startup

:unlock92
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo Full unlock - Lg l9 II d605
echo.
echo Unlocker by linuxxxx
# > Now this currently need that the phone is rooted, waiting for a way to get a fastboot interface
@adb push C:\Lg-Manager\L92\recovery\loki_flash /sdcard
@adb push C:\Lg-Manager\L92\recovery\recovery.img /sdcard
@adb shell su -c 'chmod 777/ sdcard/locki_flash'
@adb shell su -c './sdcard/locki_flash recovery /sdcard/recovery.img'
@adb shell rm /sdcard/locki_flash /sdcard/recovery.img
@adb shell su -c 'rm -rf /cache/recovery'
@adb shell su -c 'mkdir /cache/recovery'
@adb shell su -c '"echo -e '--sideload' > /cache/recovery/command"'
@adb reboot recovery
@adb wait-for-device
@adb sideload %ROOT%
echo Now phone will complete unlock.
pause
echo Done! Succesfully unlocked!
goto :startup


############# Credits
:about
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo About
echo.
echo - License: Gpl V2
echo - Developer: Joey Rizzoli
echo - Device Supported: Lg L3, L5, L7, L3 II, L4 II, L5 II, L7 II, L9 II
echo - Disclaimer: this program may void your warranty. Developer disclaim every
echo               damage caused from this program on your device.
echo - Thanks: Aosp, some xda members (do not ask names), Lg, my devices
echo - Based on: Xiaomi Toolkit [By Joey Rizzoli]
echo - Sources:  https://github.com/ionolinuxnoparty/Lg-L-Manager
echo.
pause
goto :startup

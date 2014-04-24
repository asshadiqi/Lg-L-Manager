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
echo Wipe /data if needed and enable sideload
SET /P ROM= Drag your zip file here, then press Enter:  
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
echo Wait until you'll see an updating android picture on your phone, then
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
echo Lg L3 e400 = 4
set /p DEVICE= [1] [2] [3] [4]: 
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
@adb pull /sdcard/DCIM/Camera C:\Lg-Manager\Userfiles\
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

:unlock3
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
@fastboot boot C:\Lg-Manager\L3\recovery\recovery.img
@adb wait-for-device
@adb shell rm -rf /cache/recovery
@adb shell mkdir /cache/recovery
@adb shell "echo -e '--sideload' > /cache/recovery/command"
@adb reboot bootloader
@fastboot boot C:\Lg-Manager\L3\recovery\recovery.img
@adb wait-for-device
@adb sideload C:\Lg-Manager\res\root.zip
echo Now phone will complete unlock.
echo When it will become blank / says done
pause
@adb reboot
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
@fastboot boot C:\Lg-Manager\L5\recovery\recovery.img
@adb wait-for-device
@adb push C:\Lg-Manager\L5/bootloader/emmc_appsboot.bin /sdcard/
@adb shell dd if=/sdcard/emmc_appsboot.bin of=/dev/block/mmcblk0p5
@adb reboot bootloader
@fastboot devices
@fastboot flash recovery C:\Lg-Manager\L5\recovery\recovery.img
@fastboot boot C:\Lg-Manager\L5\recovery\recovery.img
@adb shell rm -rf /cache/recovery
@adb shell mkdir /cache/recovery
@adb shell "echo -e '--sideload' > /cache/recovery/command"
@adb reboot bootloader
@fastboot boot C:\Lg-Manager\L5\recovery\recovery.img
@adb wait-for-device
@adb sideload %ROOT%
echo Now phone will complete unlock.
echo When it will become blank / says done
pause
@adb reboot
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
@adb wait-for-device
@adb push C:\Lg-Manager\L7/bootloader/emmc_appsboot.bin /sdcard/
@adb shell dd if=/sdcard/emmc_appsboot.bin of=/dev/block/mmcblk0p5 bs=4096
@adb reboot bootloader
@fastboot devices
@fastboot flash recovery C:\Lg-Manager\L7\recovery\recovery.img
@fastboot boot C:\Lg-Manager\L7\recovery\recovery.img
@adb shell rm -rf /cache/recovery
@adb shell mkdir /cache/recovery
@adb shell "echo -e '--sideload' > /cache/recovery/command"
@adb reboot bootloader
@fastboot boot C:\Lg-Manager\L5\recovery\recovery.img
@adb wait-for-device
@adb sideload %ROOT%
echo Now phone will complete unlock.
echo When it will become blank / says done
pause
@adb reboot
echo Done! Succesfully unlocked!
goto :startup


:unlock32
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo Full unlock - Lg l3 II e430
echo.
echo Unlocker by linuxxxx
@adb reboot bootloader
@fastboot devices
@fastboot boot C:\Lg-Manager\L32\recovery\recovery.img
@adb wait-for-device
@adb push C:\Lg-Manager\L32/bootloader/lock.bin /sdcard
@adb push C:\Lg-Manager\L32/bootloader/boot.img /sdcard
@adb push C:\Lg-Manager\L32\recovery\recovery.img /sdcard
@adb shell dd if=/sdcard/lock.bin of=/dev/block/platform/msm_sdcc.3/mmcblk0p5
@adb shell dd if=/sdcard/boot.img of=/dev/block/platform/msm_sdcc.3/mmcblk0p9
@adb shell dd if=/sdcard/recovery.img of=/dev/block/platform/msm_sdcc.3/mmcblk0p17
@adb reboot bootloader
@fastboot devices
@fastboot flash recovery C:\Lg-Manager\L32\recovery\recovery.img
@fastboot boot C:\Lg-Manager\L32\recovery\recovery.img
@adb shell rm -rf /cache/recovery
@adb shell mkdir /cache/recovery
@adb shell "echo -e '--sideload' > /cache/recovery/command"
@adb reboot bootloader
@fastboot boot C:\Lg-Manager\L32\recovery\recovery.img
@adb wait-for-device
@adb sideload %ROOT%
echo Now phone will complete unlock.
echo When it will become blank / says done
pause
@adb reboot
echo Done! Succesfully unlocked!
goto :startup


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
echo - Device Supported: Lg L3, L5, L7, L3 II
echo - Incoming Support: Lg L5 II, Lg L7 II
echo - Disclaimer: this program may void your warranty. Developer disclaim every
echo               damage caused from this program on your device.
echo - Thanks: Aosp, some xda members (don't ask names), Lg, my devices
echo - Based on: Xiaomi Toolkit [By Joey Rizzoli]
echo - Sources:  https://github.com/ionolinuxnoparty/Lg-L-Manager
echo.
pause
goto :startup

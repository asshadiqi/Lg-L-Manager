@echo off

%DEVICE%=none
%ROOT%=C:\Lg-Manager\res\root.zip
%L3%=C:\Lg-Manager\L3
%L7%=C:\Lg-Manager\L7
%L5%=C:\Lg-Manager\L5

######################################################################

#Device: [1] e400 > L3, [3] p700 > L7, [2] e61x > L5
cls
goto :device

######################################################################

:device
echo.
echo.
echo Select your device
echo.
echo Lg L3 e400 = L3
echo Lg L5 e61x = L5
echo Lg L7 p700 = L3

set /p DEVICE= [L3] [L5] [L7]: 
goto :startup


cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo 1- Install         4- Reboot
echo 2- Backup          5- Shell
echo 3- Push and Pull   6- Settings
echo .
echo 0- Exit
echo.
echo.
set /p S= ? :
if %S%==1 goto :install
if %S%==2 goto :backupc
if %S%==3 goto :sync
if %S%==4 goto :rebootd
if %S%==5 goto :terminal
if %S%==6 goto :setup
if %S%==0 exit
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
echo 1- Apk       4- Repartition
echo 2- Rom       5- Gapps/Mod
echo 3- Recovery  6- Root
echo.
echo 0- Go back
echo.
set /p S= ? :
if %S%==1 goto :apk
if %S%==2 goto :rom
if %S%==3 goto :rec1
if %S%==4 goto :rep1
if %S%==5 goto :mod
if %S%==6 goto :root
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


:rec1
if %DEVICE%==1 goto :rec2
if %DEVICE%==2 goto :rec3

:rec2
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo Recovery installer for Xiaomi mi2(s)
echo.
@adb reboot bootloader
@fastboot devices
@fastboot flash recovery C:\XiaomiTool\Aries\Recovery\recovery.img
echo Done!
@fastboot reboot
goto :startup


:rec3
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo Recovery installer for Xiaomi mi3
echo.
@adb reboot bootloader
@fastboot devices
@fastboot flash recovery C:\XiaomiTool\Cancro\Recovery\recovery.img
echo Done!
@fastboot reboot
goto :startup


:rep1
if %DEVICE%==1 goto :rep2
if %DEVICE%==2 goto :rep3

:rep2
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo Repartition for Xiaomi mi2(s)
echo.
@adb reboot recovery
@adb wait-for-device
pause
@adb pull C:\XiaomiTool\Aries\Repartition.sh /tmp/
@adb shell chmod 0777 /tmp/repartition.sh
@adb shell sh /tmp/repartition.sh
echo Now you MUST install a rom. Let's sideload it
pause
goto :rom

:rep2
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo Repartition for Xiaomi mi3
echo.
@adb reboot recovery
@adb wait-for-device
pause
@adb pull C:\XiaomiTool\Cancro\Repartition.sh /tmp/
@adb shell chmod 0777 /tmp/repartition.sh
@adb shell sh /tmp/repartition.sh
echo Now you MUST install a rom. Let's sideload it
pause
goto :rom

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
adb shell "echo -e '--sideload' > /cache/recovery/command"
adb reboot recovery
adb wait-for-device
echo Wait until you'll see an updating android picture on your phone, then
pause
adb sideload %MOD%
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
adb sideload C:\XiaomiTool\res\root.zip
echo Phone will apply the update, do not reboot it untit it ends
pause
goto :startup

##########Settings

:device
echo.
echo.
echo Select your device
echo.
set /p DEVICE= 1- Xiaomi Mi2(s)      2- Xiaomi Mi3    :
goto :startup



#############Backup

:backupc
cls
echo ################################
echo # Xiaomi Toolkit               #
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
@adb backup -nosystem -noshared -apk -f C:\XiaomiTool\Backups\%BAK%.ab
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
@adb restore C:\XiaomiTool\Backups\%BAK%.ab
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
echo File will be placed inside C:\XiaomiTool\Userfiles\Camera
pause
@adb pull /sdcard/DCIM/Camera C:\XiaomiTool\Userfiles\
pause
goto :starup


#############Reboot

:rebootd
cls
echo ################################
echo # LG L Manager                 #
echo # Selected device: %DEVICE%    #
echo ################################
echo.
echo Reboot..
echo.
echo 1- System        3- Bootloader
echo 2- Recovery      4- Download
echo.
echo 0- Go back
echo.
set /p S= ? :
if %S%==1 @adb reboot & goto :startup
if %S%==2 @adb reboot recovery & goto:startup
if %S%==3 @adb reboot bootloader & goto:startup
if %S%==4 @adb reboot dload & goto:startup
if %S%==0 goto :startup
echo Invalid Input? Try again!...
pause
goto :rebootd


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


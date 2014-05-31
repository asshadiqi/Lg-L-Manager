#!/bin/bash

#   Copyright 2014 Joey Rizzoli
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.


#      */*****   var    *****\*

L=~/Lg-LManager
L3=~/Lg-LManager/e400
L5=~/Lg-LManager/e610
L7=~/Lg-LManager/p700
L32=~/Lg-LManager/e430
L32=~/Lg-LManager/e460
L72=~/Lg-LManager/e710
ROOTURL=http://download.chainfire.eu/372/SuperSU/UPDATE-SuperSU-v1.86.zip?retrieve_file=1
ROOTZIP=~/Lg-LManager/res/root.zip
DEVICE=
ACTION=$1
Choice=
APK=
ZIP=
ROM=
DIR=/sdcard/tmp
BACKUPID=
BACKUPDIR=~/Lg-LManager/Backups
FILE=
CAMDIR=/sdcard/DCIM/Camera
ISCRAZY=0

#      */*****   SETUP    *****\*

becrazy () {
while :; do echo 'YOU ARE CRAZY !!!'; sleep 1; done
}



headerprint () {
  if  [ "$ISCRAZY" = "1" ]
    then
      echo "Crazy Mode is on!!"
      echo "User is crazy, to prevent damage..."
      sleep 2
      while :; do becrazy ; sleep 1; done
      break
else
clear
echo "################################"
echo "# LG L Manager                 #"
echo "# $DEVICE                         #"
echo "################################"
echo " "
fi
}

home () {
headerprint
echo "1- Install         4- Full Unlock"
echo "2- Backup          5- Shell"
echo "3- Push and Pull"
echo " "
echo "0- Exit            00-About"
read -p "?" Choice
if  [ "$Choice" = "1" ]
  then
    install
    break
elif  [ "$Choice" = "2" ]
  then
    back1
    break
elif  [ "$Choice" = "3" ]
  then
    pnp
    break
elif  [ "$Choice" = "4" ]
  then
    unlock
    break
elif  [ "$Choice" = "5" ]
  then
    shelll
    break
elif  [ "$Choice" = "0" ]
  then
    close
    break
elif  [ "$Choice" = "00" ]
  then
    about
    break
elif  [ "$Choice" = "make me a sandwich" ]
  then
    read -p "Do it yourself: " Choice
    if [ "$Choice" = "sudo make me a sandwich" ]
      then
        echo "Setting crazy mode on.."
        ISCRAZY=1
        sleep 10
        home
        break
    else
    echo "Wrong input"
    fi
    break
else
  echo "Wrong input"
  home
  fi
}

#      */*****   Install    *****\*

install () {
headerprint
echo "Installer"
echo " "
echo "1- Apk       3- Mod/Gapps"
echo "2- Rom"
echo " "
echo "0- Go Back"
read -p "?" Choice
  if  [ "$Choice" = "1" ]
    then
      apk
      break
  elif  [ "$Choice" = "2" ]
    then
      rom
      break
  elif  [ "$Choice" = "3" ]
    then
      zip
      break
  elif  [ "$Choice" = "0" ]
    then
      home
      break
else
echo "Wrong input"
install
fi
}

apk () {
headerprint
echo "Apk Installer"
echo " "
read -p "Drag your apk here and press ENTER: " APK
adb install $APK
sleep 2
home
}

rom () {
  if  [ "$DEVICE" = "E400" ]
    then
      rom3
      break
  else
  rom2
  break
  fi
}

rom2 () {
headerprint
echo "Rom installer"
adb reboot recovery
echo "Wipe /data now!"
read -p "When you've wiped /data press ENTER"
adb shell  rm -rf /cache/recovery
adb shell mkdir /cache/recovery
adb shell "echo -e '--sideload' > /cache/recovery/command"
adb reboot recovery
adb wait-for-device
read -p "Drag your zip here and press ENTER: " ROM
adb sideload $ROM
echo "Now wait until your phone install rom, about 3 mins"
sleep 360
read -p "If your phone screen is blank with recovery background, press enter or wait"
adb reboot
echo "Done!"
home
}

rom3 () {
headerprint
echo "Rom installer"
adb reboot recovery
echo "Wipe /data now!"
echo "Then,"
read -p "Drag your zip here and press ENTER: " ROM
adb shell mkdir $DIR
adb push $ROM $DIR
echo "Now select install > choose your file (it's on /sdcard)"
read -p "When it ends press ENTER"
adb shell rm -rf $DIR
adb reboot
echo "Done!"
home
}

zip () {
  if  [ "$DEVICE" = "E400" ]
    then
      zip3
      break
else
  zip2
  break
  fi
}


zip2 () {
headerprint
echo "Zip installer"
adb reboot recovery
adb shell rm -rf /cache/recovery
adb shell mkdir /cache/recovery
adb shell "echo -e '--sideload' > /cache/recovery/command"
adb reboot recovery
adb wait-for-device
read -p "Drag your zip here and press ENTER: " ZIP
adb sideload $ZIP
echo "Now wait until your phone install zip file.."
read -p "Only when your phone screen is blank with recovery background, press enter"
adb reboot
echo "Done!"
home

}

zip3 () {
headerprint
echo "Rom installer"
adb reboot recovery
read -p "Drag your zip here and press ENTER: " ZIP
adb shell mkdir $DIR
adb push $ZIP $DIR
echo "Now select install > choose your file (it's on /sdcard)"
read -p "When it ends press ENTER"
adb shell rm -rf $DIR
adb reboot
echo "Done!"
home

}

#      */*****   Unlock    *****\*

unlock () {
  if  [ "$DEVICE" = "E400" ]
    then
      unlock3
      break
  elif  [ "$DEVICE" = "P610" ]
    then
      unlock5
      break
  elif  [ "$DEVICE" = "P700" ]
    then
      unlock7
      break
  elif  [ "$DEVICE" = "E430" ]
    then
      unlock32
      break
else
echo "Device not supported"
sleep 3
home
fi
}

unlock3 () {
headerprint
echo "Unlocking Lg L3 $DEVICE"
echo " "
adb reboot bootloader
fastboot flash recovery $L3/recovery/recovery.img
fastboot boot $L3/recovery/recovery.img
adb wait-for-device
adb shell mkdir $DIR
adb push $ROOTZIP $DIR
echo "Now select install > choose your file (it's on /sdcard/root.zip)"
read -p "When it ends press ENTER"
adb shell rm -rf $DIR
adb reboot
read -p "Done!"
home
}

unlock5 () {
headerprint
echo "Unlocking Lg L5 $DEVICE"
echo " "
adb reboot bootloader
fastboot boot $L5/recovery/recovery.img
adb wait-for-device
adb shell mkdir $DIR
adb push $L5/bootloader/emmc_appsboot.bin $DIR
adb shell dd if=/sdcard/tmp/emmc_appsboot.bin of=/dev/block/mmcblk0p5
adb reboot bootloader
fastboot flash recovery $L5/recovery/recovery.img
fastboot boot $L5/recovery/recovery.img
adb wait-for-device
adb shell rm -rf /cache/recovery
adb shell mkdir /cache/recovery
adb shell "echo -e '--sideload' > /cache/recovery/command"
adb reboot bootloader
fastboot boot $L5/recovery/recovery.img
adb wait-for-device
adb sideload $ROOTZIP
echo "Finishing..."
read -p "When screen become blank with recovery background, press ENTER"
adb reboot
echo "Unlocked !"
home
}

unlock7 () {
headerprint
echo "Unlocking Lg L7 $DEVICE"
echo " "
adb reboot bootloader
fastboot boot $L7/recovery/recovery.img
adb wait-for-device
adb shell mkdir $DIR
adb push $L7/bootloader/emmc_appsboot.bin $DIR
adb shell dd if=/sdcard/tmp/emmc_appsboot.bin of=/dev/block/mmcblk0p5 bs=4096
adb reboot bootloader
fastboot flash recovery $L7/recovery/recovery.img
fastboot boot $L7/recovery/recovery.img
adb wait-for-device
adb shell rm -rf /cache/recovery
adb shell mkdir /cache/recovery
adb shell "echo -e '--sideload' > /cache/recovery/command"
adb reboot bootloader
fastboot boot $L7/recovery/recovery.img
adb wait-for-device
adb sideload $ROOTZIP
echo "Finishing..."
read -p "When screen become blank with recovery background, press ENTER"
adb reboot
echo "Unlocked !"
home
}

unlock32 () {
echo "Not working now..."
sleep 3
home
}


# */*** Other ***\*


shelll () {
headerprint
echo "Shell"
echo " "
echo "Type exit when you want to quit"
echo " "
adb shell
read -p "Press Enter to quit"
home
}



back1 () {
headerprint
echo "Backup Manager"
echo " "
echo "1- Backup    2-Restore"
echo " "
echo "0- Go Back"
read -p "?" Choice
  if [ "$Choice" = "1" ]
    then
      backup
      break
  elif [ "$Choice" = "2" ]
    then
      restore
      break
  elif [ "$Choice" = "0" ]
    then
      home
      break
  else
  echo "Wrong input"
  back1
  fi
}

backup () {
headerprint
echo "Backup"
echo " "
read -p "Type backup name (NO SPACES): " BACKUPID
echo " "
echo "Enter password on your phone and let it work"
adb backup -nosystem -noshared -apk -f $BACKFOLDER/$BACKUPID.ab
read -p "Done! Press Enter"
home
}

restore () {
headerprint
echo "Restore"
echo " "
read -p "Type backup name: " BACKUPID
echo " "
echo "On your phone, type password and let it works"
adb restore $BACKFOLDER/$BACKUPID.ab
read -p "Done! Press Enter"
home
}


pnp () {
headerprint
echo "Push and Pull"
echo " "
echo "1- Push a file "
echo "2- Import Camera Photos"
echo " "
echo "0- Go Back"
read -p "?" Choice
  if [ "$Choice" = "1" ]
    then
      push
      break
  elif [ "$Choice" = "2" ]
    then
      camera
      break
  elif [ "$Choice" = "0" ]
    then
      home
      break
  else
  echo "Wrong input"
  sleep 2
  pnp
  fi
}

push () {
headerprint
echo "Push a file"
echo " "
read -p "Drag your file here (one): " FILE
adb push $FILE /sdcard
read -p "Press ENTER"
home
}

camera () {
headerprint
echo "Import Camera Photos"
read -p "Press enter to start"
adb pull $CAMDIR $L/Camera
read -p "Press ENTER"
home
}





close () {

sleep 1
echo -n "Quitting."
sleep 1
echo -n .
sleep 1
echo -n .
sleep 1
echo -n .
sleep 1
echo -n .
sleep 1
echo -n .
sleep 1
echo -n .
sleep 2
clear
exit
}

about () {
headerprint
echo "About"
echo " "
echo "- License: Gpl V2"
echo "- Developer: Joey Rizzoli"
echo "- Device Supported: Lg L3, L5, L7, L3 II"
echo "- Incoming Support: Lg L5 II, Lg L7 II"
echo "- Disclaimer: this program may void your warranty. Developer disclaim every"
echo "              damage caused from this program on your device."
echo "- Thanks: Aosp, some xda members (don't ask names), Lg, my devices"
echo "- Based on: Xiaomi Toolkit By Joey Rizzoli"
echo "- Sources:  https://github.com/ionolinuxnoparty/Lg-L-Manager"
echo " "
echo " "
sleep 20
read -p "Press enter to go back"
home
}

detect_device() {
clear
echo "####################"
echo "Connect device..."
sleep 1
echo "Connected device is"
sleep 1
echo "$(adb shell getprop ro.product.device)"
echo "#####################"
sleep 1
echo " "
echo "Select the number based on the code you see above"
echo " "
echo "1- Lg L3 [e400][e0]"
echo "2- Lg L5 [e610]"
echo "3- Lg L7 [p700]"
echo "4- Lg L3 II [e430]"
echo " "
read -p "? " Choice
  if [ "$Choice" = "1" ]
    then
      DEVICE=E400
      home
      break
  elif [ "$Choice" = "2" ]
    then
      DEVICE=E610
      home
      break
  elif [ "$Choice" = "3" ]
    then
      DEVICE=P700
      home
      break
  elif [ "$Choice" = "4" ]
    then
      DEVICE=E430
      home
      break
  else
  echo "Wrong input, retry"
  sleep 2
  detect_device
  fi
}

if [ "$ACTION" = 0 ]
    then
      detect_device
elif [ "$ACTION" = 1 ]
    then
      DEVICE=E400
      home
elif [ "$ACTION" = 2 ]
    then
      DEVICE=E610
      home
elif [ "$ACTION" = 3 ]
    then
      DEVICE=P7O0
      home
elif [ "$ACTION" = 4 ]
    then
      DEVICE=E430
      home
elif [ "$ACTION" = 5 ]
    then
        DEVICE=E460
        home
elif [ "$ACTION" = 6 ]
    then
        DEVICE=P710
        home
else
ISCRAZY=1
detect_device
fi

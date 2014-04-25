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
BACK=echo "0- Go Back"
X=echo " "
FILE=
CAMDIR=/sdcard/DCIM/Camera

#      */*****   SETUP    *****\*


detect_device() {
    echo "Connect device..."
    DEVICE=$(adb wait-for-device shell getprop ro.product.device)

    if [[ $? != 0 ]] ; then
        echo "adb return error."
        exit -1
    fi

    if [[ "$DEVICE" == e400* ]]; then
      echo "Detected connected Lg L3"
      DEVICE=E400
    elif [[ "$DEVICE" == e0* ]]; then
      echo "Detected connected Lg L3"
      DEVICE=E400
    elif [[ "$DEVICE" == e610* ]]; then
      echo "Detected connected Lg L5"
      DEVICE=E610
    elif [[ "$DEVICE" == p700* ]]; then
      echo "Detected connected Lg L7"
      DEVICE=p700
    elif [[ "$DEVICE" == e430* ]]; then
      echo "Detected connected Lg L3 II"
      DEVICE=E430
      else
      echo "Connected device is not supported"
      exit 0
    fi
}

headerprint () {
  clear
  echo "################################"
  echo "# LG L Manager                 #"
  echo "# Selected device: $DEVICE        #"
  echo "################################"
  $X
  fi
}

home () {
  echo "1- Install         4- Full Unlock"
  echo "2- Backup          5- Shell"
  echo "3- Push and Pull"
  $X
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
      read -p "Do it yourself:" Choice
      if [ "$Choice" = "sudo make me a sandwich" ]
        then
          read -p "OK"
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
    $X
    echo "1- Apk       3- Mod/Gapps"
    echo "2- Rom"
    $X
    $BACK
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
    $X
    read -p "Drag your apk here and press ENTER: " APK
    adb install $APK
    sleep 2
    home
    fi
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
    fi
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
    fi
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
    adb shell  rm -rf /cache/recovery
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
    fi
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
    fi
    }

#      */*****   Unlock    *****\*

unlock () {
    if  [ "$DEVICE" = "E400" ]
      then
        unlock3
        break
    if  [ "$DEVICE" = "P610" ]
      then
        unlock5
        break
    if  [ "$DEVICE" = "P700" ]
      then
        unlock7
        break
    if  [ "$DEVICE" = "E430" ]
      then
        unlock32
        break
    else
    echo "Connected device is not supported"
    sleep 3
    exit 0
    fi
    }

unlock3 () {
    printheader
    echo "Unlocking Lg L3 $DEVICE"
    $X
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
    fi
    }

unlock5 () {
    printheader
    echo "Unlocking Lg L5 $DEVICE"
    $X
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
    fi
    }

unlock7 () {
    printheader
    echo "Unlocking Lg L7 $DEVICE"
    $X
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
    fi
    }

unlock32 () {
    read -p "Not working now..."
    home
    fi
    }


# */*** Other ***\*


shelll () {
    printheader
    echo "Shell"
    $X
    echo "Press Ctrl+C when you want to quit"
    $X
    adb shell
    read -p "Press Enter to quit"
    home
    fi
    }



back1 () {
    printheader
    echo "Backup Manager"
    $X
    echo "1- Backup    2-Restore"
    $X
    $BACK
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
    fi
    back1
    fi
    }

backup () {
    printheader
    echo "Backup"
    $X
    read -p "Type backup name (NO SPACES): " BACKUPID
    $X
    echo "Enter password on your phone and let it work"
    adb backup -nosystem -noshared -apk -f $BACKFOLDER/$BACKUPID.ab
    read -p "Done! Press Enter"
    home
    fi
    }

restore () {
    printheader
    echo "Restore"
    $X
    read -p "Type backup name: " BACKUPID
    $X
    echo "On your phone, type password and let it works"
    adb restore $BACKFOLDER/$BACKUPID.ab
    read -p "Done! Press Enter"
    home
    fi
    }

pnp () {
    printheader
    echo "Push and Pull"
    $X
    echo "1- Push a file "
    echo "2- Import Camera Photos"
    $X
    $BACK
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
    printheader
    echo "Push a file"
    $X
    read -p "Drag your file here (one): " FILE
    adb push $FILE /sdcard
    read -p "Press ENTER"
    home
    fi
    }

camera () {
    printheader
    echo "Import Camera Photos"
    read -p "Press enter to start"
    adb pull $CAMDIR $L/Camera
    read -p "Press ENTER"
    home
    fi
    }



# */*** Update ***\*

if [[ "$ACTION" == HELP ]]; then
    clear
    printusage
    break
elif [[ "$ACTION" == UPDATE ]]; then
    clear
    update
    break

fi

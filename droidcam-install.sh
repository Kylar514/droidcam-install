#!/bin/bash

# Check if droidcam is running and close it
if pgrep -x "droidcam" > /dev/null; then
    echo "Closing DroidCam..."
    pkill -f "droidcam"
fi

# Download and install latest DroidCam client
echo "Downloading latest DroidCam client..."
cd /tmp/
wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_2.0.0.zip
# sha1sum: 7b213dcf0bb4ac20d17007f52192c7914b10ed3f
unzip droidcam_latest.zip -d droidcam
cd droidcam && sudo ./install-client

# Install v4l2loopback-dc
echo "Installing v4l2loopback-dc..."
sudo apt install linux-headers-`uname -r` gcc make
cd /tmp/droidcam/v4l2loopback
make
sudo make install

# Ask user if they want to use DroidCam over USB
read -p "Do you want to use DroidCam over USB? (y/n) " use_usb

if [ "$use_usb" == "y" ]; then
  # Enable USB Debugging on phone
  echo "Please enable USB Debugging on your phone:"
  echo "1. Go to Settings > About Phone."
  echo "2. Tap Build Number seven times to unlock Developer options."
  echo "3. Go back to Settings and select Developer options."
  echo "4. Turn on USB Debugging."

  # Install adb
  read -p "Do you want to install adb? (y/n) " install_adb

  if [ "$install_adb" == "y" ]; then
    if [ -x "$(command -v apt-get)" ]; then
      sudo apt-get install adb -y
    elif [ -x "$(command -v yum)" ]; then
      sudo yum install android-tools -y
    else
      echo "Error: Package manager not found. Please install adb manually."
    fi
  fi

  # Connect to device using adb
  echo "Please connect your device using USB and press Enter to continue."
  read -s -n 1 key
  droidcam-cli adb
else
  # Connect to device using Wi-Fi
  echo "Please connect your device and computer to the same Wi-Fi network"
fi

# Ask user if they want to enable sound
read -p "Do you want to enable sound? (y/n) " enable_sound

if [ "$enable_sound" == "y" ]; then
  # Load Loopback sound card
  sudo ./install-sound
fi

# Ask user for resolution and set v4l2loopback resolution accordingly
echo "Please choose a resolution:"
echo "1. 640x480"
echo "2. 960x720"
echo "3. 1280x720 (720p)"
echo "4. 1920x1080 (1080p) - Requires Premium Version and Camera Support"
read -p "Enter option number: " option

case $option in
    1) width=640; height=480 ;;
    2) width=960; height=720 ;;
    3) width=1280; height=720 ;;
    4)
        echo "Note: HD resolutions require the Premium version of DroidCam and your camera must support said resolutions."
        read -p "Enter 'yes' to continue or any other key to exit: " confirm
        if [[ $confirm == "yes" ]]; then
            width=1920
            height=1080
        else
            echo "Exiting..."
            exit
        fi
        ;;
    *) echo "Invalid option. Exiting..."; exit ;;
esac

echo "Setting v4l2loopback resolution to ${width}x${height}..."
sudo rmmod v4l2loopback_dc
sudo insmod /lib/modules/`uname -r`/kernel/drivers/media/video/v4l2loopback-dc.ko width=$width height=$height

echo "Droidcam installed"

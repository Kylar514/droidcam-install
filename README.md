# DroidCam Linux Installer

This script is an easy-to-use installer for DroidCam on Linux systems, specifically Ubunutu based. It installs the latest version of the DroidCam client, v4l2loopback-dc, and enables the user to select various configuration options.  I just copied the install instructions from https://www.dev47apps.com/droidcam/linux/ and made a script.  When updating your system, it is possible that you will need to reinstall droidcam in order to get it to fuction properly again, which is what makes this script pretty handy.

## Dependencies

This script depends on the following software:

- `make`
- `gcc`
- `linux-headers`
- `adp` Note: this is optional if you want to run over usb, script will prompt you & manage install of ADP.

## Usage

1. First, ensure that all dependencies are installed on your system.
2. Download the `droidcam-installer.sh` script to your computer.
3. Open a terminal and navigate to the directory where the script is located.
4. Run the command `chmod +x droidcam-installer.sh` to make the script executable.
5. Run the command `./droidcam-installer.sh` to start the installation process.
6. Follow the on-screen instructions to configure DroidCam as desired.

## Features

- Downloads and installs the latest DroidCam client
- Downloads and installs v4l2loopback-dc
- Allows user to select whether to use DroidCam over USB or Wi-Fi
- Allows user to enable or disable sound support
- Allows user to select from several resolution options

## Note

This script is intended for use on Debian-based systems. It has been tested on KDE Neon 5.27, but may work on other Debian-based distributions as well. 

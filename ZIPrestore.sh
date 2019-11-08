!/usr/bin/env bash
#
# Version 1
#
# First best version of auto restore
# of zip archived files.
# Currently being tested and tweaked
#
# Restore: ./ZIPrestore.sh
# or
# bash ZIPrestore.sh
#

SUDO=''
if (( $EUID != 0 )); then
    SUDO='sudo'
fi
$SUDO bash ZIPrestore.sh

echo "[+] Unzipping any zip files in directory"
unzip *.zip

echo "[+] Starting copying of backed up files to system"
sudo cp -R etc/* /etc
sudp cp -R root/* /root
sudo cp -R var/log/* /var/log/
sudo cp -R home/pi/.bashrc /home/pi/

echo "[!] Restore completed!"

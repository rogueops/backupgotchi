#!/usr/bin/env bash
#
# Version 1.3b
#
# Modded version of original backup
# script that does not requite root
# to be setup/enabled and puts the
# output zip file in the pi home
# under /home/pi/pwnabackup
#
# Usage: sudo ./pwnabackup.sh
# OR     sudo bash pwnabackup.sh
#

# name of the ethernet gadget interface on the host
UNIT_HOSTNAME=$(cat /etc/hostname)

# output backup zip file
OUTPUT=$(pwnagotchi-backup.zip)

# temporary folder
BACKUP_LOCATION=/home/pi/

# what to backup
FILES_TO_BACKUP=(
  /root/brain.nn
  /root/brain.json
  /root/handshakes
  /root/peers
  /etc/pwnagotchi/
  /etc/hostname
  /etc/hosts
  /etc/motd
  /var/log/pwnagotchi.log
  /home/pi/.bashrc
)

if ! test -e /usr/bin/zip; then
    echo "[-] ZIP is not installed, installing zip package before backup starts."
    sudo apt install -y zip
    echo "[+] ZIP successfully installed, starting backup of files."
fi

echo "@ backing up $UNIT_HOSTNAME to $OUTPUT ..."

# Deleting old backups before creating new backup archive
rm -rf "$BACKUP_LOCATION"

# Create folders & Copy files to backup location
for file in "${FILES_TO_BACKUP[@]}"; do
  dir=$(dirname $file)
  echo "  $file -> $BACKUP_LOCATION$dir/"
  mkdir -p "$BACKUP_LOCATION/$dir"
  sudo cp -R /$file "$BACKUP_LOCATION$dir/"
done

# Archive copied files
ZIPFILE="$PWD/$OUTPUT"
pushd $PWD
cd "$BACKUP_LOCATION"
zip -r -9 -q "$ZIPFILE" .
popd

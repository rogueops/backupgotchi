#!/usr/bin/env bash
#
# Version 1.5b
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

TIMESTAMP=$(date +"%m-%d-%y")

# output backup zip file
OUTPUT=pwnagotchi-backup-$TIMESTAMP.zip

# temporary folder
BACKUP_LOCATION=$PWD/backupFiles/

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

echo "[+] Starting copying of files\n"

if ! test -e /usr/bin/zip; then
    echo "[-] ZIP is not installed, installing zip package before backup starts."
    sudo apt install -y zip
    echo "[+] ZIP successfully installed, starting backup of files."
fi

echo "@ backing up $UNIT_HOSTNAME to $OUTPUT ..."

# Deleting old backups before creating new backup archive
echo "[+] Checking for existing backup and removing if needed\n"
rm -rf "$BACKUP_LOCATION"

# Create folders & Copy files to backup location
for file in "${FILES_TO_BACKUP[@]}"; do
  dir=$(dirname $file)
  echo "  $file -> $BACKUP_LOCATION$dir/"
  mkdir -p "$BACKUP_LOCATION/$dir"
  sudo cp -R /$file "$BACKUP_LOCATION$dir/"
done

echo "[!] Copy completed!\n"
echo "[+] Starting archive of copied files!\n"

# Archive copied files
ZIPFILE="$PWD/$OUTPUT"
pushd $PWD
cd "$BACKUP_LOCATION"
sudo zip -r -9 -q "$ZIPFILE" .
popd

echo ""
echo "[+] Backup completed!"

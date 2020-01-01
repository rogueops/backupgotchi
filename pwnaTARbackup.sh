!/usr/bin/env bash
#
# Version 1.7
#
# Modded version of original backup
# script that does not requite root
# to be setup/enabled and puts the
# output zip file in the pi home
# folder and all copied files
# under current directory
#
# Backup: ./pwnaTARbackup.sh
# or
# bash pwnaTARbackup.sh
#
# Restore: sudo tar -xvf /home/pi/nameOFfile.tar.gz -C/
#

UNIT_HOSTNAME=$(cat /etc/hostname)

TIMESTAMP=$(date +"%m-%d-%y")

# output backup zip file
OUTPUT=gotchiBackup-$TIMESTAMP.tar.gz

# temp folder
BACKUP_LOCATION=$PWD/backupFiles/

# what to backup
FILES_TO_BACKUP=(
  /root/brain.nn
  /root/brain.json
  /root/handshakes
  /root/peers
  /root/.api-report.json
  /root/.ssh
  /root/.bashrc
  /root/.profile
  /etc/pwnagotchi/
  /etc/hostname
  /etc/hosts
  /etc/motd
  /var/log/pwnagotchi.log
  /var/log/pwnagotchi*.gz
  /home/pi/.ssh
  /home/pi/.bashrc
  /home/pi/.profile
  /etc/ssh/
)

echo "[+] backing up $UNIT_HOSTNAME to $OUTPUT ..."

echo "[!] Remove existing backup if exists first!"

# Deleting old backups before creating new backup archive
rm -rf "$BACKUP_LOCATION"

echo "[+] Starting copying of files\n"

# Create folders & Copy files to backup location
for file in "${FILES_TO_BACKUP[@]}"; do
  dir=$(dirname $file)
  echo "  $file -> $BACKUP_LOCATION$dir/"
  mkdir -p "$BACKUP_LOCATION/$dir"
  sudo cp -R $file "$BACKUP_LOCATION$dir/"
done

echo "[+] Copy completed!\n"
echo "[?] Check above for any errors\n"
echo "[+] Now archiving files copied\n"

# Archive copied files
ZIPFILE="$PWD/$OUTPUT"
pushd $PWD
cd "$BACKUP_LOCATION"
sudo tar -cvzf "$ZIPFILE" .
popd

echo ""
echo "[+] Completed!"

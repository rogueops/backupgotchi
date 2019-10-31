# BackupGotchi - no root local backup script
No need to enable root.

No need to set a root password.

No need to enable root login in SSH.

No need to install zip if using TAR version.

Adds date of backup to file name.

**ZIP version will check for zip and auto install if missing. Requires internet.**

Puts the tar.gz or zip file in a folder called backup in the directory you are currently in.

# Usage

Download script logged in a pi:
    
    git clone https://github.com/gh0stshell/backupgotchi.git

Run backup script to create a tar ball of all needed files:
    
    sudo bash pwnaTARbackup.sh
    
Run backup script to create a zip archive of all needed files:

    sudo bash pwnaZIPbackup.sh
    
A new tar file called pwnagotchi-backup.tar.gz will now be in your /home/pi directory.

# Restore For Tar Version

Once you move the backup back to your unit after upgrading run the following to restore:

    sudo tar -xvf pwnagotchi-backup.tar.gz -C/

# Restore For Zip Version

If using zip, extract zip file and then use:

    sudo cp -R backedUPfolder/* /whereTOcopyBACKUPEDfiles
   
Example:

    sudo cp -R etc/* /etc

# Final Step

    sudo reboot

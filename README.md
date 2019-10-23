# pwnabackup no root backup script
No need to enable root.

No need to set a root password.

No need to enable root login in SSH.

No need to install zip.

Puts the tar.gz file right in your home folder.

# Usage

Download script logged in a pi:
    
    git clone https://github.com/gh0stshell/pwnabackup.git

Run backup script to create a tar of all needed files:
    
    sudo bash pwnabackup.sh
    
A new tar file called pwnagotchi-backup.tar.gz will now be in your /home/pi directory.

# Restore

Once you move the backup back to your unit after upgrading run the following to restore:

    sudo tar -xvf pwnagotchi-backup.tar.gz -C/

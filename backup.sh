#!/bin/sh

# Based on the following posts
# http://www.batchworks.de/automatic-backup-of-usb-flashdrives-with-a-folder-action
# /http://blog.interlinked.org/tutorials/rsync_time_machine.html

BACKUPFOLDER=/Volumes/GRRRMO_BP/Dropbox_Teaching
IMPORTANT_FOLDER=~/Dropbox/Teaching

USBNAMES=(GRRRMO_BP)

MOUNTFOLDER=/Volumes
MOUNTS=( $MOUNTFOLDER/* )


date=`date "+%Y-%m-%d-%H%M%S"`

LINK=$BACKUPFOLDER/current
TARGET_INC=$BACKUPFOLDER/back-${date}_incomplete
TARGET_FINAL=$BACKUPFOLDER/back-${date}

RSYNC=/usr/local/bin/rsync
RSYNCOPT="-aP --log-file=$BACKUPFOLDER/backup.log  --link-dest=$LINK"

for folder in $MOUNTS
do
    for name in $USBNAMES
    do
        if [ $folder == "$MOUNTFOLDER/$name" ]
        then
            # create backup folder if missing
            if [ ! -d $BACKUPFOLDER ]
            then
                mkdir -p $BACKUPFOLDER
            fi

            $RSYNC $RSYNCOPT $IMPORTANT_FOLDER $TARGET_INC && mv $TARGET_INC $TARGET_FINAL && rm -f $LINK  && ln -s $TARGET_FINAL $LINK      
        fi
    done
done

#!/bin/sh

# Based on the following posts
# http://www.batchworks.de/automatic-backup-of-usb-flashdrives-with-a-folder-action
# /http://blog.interlinked.org/tutorials/rsync_time_machine.html

BACKUPFOLDER=/Volumes/GRRRMO_BP/Dropbox_Teaching
IMPORTANT_FOLDER=~/Dropbox/Teaching

USBNAMES=(GRRRMO_BP)

MOUNTFOLDER=/Volumes
MOUNTS=( $MOUNTFOLDER/* )

RSYNC=/usr/local/bin/rsync
RSYNCOPT=-aP

date=`date "+%Y-%m-%d-%H%M%S"`

LINK=$BACKUPFOLDER/current
TARGET_INC=$BACKUPFOLDER/back-${date}_incomplete

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

            $RSYNC $RSYNCOPT --link-dest=$LINK $IMPORTANT_FOLDER $TARGET_INC --log-file=$BACKUPFOLDER/$name.log && mv $BACKUPFOLDER/back-${date}_incomplete $BACKUPFOLDER/back-${date} && rm -f $BACKUPFOLDER/current && ln -s $BACKUPFOLDER/back-$date $BACKUPFOLDER/current
        fi
    done
done

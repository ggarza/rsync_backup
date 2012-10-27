#!/bin/sh

USBNAMES=(GRRRMO_BP)
RSYNC=/usr/local/bin/rsync
RSYNCOPT=-aP
BACKUPFOLDER=/Volumes/GRRRMO_BP/Dropbox_Teaching
IMPORTANT_FOLDER=~/Dropbox/Teaching
MOUNTFOLDER=/Volumes
MOUNTS=( $MOUNTFOLDER/* )

# create backup folder if missing
# if [ ! -d $BACKUPFOLDER ]
#    then
#         mkdir -p $BACKUPFOLDER
# fi 

for folder in $MOUNTS
do
    for name in $USBNAMES
    do
        if [ $folder == "$MOUNTFOLDER/$name" ]
        then
            date=`date "+%Y-%m-%d_%H:%M:%S"`
            $RSYNC $RSYNCOPT --link-dest=$BACKUPFOLDER/current $IMPORTANT_FOLDER $BACKUPFOLDER/back-$date --log-file=$BACKUPFOLDER/$name.log
            rm -f $BACKUPFOLDER/current
            ln -s $BACKUPFOLDER/back-$date $BACKUPFOLDER/current
        fi
    done
done




# 
# date=`date "+%Y-%m-%d_%H:%M:%S"`
# $RSYNC $RSYNCOPT --link-dest=$BACKUPFOLDER/current $IMPORTANT_FOLDER $BACKUPFOLDER/back-$date
# rm -f $BACKUPFOLDER/current
# ln -s $BACKUPFOLDER/back-$date $BACKUPFOLDER/current

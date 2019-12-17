#!/bin/bash

mkdir -p /home/nekosmonavt/restore

lastBackup=0
backupDate=""

for dir in $(ls /home/nekosmonavt/ | grep -E "^Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}$");
do
	date=$(echo $dir | sed 's/^Backup-//')
	days=$(date -d "$date" +"%s")
	let days=$days/86400
	if [[ $lastBackup -eq "0" ]];
	then
		lastBackup=$days
		backupDate=$date
	fi

	if [[ $lastBackup -lt $days ]];
	then
		lastBackup=$days
		backupDate=$date
	fi
done

pathFrom="/home/nekosmonavt/Backup-$backupDate/"
pathTo="/home/nekosmonavt/restore/"

for file in $(ls $pathFrom | grep -hv "\.[0-9]{4}-[0-9]{2}-[0-9]{2}$");
do
	cp $pathFrom$file $pathTo
done

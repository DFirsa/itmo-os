#!/bin/bash

now=$(TZ=":Europe/Moscow" date +"%F")
nowSec=$(date -d "$now" +"%s")

sourcePath="/home/nekosmonavt/source/"
backupReport="/home/nekosmonavt/backup-report"

haveRecentBackup=0
for dir in $(ls /home/nekosmonavt/ | grep -E "^Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}$");
do
	lastTimeBackup=$(echo $dir | sed 's/^Backup-//')
	lastBackupSec=$(date -d "$lastTimeBackup" +"%s")
	let dDays=($nowSec-$lastBackupSec)/86400
	if [[ $dDays -lt "7" ]];
	then 
		haveRecentBackup=1
		break
	fi	
done


if [[ $haveRecentBackup -eq "0" ]];
then
	newDir="Backup-$now"
	mkdir /home/nekosmonavt/$newDir
	for sourceFile in $(ls -p $sourcePath | grep -hv "/");
	do
		newFileName=$(echo "/home/nekosmonavt/$newDir")
		backupedFile=$(echo "$sourcePath$sourceFile")
		cp $backupedFile $newFileName
	done
	echo "- $newDir created at $now" >> $backupReport
	echo "Files:" >> $backupReport
	ls /home/nekosmonavt/$newDir >> $backupReport
else
	touch modify.tmp
	touch new.tmp

	#NEED TO FIX THIS 

	for sourceFile in $(ls -p $sourcePath | grep -hv "/");
	do
		isNotNewFile=$(ls /home/nekosmonavt/$dir/ | grep -h "${sourceFile}" | wc -l)
		sourceWithPath=$(echo "$sourcePath$sourceFile")	
			
		if [[ $isNotNewFile -eq "0" ]];
		then
			newFile=$(echo $sourceWithPath | sed "s/\/source\//\/${dir}\//")
			cp $sourceWithPath $newFile
			echo $sourceFile >> new.tmp
		else
			alreadyBackupped=$(echo "/home/nekosmonavt/$dir/$sourceFile")
			cmp -s $sourceWithPath $alreadyBackupped ||
				{
					newName=$(echo "$alreadyBackupped.$now")
					mv $alreadyBackupped $newName
					path=$(echo "/home/nekosmonavt/$dir")
					cp $sourceWithPath $path
					echo "$sourceFile (new version)" >> modify.tmp
					echo "$alreadyBackupped -> $newName" | sed "s/\/home\/nekosmonavt\/${dir}\///g" >> modify.tmp
				}
		fi
		
	done
	
	echo "- $dir was changed at $now" >> $backupReport
	echo "Modified files:" >> $backupReport
	cat modify.tmp >> $backupReport
	echo "New files:" >> $backupReport
	cat new.tmp >> $backupReport

	rm modify.tmp
	rm new.tmp
fi

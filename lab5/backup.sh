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
	for sourceFile in $sourcePath*;
	do
		newFileName=$(echo $sourceFile | sed "s/source/${newDir}/")
		cp $sourceFile $newFileName
	done
	echo "- $newDir created at $now" >> $backupReport
	echo "Files:" >> $backupReport
	ls /home/nekosmonavt/$newDir >> $backupReport
else
	touch modify.tmp
	touch new.tmp

	#NEED TO FIX THIS 

	for sourceFile in $sourcePath*;
	do
		sourceFName=$(echo $surceFile | sed "s/${sourcePath}//")
		for alreadyBackupedFile in $dir*;
		do
			currentFileName=$(echo $alreadyBackupedFile | sed "s/${dir}//")
			if [[ $currentFileName == $sourceFName ]];
			then
				cmp -s $sourceFile $alreadyBackupedFile ||
					{
						newNameOfOldFile=$(echo "$currentFileName\.$now")
						mv $alreadyBackupedFile $dir$newNameOfOldFile
						cp $sourceFile $alreadyBackupedFile
						echo "$alreadyBackupedFile $dir$newNameOfOldFile" | sed 's/ /->/' >> modify.tmp
						echo "$sourceFile $alreadyBackupedFile" | sed 's/ /->/' >> new.tmp
					} 
			else
				cp $sourceFile $alreadyBackupedFile
				echo "$sourceFile $alreadyBackupedFile" | sed 's/ /->' >> new.tmp
			fi
		done
	done
	
	echo "- $dir was changed at $now" >> $backupReport
	echo "Modified files:" >> $backupReport
	cat modify.tmp >> $backupReport
	echo "New files:" >> $backupReport
	cat new.tmp >> $backupReport

	rm modify.tmp
	rm new.tmp
fi

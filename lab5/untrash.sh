#!/bin/bash

haveSmth=0

for line in $(grep -h "/$1" ~/.trash.log | awk '{print $1 "::" $2}');
do
	link=$(echo $line | sed 's/::/ /' | awk '{print $2}')
	path=$(echo $line | sed 's/::/ /' | awk '{print $1}')

	doesLinkExist=0
	restoreName=$(echo "$1 $link" | awk '{print "restored_" $2 "_" $1}')

	for file in ~/.trash/*;
	do
		fileName=$(echo $file | sed 's/\/.trash\// /' | awk '{print $2}')
		if [[ $fileName == $link ]];
		then
			doesLinkExist=1
			break
		fi
	done

	if [[ $doesLinkExist -eq "0" ]];
	then
		continue
	else
		haveSmth=1
	fi

	fullDirName=$(echo $path | sed "s/${1}/${restoreName}/")
	dir=$(echo $path | sed "s/${1}//")

	echo "to restore: $path (y/n)?"
	read answer
	case $answer in
		'y')
			if [[ -d $dir ]];
			then
				ln ~/.trash/$link $fullDirName
			else
				ln ~/.trash/$link ~/$restoreName
				echo "File have restored to home derictory"
			fi
			rm ~/.trash/$link
			;;
		'n')
			continue
			;;
		*)
			echo "ACHTUNG!!! Unknown entered value"
			exit
			;;
	esac
done

if [[ $haveSmth -eq "0" ]];
then
	echo "ACHTUNG!!! Restored file not found"
fi

#!/bin/bash

plusMode=1
result=1

(tail -n 0 -f task5file.txt) |
while true; do
	read line;
	case $line in
		'+')
			plusMode=1
			;;
		'm')
			plusMode=0
			;;
		'QUIT')
			echo "Exit"
			kill $(cat task5.pid)
			kill $$
			exit
			;;
		[0-9]*)
			if [[ $plusMode -eq "1" ]];
			then
				let result=$result+$line
			else
				let result=$result*$line
			fi

			echo "= $result"
			;;
		*)
			echo "ACHTUNG!!! Unknown Input"
			kill $(cat task5.pid)
			kill $$
			exit
			;;
	esac
done

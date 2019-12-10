#!/bin/bash

while true; do
	read line
	case $line in
		'TERM')
			kill -SIGTERM $(cat task7.pid)
			exit
			;;
		'+')
			kill -USR1 $(cat task7.pid)
			;;
		'm')
			kill -USR2 $(cat task7.pid)
			;;
	esac
done

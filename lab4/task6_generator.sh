#!/bin/bash

while true; do
	read line
	case $line in
		'TERM')
			kill -SIGTERM $(cat task6.pid)
			exit
			;;
		*)
			:
			;;
	esac
done

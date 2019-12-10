#!/bin/bash

echo $$ > task6.pid
value=1
MODE=0

sigterm()
{
	MODE=1
}

trap 'sigterm' SIGTERM
while true; do
	case $MODE in
		'0')
			let value=$value+1
			echo $value
			;;
		'1')
			echo 'Stopped by SIGTERM'
			exit
			;;
	esac
	sleep 5s
done	

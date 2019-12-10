#!/bin/bash

echo $$ > task7.pid

isWorking=1
plusMode=1
value=1

usr1()
{
	plusMode=1
}

usr2()
{
	plusMode=0
}

sigterm()
{
	isWorking=0
	echo "Handler shutdown"
	exit
}		

trap 'usr1' USR1
trap 'usr2' USR2
trap 'sigterm' SIGTERM

while [ $isWorking -eq 1 ]
do
	case $plusMode in
		'0')
			let value=$value*2
			;;
		'1')
			let value=$value+2
			;;
	esac
	
	echo "= $value"
	sleep 5s
done	

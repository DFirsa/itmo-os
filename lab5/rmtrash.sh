#!/bin/bash

if [ ! -e ".link.tmp" ]
then
	touch .link.tmp
	echo "0" > .link.tmp
fi

mkdir -p ~/.trash

linkName=$(cat .link.tmp)
let newName=$linkName+1
echo $newName > .link.tmp

ln $1 ~/.trash/$linkName || 
	{
		echo "ACHTUNG!!! File not found!" 
		exit
	}

rm $1
echo "$(realpath $1) $linkName" >> ~/.trash.log

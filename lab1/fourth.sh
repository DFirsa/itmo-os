#!/bin/bash

input=0
counter=0

while [ true ]
	do
		read input
		let counter=$counter+1
		if [[ $input%2 -eq 0 ]]
			then break
		fi
done

echo count of values is $counter

#!/bin/bash

input=""
result=""

while [ true ]
	do
		read input
		result="$result${input}"
		if [[ $input = "q" ]]
			then break
		fi
done

echo result is $result	

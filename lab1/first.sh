#!/bin/bash

echo first is $1
echo second is $2

if [[ $1 -eq $2 ]]
	then echo "first = second"
	else echo "first != second"
fi

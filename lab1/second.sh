#! /bin/bash

echo first is $1
echo second is $2
echo third is $3

max=$1

if [[ $max -lt $2 ]]
	then max=$2
fi

if [[ $max -lt $3 ]]
	then max=$3
fi

echo max is $max

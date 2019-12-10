#!/bin/bash

echo $$ > task5.pid

while true;
do
	read -r line
	echo $line >> task5file.txt
done

#!/bin/bash

for pr in $(ps -Ao pid)
do
	printf $pr
	cat /proc/$pr/statm | awk '{print ":" $2-$3}'
done

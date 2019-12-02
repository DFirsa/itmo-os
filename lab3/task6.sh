#!/bin/bash

echo "Average_Sleeping_Children_of_Parents_Processes_Info" >> pid.info

for ppid in $(cat pid.info | awk '{print $3}' | sed 's/Parent_ProcessID=//' | uniq)
do
	count=$(grep -o "Parent_ProcessID=$ppid" pid.info | uniq -c | sed 's/Parent_ProcessID=//'| awk '{print $1}')
	sumSleep=0

	for pSleep in $(grep "$ppid" pid.info | awk '{print $5}' | sed 's/Average_Sleeping_Time=//')
	do
		sumSleep=$(perl -e "print $sumSleep + $pSleep")
	done

	avg=$(perl -e "print $sumSleep / $count")
	grep -h "Parent_ProcessID=$ppid" pid.info >> pid2.info
	echo "Average_Sleeping_Time_Children_of_ParentID=$ppid is $avg" | sed 's/Parent_ProcessID=//' >> pid2.info
done

rm pid.info
cat pid2.info >> pid.info
rm pid2.info

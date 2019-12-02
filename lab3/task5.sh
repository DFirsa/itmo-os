#!/bin/bash

for pr in $(ps -Ao pid=)
do

	if [[ ! -f /proc/$pr/status ]]; then
		continue
	fi

	pid=$(grep "^Pid" /proc/$pr/status | awk '{print $2}')
	ppid=$(grep "^PPid" /proc/$pr/status | awk '{print $2}')
	sum=$(grep "^se.sum_exec_runtime" /proc/$pr/sched | awk '{print $3}')
	switch=$(grep "^nr_switches" /proc/$pr/sched | awk '{print $3}')	

	avg=-1
	if [[ $switch -ne "0" ]]; then
		avg=$(perl -e "print $sum/$switch")


	echo "$pid $ppid $avg" | sed 's/-1/-1LL/' >> pid.info

done

sort -nk2 pid.info | awk '{print "ProcessID=" $1 " : Parent_ProcessID=" $2 " : Average_Sleeping_Time=" $3}' > pid.info

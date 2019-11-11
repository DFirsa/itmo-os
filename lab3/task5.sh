#!/bin/bash

echo "" > pid.info

for pr in $(ps -Ao pid)
do
	if [[ ! -f /proc/$pr/status ]]; then
		continue
	fi

	pid=$(grep "^Pid" /proc/$pr/status | awk '{print $2}')
	ppid=$(grep "^PPid" /proc/$pr/status | awk '{print $2}')
	sum=$(grep "^se.sum_exec_runtime" /proc/$pr/sched | awk '{print $3}')
	switch=$(grep "^nr_switches" /proc/$pr/sched | awk '{print $3}')

	avg=-1
	if [[ $switch -gt "0" ]]; then
		let avg=$sum/$switch
	fi

	echo "${pid} ${ppid} ${avg}" | sed 's/-1/-1LL/' >> pid.info
done

#sort -nk2 pid.info | awk '{print "ProcessID=" $1 " : Parent ProcessID=" $2 " : Average Sleeping Time=" $3}' > pid.info

#!/bin/bash

ps -eo user,pid,cmd | grep "^root" | awk '{print $2 ":" $3}' > pid.info
wc -l < pid.info

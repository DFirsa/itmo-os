#!/bin/bash

ps -eo start,pid | sort -nrk 1 | head -n 2 | awk '{print $2}'

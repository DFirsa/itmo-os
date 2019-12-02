#!/bin/bash

ps -eo pid,cmd | grep "[[:digit:]] /sbin/"
# | awk '{print $1}'

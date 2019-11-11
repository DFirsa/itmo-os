#!/bin/bash

cat /etc/passwd | sort -t ':' -nk3 | awk -F ":" '{print $1 " " $3}'

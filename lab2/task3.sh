#!/bin/bash

emails="\<[a-z0-9A-Z_.]+@[a-z0-9A-Z_]+\.[a-zA-Z.]+\>"
grep -r -h -E -o -I -w $emails /etc/* | sort -u | awk '{printf $0 ", "}' > emails.lst

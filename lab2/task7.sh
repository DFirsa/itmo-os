#!/bin/bash

man bash | sed 's/\s/\n/g'| grep -vwE '\w{0,3}'| sort | uniq -c | sort -rn | head -n 3 | awk '{print $2}'

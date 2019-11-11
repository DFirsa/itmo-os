#!/bin/bash

grep "(WW)" /var/log/Xorg.0.log | sed 's/(WW)/Warning: /' > full.log
grep "(II)" /var/log/Xorg.0.log | sed 's/(II)/Information: /' >> full.log

cat full.log

#!/bin/bash

grep -r -x -H "^#!/.*" /bin | sed "s/*.//" | awk -F ":" '{print $2}' | sort | uniq -c | sort -rn | head -n1 | awk '{print $2}'

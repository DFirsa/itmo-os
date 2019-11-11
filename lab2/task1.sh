#!/bin/bash

grep -h -r "^ACPI" /var/log/* > errors.log
grep -h "[[:space:]]/" errors.log


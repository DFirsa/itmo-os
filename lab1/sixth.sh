#!/bin/bash

if [[ "$PWD" = "$HOME" ]]
	then
		echo $HOME
		exit 0
	else
		echo using catalogue is not home catalogue 
		exit 1
fi

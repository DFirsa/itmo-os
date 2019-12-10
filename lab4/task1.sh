#!/bin/bash

startTime=$(TZ=":Europe/Moscow" date | awk '{print $2 "_" $3 "_" $4 "_" $1 "_" $5}')

mkdir ~/test && {
	echo "catalog test was created succesfully" >> ~/report
	touch ~/test/$startTime
}

ping "www.net_nikogo.ru" || echo "resource not responsible" >> ~/report	

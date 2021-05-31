#!bin/bash

clear
db=`basename ${PWD}`

echo "###############################"
echo "Available tables in database '"${db}"':"
echo "###############################"

if [ "$(ls -A . 2> /dev/null)" ]; then
	tree --noreport -I '*meta*' . 
else
	echo "No tables in database '"${db}"'!!"
	echo "###############################"
	sleep 1
fi


#!bin/bash

clear

echo "###############################"
echo "Available Databases:"
echo "###############################"

if [ "$(ls -A ../storage/ 2> /dev/null)" ]; then
	cd "../storage/"
	tree --noreport -d  .
	cd ../scripts/
	echo "###############################"
else
	echo "No available databases!!"
	echo "###############################"
	sleep 2
fi




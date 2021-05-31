#!bin/bash

clear

echo "###############################"
echo "Available Databases:"
echo "###############################"

if [ "$(ls -A ../storage/ 2> /dev/null)" ]; then
	cd "../storage/"
	tree --noreport -d  .
	cd ../scripts/
else
	echo "No available databases!!"	
fi
echo "###############################"
read -sp 'Press Enter To Continue...'



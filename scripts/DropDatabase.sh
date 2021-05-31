#!bin/bash


. ./TempDBList.sh

while [ true ] && [ "$(ls -A ../storage/ 2> /dev/null)" ]
do
clear
	. ./TempDBList.sh	
	echo "Enter database name you want to delete: "
	read dbName
	
	echo "############################################"
	if [ ! -z "${dbName}" ] && [ -d  "../storage/$dbName" ];
	then
		cp -rn  "../storage/"${dbName}"" "../trach/deletedb/"
		rm -rf "../storage/"${dbName}""

		echo "Database '"${dbName}"' is Removed Successfully!!"
		echo "############################################"
		read -t 5 -n 1 -s -r -p "Press any key to continue..."
		. ./ListDatabases.sh
		break;

	else
		echo "ERROR!! Enter database name correctly...!!"
		echo "############################################"
		read -t 5 -n 1 -s -r -p "Press any key to continue..."

		
	fi
	
done


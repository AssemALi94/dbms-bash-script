#!/bin/bash

clear

while [ true ];
do
clear
	
	echo "#########################################"
	echo "------------Creating Database------------"
	echo "#########################################"
	echo "Enter Database name: "
	read dbName
	echo "#########################################"

	if  [[ ! ${dbName} =~ ^[[:alpha:]]+$ ]];
	then
		echo "ERROR: invalid Database name!! "
		echo "#########################################"
		read -t 5 -n 1 -s -r -p "Press any key to continue..."
	
	elif  [ -d "../storage/${dbName}" ];
	then
		echo "ERROR: Database name already exist!!"
		echo "#########################################"
		read -t 5 -n 1 -s -r -p "Press any key to continue..."
	else
		echo "Creating database ${dbName}...."
		echo "#########################################"
		if [ -d "../storage/" ];
		then
	        	cd "../storage/"
	        	mkdir "./${dbName}"
			cd "../scripts/"
		else
		        mkdir -p "../storage/${dbName}"
        	fi
		clear
		echo "#########################################"
		echo "Database '"${dbName}"' created successfully."
		echo "#########################################"
		read -t 5 -n 1 -s -r -p "Press any key to continue..."
		break
	fi	
done


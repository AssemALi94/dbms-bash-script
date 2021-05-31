#!/bin/bash
clear

. ./TempDBList.sh
while [ true ] && [ "$(ls -A ../storage/ 2> /dev/null)" ];
do
	clear
	. ./TempDBList.sh

	echo "Enter database name to connect:"
	read dbName
	echo "###############################"



	if [ ! -z "${dbName}" ] && [ -d  "../storage/${dbName}" ];
	then
		cd "../storage/"${dbName}"/"
		clear
		echo "####################################################"
		echo "Connection to Database '"${dbName}"' is Successfull."
		echo "####################################################"
		read -t 5 -n 1 -s -r -p "Press any key to continue..."
		break;

	else

		echo "Invalid!! Enter Name Correctly!"
		echo "###############################"
		read -t 5 -n 1 -s -r -p "Press any key to continue..."
	fi
	

done



while [ true ] && [ "$(ls -A ../../storage 2> /dev/null)" ]; do
clear
echo "##################################"
echo "Database '"${dbName}"' is connected."
echo "##################################"
PS3="Please choose an option: "
select option in "Create Table" "List Tables" "Drop Table" "Insert Into Table" "Select From Table" "Update Table"  "Delete Row" "Back To Home"
do
	case $REPLY in
	1 ) . ../../scripts/CreateTable.sh; break ;;
	2 ) . ../../scripts/ListTables.sh; break ;;
	3 ) . ../../scripts/DropTable.sh; break ;;
      	4 ) . ../../scripts/Insert.sh; break ;;
	5 ) . ../../scripts/Select.sh; break  ;;
	6 ) . ../../scripts/Update.sh; break  ;;	  		  	
	7 ) . ../../scripts/Delete.sh; break ;;
	8 ) cd ../../scripts/; break  ;; 
	* ) echo "Wrong option!!..please enter number from 1 to 8.";  
		 ;;
	esac
done
done

#!bin/bash

clear
db=`basename ${PWD}`
. ../../scripts/TmpTabList.sh
while [ true ] && [ "$(ls -A . 2> /dev/null)" ];
do
clear
	. ../../scripts/TmpTabList.sh
	echo "#####################################################"
	echo "**Note: Table and table-meta file will be deleted...!"
	echo "#####################################################"
	echo "Enter table name you want to delete: "
	read tabName
	echo "############################################"
	
	if  [ ! -z "${dbName}" ] && [ -f  "${tabName}".json ];
	then
		
		mv -f "${tabName}".json "../../trach/deletedtab/"
		mv -f "${tabName}"-meta.json "../../trach/deletedtab/"

		echo "Table '"${tabName}"' is removed successfully!!"
		echo "############################################"
		read -t 5 -n 1 -s -r -p "Press any key to continue..."
		. ../../scripts/ListTables.sh
		break;

	else
		echo "Please enter table name correctly...!!"
		echo "############################################"
		read -t 5 -n 1 -s -r -p "Press any key to continue..."

	fi
	
done


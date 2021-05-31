#!bin/bash

clear


#listing tables for user
. ../../scripts/TmpTabList.sh

while [ "$(ls -A . 2> /dev/null)" ];
do

while [ true ];
do

	. ../../scripts/TmpTabList.sh
	echo "#############################################"
	echo "Enter table name to insert into: "
	echo "***Enter without json extension only name."
	echo "#############################################"
	read tabName
	echo "#############################################"
	

	if  [ -f  "${tabName}".json ] && [ -f  "${tabName}"-meta.json ];
	then
		echo "Fetching table "${tabName}" meta data..."
		echo "#############################################"
		read -t 5 -n 1 -s -r -p "Press any key to continue..."
		break;

	else
		echo "Enter table name correctly and without extension!"
		read -t 5 -n 1 -s -r -p "Press any key to continue..."
	fi
	echo "#################################################"
done

clear

#fetching meta data

colCount=`jq '.colCount' "${tabName}"-meta.json`
pkey=`jq '.pkey' "${tabName}"-meta.json`
pkTyp=`jq '.colTypes[0]' "${tabName}"-meta.json`
lastPkey=`jq '.lastPkey' "${tabName}"-meta.json`
colNames=`jq '.colNames[]' "${tabName}"-meta.json`
colTypes=`jq '.colTypes[]' "${tabName}"-meta.json`



while [ true ];
	do
	clear
		echo "Table "${tabName}" is fetched..!!"
		PS3="Please select an option: "
		select OPTIONS in "Select '"${tabName}"' Table" "Select Columns" "Select Rows By "${pkey}"" "Exit"

		do
		case $REPLY in
		1 ) . ../../scripts/SelectTable.sh "${tabName}"; break ;;
		2 ) . ../../scripts/SelectColumns.sh "${tabName}";  break ;;
		3 ) . ../../scripts/SelectRows.sh "${tabName}"; break ;;
		4 )  break 2;;
		* ) echo "Wrong option!!..please enter number from 1 to 4!!!"; 
		sleep 1;  break ;;
		esac
	done 

done 
break
done


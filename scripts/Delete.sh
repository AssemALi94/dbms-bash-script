#!bin/bash

clear
db=`basename ${PWD}`

#listing tables for user
. ../../scripts/TmpTabList.sh

while [ "$(ls -A . 2> /dev/null)" ];
do

while [ true ];
do

	. ../../scripts/TmpTabList.sh
	echo "#############################################"
	echo "Enter table name to delete from: "
	echo "***Enter without json extension only name."
	echo "#############################################"
	read tabName
	echo "#############################################"
	

	if  [ -f  "${tabName}".json ] && [ -f  "${tabName}"-meta.json ];
	then
		echo "Fetching table "${tabName}" meta data..."
		sleep 1
		read -t 5 -n 1 -s -r -p "Press any key to continue..."
		break;

	else
		echo "Enter table name correctly and without extension!"
		read -t 5 -n 1 -s -r -p "Press any key to continue..."
	fi
	echo "#################################################"
done

clear

#fetching pkey value data


pkey=`jq '.pkey' "${tabName}"-meta.json`
pkTyp=`jq '.colTypes[0]' "${tabName}"-meta.json`


while [ true ];
do
clear
		echo "########################################"		
		echo "Now enter row's "${pkey}" value to delete."
		echo "########################################"		
		read delpk
		echo "########################################"

		
		if [  "${pkTyp}" == '"int"' ] && [[  ${delpk} =~ ^[0-9]+$ ]]; then
		
			pkeys=`jq --argjson pk "${pkey}" --argjson dpk "${delpk}" '.[]|.[$pk] == $dpk' "${tabName}".json`		
		
		elif [  "${pkTyp}" == '"str"' ] && [[  "${delpk}" =~ ^[[:alpha:]]+$ ]]; then
			
			pkeys=`jq --argjson pk "${pkey}" --argjson dpk "${delpk}" '.[]|.[$pk] == $dpk' "${tabName}".json`		
		else 
			echo "ERROR: Invalid entry!!"
			echo "########################################"
			read -t 5 -n 1 -s -r -p "Press any key to continue..."
			continue
		
		fi		
		
		if [[ "${pkeys[@]}" =~ true ]];then
			
			echo "Deleted row can't be undone!!"
			echo "########################################"
			read -t 5 -n 1 -s -r -p "Press any key to continue..."
			echo
			
			##fetching index of raw to be deleted then delete it by apply to array	
			pdIndex=`jq --argjson pk "${delpk}" --argjson k "${pkey}" ' map(.[$k]  == $pk) | index(true) ' "${tabName}".json`
			jq --argjson d "${pdIndex}" 'del(.[$d])' "${tabName}".json > delraw.tmp && mv delraw.tmp "${tabName}".json
			clear
			echo "########################################"		
			echo "Table row with "${pkey}" value = "${delpk}" "
			echo "Is deleted successfully!!"	
			echo "########################################"	
			read -t 5 -n 1 -s -r -p "Press any key to continue..."
			break

			
		else
			echo "ERROR: "${pkey}" = "${delpk}" not found!!"
			echo "########################################"
			read -t 5 -n 1 -s -r -p "Press any key to continue..."
	
		fi

done

break

done

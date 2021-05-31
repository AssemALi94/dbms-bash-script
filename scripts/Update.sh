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
	echo "Enter table name to update in: "
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

colCount=`jq '.colCount' "${tabName}"-meta.json`
pkey=`jq '.pkey' "${tabName}"-meta.json`
pkTyp=`jq '.colTypes[0]' "${tabName}"-meta.json`
colNames=`jq '.colNames[]' "${tabName}"-meta.json`
colTypes=`jq '.colTypes[]' "${tabName}"-meta.json`

#for saving input data along with table names
declare -a colRaw=()

while [ true ];
do
clear
		echo "########################################"		
		echo "Now enter row's "${pkey}" value to update."
		echo "########################################"		
		read upk
		echo "########################################"

		
		if [  "${pkTyp}" == '"int"' ] && [[  ${upk} =~ ^[0-9]+$ ]]; then
		
			pkeys=`jq --argjson pk "${pkey}" --argjson uppk "${upk}" '.[]|.[$pk] == $uppk' "${tabName}".json`		
		
		elif [  "${pkTyp}" == '"str"' ] && [[  "${upk}" =~ ^[[:alpha:]]+$ ]]; then
			
			pkeys=`jq --argjson pk "${pkey}" --argjson uppk "${upk}" '.[]|.[$pk] == $uppk' "${tabName}".json`		
		else 
			echo "ERROR: Invalid entry!!"
			echo "########################################"
			read -t 5 -n 1 -s -r -p "Press any key to continue..."
			continue
		
		fi		
		
		if [[ "${pkeys[@]}" =~ true ]];then

			echo "Updating row can't be undone!!"
			echo "########################################"
			read -t 5 -n 1 -s -r -p "Press any key to continue..."
			echo
			colRaw+=("${pkey}"':'${upk}'')
			##fetching index of raw to be updated.
			upIndex=`jq --argjson pk "${upk}" --argjson k "${pkey}" ' map(.[$k]  == $pk) | index(true) ' "${tabName}".json`
			
			for ((i = 1 ; i < ${colCount} ; i++)); do

			while [ true ] 
			do
				clear
				currName=`jq --argjson n "$i" '.colNames[$n]' "${tabName}"-meta.json`
				currType=`jq --argjson t "$i" '.colTypes[$t]' "${tabName}"-meta.json`
				echo "##################################"
				echo "Enter new "${currName}" for row "${pkey}"="${upk}" "
				echo "##################################"
				echo "Column Type: "${currType}""
				echo "##################################"
				read inCol
				echo "##################################"

				if [  "${currType}" == '"str"' ] && [[  ${inCol} =~ ^[[:alpha:]]+$ ]];
				then
	    				colRaw+=(','${currName}':"'$inCol'"')
					echo "Entered value accepted."
					echo "##################################"
					read -t 5 -n 1 -s -r -p "Press any key to continue..."
        				break
				elif [  "${currType}" == '"int"' ] && [[  ${inCol} =~ ^[[:digit:]]+$ ]];
				then
	    				colRaw+=(','${currName}': '$inCol'')
					echo "Entered value accepted."
					echo "##################################"
					read -t 5 -n 1 -s -r -p "Press any key to continue..."
        				break
				else
					echo "ERROR: invalid column type or value!!"
					echo "##################################"
					read -t 5 -n 1 -s -r -p "Press any key to continue..."
	
				fi
				done
				done

				#constructing updated values
				jsRaw='{'${colRaw[@]}'}'

				#saving updated data into table
				jq  --argjson ind "${upIndex}" --argjson upd "${jsRaw}" '.[$ind]=$upd' "${tabName}".json > out.tmp && mv out.tmp "${tabName}".json
				clear
				echo "########################################"		
				echo "Table row with "${pkey}" value = "${upk}" "
				echo "Is updated successfully"	
				echo "########################################"	
				read -t 5 -n 1 -s -r -p "Press any key to continue..."
				break

			
		else
			echo "ERROR: "${pkey}" = "${upk}" not found!!"
			echo "########################################"
			read -t 5 -n 1 -s -r -p "Press any key to continue..."
	
		fi

done

break

done

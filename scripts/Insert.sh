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
	echo "Enter table name to insert into: "
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

#fetching meta data

colCount=`jq '.colCount' "${tabName}"-meta.json`
pkey=`jq '.pkey' "${tabName}"-meta.json`
pkTyp=`jq '.colTypes[0]' "${tabName}"-meta.json`
lastPkey=`jq '.lastPkey' "${tabName}"-meta.json`
colNames=`jq '.colNames[]' "${tabName}"-meta.json`
colTypes=`jq '.colTypes[]' "${tabName}"-meta.json`

#for saving input data along with table names
declare -a colRaw=()

while [ true ];
do
clear
		echo "########################################"		
		echo "Now enter primary key "${pkey}" value."
		echo "Last inserted value is ["${lastPkey}"]."
		echo "########################################"		
		echo  "Insert into primary key column "${pkey}""
		echo "########################################"
		echo "Column Type: "${pkTyp}""
		echo "########################################"
		read inpk
		echo "########################################"


		if [  "${pkTyp}" == '"int"' ] && [[  ${inpk} =~ ^[0-9]+$ ]]; then
		
			pkeys=`jq --argjson pk "${pkey}" --argjson ipk "${inpk}" '.[]|.[$pk] == $ipk' "${tabName}".json`
		
		elif [  "${pkTyp}" == '"str"' ] && [[  "${inpk}" =~ ^[[:alpha:]]+$ ]]; then
			
			pkeys=`jq --argjson pk "${pkey}" --argjson ipk "${inpk}" '.[]|.[$pk] == $ipk' "${tabName}".json`
		else 
			echo "ERROR: Invalid entry!!"
			echo "########################################"
			read -t 5 -n 1 -s -r -p "Press any key to continue..."
			continue
		
		fi
		
		
		if [[ "${pkeys[@]}" =~ true ]]; then

			echo "Error!! Value already exist."
			read -t 5 -n 1 -s -r -p "Press any key to continue..."

		elif [  "${pkTyp}" == '"int"' ];
		then
	    		colRaw+=("${pkey}" : "${inpk}")
			echo "Entered value accepted."
			echo "########################################"
			read -t 5 -n 1 -s -r -p "Press any key to continue..."
        		break


		elif [  "${pkTyp}" == "str" ];
		then
	    		colRaw+=("${pkey}"':"'${inpk}'"')
			echo "Entered value accepted."
			echo "########################################"
			read -t 5 -n 1 -s -r -p "Press any key to continue..."
        		break

	
		fi
done




for ((i = 1 ; i < ${colCount} ; i++)); do

while [ true ] 
do
clear
		currName=`jq --argjson n "$i" '.colNames[$n]' "${tabName}"-meta.json`
		currType=`jq --argjson t "$i" '.colTypes[$t]' "${tabName}"-meta.json`

		echo "##################################"
		echo "Insert into column "${currName}""
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

#constructing inserted values
jsRaw='{'${colRaw[@]}'}'



#saving insertion finally into table
cat "${tabName}".json | jq --argjson inp "$jsRaw" '. += [$inp]' > out.tmp && mv out.tmp "${tabName}".json
cat "${tabName}"-meta.json | jq --argjson lpk "${inpk}" '.lastPkey = $lpk' > out2.tmp && mv out2.tmp "${tabName}"-meta.json

clear
echo "#########################################"
echo "All data inserted successfully into '"${tabName}"' table."
echo "#########################################"
read -t 5 -n 1 -s -r -p "Press any key to continue..."
break
done

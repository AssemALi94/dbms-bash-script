#!/bin/bash
clear

#fetch database name.

db=`basename ${PWD}`



while true
do
clear
	echo "#########################################"
	echo "Create Table in Database '"$db"'"
	echo "#########################################"
	echo "Enter Table Name Correctly:"
	read tabName
	echo "#########################################"

	if [[ ! ${tabName} =~ ^[[:alpha:]]+$ ]];
	then
		echo "ERROR: Invalid table name!! "
		echo "#########################################"
		read -t 5 -n 1 -s -r -p "Press any key to continue..."
		
	elif  [ -f "./${tabName}.json" ];
	then
		echo "ERROR: Table name already exist!!"
		echo "#########################################"
		read -t 5 -n 1 -s -r -p "Press any key to continue..."
	else	
		echo "Table name '"${tabName}"' saved successfully"
		echo "#########################################"
		read -t 5 -n 1 -s -r -p "Press any key to continue..."
        	break
     	fi
	

done

clear

#getting number of columns
while [ true ]
do
clear
		echo "#########################################"
		echo "Create Table '"${tabName}"' in Database '"$db"'"
		echo "#########################################"		
		echo "Please enter number of columns required"
		echo "#########################################"
		read numc

		echo "#########################################"
		if [[ ! ${numc} =~ ^[[:digit:]]+$ ]] || [ ! ${numc} -gt 1 ];
		then
			echo "ERROR: Not valid!!...Enter number greater than 1. "
			echo "##################################################"
			read -t 5 -n 1 -s -r -p "Press any key to continue..."
		else
			echo "Number of columns is => '"${numc}"'"
			echo "#########################################"
			read -t 5 -n 1 -s -r -p "Press any key to continue..."
			break
		fi	
done

#getting primary key name and type
while [ true ]
do
clear
		echo "#########################################"
		echo "Create Table '"${tabName}"' in Database '"$db"'"
		echo "#########################################"
		echo "Please enter primary key name."
		echo "#########################################"
		read pkey
		echo "#########################################"

		if [[ ! ${pkey} =~ ^[[:alpha:]]+$ ]];
		then
			echo "ERROR: Invalid Name!!"
			echo "#########################################"
			read -t 5 -n 1 -s -r -p "Press any key to continue..."
		else
					
			echo "Primary key column name is => '"${pkey}"'"
			echo "######################################################"
			
			while [ true ];
			do
				echo "Select primary key '"${pkey}"' type from types=[int,str]"
				echo "######################################################"
				read typePk
				echo "######################################################"

				if [  "${typePk}" == "int" ] || [ "${typePk}" == "str" ];
				then

					echo "Primary key type is set to '"${typePk}"'"
					echo "######################################################"
					read -t 5 -n 1 -s -r -p "Press any key to continue..."
        				break
			
				else
					echo "ERROR: invalid column type!!"
					echo "######################################################"
				fi
			done
			break
		fi	
done

clear

#saving number to prompt user.
let remCol=numc-1;


#saving columns name in arr
declare -a clnames=()

#saving columns types in arr
declare -a cltypes=()


for ((i = 1 ; i < ${numc} ; i++)); do
n=$((i+1))
	
while [ true ]
do
		clear
		echo "######################################################"
		echo "Now please enter names and types for remaining columns"
		echo "Remaining columns is:'"${remCol}"'"
		echo "######################################################"

		echo "Enter column no.'"${n}"' name:"
		echo "######################################################"
		read namec
		echo "######################################################"

		if [[ ! ${namec} =~ ^[[:alpha:]]+$ ]];
		then
			echo "ERROR: invalid column name!! "
			echo "######################################################"
			read -t 5 -n 1 -s -r -p "Press any key to continue..."
	
		elif  [[ "${clnames[@]}" =~ ',"'${namec}'"' ]] || [  ${namec} == ${pkey} ];
		then
			echo "ERROR: column name already exist!!"
			echo "######################################################"
			read -t 5 -n 1 -s -r -p "Press any key to continue..."
		else
			clnames+=(',"'${namec}'"')
			echo "Column '"${namec}"' is added to table."
			echo "######################################################"
			while [ true ];
			do

				echo "Select column '"${namec}"' type from types=[int,str]"
				echo "######################################################"
				read typec
				echo "######################################################"

				if [  ${typec} == "int" ] || [ ${typec} == "str" ];
				then
		    			cltypes+=(',"'$typec'"')
					echo "Column type is set to '"${typec}"'"
					echo "######################################################"
					read -t 5 -n 1 -s -r -p "Press any key to continue..."
        				break
				else
					echo "ERROR: invalid column type!!"
					echo "######################################################"

	
				fi
			done
        	break
		fi
	
done
  ((remCol--))

done

#creating table and meta table


jsmeta='{"tableName":"'${tabName}'","colCount":'${numc}',"pkey":"'${pkey}'",colNames:["'${pkey}'"'"${clnames[@]}"'],colTypes:["'"${typePk}"'"'${cltypes[@]}'],"lastPkey":null}'

#parsing json table using jq command
jq -n "$jsmeta"  > "${tabName}"-meta.json

#intializing table
echo '[]' | jq . > ${tabName}.json

clear
#done
echo "#########################################"
echo "Table '"${tabName}"' created successfully." 
echo "#########################################"
read -t 5 -n 1 -s -r -p "Press any key to continue..."

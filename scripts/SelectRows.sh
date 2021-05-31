#!bin/bash
clear

pkey=`jq '.pkey' "${1}"-meta.json`


while [ true ]
do
clear
		echo "###################################"
		echo "Selecting Columns From Table '"${1}"' "
		echo "###################################"
		echo "Please enter "${pkey}" value to select"
		echo "###################################"
		read inpk
		clear
		echo "###################################"
		if [ "$(jq --argjson ipk "${inpk}" --argjson pk "${pkey}"  '.[] | select(.[$pk]==$ipk)' $1.json )" ];then
		
		echo "Row with "${pkey}" = "${inpk}" is:"
		echo "###################################"
		jq --argjson ipk "${inpk}" --argjson pk "${pkey}"  '.[] | select(.[$pk]==$ipk)' $1.json | column -t -s':' | tr -d '{},"'
		echo "###################################"
		echo "Json Form"
		echo "###################################"
		jq --argjson ipk "${inpk}" --argjson pk "${pkey}"  '.[] | select(.[$pk]==$ipk)' $1.json
		echo "###################################"
			echo "Press enter to continue..."
			read -s nothing
			break 
		else
			echo "Invalid "${pkey}" value!!!"
		echo "###################################"
			
			
		fi	
done



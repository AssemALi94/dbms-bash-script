#!bin/bash

clear
colCount=`jq '.colCount' "${1}"-meta.json`
colNames=`jq '.colNames' "${1}"-meta.json`


declare -a colmsReq=()
for i in ` jq '.colNames[]' dd-meta.json`;do colms+=($i); done
while [ true ]
do
clear
		echo "#########################################"
		echo "Selecting Columns From Table '"${1}"' "
		echo "#########################################"		
		echo "Please enter number of columns required"
		echo "#########################################"
		read numc

		echo "#########################################"
		if [[ ! ${numc} =~ ^[[:digit:]]+$ ]] || [[ ! ${numc} -gt 0 || ${numc} -gt "${colCount}" ]];
		then
			echo "ERROR: Not valid!!...Enter number between 1 and "${colCount}". "
			echo "##################################################"
			read -t 5 -n 1 -s -r -p "Press any key to continue..."
		else
			echo "Number of columns required => '"${numc}"'"
			echo "#########################################"
			read -t 5 -n 1 -s -r -p "Press any key to continue..."
			break
		fi	
done


for ((i = 0 ; i < ${numc} ; i++)); do

while [ true ] 
do
clear
		echo "##################################"
		echo "Table coulmns"
		echo "##################################"
		jq -r '.colNames[]' "${1}"-meta.json
		echo "##################################"
		echo "Enter required column name "
		echo "##################################"
		read inCol
		echo "##################################"

		if [ "$(jq --arg col "${inCol}" '.[] | select(.[$col])' $1.json )" ];then
		
	    		colmsReq+=( ${inCol} )
			echo "Entered value accepted."
			echo "##################################"
			read -t 5 -n 1 -s -r -p "Press any key to continue..."
			echo			
			echo "##################################"
        		break
		else
			echo "ERROR: column name not found!!"
			echo "##################################"
			read -t 5 -n 1 -s -r -p "Press any key to continue..."
			echo "##################################"
	
		fi
done
done

for colm in ${colmsReq[@]};
do 
	echo $colm >>tmp1.txt			
	jq  -r --arg col "${colm}" '.[]|.[$col]' ${1}.json  >> tmp2.txt
done
		  

clear
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
cat tmp1.txt | pr  --column $numc -t -s'		'

printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -

cat tmp2.txt | pr  --column $numc -t -s'		' 
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -

echo "Press Enter to continue"
read -s nothing
#cleaning
rm tmp1.txt
rm tmp2.txt	

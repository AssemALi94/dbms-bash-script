#!/bin/bash
# This is the interface of database engine

clear;
if ! [ -x "$(command -v jq)" ]; then
	echo "ERROR!!!!!!!"
	echo "jq - Command line JSON processor is missing..!!" >&2
	echo "JS-Unix won't work unless jq is installed " >&2
	echo "Program will exit in 5 sec.."	
	read -t 5 -n 1 -s -r -p "Press any key to exit..."
	exit
else
	while [ true ];
	do
	clear
		echo "Hello, `echo $USER` welcome to Js-UNIX Database Management System!!"
		PS3="Please select an option: "
		select OPTIONS in "Create Database" "List Databases" "Connect To Databases" "Drop Database" "Empty Trash" "About Program" "Exit"

		do
		case $REPLY in
		1 ) source CreateDatabase.sh; break ;;
		2 ) source ListDatabases.sh; break ;;
		3 ) source ConnectMenu.sh; break ;;
		4 ) source DropDatabase.sh; break ;;
		5 ) source EmptyTrash.sh; break ;;
		6 ) more ReadMe; clear;break;; 	
		7 ) echo "Thanks for using Js-UNIX...Preogram will exit now!!"; sleep 1; clear ; exit 0;;
		* ) echo "Wrong option!!..please enter number from 1 to 7."; 
		sleep 1;  break ;;
		esac
	done 
done 
fi

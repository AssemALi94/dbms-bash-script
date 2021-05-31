#!bin/bash

clear

if  [ "$(ls -A ../trach/deletedb/ 2> /dev/null)" ] && [ "$(ls -A ../trach/deletedtab/ 2> /dev/null)" ]; then


		echo "###################################################"
		echo "Clearing the trash can't be undone are you sure?!!!"
		echo "###################################################"
		read -t 5 -n 1 -s -r -p "Press any key to continue..."
		echo

		shopt -s dotglob

		rm -rfv  ../trach/deletedb/* 
		rm -rfv ../trach/deletedtab/*
		
		shopt -u dotglob

		clear
		echo "###################"
		echo "Trash Is Empty!!"
		echo "###################"
		read -t 5 -n 1 -s -r -p "Press any key to continue..."
		echo
		echo "###################"		

else
		echo "###################"
		echo "Trash Is Empty!!"
		echo "###################"
		read -t 5 -n 1 -s -r -p "Press any key to continue..."
		echo
		echo "###################"

		
fi
	



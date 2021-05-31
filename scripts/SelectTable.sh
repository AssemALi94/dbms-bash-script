#!bin/bash

clear

printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -

echo "Table '"${1}"'"
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -

jq -r '(.[0] | keys_unsorted) as $keys | ($keys | @tsv)' "${1}".json
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
jq -r '(.[0] | keys_unsorted) as $keys | map([.[ $keys[] ]])[] | @tsv' "${1}".json
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -

read -sp "Press enter to continue...."   
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -


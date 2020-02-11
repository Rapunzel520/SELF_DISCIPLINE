#!/bin/bash

if [[ ! -z $1 ]]; then
	echo $1 | egrep "(19|20)[0-9][0-9]-(0[1-9]|1[0-2])-(0[1-9]|1[0-9]|2[0-9]|3[01])" >/dev/null
	if [[ $? -eq 0 ]]; then
		DAY=$1
	else
		echo "$1不符合要求(yyyy-MM-dd)"
		exit
	fi
else
	DAY=$(date +%F)
fi


YEAR=$(echo ${DAY} | awk -F'-' '{print $1}')
MONTH=$(echo ${DAY} | awk -F'-' '{print $2}')
COMMIT_MESSAGE=$(echo ${DAY} | tr -d '-')

[ ! -d ${YEAR} ] && mkdir ${YEAR}
cd ${YEAR}
[ ! -d ${MONTH} ] && mkdir ${MONTH}
cd ${MONTH}
echo -e "\033[31mecho \"${DAY}\" > ${COMMIT_MESSAGE}.md\033[0m"
echo ${DAY} > ${COMMIT_MESSAGE}.md
echo -e "\033[31mgit add ${COMMIT_MESSAGE}.md\033[0m"
git add ${COMMIT_MESSAGE}.md
echo -e "\033[31mgit commit -m \"${COMMIT_MESSAGE}\"\033[0m"
git commit -m "${COMMIT_MESSAGE}"
echo -e "\033[31mgit push origin master\033[0m"
git push origin master


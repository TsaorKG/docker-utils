#!/bin/bash
# Author : Gabriel Walbron
# Date : 23/03/2018
# Configuration
# Adapt to your env
USER=''
MANAGER=''
SSHKEY=''
# Colors
RED='\033[0;31m'
C='\033[0;36m'
NC='\033[0m'

# Start 
NODES=($(ssh -i .ssh/${SSHKEY}  ${USER}@${MANAGER} "docker service ps -f 'desired-state=running' --format '{{.Node}}' $1"))
COLUMNS=$(tput cols)
if [ ${#NODES[@]} -eq 0 ]; then
	echo "${C}The service does not exist or is not running${NC}"
elif [ ${#NODES[@]} -eq 1 ]; then
	echo "${C}Container found${NC}"
	id=$(ssh -i .ssh/${SSHKEY}  ${USER}@${NODES[0]} "docker ps -f 'name=$1' --format '{{.ID}}'")
	echo -e "${C}Run : ${NC}${RED}docker exec -it $id bash -c 'stty cols $COLUMNS; bash'${NC}"
	ssh -i .ssh/${SSHKEY}  ${USER}@${NODES[0]}	
else
	for i in "${!NODES[@]}"
	do
        echo -e "${RED}$i${NC}${C} => ${NODES[i]}${NC}"
	done
	echo -e "${C}Choose which node to exec${NC}"
	read -p "Enter node indice : " index
	id=$(ssh -i .ssh/${SSHKEY}  ${USER}@${NODES[$index]} "docker ps -f 'name=$1' --format '{{.ID}}'")
	echo -e "${C}Run : ${NC}${RED}docker exec -it $id bash -c 'stty cols $COLUMNS; bash'${NC}"
        ssh -i .ssh/${SSHKEY}  ${USER}@${NODES[$index]}

fi

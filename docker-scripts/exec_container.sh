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
NC='\033[0m'

# Start 
NODES=($(ssh -i .ssh/${SSHKEY}  ${USER}@${MANAGER} "docker service ps -f 'desired-state=running' --format '{{.Node}}' $1"))
COLUMNS=$(tput cols)
if [ ${#NODES[@]} -eq 0 ]; then
	echo "The service does not exist or is not running"
elif [ ${#NODES[@]} -eq 1 ]; then
	echo "Container found"
	id=$(ssh -i .ssh/${SSHKEY}  ${USER}@${NODES[0]} "docker ps -f 'name=$1' --format '{{.ID}}'")
	echo -e "Run : ${RED}docker exec -it $id bash -c 'stty cols $COLUMNS; bash'${NC}"
	ssh -i .ssh/${SSHKEY}  ${USER}@${NODES[0]}	
else
	for i in "${!NODES[@]}"
	do
        echo -e "${RED}$i${NC} => ${NODES[i]}"
	done
	echo "Choose which node to exec"
	read -p "Enter node indice : " index
	id=$(ssh -i .ssh/${SSHKEY}  ${USER}@${NODES[$index]} "docker ps -f 'name=$1' --format '{{.ID}}'")
	echo -e "Run : ${RED}docker exec -it $id bash -c 'stty cols $COLUMNS; bash'${NC}"
        ssh -i .ssh/${SSHKEY}  ${USER}@${NODES[$index]}

fi

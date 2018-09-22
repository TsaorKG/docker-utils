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

# Define inspect method
inspect () {
	state=$(ssh -i .ssh/${SSHKEY}  ${USER}@${NODES[$1]} "docker inspect --format='Desired status = {{println .State.Status}}Running = {{.State.Running}}'  $2")
	mount=$(ssh -i .ssh/${SSHKEY}  ${USER}@${NODES[$1]} "docker inspect --format '{{range .Mounts}}Source = {{println .Source}}Destination = {{println .Destination}}{{end}}' $2")
	create_time=$(ssh -i .ssh/${SSHKEY}  ${USER}@${NODES[$1]} "docker inspect --format='{{json .Created}}' $2")
	image=$(ssh -i .ssh/${SSHKEY}  ${USER}@${NODES[$1]} "docker inspect --format='{{json .Config.Image}}' $2")
	networks=$(ssh -i .ssh/${SSHKEY}  ${USER}@${NODES[$1]} "docker inspect --format='Networks : {{println}}{{range $key, $value := .NetworkSettings.Networks}}{{println $key }}{{end}}' $2")
	root_size=$(ssh -i .ssh/${SSHKEY}  ${USER}@${NODES[$1]} "docker inspect --size --format='{{.SizeRootFs}}' $2")
	root_size=$(($root_size / 1048576))
	echo -e "${RED}Running Image :${NC} $image"
	echo -e "${RED}Since :${NC} $create_time"
	echo -e "${RED}State :${NC} $state"
	echo -e "${RED}Networks :${NC} $networks"
	echo -e "${RED}Mountpoint :${NC} $mount"
	echo -e "${RED}Size of '/' =${NC} $root_size MB"
}

# Start 
NODES=($(ssh -i .ssh/${SSHKEY}  ${USER}@${MANAGER} "docker service ps -f 'desired-state=running' --format '{{.Node}}' $1"))
if [ ${#NODES[@]} -eq 0 ]; then
	echo "The service does not exist or is not running"
elif [ ${#NODES[@]} -eq 1 ]; then
	echo "Container found on node ${NODES[0]}"
	id=$(ssh -i .ssh/${SSHKEY}  ${USER}@${NODES[0]} "docker ps -f 'name=$1' --format '{{.ID}}'")
	inspect 0 $id
else
	echo "Container found on nodes :"
	for i in "${!NODES[@]}"
	do
        echo -e "${RED}$i${NC} => ${NODES[i]}"
	done
	echo "Choose which node to inspect"
	read -p "Enter node indice : " index
	id=$(ssh -i .ssh/${SSHKEY}  ${USER}@${NODES[$index]} "docker ps -f 'name=$1' --format '{{.ID}}'")
	inspect $index $id
fi
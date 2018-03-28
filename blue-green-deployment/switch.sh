#!/bin/bash
# Author : Gabriel Walbron
# Date : 27/03/2018
B='\033[0;34m'
G='\033[0;32m'
C='\033[0;36m'
NC='\033[0m'
echo -e "${C}Starting the switch process${NC}"
ID=$(docker ps -f 'name=test_bg' --format '{{.ID}}')
if [ ${#ID[@]} -eq 0 ]; then
	echo -e "${C}The service does not exist or is not running${NC}"
elif [ ${#ID[@]} -eq 1 ]; then
	COLOR=$(docker exec ${ID[0]} bash -c 'echo "$COLOR"')
    echo -e "${C}$COLOR stack is online${NC}"
else
	COLOR=$(docker exec ${ID[0]} bash -c 'echo "$COLOR"')
    echo -e "${C}$COLOR stack is online${NC}"
fi
echo -e "${C}Scaling container blue-green to 2${NC}"
docker service scale test_bg=2
if [ $COLOR = "blue" ]; then
    echo -e "${G}Switching to green stack${NC}"
    echo -e "${B}[ ][ ][ ][ ][ ][ ]${NC}    ${G}[ ][ ][ ][ ][ ][ ]${NC}"
    echo -e "${B}[ ][ ][ ][ ][ ][ ]${NC}    ${G}[ ][ ][ ][ ][ ][ ]${NC}"
    echo -e "${B}[ ][ ][ ][ ][ ][ ]${NC}${C}--->${NC}${G}[ ][ ][ ][ ][ ][ ]${NC}"
    echo -e "${B}[ ][ ][ ][ ][ ][ ]${NC}    ${G}[ ][ ][ ][ ][ ][ ]${NC}"
    echo -e "${B}[ ][ ][ ][ ][ ][ ]${NC}    ${G}[ ][ ][ ][ ][ ][ ]${NC}"
    docker service update --env-add COLOR=green --update-delay 30s test_bg
    echo -e "${G}Green stack is online${NC}"
else
    echo -e "${B}Switching to blue stack${NC}"
    echo -e "${G}[ ][ ][ ][ ][ ][ ]${NC}    ${B}[ ][ ][ ][ ][ ][ ]${NC}"
    echo -e "${G}[ ][ ][ ][ ][ ][ ]${NC}    ${B}[ ][ ][ ][ ][ ][ ]${NC}"
    echo -e "${G}[ ][ ][ ][ ][ ][ ]${NC}${C}--->${NC}${B}[ ][ ][ ][ ][ ][ ]${NC}"
    echo -e "${G}[ ][ ][ ][ ][ ][ ]${NC}    ${B}[ ][ ][ ][ ][ ][ ]${NC}"
    echo -e "${G}[ ][ ][ ][ ][ ][ ]${NC}    ${B}[ ][ ][ ][ ][ ][ ]${NC}"
    docker service update --env-add COLOR=blue --update-delay 30s test_bg
    echo -e "${B}Blue stack is online${NC}"
fi
echo -e "${C}Re-scaling container blue-green to 1${NC}"
docker service scale test_bg=1

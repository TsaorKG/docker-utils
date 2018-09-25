#!/bin/bash
# Author : Gabriel Walbron
# Date : 27/03/2018
#Color value blue, green, cyan, no color
B='\033[0;34m'
G='\033[0;32m'
C='\033[0;36m'
NC='\033[0m'
echo -e "${C}STARTING ${NC}${B}BLUE${NC}${C}-${NC}${G}GREEN${NC}${C} DEPLOYMENT SAMPLE${NC}"
echo -e "${B}[ ][ ][ ][ ][ ][ ]${NC}    ${G}[ ][ ][ ][ ][ ][ ]${NC}"
echo -e "${B}[ ][ ][ ][ ][ ][ ]${NC}    ${G}[ ][ ][ ][ ][ ][ ]${NC}"
echo -e "${B}[ ][ ][ ][ ][ ][ ]${NC}${C}<-->${NC}${G}[ ][ ][ ][ ][ ][ ]${NC}"
echo -e "${B}[ ][ ][ ][ ][ ][ ]${NC}    ${G}[ ][ ][ ][ ][ ][ ]${NC}"
echo -e "${B}[ ][ ][ ][ ][ ][ ]${NC}    ${G}[ ][ ][ ][ ][ ][ ]${NC}"
echo -e "${C}[INFO] >>> Creating local registry${NC}"
docker service create \
  --name registry \
  --publish published=5000,target=5000 \
  registry:2
cd app 
echo -e "${C}[INFO] >>> Build sample app image${NC}"
docker-compose build
echo -e "${C}[INFO] >>> Push to repo${NC}"
docker-compose push
cd ..
echo -e "${C}[INFO] >>> Build container nginx ${B}Blue${NC}${C}-${NC}${G}Green${NC}${NC}"
docker-compose build
echo -e "${C}[INFO] >>> Push to repo${NC}"
docker-compose push
echo -e "${C}[INFO] >>>${NC} ${B}Deploy stack blue${NC}"
export COLOR=blue
docker stack deploy -c app.yml blue
echo -e "${C}[INFO] >>>${NC} ${G}Deploy stack green${NC}"
export COLOR=green
docker stack deploy -c app.yml green
echo -e "${C}[INFO] >>> Deploy container ${B}Blue${NC}${C}-${NC}${G}Green${NC}${NC}"
docker stack deploy -c bg.yml bg
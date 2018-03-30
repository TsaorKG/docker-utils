#!/bin/bash
C='\033[0;36m'
NC='\033[0m'

echo -e "${C}You must pass as first argument the driver you are running with${NC}"
echo -e "${C}For mac use virtualbox${NC}"
echo -e "${C}For windows use hyperv${NC}"
if [ $2 = 3 ]; then
    echo -e "${C}Create manager1${NC}"
    docker-machine create -d "$1" manager1
    echo -e "${C}Create worker1${NC}"
    docker-machine create -d "$1" worker1
    echo -e "${C}Create worker2${NC}"
    docker-machine create -d "$1" worker2
    IP=$(docker-machine ip manager1)
    echo -e "${C}Init swarm on manager1${NC}"
    docker-machine ssh manager1 docker swarm init --advertise-addr $IP
    COMMAND=$(docker-machine ssh manager1 docker swarm join-token worker)
    JOIN=$(echo $COMMAND | sed 's/.*command://')
    echo -e "${C}Worker1 joining swarm${NC}"
    docker-machine ssh worker1 $JOIN
    echo -e "${C}Worker2 joining swarm${NC}"
    docker-machine ssh worker2 $JOIN
elif [ $2 = 6 ]; then
    echo -e "${C}Create manager1${NC}"
    docker-machine create -d "$1" manager1
    echo -e "${C}Create manager2${NC}"
    docker-machine create -d "$1" manager2
    echo -e "${C}Create manager3${NC}"
    docker-machine create -d "$1" manager3
    echo -e "${C}Create worker1${NC}"
    docker-machine create -d "$1" worker1
    echo -e "${C}Create worker2${NC}"
    docker-machine create -d "$1" worker2
    echo -e "${C}Create worker3${NC}"
    docker-machine create -d "$1" worker3
    IP=$(docker-machine ip manager1)
    echo -e "${C}Init swarm on manager1${NC}"
    docker-machine ssh manager1 docker swarm init --advertise-addr $IP
    COMMAND=$(docker-machine ssh manager1 docker swarm join-token manager)
    JOIN=$(echo $COMMAND | sed 's/.*command://')
    echo -e "${C}Manager2 joining swarm${NC}"
    docker-machine ssh manager2 $JOIN
    echo -e "${C}Manager3 joining swarm${NC}"
    docker-machine ssh manager3 $JOIN
    COMMAND=$(docker-machine ssh manager1 docker swarm join-token worker)
    JOIN=$(echo $COMMAND | sed 's/.*command://')
    echo -e "${C}Worker1 joining swarm${NC}"
    docker-machine ssh worker1 $JOIN
    echo -e "${C}Worker2 joining swarm${NC}"
    docker-machine ssh worker2 $JOIN
    echo -e "${C}Worker3 joining swarm${NC}"
    docker-machine ssh worker3 $JOIN
else
    echo -e "${C}Wrong cluster size${NC}"
fi

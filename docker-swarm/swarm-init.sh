#!/bin/bash
docker-machine create 
docker-machine ssh manager1 docker swarm init --advertise-addr 10.0.2.15)
test=$(docker-machine ssh manager1 docker swarm join-token worker)
test=$(echo $test | sed 's/.*command://')
echo $test
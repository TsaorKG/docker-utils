#!/bin/bash
docker build . -t test:1.0
docker secret create secret_data secret
#docker run -d -p 8080:8080 --name tester test:1.0
docker service create -p 8080:8080 --secret secret_data --name tester test:1.0
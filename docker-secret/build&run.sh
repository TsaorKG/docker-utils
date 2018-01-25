#!/bin/bash
docker build . -t test:1.0
docker run -d -p 8080:8080 --name server test:1.0
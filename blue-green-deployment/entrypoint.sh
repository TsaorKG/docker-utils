#!/bin/bash
# Author : Gabriel Walbron
# Date : 27/03/2018
B='\033[0;34m'
G='\033[0;32m'
C='\033[0;36m'
NC='\033[0m'
if [ $COLOR = "blue" ]; then
    rm /etc/nginx/nginx.conf
    cp /etc/nginx/nginx.conf.blue /etc/nginx/nginx.conf
    echo -e "${B}Loading blue stack conf${NC}"
elif [ $COLOR = "green" ]; then
    rm /etc/nginx/nginx.conf
    cp /etc/nginx/nginx.conf.green /etc/nginx/nginx.conf
    echo -e "${G}Loading green stack conf${NC}"
else
    echo -e "${C}COLOR is incorrect${NC}"
fi

exec "$@"
#!/bin/bash
# Author : Gabriel Walbron
# Date : 27/03/2018
C='\033[0;36m'
NC='\033[0m'
if [ $COLOR = "blue" ]; then
    python2.7 replace_dicovar.py . /run/secrets/secret_data_blue
elif [ $COLOR = "green" ]; then
    python2.7 replace_dicovar.py . /run/secrets/secret_data_green
else
    echo -e "${C}COLOR is incorrect${NC}"
fi

exec "$@"
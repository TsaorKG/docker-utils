#!/bin/bash
# Author : Gabriel Walbron
# Date : 27/03/2018
C='\033[0;36m'
NC='\033[0m'
echo "COLOR=$COLOR" > /dico
python2.7 replace_dicovar.py . /dico

exec "$@"
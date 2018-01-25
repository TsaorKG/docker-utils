#!/bin/bash

python2.7 replace_dicovar.py . /run/secrets/secret_data

echo "You can now connect to localhost:8080 and check your sample values"
exec "$@"
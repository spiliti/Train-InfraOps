#!/bin/sh

export PGADMIN_SETUP_EMAIL=$PGADMIN_DEFAULT_EMAIL
export PGADMIN_SETUP_PASSWORD=$PGADMIN_DEFAULT_PASSWORD

python3 /init.py

uwsgi --http-socket 0.0.0.0:$PGADMIN_PORT \
      --processes 1 \
      --threads 25 \
      --chdir /usr/local/lib/python3.7/site-packages/pgadmin4/ \
      --mount /=pgAdmin4:app
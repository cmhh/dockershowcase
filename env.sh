#! /usr/bin/env bash

echo "GID=$(id -g)" > .env
echo "UID=$(id -u)" >> .env
echo "MSSQL_SA_PASSWORD=\"$(head -c 8 /dev/urandom | base64)\"" >> .env
chmod 600 .env
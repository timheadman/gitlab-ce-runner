#!/bin/bash
# Создаем новые наборы сертификатов для GitLab (docker)

if [[ "$#" == 0 ]]; then
    echo Requires 1 host name.
    exit 1
fi

host=$1

mkdir -p keys
cd keys
rm -f *

openssl genrsa -out ca.key 2048
openssl req -new -x509 -days 1024 -key ca.key -subj "/C=CN/ST=GD/L=SZ/O=Monsters Inc./CN=Monsters Inc. Root CA" -out ca.crt
openssl req -newkey rsa:2048 -nodes -keyout $host.key -subj "/C=CN/ST=GD/L=SZ/O=Monsters Inc./CN=gitlab" -out $host.csr
openssl x509 -req -extfile <(printf "subjectAltName=DNS:$host,DNS:$host") -days 1024 -in $host.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out $host.crt


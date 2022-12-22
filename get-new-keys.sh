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
openssl req -newkey rsa:2048 -nodes -keyout localhost.key -subj "/C=CN/ST=GD/L=SZ/O=Monsters Inc./CN=gitlab" -out localhost.csr
openssl x509 -req -extfile <(printf "subjectAltName=DNS:localhost,DNS:gitlab,DNS:$host") -days 1024 -in localhost.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out localhost.crt

cp localhost.crt gitlab.crt
cp localhost.key gitlab.key
cp localhost.crt $host.crt
cp localhost.key $host.key


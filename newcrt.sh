#!/bin/bash
# Создаем новые наборы сертификатов для GitLab (docker)

SERVER_NAME=$1
UTC=$(date +"%s")
mkdir -p new-keys
cd new-keys
rm -f *
openssl genrsa -out ca.key 2048
openssl req -new -x509 -days 1024 -key ca.key -subj "/C=CN/ST=GD/L=SZ/O=Monsters Inc., Inc./CN=Monsters Inc. Root CA" -out ca.crt
openssl req -newkey rsa:2048 -nodes -keyout $1.key -subj "/C=CN/ST=GD/L=SZ/O=Monsters Inc., Inc./CN=$1" -out $1.csr
openssl x509 -req -extfile <(printf "subjectAltName=DNS:$1,DNS:gitlab") -days 1024 -in $1.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out $1.crt
cp $1.crt gitlab.crt
cp $1.key gitlab.key
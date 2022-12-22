#!/bin/bash

url=$(ls keys/*.csr)
url=${url%.csr}
url=${url#keys/}

#docker exec gitlab bash -c "rm /etc/gitlab/ssl/*"

# Копируем сертификаты в GitLab 
docker cp keys/${url}.crt gitlab:/etc/gitlab/ssl/${url}.crt
docker cp keys/${url}.key gitlab:/etc/gitlab/ssl/${url}.key


#!/bin/bash

if [[ "$#" -lt 1 ]]; then
    echo Requires url and registration-token registration token.
    exit 1
fi

url=$1
file_name=${url%:*}
token=$2

# Копируем сертификаты на GitLab runner 
#docker cp keys/ca.crt gitlab-runner:/etc/gitlab-runner/certs/ca.crt
#docker cp keys/ca.key gitlab-runner:/etc/gitlab-runner/certs/ca.key
docker cp keys/localhost.crt gitlab-runner:/etc/gitlab-runner/certs/${file_name}.crt
docker cp keys/localhost.key gitlab-runner:/etc/gitlab-runner/certs/${file_name}.key

#WARNING: The 'register' command has been deprecated in GitLab Runner 15.6 and will be replaced with a 'deploy' command. For more information, see https://gitlab.com/gitlab-org/gitlab/-/issues/380872 
docker exec -it gitlab-runner gitlab-runner register \
                     --non-interactive \
                     --executor "docker" \
                     --docker-image alpine:latest \
                     --url "https://${url}" \
                     --registration-token "${token}" \
                     --description "docker-runner" \
                     --maintenance-note "Free-form maintainer notes about this runner" \
                     --tag-list "docker" \
                     --docker-volumes "/var/run/docker.sock:/var/run/docker.sock" \
                     --run-untagged="true" \
                     --locked="false" \
                     --access-level="not_protected"


                     #--tls-ca-file "/etc/gitlab-runner/certs/ca.crt"

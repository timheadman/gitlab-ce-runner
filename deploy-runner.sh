#!/bin/bash

if [[ "$#" == 0 ]]; then
    echo Requires at least 1 registration token.
    exit 1
fi

# Копируем сертификаты на GitLab runner 
docker cp keys/localhost.crt gitlab-runner:/etc/gitlab-runner/certs/gitlab.crt
docker cp keys/localhost.key gitlab-runner:/etc/gitlab-runner/certs/gitlab.key

#WARNING: The 'register' command has been deprecated in GitLab Runner 15.6 and will be replaced with a 'deploy' command. For more information, see https://gitlab.com/gitlab-org/gitlab/-/issues/380872 
docker exec -it gitlab-runner gitlab-runner register \
                     --non-interactive \
                     --executor "docker" \
                     --docker-image alpine:latest \
                     --url "https://gitlab:44324" \
                     --registration-token "${1}" \
                     --description "docker-runner" \
                     --maintenance-note "Free-form maintainer notes about this runner" \
                     --tag-list "docker,aws" \
                     --run-untagged="true" \
                     --locked="false" \
                     --access-level="not_protected"


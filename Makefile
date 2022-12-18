.PHONY: key_copy
# Копируем сертификаты на GitLab и GitLab runner 
copy:
	@docker cp /new_key/localhost.crt gitlab_runner:/etc/gitlab-runner/certs/gitlab.crt
	#@docker cp /new_key/server.* gitlab_runner:/etc/gitlab-runner/certs/gitlab.crt
	#ToDO доделать

.PHONY: runner
runner:
	@docker run -d --name gitlab-runner --restart always \
		    -v /srv/gitlab-runner/config:/etc/gitlab-runner \
		    -v /var/run/docker.sock:/var/run/docker.sock \
  		    gitlab/gitlab-runner:latest


.PHONY: runner_register
runner_register:
	@docker exec -it gitlab_runner gitlab-runner register \
                     --non-interactive \
                     --executor "docker" \
                     --docker-image alpine:latest \
                     --url "https://gitlab" \
                     --registration-token "*****TOKEN*****" \
                     --description "docker_runner" \
                     --maintenance-note "Free-form maintainer notes about this runner" \
                     --tag-list "docker,aws" \
                     --run-untagged="true" \
                     --locked="false" \
                     --access-level="not_protected"


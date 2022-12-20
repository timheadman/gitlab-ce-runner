.PHONY: key
# Копируем сертификаты на GitLab и GitLab runner 
key:
	@docker cp /new-key/localhost.crt gitlab-runner:/etc/gitlab-runner/certs/gitlab.crt
	#@docker cp /new-key/server.* gitlab-runner:/etc/gitlab-runner/certs/gitlab.crt
	#ToDO доделать

.PHONY: runner
runner:
	@docker run -d --name gitlab-runner --restart always \
		    -v /srv/gitlab-runner/config:/etc/gitlab-runner \
		    -v /var/run/docker.sock:/var/run/docker.sock \
  		    gitlab/gitlab-runner:latest


.PHONY: runner-register
runner-register:
	@docker exec -it gitlab-runner gitlab-runner register \
                     --non-interactive \
                     --executor "docker" \
                     --docker-image alpine:latest \
                     --url "https://gitlab" \
                     --registration-token "*****TOKEN*****" \
                     --description "docker-runner" \
                     --maintenance-note "Free-form maintainer notes about this runner" \
                     --tag-list "docker,aws" \
                     --run-untagged="true" \
                     --locked="false" \
                     --access-level="not_protected"


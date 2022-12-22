.PHONY: test-up
test-up:
	docker compose build
	docker compose up

.PHONY: test-down
test-down:
	docker compose down
	docker system prune --force
	#docker volume prune --force

.PHONY: copy-key
copy-key:
	sudo cp keys/* /var/lib/docker/volumes/gitlab_gitlab-config/_data/ssl/
	sudo ls -la /var/lib/docker/volumes/gitlab_gitlab-config/_data/ssl/

.PHONY: run-runner
run-runner:
	docker volume create gitlab-runner-config
	docker run -d --name gitlab-runner --restart always \
    		   -v /var/run/docker.sock:/var/run/docker.sock \
    		   -v gitlab-runner-config:/etc/gitlab-runner \
	   		    gitlab/gitlab-runner:latest



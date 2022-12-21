.PHONY: test-up
test-up:
	docker compose build
	docker compose up

.PHONY: test-down
test-down:
	docker compose down
	docker system prune --force
	#docker volume prune --force


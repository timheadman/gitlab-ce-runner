# Default root password
cat /data/docker/gitlab/etc/gitlab/initial_root_password

# Getting started
1. Create new kys if needed: `./get-new-keys.sh`
2. Run gitlab container: `docker compose up --detach`
3. Run gitlab runner container: `make run-runner`
4. Configuring GitLab Runner: `./deploy-runner.sh URL:PORT TOKEN` 

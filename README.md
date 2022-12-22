# Default root password
cat /data/docker/gitlab/etc/gitlab/initial_root_password

# Getting started
1. ./get-new-keys.sh - if needed
2. docker compose up --detach
3. ./deploy-runner.sh URL:PORT TOKEN 

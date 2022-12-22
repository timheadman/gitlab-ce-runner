# Default root password
cat /data/docker/gitlab/etc/gitlab/initial_root_password

# Getting started
1. Create new keys, if needed: `./get-new-keys.sh server.lan`
2. Run gitlab container: `docker compose up --detach`
3. Edit gitlab.rb, if needed: `external_url https://server.lan:44324`
4. Copy new keys to container: `./copy-keys.sh`
5. Restart container: `docker exec gitlab bash -c "gitlab-ctl restart"`
6. Run and configuring GitLab Runner: `./deploy-runner.sh URL:PORT TOKEN` 

FROM gitlab/gitlab-ce:latest

RUN mkdir -p /etc/gitlab/ssl 
COPY keys/*.crt /etc/gitlab/ssl 
COPY keys/*.key /etc/gitlab/ssl 


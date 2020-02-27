FROM jenkins/jnlp-agent-alpine

WORKDIR /usr/src/app

# Adjust the following ENV values for your Jenkins host, and port
ENV JENKINS_URL=http://192.168.1.241:10010
ENV JENKINS_TUNNEL=192.168.1.241:10000

ENV PATH "$PATH:/usr/src/app"

USER root

RUN apk update && apk add -u libcurl curl

ARG DOCKER_VERSION=18.03.0-ce
ARG DOCKER_COMPOSE_VERSION=1.21.0
RUN curl -fsSL https://download.docker.com/linux/static/stable/`uname -m`/docker-$DOCKER_VERSION.tgz | tar --strip-components=1 -xz -C /usr/local/bin docker/docker
RUN curl -fsSL https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

RUN touch /debug-flag
USER jenkins
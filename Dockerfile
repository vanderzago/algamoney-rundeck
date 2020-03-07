FROM rundeck/rundeck:SNAPSHOT

LABEL maintainer="vander.alves@inmetrics.com.br"

USER root

COPY rundeck-cli-1.1.8-all.jar /tmp/
COPY src/yaml/ /tmp/
COPY src/sh/load_jobs.sh /docker-entrypoint.d/
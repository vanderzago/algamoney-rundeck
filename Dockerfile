FROM rundeck/rundeck:SNAPSHOT

ARG USER
ARG PASS
ARG URL

LABEL maintainer="vander.alves@inmetrics.com.br"

USER root

COPY rundeck-cli-1.1.8-all.jar /tmp/
COPY src/ /tmp/

RUN chmod +x /tmp/sh/load_jobs.sh

USER rundeck

#CMD ["/tmp/sh/load_jobs.sh","${USER}","${PASS}","${URL}"]
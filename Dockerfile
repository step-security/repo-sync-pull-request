FROM alpine:3.23

LABEL \
  "name"="GitHub Pull Request Action" \
  "repository"="https://github.com/step-security/repo-sync-pull-request" \
  "maintainer"="step-security"

RUN echo https://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
  apk add --no-cache git hub bash curl

ADD *.sh /

ENTRYPOINT ["/entrypoint.sh"]

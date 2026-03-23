FROM alpine:3.23

LABEL \
  "name"="GitHub Pull Request Action" \
  "repository"="https://github.com/step-security/repo-sync-pull-request" \
  "maintainer"="step-security"

RUN apk add --no-cache git github-cli bash curl

ADD *.sh /

ENTRYPOINT ["/entrypoint.sh"]

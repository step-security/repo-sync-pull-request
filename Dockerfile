FROM alpine:3.24@sha256:a2d49ea686c2adfe3c992e47dc3b5e7fa6e6b5055609400dc2acaeb241c829f4

LABEL \
  "name"="GitHub Pull Request Action" \
  "repository"="https://github.com/step-security/repo-sync-pull-request" \
  "maintainer"="step-security"

RUN apk add --no-cache git github-cli bash curl jq

ADD *.sh /

ENTRYPOINT ["/entrypoint.sh"]

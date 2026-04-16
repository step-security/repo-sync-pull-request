FROM alpine:3.23@sha256:5b10f432ef3da1b8d4c7eb6c487f2f5a8f096bc91145e68878dd4a5019afde11

LABEL \
  "name"="GitHub Pull Request Action" \
  "repository"="https://github.com/step-security/repo-sync-pull-request" \
  "maintainer"="step-security"

RUN apk add --no-cache git github-cli bash curl jq

ADD *.sh /

ENTRYPOINT ["/entrypoint.sh"]

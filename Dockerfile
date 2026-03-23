FROM alpine:3.23@sha256:25109184c71bdad752c8312a8623239686a9a2071e8825f20acb8f2198c3f659

LABEL \
  "name"="GitHub Pull Request Action" \
  "repository"="https://github.com/step-security/repo-sync-pull-request" \
  "maintainer"="step-security"

RUN apk add --no-cache git github-cli bash curl

ADD *.sh /

ENTRYPOINT ["/entrypoint.sh"]

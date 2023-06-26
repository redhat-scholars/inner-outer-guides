### BUILDER IMAGE ###
FROM docker.io/antora/antora:3.1.2 as builder

ADD . /antora/

RUN antora generate --stacktrace site.yml

### RUNTIME IMAGE ###
FROM registry.redhat.io/ubi8/httpd-24:1-256.1680797936

ARG CREATED_AT=none
ARG GITHUB_SHA=none

LABEL org.opencontainers.image.created="$CREATED_AT"
LABEL org.opencontainers.image.revision="$GITHUB_SHA"

LABEL org.opencontainers.image.title="Inner & Outer Development Guides"
LABEL org.opencontainers.image.description="Inner & Outer Development Guides."
LABEL org.opencontainers.image.url="https://demo.redhat.com"
LABEL org.opencontainers.image.source="git@github.com:redhat-scholars/inner-outer-guides"
LABEL org.opencontainers.image.documentation="https://github.com/redhat-scholars/inner-outer-guides"
LABEL org.opencontainers.image.authors="blues-man"
LABEL org.opencontainers.image.vendor="redhat"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.version="1.0.0"

COPY --from=builder /antora/site/ /var/www/html/

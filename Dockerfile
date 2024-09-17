# syntax=docker/dockerfile:1

FROM alpine AS builder
ARG HGVERSION=local
ADD . /src
RUN set -ex && \
    apk add build-base && \
    cd /src && \
    env "HGVERSION=${HGVERSION}" make

FROM alpine

COPY --from=builder --chmod=0755 --chown=root:root /src/mdns-repeater /bin/mdns-repeater
RUN apk add --no-cache libcap && setcap cap_net_raw=+ep /bin/mdns-repeater

ENTRYPOINT ["/bin/mdns-repeater"]

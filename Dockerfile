FROM alpine:3.15

RUN apk add restic tini

COPY --chmod=755 *sh /

ENTRYPOINT ["tini", "/docker-entrypoint.sh"]

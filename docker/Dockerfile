FROM alpine:3.20

RUN apk add --no-cache bash curl ca-certificates
RUN apk add --no-cache bash curl ca-certificates docker-cli

WORKDIR /app

COPY cli/ /app/

RUN chmod +x /app/main.sh

ENTRYPOINT ["/app/main.sh"]
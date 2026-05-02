FROM alpine:3.20

RUN apk add --no-cache \
    bash \
    curl \
    ca-certificates \
    docker-cli

WORKDIR /app

COPY cli/ /app/

RUN chmod +x /app/main.sh

# Use a small wrapper to support both interactive and CLI modes
COPY <<'EOF' /entrypoint.sh
#!/usr/bin/env bash
set -e

# If arguments are provided, run them
if [ $# -gt 0 ]; then
    exec "$@"
fi

# If running in a TTY, drop into shell
if [ -t 0 ]; then
    exec /bin/bash
fi

# Default behavior
exec /app/main.sh
EOF

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD []
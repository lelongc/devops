FROM kong:3.4-alpine

# Switch to root to install additional tools
USER root

# Install additional tools
RUN apk add --no-cache \
    curl \
    jq \
    postgresql-client

# Copy custom configuration
COPY kong.conf /etc/kong/kong.conf

# Copy custom plugins
COPY plugins/ /usr/local/share/lua/5.1/kong/plugins/

# Copy initialization scripts
COPY init-scripts/ /docker-entrypoint-initdb.d/

# Set environment variables
ENV KONG_DATABASE=postgres \
    KONG_PG_HOST=kong-database \
    KONG_PG_USER=kong \
    KONG_PG_PASSWORD=changeme \
    KONG_PG_DATABASE=kong \
    KONG_PROXY_ACCESS_LOG=/dev/stdout \
    KONG_ADMIN_ACCESS_LOG=/dev/stdout \
    KONG_PROXY_ERROR_LOG=/dev/stderr \
    KONG_ADMIN_ERROR_LOG=/dev/stderr \
    KONG_ADMIN_LISTEN="0.0.0.0:8001"

# Switch back to kong user
USER kong

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD kong health || exit 1

EXPOSE 8000 8443 8001 8444

CMD ["kong", "docker-start"]

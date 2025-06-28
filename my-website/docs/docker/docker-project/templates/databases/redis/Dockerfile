FROM redis:7-alpine

# Install additional tools
RUN apk add --no-cache \
    curl \
    redis-tools

# Set environment variables
ENV REDIS_PASSWORD=changeme \
    REDIS_PORT=6379 \
    REDIS_DATABASES=16 \
    REDIS_MAXMEMORY=256mb \
    REDIS_MAXMEMORY_POLICY=allkeys-lru

# Copy custom configuration
COPY redis.conf /usr/local/etc/redis/redis.conf

# Copy initialization scripts
COPY init-scripts/ /docker-entrypoint-initdb.d/

# Copy backup scripts
COPY scripts/ /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

# Create data and backup directories
RUN mkdir -p /data /backup && \
    chown redis:redis /data /backup

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD redis-cli ping || exit 1

EXPOSE 6379

# Start Redis with custom config
CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]

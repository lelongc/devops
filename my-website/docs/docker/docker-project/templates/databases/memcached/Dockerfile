FROM memcached:1.6-alpine

# Install additional tools
RUN apk add --no-cache \
    curl \
    netcat-openbsd

# Set environment variables
ENV MEMCACHED_MEMORY=128 \
    MEMCACHED_PORT=11211 \
    MEMCACHED_USER=memcache

# Copy custom configuration script
COPY memcached.conf /etc/memcached.conf
COPY scripts/ /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD echo stats | nc localhost 11211 || exit 1

EXPOSE 11211

# Start memcached with custom settings
CMD ["memcached", "-m", "128", "-p", "11211", "-u", "memcache", "-l", "0.0.0.0"]

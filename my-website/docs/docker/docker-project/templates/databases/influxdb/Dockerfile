FROM influxdb:2.7-alpine

# Install additional tools
RUN apk add --no-cache \
    curl \
    jq

# Set environment variables
ENV INFLUXDB_DB=mydb \
    INFLUXDB_ADMIN_USER=admin \
    INFLUXDB_ADMIN_PASSWORD=changeme \
    INFLUXDB_USER=user \
    INFLUXDB_USER_PASSWORD=password

# Copy custom configuration
COPY influxdb.conf /etc/influxdb/influxdb.conf

# Copy initialization scripts
COPY init-scripts/ /docker-entrypoint-initdb.d/

# Copy backup scripts
COPY scripts/ /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

# Create backup directory
RUN mkdir -p /backup && chown influxdb:influxdb /backup

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD influx ping || exit 1

EXPOSE 8086

CMD ["influxd"]

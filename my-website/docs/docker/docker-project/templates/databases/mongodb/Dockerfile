FROM mongo:6.0

# Install additional tools
RUN apt-get update && apt-get install -y \
    curl \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV MONGO_INITDB_ROOT_USERNAME=admin \
    MONGO_INITDB_ROOT_PASSWORD=changeme \
    MONGO_INITDB_DATABASE=myapp

# Copy initialization scripts
COPY init-scripts/ /docker-entrypoint-initdb.d/

# Copy custom configuration
COPY mongod.conf /etc/mongod.conf

# Copy backup scripts
COPY scripts/ /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

# Create backup directory
RUN mkdir -p /backup && chown mongodb:mongodb /backup

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD mongosh --eval "db.adminCommand('ping')" || exit 1

EXPOSE 27017

CMD ["mongod", "--config", "/etc/mongod.conf"]

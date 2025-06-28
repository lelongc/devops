FROM postgres:15-alpine

# Install additional tools
RUN apk add --no-cache \
    postgresql-contrib \
    postgresql-dev \
    curl \
    bash

# Set custom configuration
ENV POSTGRES_DB=myapp \
    POSTGRES_USER=appuser \
    POSTGRES_PASSWORD=changeme \
    PGDATA=/var/lib/postgresql/data/pgdata

# Copy initialization scripts
COPY init-scripts/ /docker-entrypoint-initdb.d/

# Copy custom postgresql.conf
COPY postgresql.conf /etc/postgresql/postgresql.conf

# Copy backup scripts
COPY scripts/ /usr/local/bin/

# Make scripts executable
RUN chmod +x /usr/local/bin/*.sh

# Create directories
RUN mkdir -p /backup /var/log/postgresql && \
    chown -R postgres:postgres /backup /var/log/postgresql

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD pg_isready -U $POSTGRES_USER -d $POSTGRES_DB || exit 1

EXPOSE 5432

# Custom entrypoint
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]

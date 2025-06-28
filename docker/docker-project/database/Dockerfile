FROM postgres:15-alpine

# Install additional extensions
RUN apk add --no-cache \
    postgresql-contrib \
    postgresql-dev

# Set environment variables
ENV POSTGRES_DB=myapp \
    POSTGRES_USER=appuser \
    POSTGRES_PASSWORD=changeme \
    PGDATA=/var/lib/postgresql/data/pgdata

# Copy initialization scripts
COPY init.sql /docker-entrypoint-initdb.d/
COPY postgresql.conf /etc/postgresql/postgresql.conf

# Copy custom configuration
COPY --chown=postgres:postgres postgresql.conf /usr/local/share/postgresql/postgresql.conf.sample

# Create backup directory
RUN mkdir -p /backup && chown postgres:postgres /backup

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD pg_isready -U $POSTGRES_USER -d $POSTGRES_DB || exit 1

# Expose port
EXPOSE 5432

# Use custom entrypoint if needed
# COPY docker-entrypoint.sh /usr/local/bin/
# RUN chmod +x /usr/local/bin/docker-entrypoint.sh
# ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]
